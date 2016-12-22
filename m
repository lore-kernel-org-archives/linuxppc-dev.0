Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tkdl86bvfzDwP4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 15:26:44 +1100 (AEDT)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uBM4NfTS027946
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 23:26:41 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 27g1uu8944-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Dec 2016 23:26:41 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 22 Dec 2016 14:26:37 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3C5B82BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 15:26:34 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uBM4QYOD32768018
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 15:26:34 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uBM4QXcP021111
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Dec 2016 15:26:34 +1100
Date: Thu, 22 Dec 2016 15:26:33 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org,
 #v4.9+@gwshan.ozlabs.ibm.com
Subject: Re: [PATCH] drivers/pci/hotplug: Handle presence detection change
 properly
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1482216573-21487-1-git-send-email-gwshan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1482216573-21487-1-git-send-email-gwshan@linux.vnet.ibm.com>
Message-Id: <20161222042633.GA7205@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 20, 2016 at 05:49:33PM +1100, Gavin Shan wrote:
>The surprise hotplug is driven by interrupt in PowerNV PCI hotplug
>driver. In the interrupt handler, pnv_php_interrupt(), we bail when
>pnv_pci_get_presence_state() returns zero wrongly. It causes the
>presence change event is always ignored incorrectly.
>
>This fixes the issue by bailing on error (non-zero value) returned
>from pnv_pci_get_presence_state().
>
>Fixes: 360aebd85a4 ("drivers/pci/hotplug: Support surprise hotplug in powernv driver")
>Cc: stable@vger.kernel.org #v4.9+
>Reported-by: Hank Chang <hankmax0000@gmail.com>
>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>Tested-by: Willie Liauw <williel@supermicro.com.tw>
>---

Please ignore this one for now. I will post a revised series to fix
more issues found in recent testing. Also, the warning message will
be modified accordingly.

Thanks,
Gavin

> drivers/pci/hotplug/pnv_php.c | 6 +++++-
> 1 file changed, 5 insertions(+), 1 deletion(-)
>
>diff --git a/drivers/pci/hotplug/pnv_php.c b/drivers/pci/hotplug/pnv_php.c
>index 56efaf7..38a2309 100644
>--- a/drivers/pci/hotplug/pnv_php.c
>+++ b/drivers/pci/hotplug/pnv_php.c
>@@ -707,8 +707,12 @@ static irqreturn_t pnv_php_interrupt(int irq, void *data)
> 		added = !!(lsts & PCI_EXP_LNKSTA_DLLLA);
> 	} else if (sts & PCI_EXP_SLTSTA_PDC) {
> 		ret = pnv_pci_get_presence_state(php_slot->id, &presence);
>-		if (!ret)
>+		if (ret) {
>+			dev_warn(&pdev->dev, "PCI slot [%s] error %d handling PDC event (0x%04x)\n",
>+				php_slot->name, ret, sts);
> 			return IRQ_HANDLED;
>+		}
>+
> 		added = !!(presence == OPAL_PCI_SLOT_PRESENT);
> 	} else {
> 		return IRQ_NONE;
>-- 
>2.7.4
>
