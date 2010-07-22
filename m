Return-Path: <yanok@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E2E0C1007D2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Jul 2010 07:27:43 +1000 (EST)
Message-ID: <4C48B384.1020006@emcraft.com>
Date: Fri, 23 Jul 2010 01:09:24 +0400
From: Ilya Yanok <yanok@emcraft.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Commit 3da34aa brakes MSI support on MPC8308 (possibly all MPC83xx)
	[REPOST]
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  Hi Kumar, Kim, Josh, everybody,

I hope to disturb you but I haven't got any reply for my first posting...

I've found that MSI work correctly with older kernels on my MPC8308RDB 
board and don't work with newer ones. After bisecting I've found that 
the source of the problem is commit 3da34aa:

commit 3da34aae03d498ee62f75aa7467de93cce3030fd
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Tue May 12 15:51:56 2009 -0500

     powerpc/fsl: Support unique MSI addresses per PCIe Root Complex

     Its feasible based on how the PCI address map is setup that the region
     of PCI address space used for MSIs differs for each PHB on the same 
SoC.

     Instead of assuming that the address mappes to CCSRBAR 1:1 we read
     PEXCSRBAR (BAR0) for the PHB that the given pci_dev is on.

     Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

I can see BAR0 initialization for 85xx/86xx hardware but not for 83xx 
neigher in the kernel nor in U-Boot (that makes me think that all 83xx 
can be affected).
I'm not actually an PCI expert so I've just tried to write IMMR base 
address to the BAR0 register from the U-Boot to get the correct address 
but this doesn't help.
Please direct me how to init 83xx PCIE controller to make it compatible 
with this patch.

Kim, I think MPC8315E is affected too, could you please test it?

Thanks in advance.

Regards, Ilya.
