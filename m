Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.67.118]) by ozlabs.org (Postfix) with ESMTP id 3B053DE037
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 28 Apr 2007 05:50:24 +1000 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-embedded@ozlabs.org,
	paulus@samba.org
Subject: [PATCH 0/7] Revised Xilinx virtex establish sanity patchset
Date: Fri, 27 Apr 2007 13:49:57 -0600
Message-Id: <11777034052773-git-send-email-grant.likely@secretlab.ca>
Cc: Peter Korsgaard <jacmet@sunsite.dk>,
	Andrei Konovalov <akonovalov@ru.mvista.com>,
	Rick Moleres <Rick.Moleres@xilinx.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Based on received comments, I posting this revised patchset for Virtex
cleanup in arch/ppc.  Changes from the last set include Kconfig tweaks,
support for more than 4 serial ports, xparams fixups pulled from Xilinx
code.  Biggest change is the move to use ppcboot.h for bd_t definition
which makes u-boot work correctly with the in-tree virtex ports.

Paul, I believe this patch set is ready for merging.  You can also pull
it from the 'virtex-forupstream' branch of my git tree if you prefer:

git://git.secretlab.ca/git/linux-2.6.git virtex-forupstream

Cheers,
g.

--- original description:

The Virtex support in Linus' tree is a mess.  When I ported the common
devices over to using the platform bus I tried the use the ppc_sys
infrastructure.  ppc_sys is intended for SoCs that have a fixed set of
devices.  It is the *wrong* approach for FPGA support, and I made a
royal mess of things.  This patch set fixes that problem and makes
a number of other changes that make supporting Virtex boards easier.

I do know that changes to arch/ppc are frowned upon at the moment.  However,
4xx support in arch/powerpc is not merged yet, and Virtex support needs
additional work beyond that.  I suspect that arch/ppc support for the
4xx parts is going to need to stay alive for the next 2-3 kernel releases
anyway while arch/powerpc support stablizes.  Getting these patches in
will make it easier to support the Virtex ports while I hack on getting
arch/powerpc stuff figured out.
