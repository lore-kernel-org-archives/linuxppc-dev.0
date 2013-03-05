Return-Path: <B38951@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 93BB82C03AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2013 21:12:40 +1100 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Stuart Yoder <b08248@gmail.com>
Subject: RE: [PATCH V4] powerpc/85xx: Add machine check handler to fix PCIe
 erratum on mpc85xx
Date: Tue, 5 Mar 2013 10:12:30 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01BE952E@039-SN1MPN1-002.039d.mgd.msft.net>
References: <CALRxmdBjb+TrqZ_XdNjH=oDcdYtVJ5=Q71dcCkKodpe7WCHDpA@mail.gmail.com>	(from
 b08248@gmail.com on Mon Mar  4 10:16:10 2013) <1362440744.16575.6@snotra>
In-Reply-To: <1362440744.16575.6@snotra>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: Wood Scott-B07421
> Sent: Tuesday, March 05, 2013 7:46 AM
> To: Stuart Yoder
> Cc: Jia Hongtao-B38951; linuxppc-dev@lists.ozlabs.org; Kumar Gala
> Subject: Re: [PATCH V4] powerpc/85xx: Add machine check handler to fix
> PCIe erratum on mpc85xx
>=20
> On 03/04/2013 10:16:10 AM, Stuart Yoder wrote:
> > On Mon, Mar 4, 2013 at 2:40 AM, Jia Hongtao <B38951@freescale.com>
> > wrote:
> > > A PCIe erratum of mpc85xx may causes a core hang when a link of PCIe
> > > goes down. when the link goes down, Non-posted transactions issued
> > > via the ATMU requiring completion result in an instruction stall.
> > > At the same time a machine-check exception is generated to the core
> > > to allow further processing by the handler. We implements the
> > handler
> > > which skips the instruction caused the stall.
> >
> > Can you explain at a high level how just skipping an instruction
> > solves
> > anything?   If you just skip a load/store and continue like nothing is
> > wrong, isn't your system possibly in a really bad state.
>=20
> If the instruction was a load, we probably at least want to fill the
> destination register with 0xffffffff or similar.

You discuss this with Liu Shuo about a year ago.
here is the log:

"
On 02/01/2012 02:18 AM, shuo.liu@freescale.com wrote:
> v3 : Skip the instruction only. Don't access the user space memory in=20
>      mechine check.=20

It may be the least bad option for now, but be aware that there's a
small chance that this will cause a leak of sensitive information (such
as a piece of a crypto key that happened to be sitting in the register
to be loaded into).

-Scott
"

-Hongtao.

>=20
> > And if the core is already hung, due to the PCI link going down, isn't
> > it too late?   How does skipping help?
>=20
> Maybe the machine check unhangs the core?
>=20
> Is there an erratum number for this?
>=20
> -Scott
