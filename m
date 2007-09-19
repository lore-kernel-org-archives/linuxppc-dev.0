Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 499E4DDE3E
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Sep 2007 04:40:10 +1000 (EST)
Message-ID: <46F16CC9.3010003@ru.mvista.com>
Date: Wed, 19 Sep 2007 22:39:05 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Sequoia kernel crash workaround.
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've observed kernel crashes on Sequoia board several times.
Kernel often crashes with high network/memory loads.
This is due to 440EPx h/w issue.

According to the errata:
CHIP_8: Incorrect Write to DDR SDRAM.
Category: 3
Overview:
The write address can be corrupted during writes to DDR SDRAM when write 
pipelining is enabled on PLB0. The probability of encountering the 
problem increases with the amount of back-pressure applied by the SDRAM.
Impact: Data can be written to the wrong address in SDRAM.
Workaround:
Disable write pipelining to DDR SDRAM by setting PLB4A0_ACR[WRP] = 0. 
Only primary write transfers are broadcast and the write address 
corruption is avoided.

Disabling write pipelining really helps.
Josh, David, what is the right place to put this workaround to?

Is it OK to do mtdcr(PLB4A0_ACR, mfdcr(PLB4A0_ACR) & ~PLB4_WRP); in
arch/powerpc/boot/cuboot-sequoia.c:sequoia_fixups()?
or
should this be done in
arch/powerpc/platforms/44x/sequoia.c:sequoia_setup_arch()
with dcr_map, dcr_read/write stuff?

Thanks,
Valentine.
