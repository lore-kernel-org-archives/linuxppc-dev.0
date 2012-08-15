Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EB3D12C008D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Aug 2012 08:43:10 +1000 (EST)
Message-ID: <1345070575.11751.8.camel@pasglop>
Subject: Re: [PATCH V7 1/3] powerpc/pci: Make sure ISA IO base is not zero
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Thu, 16 Aug 2012 08:42:55 +1000
In-Reply-To: <502C1B64.8050505@freescale.com>
References: <1345021026-10886-1-git-send-email-B38951@freescale.com>
 <1345021026-10886-2-git-send-email-B38951@freescale.com>
 <502BDC6B.4090800@freescale.com> <1345066379.11596.1.camel@pasglop>
 <502C1B64.8050505@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: B07421@freescale.com, linuxppc-dev@lists.ozlabs.org,
 Jia Hongtao <B38951@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-08-15 at 16:57 -0500, Scott Wood wrote:
> Is there no lasting remnant of that temporary wrong isa_io_base?  We
> won't have I/O resources that were calculated relative to that, which
> stop working once isa_io_base changes?  Or does that happen later, after
> this function has been called on all buses (and would that continue to
> be the case if we change the PCI bus to a platform device)?

If you continue creating your PCI busses all at once early on you'll be
fine. The platform device business is going to break that (and other
things as well btw, such as pci_final_fixup).

Maybe it's time to contemplate doing something more like ppc64 and
reserve a piece of virtual address space (I know there isn't much, so
make it 64k per bus max) and just map the busses in there with the first
64k being reserved for the ISA stuff if it exists ?

Cheers,
Ben.
