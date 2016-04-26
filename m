Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qvBxd4Kw6zDq64
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Apr 2016 15:49:41 +1000 (AEST)
Date: Tue, 26 Apr 2016 15:29:59 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, alistair@popple.id.au, ruscur@russell.cc,
 mpe@ellerman.id.au
Subject: Re: [PATCH v2 1/3] powerpc/eeh: Ignore error handlers in
 eeh_pe_reset_and_recover()
Message-ID: <20160426052959.GJ15176@voom.fritz.box>
References: <1461331687-1069-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="sT9gWZPUZYhvPS56"
In-Reply-To: <1461331687-1069-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--sT9gWZPUZYhvPS56
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 22, 2016 at 11:28:02PM +1000, Gavin Shan wrote:
> The function eeh_pe_reset_and_recover() is used to recover EEH
> error when the passthrough device are transferred to guest and
> backwards, meaning the device's driver is vfio-pci or none.
> When the driver is vfio-pci that provides error_detected() error
> handler only, the handler simply stops the guest and it's not
> expected behaviour. On the other hand, no error handlers will
> be called if we don't have a bound driver.
>=20
> This ignores all error handlers provided by device driver in
> eeh_pe_reset_and_recover() to avoid the exceptional behaviour.
>=20
> Fixes: 5cfb20b9 ("powerpc/eeh: Emulate EEH recovery for VFIO devices")
> Cc: stable@vger.kernel.org #v3.18+
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Russell Currey <ruscur@russell.cc>
> ---
>  arch/powerpc/kernel/eeh_driver.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>=20
> diff --git a/arch/powerpc/kernel/eeh_driver.c b/arch/powerpc/kernel/eeh_d=
river.c
> index fb6207d..1c7d703 100644
> --- a/arch/powerpc/kernel/eeh_driver.c
> +++ b/arch/powerpc/kernel/eeh_driver.c
> @@ -552,7 +552,7 @@ static int eeh_clear_pe_frozen_state(struct eeh_pe *p=
e,
> =20
>  int eeh_pe_reset_and_recover(struct eeh_pe *pe)
>  {
> -	int result, ret;
> +	int ret;
> =20
>  	/* Bail if the PE is being recovered */
>  	if (pe->state & EEH_PE_RECOVERING)
> @@ -564,9 +564,6 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
>  	/* Save states */
>  	eeh_pe_dev_traverse(pe, eeh_dev_save_state, NULL);
> =20
> -	/* Report error */
> -	eeh_pe_dev_traverse(pe, eeh_report_error, &result);

Ok, so after chatting to Gavin, I've made sense of this.  The basic
thing here is that eeh_pe_reset_and_recover() should be discarding any
errors from before the reset, not reporting them - the whole point is
that we know things have gone bad, and we want to clear back to a good
state.

>  	/* Issue reset */
>  	ret =3D eeh_reset_pe(pe);
>  	if (ret) {
> @@ -581,15 +578,9 @@ int eeh_pe_reset_and_recover(struct eeh_pe *pe)
>  		return ret;
>  	}
> =20
> -	/* Notify completion of reset */
> -	eeh_pe_dev_traverse(pe, eeh_report_reset, &result);

However, it's not clear if removing the report of a reset makes sense.
There are no current users of reset notification IIUC, but if we're
going to remove the reset reporting, we should put that in a separate
patch with its own justification, and remove the other caller as well.

>  	/* Restore device state */
>  	eeh_pe_dev_traverse(pe, eeh_dev_restore_state, NULL);
> =20
> -	/* Resume */
> -	eeh_pe_dev_traverse(pe, eeh_report_resume, NULL);

And I'm not sure if it makes sense to remove the resume notification either.

>  	/* Clear recovery mode */
>  	eeh_pe_state_clear(pe, EEH_PE_RECOVERING);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--sT9gWZPUZYhvPS56
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXHvzWAAoJEGw4ysog2bOSrpsP/1ggIA7ZMFL8UI9ObtxtIopw
1zqAOin+QlxhFQURlCTX6fRcrcq8pKjzRNdr3jBty62Ar9oN1xu/hFh7tFOCslY1
I1m3oGFVTouGyVX8xr8tYYeuZ79c42lPHx9CZvK+35X1uqwaXwIZMxc0pD1wlnde
9vntGCpXJVpyeK5zfXslS3qZLE/WklixAguIurfay+aK4PrQPWo0GMGSe9oWygFB
3/sCffKcGZC+PE8PHCUcsiLKu5c6Hfn4APq8CT3IUMqYusdaFugaTpzjzG75D8xV
HcdaedV8jm9p/GAG96HeM1L03pn0uR8fkR0stvVrspDHnr/ryQM9nAohlTzucNEG
8ajwxZTS5YkAbQHWXm3gN4i/G3vPsjezZyry6W5Y4S7XJSZOtSNffvs6W+XpYzsm
13c7gdhQeYZvPYxtMHQZkANI/h0cfBVgPu7C37dYksPKXi3aJ7bRKU7L4i4xLFuT
yIBGr6RLuT0trAKmYSYbDPbZ6OhxLiVsh/pZDoPnwzg+uDJqg29T0Rq98x0kdLYv
GAq/5+UzJ16nbg7VNC+a4YxJiz5wgokvyeAToA2iOilAb2aUcROa4SJBa9RaXRHP
rjebOS9DrRjfAspDD70MmB5L3syLFbWTGk3MJN11NA4mMa9pdEJnD0cJiXK3rvJE
sJCzlM89aqcgns/uHiZd
=Twf9
-----END PGP SIGNATURE-----

--sT9gWZPUZYhvPS56--
