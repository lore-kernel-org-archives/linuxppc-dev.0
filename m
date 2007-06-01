Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2553EDDFEA
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Jun 2007 17:44:26 +1000 (EST)
Subject: RE: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
In-Reply-To: <46B96294322F7D458F9648B60E15112C30780F@zch01exm26.fsl.freescale.net>
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
Content-Type: text/plain
Date: Fri, 01 Jun 2007 17:44:14 +1000
Message-Id: <1180683854.19517.419.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-01 at 14:45 +0800, Zhang Wei-r63237 wrote:
> There are lots of lagacy PCI codes in kernel, such as
> pci_bus_to_hose(busnr). If two hose's bus number have overlaps,
> pci_bus_to_hose() can not return the correct hose. And there will
> effect
> /proc/pci and lspci tools.

More specifically...

Overlapping bus numbers on separate domains work... on 64 bits :-) The
32 bits PCI code assumes non-overlapping numbers. The main reason for
that historically was that back then, domains didn't work well.

The second reasons why I didn't actually fix it is that turning on full
domain support had (and probably still has) the nasty habit of breaking
the X server :-( X is full of most horrible hacks for PCI and it will be
terminally broken until they finally merge the pci-rework branch that
Ian Romanick's been working on for some time now.

One of these days, one of us will finally tackle merging 32 and 64 bits
PCI code (and fix both of them while at it to better use the generic
code, which involves fixing issues in the said generic code too :-) at
which point I'll enable full domain support for 32 bits as well, with an
option to degrade it to bus number remapping.

Ben.
