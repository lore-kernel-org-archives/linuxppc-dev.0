Return-Path: <andriy.shevchenko@linux.intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by lists.ozlabs.org (Postfix) with ESMTP id 36B2B1A026F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Mar 2015 07:41:28 +1100 (AEDT)
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, rsarmah@amcc.com,
 Alexey Brodkin <Alexey.Brodkin@synopsys.com>
Subject: [PATCH v1 0/2] sata_dwc_460ex: move to generic DMA driver
Date: Tue,  3 Mar 2015 22:41:20 +0200
Message-Id: <1425415282-3750-1-git-send-email-andriy.shevchenko@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The SATA implementation based on two actually different devices, i.e. SATA and
DMA controllers.

For Synopsys DesignWare DMA we have already a generic implementation of the
driver. Thus, the patch 1/2 converts the code to use DMAEngine framework and
dw_dmac driver.

In future it will be better to split the devices inside DTS as well like it's
done on other platforms and remove hardcoded parameters of DMA controller.

Besides it's a nice clean up it removes a lot of warnings produced by the
original code, that pissed off even Linus [1]. Though, this series doesn't
re-enable COMPILE_TEST for this module.

The driver is compile tested only on x86. So, it would be nice if anyone who
has either AMCC 460EX Canyonlands board or similar SATA controller in
possession can test this.

[1] http://www.spinics.net/lists/linux-ide/msg50334.html

Andy Shevchenko (2):
  sata_dwc_460ex: move to generic DMA driver
  sata_dwc_460ex: re-use hsdev->dev instead of dwc_dev

 drivers/ata/sata_dwc_460ex.c | 753 ++++++++-----------------------------------
 1 file changed, 130 insertions(+), 623 deletions(-)

-- 
2.1.4
