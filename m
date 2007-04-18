Return-Path: <michael@ellerman.id.au>
Subject: Re: [PATCH 1/2] hvc_console polling mode timer backoff
From: Michael Ellerman <michael@ellerman.id.au>
To: will_schmidt@vnet.ibm.com
In-Reply-To: <1176821087.28514.145.camel@farscape.rchland.ibm.com>
References: <1176821087.28514.145.camel@farscape.rchland.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-fU8MyP4VLFXiGPdoYhEn"
Date: Wed, 18 Apr 2007 16:09:51 +1000
Message-Id: <1176876591.4987.44.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
Reply-To: michael@ellerman.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


--=-fU8MyP4VLFXiGPdoYhEn
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2007-04-17 at 09:44 -0500, Will Schmidt wrote:
> Paulus, I think this is ready to go, please apply, thanks.=20
>=20
>=20
>=20
> Add a back-off mechanism to hvc_console's polling logic.   This change
> drops the timers/second ratio from ~90 to ~1/2 while the console is
> idle.
> This change is most noticeable when watching /proc/timer_stats output.
>=20
> This only affects when the hvc_console is running in poll mode, i.e.
> power4 and cell systems.
>=20
> I've tested on Power4, Michael Ellerman has both contributed to the
> patch and tested on cell.  =20
>=20
> Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
> cc: Michael Ellerman <michael@ellerman.id.au>

That should probably be:

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

cheers

> ---
> diff --git a/drivers/char/hvc_console.c b/drivers/char/hvc_console.c
> index a0a88aa..fc9bc77 100644
> --- a/drivers/char/hvc_console.c
> +++ b/drivers/char/hvc_console.c
> @@ -47,8 +47,6 @@ #include "hvc_console.h"
>  #define HVC_MAJOR	229
>  #define HVC_MINOR	0
> =20
> -#define TIMEOUT		(10)
> -
>  /*
>   * Wait this long per iteration while trying to push buffered data to th=
e
>   * hypervisor before allowing the tty to complete a close operation.
> @@ -550,6 +548,18 @@ static int hvc_chars_in_buffer(struct tt
>  	return hp->n_outbuf;
>  }
> =20
> +/*
> + * timeout will vary between the MIN and MAX values defined here.  By de=
fault
> + * and during console activity we will use a default MIN_TIMEOUT of 10. =
 When
> + * the console is idle, we increase the timeout value on each pass throu=
gh
> + * msleep until we reach the max.  This may be noticeable as a brief (av=
erage
> + * one second) delay on the console before the console responds to input=
 when
> + * there has been no input for some time.
> + */
> +#define MIN_TIMEOUT		(10)
> +#define MAX_TIMEOUT		(2000)
> +static u32 timeout =3D MIN_TIMEOUT;
> +
>  #define HVC_POLL_READ	0x00000001
>  #define HVC_POLL_WRITE	0x00000002
> =20
> @@ -642,9 +652,14 @@ #endif /* CONFIG_MAGIC_SYSRQ */
>   bail:
>  	spin_unlock_irqrestore(&hp->lock, flags);
> =20
> -	if (read_total)
> +	if (read_total) {
> +		/* Activity is occurring, so reset the polling backoff value to
> +		   a minimum for performance. */
> +		timeout =3D MIN_TIMEOUT;
> +
>  		tty_flip_buffer_push(tty);
> -=09
> +	}
> +
>  	return poll_mask;
>  }
> =20
> @@ -688,8 +703,12 @@ int khvcd(void *unused)
>  		if (!hvc_kicked) {
>  			if (poll_mask =3D=3D 0)
>  				schedule();
> -			else
> -				msleep_interruptible(TIMEOUT);
> +			else {
> +				if (timeout < MAX_TIMEOUT)
> +					timeout +=3D (timeout >> 6) + 1;
> +
> +				msleep_interruptible(timeout);
> +			}
>  		}
>  		__set_current_state(TASK_RUNNING);
>  	} while (!kthread_should_stop());
>=20
>=20
>=20
>=20
--=20
Michael Ellerman
OzLabs, IBM Australia Development Lab

wwweb: http://michael.ellerman.id.au
phone: +61 2 6212 1183 (tie line 70 21183)

We do not inherit the earth from our ancestors,
we borrow it from our children. - S.M.A.R.T Person

--=-fU8MyP4VLFXiGPdoYhEn
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBGJbYvdSjSd0sB4dIRAg9/AJ9N2ASl8ceH6JRZOv0PS7Gy+EHOrACgnNAM
ROVjVIPaZb+B6VG8uKOy4Ds=
=NB5U
-----END PGP SIGNATURE-----

--=-fU8MyP4VLFXiGPdoYhEn--
