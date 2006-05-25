Return-Path: <paul.gortmaker@windriver.com>
Received: from mail.wrs.com (mail.windriver.com [147.11.1.11])
	by ozlabs.org (Postfix) with ESMTP id 0777E67A79
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 26 May 2006 08:47:09 +1000 (EST)
Date: Thu, 25 May 2006 14:15:55 -0400
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: linuxppc-embedded@ozlabs.org
Subject: [PATCH 0/5] Updates for WRS SBC82xx boards
Message-ID: <20060525181554.GB679@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: p_gortmaker@yahoo.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

There are five patches required to use the WRS SBC8265 board (with PCI).
The biggest issue was the earlier cleanup/replacement of m8260_pci with
m82xx_pci -- in the process it became specific to the PQ2FADS.

I've booted on 2.6.17rc3, and they still apply to 17rc4-git12 snapshot,
but I wouldn't be surprised if the CPM UART changes in rc3 --> rc4 break
sbc82xx CPM serial as I see Vitaly is still working on that.

Paul.

----

patch1: sbc82xx-diff0
	- replace NR_SIU_INTS with NR_CPM_INTS

patch2: sbc82xx-PCI-diff1
	- allow m82xx_pci.c to be used by other platforms that have
	  their own map_irq

patch3: sbc82xx-CONFIG.diff1
	- add CONFIG_SBC82xx alongside CONFIG_PQ2FADS where required.

patch4: sbc82xx-mchk-pci9.diff1
	- restore machine check disable for PCI9 that was in earlier
	  m8260_pci.c

patch5: fcc_enet-mac-addr.diff1
	- restore proper collection of mac addr data in obsolete FCC
	  driver by replacing mix of #ifdef and if() with case
