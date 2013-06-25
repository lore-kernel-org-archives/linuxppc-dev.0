Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 27D302C0082
 for <linuxppc-dev@ozlabs.org>; Tue, 25 Jun 2013 16:05:53 +1000 (EST)
In-Reply-To: <20130625005100.GA22976@home.buserror.net>
References: <13517672561.20120531113057@abatron.ch>
 <OF1016B1AA.DF19B646-ONC1257A0F.003647EF-C1257A0F.003699E5@transmode.se>
 <4FC7AEC9.5050203@freescale.com>
 <OF3AA5925F.E17EF6A4-ONC1257A0F.0076C23F-C1257A0F.0076D836@transmode.se>
 <4FC7E606.1070205@freescale.com>
 <OF43D61D1E.31CC8410-ONC1257A0F.0079F3A4-C1257A0F.007A237A@transmode.se>
 <4FC7EDD5.8090302@freescale.com>
 <OFDC3DAEDA.27E0B532-ONC1257A0F.007BF637-C1257A0F.007C1E26@transmode.se>
 <3E027F8168735B46AC006B1D0C7BB002079C3290@039-SN2MPN1-013.039d.mgd.msft.net>
 <OF2715F7FE.447A7381-ONC1257A41.002F433E-C1257A41.002F5BFA@transmode.se>
 <20130625005100.GA22976@home.buserror.net>
To: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
Subject: Re: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <OF239E7E70.94A77B69-ONC1257B95.0020B40D-C1257B95.0020FEEE@transmode.se>
Date: Tue, 25 Jun 2013 08:00:23 +0200
Content-Type: text/plain; charset="US-ASCII"
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

Scott Wood <scottwood@freescale.com> wrote on 2013/06/25 02:51:00:
> 
> On Fri, Jul 20, 2012 at 10:37:17AM +0200, Joakim Tjernlund wrote:
> > Zang Roy-R61911 <r61911@freescale.com> wrote on 2012/07/20 10:27:52:
> > >
> > >
> > >
> > > > -----Original Message-----
> > > > From: 
linuxppc-dev-bounces+tie-fei.zang=freescale.com@lists.ozlabs.org
> > > > [
mailto:linuxppc-dev-bounces+tie-fei.zang=freescale.com@lists.ozlabs.org]
> > > > On Behalf Of Joakim Tjernlund
> > > > Sent: Friday, June 01, 2012 6:36 AM
> > > > To: Wood Scott-B07421
> > > > Cc: linuxppc-dev@ozlabs.org; Dan Malek; Bob Cochran; Support
> > > > Subject: Re: [RFC] [PATCH] powerpc: Add MSR_DE to MSR_KERNEL
> > > >
> > > > It just occurred to me that you guys have this already in your 
Linux SDK so
> > > > it can't be that bad.
> > > No. MSR_DE is ONLY added when using CW debug in SDK.
> > > Roy
> > >
> > 
> > Yes, and I later found that user space debugging is busted if you turn 
on MSR_DE in
> > kernel.
> 
> So, how should we handle the CONFIG_BDI_SWITCH patch?  It seems like it
> should at least have a warning in the kconfig help text that it breaks
> userspace debugging (to the point of causing a kernel oops if it's
> tried).  Or maybe it can deselect CONFIG_PPC_ADV_DEBUG_REGS?
> 
> It'd also be nice to keep things like this, that are a consequence of 
how
> external debug works on e500, separate from the Abatron-specific stuff.
> 

I was hoping the kernel would grow per context handling of MSR_DE. Then 
one could have
MSR_DE on in MSR_KERNEL but off in user space(unless gdb request it on a 
per process basis). 

 Jocke
