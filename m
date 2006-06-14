Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id A0FED67B62
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Jun 2006 22:38:03 +1000 (EST)
Subject: RE: No ttyS device at I/O port 0xfe004500 for console
Date: Wed, 14 Jun 2006 14:37:56 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D9397E9DAC@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Alex Zeffertt" <ajz@cambridgebroadband.com>,
	"Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

=20
> Kumar Gala wrote:
> >> Here you go:
> >=20
> > Let me know if this fixes the issues you guys are seeing=20
> with your 83xx=20
> > boards.  If so, I'll clean up this patch and push it upstream.
> >=20
> > - k
>=20
>=20
> Great, thank you!
>=20
> Your patch and the params "console=3Duart,io,0xfe004500=20
> console=3DttyS0" in
> the kernel command line do the trick.

I think you should loose the "console=3Duart,io,0xfe004500", don't think
it is needed
sine the "console=3DttyS0" will override it.

>=20
> Alex
>=20
>=20
> >> +        .device_list    =3D (enum ppc_sys_devices[])
> >> +        {
> >> +            MPC83xx_IIC1, MPC83xx_DUART,
> >> +#ifdef CONFIG_QE
> >> +            MPC83xx_QE_UCC3, MPC83xx_QE_UCC4,
> >> +#endif
> >> +        },
> >> +    },
> >>      {    /* default match */
> >>          .ppc_sys_name    =3D "",
> >>          .mask         =3D 0x00000000,

This device list appears to be common to all 8323E CPUs and to me this
looks
like a board unique list. Seems to that this list is better off in the=20
mpc832xe_mds.c board file. That would make it easier for custom boards I
think.

 Jocke
