Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 15B352C007C
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Jun 2013 07:43:48 +1000 (EST)
Date: Wed, 26 Jun 2013 16:42:30 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
In-Reply-To: <OF239E7E70.94A77B69-ONC1257B95.0020B40D-C1257B95.0020FEEE@transmode.se>
 (from joakim.tjernlund@transmode.se on Tue Jun 25 01:00:23 2013)
Message-ID: <1372282950.8183.43@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>, Bob Cochran <ppc@mindchasers.com>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 Dan Malek <ppc6dev@digitaldans.com>, Support <support@abatron.ch>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/25/2013 01:00:23 AM, Joakim Tjernlund wrote:
> Scott Wood <scottwood@freescale.com> wrote on 2013/06/25 02:51:00:
> >
> > On Fri, Jul 20, 2012 at 10:37:17AM +0200, Joakim Tjernlund wrote:
> > > Zang Roy-R61911 <r61911@freescale.com> wrote on 2012/07/20 =20
> 10:27:52:
> > > >
> > > >
> > > >
> > > > > -----Original Message-----
> > > > > From:
> linuxppc-dev-bounces+tie-fei.zang=3Dfreescale.com@lists.ozlabs.org
> > > > > [
> mailto:linuxppc-dev-bounces+tie-fei.zang=3Dfreescale.com@lists.ozlabs.org=
]
> > > > > On Behalf Of Joakim Tjernlund
> > > > > Sent: Friday, June 01, 2012 6:36 AM
> > > > > To: Wood Scott-B07421
> > > > > Cc: linuxppc-dev@ozlabs.org; Dan Malek; Bob Cochran; Support
> > > > > Subject: Re: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
> > > > >
> > > > > It just occurred to me that you guys have this already in your
> Linux SDK so
> > > > > it can't be that bad.
> > > > No. MSR_DE is ONLY added when using CW debug in SDK.
> > > > Roy
> > > >
> > >
> > > Yes, and I later found that user space debugging is busted if you =20
> turn
> on MSR_DE in
> > > kernel.
> >
> > So, how should we handle the CONFIG_BDI_SWITCH patch?  It seems =20
> like it
> > should at least have a warning in the kconfig help text that it =20
> breaks
> > userspace debugging (to the point of causing a kernel oops if it's
> > tried).  Or maybe it can deselect CONFIG_PPC_ADV_DEBUG_REGS?
> >
> > It'd also be nice to keep things like this, that are a consequence =20
> of
> how
> > external debug works on e500, separate from the Abatron-specific =20
> stuff.
> >
>=20
> I was hoping the kernel would grow per context handling of MSR_DE. =20
> Then
> one could have
> MSR_DE on in MSR_KERNEL but off in user space(unless gdb request it =20
> on a
> per process basis).

What if the external debugger wants debugging to work when in userspace =20
as well?  Plus, you wouldn't be able to debug from the very beginning =20
of an exception handler if the exception came from userspace.

-Scott=
