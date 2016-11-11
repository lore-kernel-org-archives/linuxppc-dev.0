Return-Path: <chunkeey@googlemail.com>
Received: from mail-wm0-x242.google.com (mail-wm0-x242.google.com
 [IPv6:2a00:1450:400c:c09::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFsjP12kqzDvrM
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 12 Nov 2016 07:59:20 +1100 (AEDT)
Received: by mail-wm0-x242.google.com with SMTP id u144so8029wmu.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 12:59:20 -0800 (PST)
From: Christian Lamparter <chunkeey@googlemail.com>
To: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: John Youn <johnyoun@synopsys.com>, Mark Rutland <mark.rutland@arm.com>,
 Rob Herring <robh+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Felipe Balbi <felipe.balbi@linux.intel.com>
Subject: [PATCH 2/2] usb: dwc2: fixes host_dma logic
Date: Fri, 11 Nov 2016 21:59:14 +0100
Message-Id: <4043f817106c8dffdc9a3f411d965465168b263d.1478897792.git.chunkeey@gmail.com>
In-Reply-To: <b1ec4a4425388cdee36be081971484db2a7d048a.1478897792.git.chunkeey@gmail.com>
References: <b1ec4a4425388cdee36be081971484db2a7d048a.1478897792.git.chunkeey@gmail.com>
In-Reply-To: <b1ec4a4425388cdee36be081971484db2a7d048a.1478897792.git.chunkeey@gmail.com>
References: <b1ec4a4425388cdee36be081971484db2a7d048a.1478897792.git.chunkeey@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch moves the the host_dma initialization
before dwc2_set_param_dma_desc_enable and
dwc2_set_param_dma_desc_fs_enable. The reason being
that both function need it.

Fixes: 1205489cee75bf39 ("usb: dwc2: Get host DMA device properties")

Cc: John Youn <johnyoun@synopsys.com>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---
 drivers/usb/dwc2/params.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
index 5d822c5..222a83c 100644
--- a/drivers/usb/dwc2/params.c
+++ b/drivers/usb/dwc2/params.c
@@ -1157,9 +1157,6 @@ static void dwc2_set_parameters(struct dwc2_hsotg *hsotg,
 	bool dma_capable = !(hw->arch == GHWCFG2_SLAVE_ONLY_ARCH);
 
 	dwc2_set_param_otg_cap(hsotg, params->otg_cap);
-	dwc2_set_param_dma_desc_enable(hsotg, params->dma_desc_enable);
-	dwc2_set_param_dma_desc_fs_enable(hsotg, params->dma_desc_fs_enable);
-
 	if ((hsotg->dr_mode == USB_DR_MODE_HOST) ||
 	    (hsotg->dr_mode == USB_DR_MODE_OTG)) {
 		bool disable;
@@ -1174,6 +1171,8 @@ static void dwc2_set_parameters(struct dwc2_hsotg *hsotg,
 				    !disable, false,
 				    dma_capable);
 	}
+	dwc2_set_param_dma_desc_enable(hsotg, params->dma_desc_enable);
+	dwc2_set_param_dma_desc_fs_enable(hsotg, params->dma_desc_fs_enable);
 
 	dwc2_set_param_host_support_fs_ls_low_power(hsotg,
 			params->host_support_fs_ls_low_power);
-- 
2.10.2
