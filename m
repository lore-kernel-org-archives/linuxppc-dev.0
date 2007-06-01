Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DED68DE05E
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 02:35:17 +1000 (EST)
Message-ID: <46604AE0.5040700@genesi-usa.com>
Date: Fri, 01 Jun 2007 17:35:44 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
References: <11798051102658-git-send-email-wei.zhang@freescale.com>	<11798051101543-git-send-email-wei.zhang@freescale.com>	<1179805110272-git-send-email-wei.zhang@freescale.com>	<1179805110278-git-send-email-wei.zhang@freescale.com>	<1179856792.27985.22.camel@rhino>	<46B96294322F7D458F9648B60E15112C234A2D@zch01exm26.fsl.freescale.net>	<F1C4E37E-FF0F-4A5F-AC49-860B4AAC4E28@kernel.crashing.org>	<46B96294322F7D458F9648B60E15112C30777C@zch01exm26.fsl.freescale.net>	<A7C2B8A9-AE89-4E00-9771-F3C21A610121@kernel.crashing.org>	<18015.48278.312517.781244@cargo.ozlabs.ibm.com>	<46B96294322F7D458F9648B60E15112C30780F@zch01exm26.fsl.freescale.net>
	<1180683854.19517.419.camel@localhost.localdomain>
In-Reply-To: <1180683854.19517.419.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Re enabling proper domain support on 32-bit... now, now, now please!

X guys won't merge in code, we've been punished by both sides on Pegasos
for nearly 12 months now after there's been a bunch of misguided attempts
to 'fix' domain support in X. The real fix is in the kernel to make it
very clear that domains and proper, per-domain bus numbering (not
global bus numbering) and suchlike is the standard like it is on SPARC
and PPC64 and IA64.

If ppc32 suddenly goes the way of these, X guys will fix it, there will
be patches to work against this kernel, even if they have to detect the
kernel version to do it or look at a procfs or sysfs entry to fix up
their dumb pci scanning code.

I don't think stalling on it "because of X" is right. Fix Linux, X will
follow, because it really has to.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Benjamin Herrenschmidt wrote:
> On Fri, 2007-06-01 at 14:45 +0800, Zhang Wei-r63237 wrote:
>> There are lots of lagacy PCI codes in kernel, such as
>> pci_bus_to_hose(busnr). If two hose's bus number have overlaps,
>> pci_bus_to_hose() can not return the correct hose. And there will
>> effect
>> /proc/pci and lspci tools.
> 
> More specifically...
> 
> Overlapping bus numbers on separate domains work... on 64 bits :-) The
> 32 bits PCI code assumes non-overlapping numbers. The main reason for
> that historically was that back then, domains didn't work well.
> 
> The second reasons why I didn't actually fix it is that turning on full
> domain support had (and probably still has) the nasty habit of breaking
> the X server :-( X is full of most horrible hacks for PCI and it will be
> terminally broken until they finally merge the pci-rework branch that
> Ian Romanick's been working on for some time now.
> 
> One of these days, one of us will finally tackle merging 32 and 64 bits
> PCI code (and fix both of them while at it to better use the generic
> code, which involves fixing issues in the said generic code too :-) at
> which point I'll enable full domain support for 32 bits as well, with an
> option to degrade it to bus number remapping.
> 
> Ben.
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
