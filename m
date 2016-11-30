Return-Path: <brking@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTYSv4Pf7zDvxC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 08:29:03 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAULSmZT026087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 16:29:00 -0500
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2723qah9ek-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 16:29:00 -0500
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Wed, 30 Nov 2016 14:28:59 -0700
Subject: Re: [PATCH] scsi/ipr: Fix runaway IRQs when falling back from MSI to
 LSI
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linux-scsi@vger.kernel.org
References: <1479947042.10230.88.camel@kernel.crashing.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 linuxppc dev list <linuxppc-dev@lists.ozlabs.org>
From: Brian King <brking@linux.vnet.ibm.com>
Date: Wed, 30 Nov 2016 15:28:55 -0600
MIME-Version: 1.0
In-Reply-To: <1479947042.10230.88.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
Message-Id: <683a1049-2ff3-2777-b908-062212008ae4@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Looks good. Thanks! Here is an updated version that should apply
cleanly on top of scsi-next.

8<
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>

LSIs must be ack'ed with an MMIO otherwise they remain asserted
forever. This is controlled by the "clear_isr" flag.

While we set that flag properly when deciding initially whether
to use LSIs or MSIs, we fail to set it if we first chose MSIs,
the test fails, then fallback to LSIs.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
---

 drivers/scsi/ipr.c |    1 +
 1 file changed, 1 insertion(+)

diff -puN drivers/scsi/ipr.c~ipr_misx_fail_intx_clear_isr drivers/scsi/ipr.c
--- scsi/drivers/scsi/ipr.c~ipr_misx_fail_intx_clear_isr	2016-11-29 20:56:27.902534325 -0600
+++ scsi-bjking1/drivers/scsi/ipr.c	2016-11-29 20:56:50.645538533 -0600
@@ -10157,6 +10157,7 @@ static int ipr_probe_ioa(struct pci_dev
 			pci_free_irq_vectors(pdev);
 
 			ioa_cfg->nvectors = 1;
+			ioa_cfg->clear_isr = 1;
 			break;
 		default:
 			goto out_msi_disable;
_
