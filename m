Return-Path: <jonsmirl@gmail.com>
Received: from mail-qy0-f196.google.com (mail-qy0-f196.google.com
	[209.85.221.196]) by ozlabs.org (Postfix) with ESMTP id 5920EDE14D
	for <linuxppc-dev@ozlabs.org>; Thu, 21 May 2009 01:14:48 +1000 (EST)
Received: by qyk34 with SMTP id 34so891378qyk.17
	for <linuxppc-dev@ozlabs.org>; Wed, 20 May 2009 08:14:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <A88094362DE0AE49A118AB9B4EB3612403F9DEBE@dekaexchange.deka.local>
References: <A88094362DE0AE49A118AB9B4EB3612403F9DEB6@dekaexchange.deka.local>
	<20090519203645.GW19843@pengutronix.de>
	<20090519205706.GD27476@pengutronix.de>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEBC@dekaexchange.deka.local>
	<fa686aa40905191636u6f4a23d0xc8c6c13904a65b8e@mail.gmail.com>
	<20090520064218.GA29102@pengutronix.de>
	<A88094362DE0AE49A118AB9B4EB3612403F9DEBE@dekaexchange.deka.local>
Date: Wed, 20 May 2009 11:14:46 -0400
Message-ID: <9e4733910905200814p63915ff8pf65614dbb8dc9adf@mail.gmail.com>
Subject: Re: mpc5200 fec error
From: Jon Smirl <jonsmirl@gmail.com>
To: Eric Millbrandt <emillbrandt@dekaresearch.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 20, 2009 at 9:42 AM, Eric Millbrandt
<emillbrandt@dekaresearch.com> wrote:
>> > I am able to reproduce the error using 2.6.29.2-rt11. =A0I was able to
>> > mitigate the problem by raising the priority of the transmit irq.
>> > However when running an NFS server on the pcm030 under high cpu load I
>> > now get
>> >
>> > [ =A0132.477503] net eth0: FEC_IEVENT_RFIFO_ERROR
>> > [ =A0132.892329] net eth0: FEC_IEVENT_RFIFO_ERROR
>> > [ =A0133.884109] net eth0: FEC_IEVENT_RFIFO_ERROR
>> > [ =A0134.876059] net eth0: FEC_IEVENT_RFIFO_ERROR
>> >
>> > Raising the priority of the rx irq does not seem to fix this problem
>> > though.
>>
>> Hi Eric,
>>
>> This error has been seen before in non-rt kernels. =A0I haven't had the
>> chance to track it down and kill it yet. =A0I believe there are locking
>> issues associated with it.
>
> Uuuh, I recall this message. Kept me busy for some time :(
>
> You might try this patch which helped in our situation.
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Subject: Enable XLB pipelining for MPC5200B
> From: Wolfram Sang <w.sang@pengutronix.de>
>
> Enable pipelining as it helps getting rid of FEC problems.
> Not intended for upstream, this must be dealt differently there.
>
> This patch is disabled by default. The bootloader should enable this feat=
ure.
> So, this patch is only intended to be used where the bootloader does it i=
n a
> wrong manner and can't be replaced.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Acked-by: Juergen Beisert <j.beisert@pengutronix.de>
>
> ---
> =A0arch/powerpc/platforms/52xx/mpc52xx_common.c | =A0 =A07 +++++++
> =A01 file changed, 7 insertions(+)
>
> Index: arch/powerpc/platforms/52xx/mpc52xx_common.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- arch/powerpc/platforms/52xx/mpc52xx_common.c.orig
> +++ arch/powerpc/platforms/52xx/mpc52xx_common.c
> @@ -107,6 +107,13 @@ mpc5200_setup_xlb_arbiter(void)
> =A0 =A0 =A0 =A0 */
> =A0 =A0 =A0 =A0if ((mfspr(SPRN_SVR) & MPC5200_SVR_MASK) =3D=3D MPC5200_SV=
R)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0out_be32(&xlb->config, in_be32(&xlb->confi=
g) | MPC52xx_XLB_CFG_PLDIS);
> +#if 0
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Enable pipelining, fixes FEC problems. The previous wo=
rkaround is not
> + =A0 =A0 =A0 =A0* needed, as we have an MPC5200B (not A).
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 out_be32(&xlb->config, in_be32(&xlb->config) & ~MPC52xx_XLB=
_CFG_PLDIS);
> +#endif
>
> =A0 =A0 =A0 =A0iounmap(xlb);
> =A0}
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | Wo=
lfram Sang =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0|
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/ =A0|
>
> Wolfram,
>
> Thanks, but no luck with this patch. =A0It was already setup correctly by=
 U-Boot.


I don't see where this gets enabled in the u-boot source. Have you
added it locally?

These are the only two I see:
cpu/mpc5xxx/cpu_init.c:	*(vu_long *)(MPC5XXX_XLBARB + 0x40) |=3D (1 << 13);
cpu/mpc5xxx/cpu_init.c:	*(vu_long *)(MPC5XXX_XLBARB + 0x40) |=3D (1 << 15);


--=20
Jon Smirl
jonsmirl@gmail.com
