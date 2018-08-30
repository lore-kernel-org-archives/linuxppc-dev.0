Return-Path: <hofrat@osadl.org>
Received: from www.osadl.org (www.osadl.org [62.245.132.105])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 421KG42RPVzF35n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Aug 2018 20:57:47 +1000 (AEST)
From: Nicholas Mc Guire <hofrat@osadl.org>
To: Li Yang <leoyang.li@nxp.com>
Cc: Felipe Balbi <balbi@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH 2/2] usb: gadget: fsl_udc_core: fixup struct_udc_setup
 documentation
Date: Thu, 30 Aug 2018 12:16:59 +0200
Message-Id: <1535624219-17854-2-git-send-email-hofrat@osadl.org>
In-Reply-To: <1535624219-17854-1-git-send-email-hofrat@osadl.org>
References: <1535624219-17854-1-git-send-email-hofrat@osadl.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The original implementation from commit b504882da539
("USB: add Freescale high-speed USB SOC device controller driver")
returned NULL on failure and an allocated + initialized struct fsl_udc on
success. The current code introduced in commit 4365831dadfe
("USB: fsl_usb2_udc: Get max ep number from DCCPARAMS register") only
provides partial initialization as well as returning 0 on success and -1
on failures. The function documentation is updated accordingly.

Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
Fixes: 4365831dadfe ("USB: fsl_usb2_udc: Get max ep number from DCCPARAMS register")
---

Problem located during code-review

Patch is against 4.19-rc1 (localversion-next is next-20180830)

 drivers/usb/gadget/udc/fsl_udc_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/fsl_udc_core.c b/drivers/usb/gadget/udc/fsl_udc_core.c
index e637afb..680b46e 100644
--- a/drivers/usb/gadget/udc/fsl_udc_core.c
+++ b/drivers/usb/gadget/udc/fsl_udc_core.c
@@ -2234,8 +2234,10 @@ static void fsl_udc_release(struct device *dev)
 	Internal structure setup functions
 *******************************************************************/
 /*------------------------------------------------------------------
- * init resource for globle controller
- * Return the udc handle on success or NULL on failure
+ * init resource for global controller called by fsl_udc_probe()
+ * On success the udc handle is initialized, on failure it is
+ * unchanged (reset).
+ * Return 0 on success and -1 on allocation failure
  ------------------------------------------------------------------*/
 static int struct_udc_setup(struct fsl_udc *udc,
 		struct platform_device *pdev)
-- 
2.1.4
