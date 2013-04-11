Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 00FCF2C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Apr 2013 00:47:31 +1000 (EST)
Date: Thu, 11 Apr 2013 09:47:03 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V5] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
To: Jia Hongtao-B38951 <B38951@freescale.com>
References: <1365409614-2634-1-git-send-email-hongtao.jia@freescale.com>
 <1365630703.8381.23@snotra>
 <412C8208B4A0464FA894C5F0C278CD5D01C35D42@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <412C8208B4A0464FA894C5F0C278CD5D01C35D42@039-SN1MPN1-003.039d.mgd.msft.net>
 (from B38951@freescale.com on Thu Apr 11 04:14:51 2013)
Message-ID: <1365691623.3640.0@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/11/2013 04:14:51 AM, Jia Hongtao-B38951 wrote:
>=20
>=20
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Thursday, April 11, 2013 5:52 AM
> > To: Jia Hongtao-B38951
> > Cc: linuxppc-dev@lists.ozlabs.org; galak@kernel.crashing.org; Wood =20
> Scott-
> > B07421; Li Yang-R58472; Jia Hongtao-B38951
> > Subject: Re: [PATCH V5] powerpc/85xx: Add machine check handler to =20
> fix
> > PCIe erratum on mpc85xx
> >
> > The X and (especially for PCI) BRX versions are important -- =20
> probably
> > more so than the U versions.  I doubt we need the A variant.
>=20
> Then I will add X and BRX variant and remove A variant.
>=20
> >
> > If you do support the A variant, why are you not sign-extending the
> > value?
>=20
> Just curious, sign-extending the value means fill rd with 0xffffffff?

Or 0xffffffffffffffff on 64-bit (even if you're not going to implement =20
64-bit instructions, the ones you do implement shouldn't misbehave =20
there).  You could write it as "regs->gpr[rd] =3D ~0UL".

-Scott=
