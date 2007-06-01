Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 62B02DDFAC
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 02:47:24 +1000 (EST)
Subject: Re: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
From: Jon Loeliger <jdl@freescale.com>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <46604AE0.5040700@genesi-usa.com>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
	<1179856792.27985.22.camel@rhino>
	<46B96294322F7D458F9648B60E15112C234A2D@zch01exm26.fsl.freescale.net>
	<F1C4E37E-FF0F-4A5F-AC49-860B4AAC4E28@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C30777C@zch01exm26.fsl.freescale.net>
	<A7C2B8A9-AE89-4E00-9771-F3C21A610121@kernel.crashing.org>
	<18015.48278.312517.781244@cargo.ozlabs.ibm.com>
	<46B96294322F7D458F9648B60E15112C30780F@zch01exm26.fsl.freescale.net>
	<1180683854.19517.419.camel@localhost.localdomain>
	<46604AE0.5040700@genesi-usa.com>
Content-Type: text/plain
Message-Id: <1180716433.14219.11.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 01 Jun 2007 11:47:13 -0500
Cc: Wei Zhang <Wei.Zhang@freescale.com>, Paul Mackerras <paulus@samba.org>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-01 at 11:35, Matt Sealey wrote:
> Re enabling proper domain support on 32-bit... now, now, now please!
> 
> X guys won't merge in code, we've been punished by both sides on Pegasos
> for nearly 12 months now after there's been a bunch of misguided attempts
> to 'fix' domain support in X. The real fix is in the kernel to make it
> very clear that domains and proper, per-domain bus numbering (not
> global bus numbering) and suchlike is the standard like it is on SPARC
> and PPC64 and IA64.
> 
> If ppc32 suddenly goes the way of these, X guys will fix it, there will
> be patches to work against this kernel, even if they have to detect the
> kernel version to do it or look at a procfs or sysfs entry to fix up
> their dumb pci scanning code.
> 
> I don't think stalling on it "because of X" is right. Fix Linux, X will
> follow, because it really has to.

OK.  Let me interpret this for my (8641) case:

These two lines of quirky code in _exclude_device()
are not ideal, but they adjust for a PCI systemic 
problem that isn't going to be fixed any time soon.

Therefore, I will go ahead and repost my PCI patch
series to get PCI-E working again on 8641, and pointed
in the right direction so we can merge in the support
for 8548 and 8544 as follow ups.

We (collectively) will then address the systemic PCI
problem with 32-bit systems later.

Thanks,
jdl
