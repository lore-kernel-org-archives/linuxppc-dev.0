Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sSLXd4R0NzDrnD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Sep 2016 17:12:49 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8572reu075668
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 03:12:46 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 258btyp1ba-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Sep 2016 03:12:46 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Mon, 5 Sep 2016 17:12:42 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 3B2F22BB0054
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Sep 2016 17:12:39 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u857CdBn7274816
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 17:12:39 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u857CcwC014278
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Sep 2016 17:12:38 +1000
Subject: Re: [PATCH 2/6] cxlflash: Remove the device cleanly in the system
 shutdown path
To: Uma Krishnan <ukrishn@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
References: <1472848612-64888-1-git-send-email-ukrishn@linux.vnet.ibm.com>
 <1472848756-64998-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ian Munsie <imunsie@au1.ibm.com>,
 Frederic Barrat <fbarrat@linux.vnet.ibm.com>,
 Christophe Lombard <clombard@linux.vnet.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Mon, 5 Sep 2016 17:12:37 +1000
MIME-Version: 1.0
In-Reply-To: <1472848756-64998-1-git-send-email-ukrishn@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <609a0eff-d4e4-03ea-739f-770fc24860ef@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/09/16 06:39, Uma Krishnan wrote:
> Commit 704c4b0ddc03 ("cxlflash: Shutdown notify support for CXL Flash
> cards") was recently introduced to notify the AFU when a system is going
> down. Due to the position of the cxlflash driver in the device stack,
> cxlflash devices are _always_ removed during a reboot/shutdown. This can
> lead to a crash if the cxlflash shutdown hook is invoked _after_ the
> shutdown hook for the owning virtual PHB. Furthermore, the current
> implementation of shutdown/remove hooks for cxlflash are not tolerant to
> being invoked when the device is not enabled. This can also lead to a
> crash in situations where the remove hook is invoked after the device has
> been removed via the vPHBs shutdown hook. An example of this scenario
> would be an EEH reset failure while a reboot/shutdown is in progress.
>
> To solve both problems, the shutdown hook for cxlflash is updated to
> simply remove the device. This path already includes the AFU notification
> and thus this solution will continue to perform the original intent. At
> the same time, the remove hook is updated to protect against being
> called when the device is not enabled.
>
> Fixes: 704c4b0ddc03 ("cxlflash: Shutdown notify support for CXL Flash
> cards")
> Signed-off-by: Uma Krishnan <ukrishn@linux.vnet.ibm.com>
> ---
>  drivers/scsi/cxlflash/main.c | 18 ++++++------------
>  1 file changed, 6 insertions(+), 12 deletions(-)
>
> diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
> index b063c41..4c2559a 100644
> --- a/drivers/scsi/cxlflash/main.c
> +++ b/drivers/scsi/cxlflash/main.c
> @@ -823,17 +823,6 @@ static void notify_shutdown(struct cxlflash_cfg *cfg, bool wait)
>  }
>
>  /**
> - * cxlflash_shutdown() - shutdown handler
> - * @pdev:	PCI device associated with the host.
> - */
> -static void cxlflash_shutdown(struct pci_dev *pdev)
> -{
> -	struct cxlflash_cfg *cfg = pci_get_drvdata(pdev);
> -
> -	notify_shutdown(cfg, false);

You can get rid of the second parameter to notify_shutdown() now.

> -}
> -
> -/**
>   * cxlflash_remove() - PCI entry point to tear down host
>   * @pdev:	PCI device associated with the host.
>   *
> @@ -844,6 +833,11 @@ static void cxlflash_remove(struct pci_dev *pdev)
>  	struct cxlflash_cfg *cfg = pci_get_drvdata(pdev);
>  	ulong lock_flags;
>
> +	if (!pci_is_enabled(pdev)) {
> +		pr_debug("%s: Device is disabled\n", __func__);
> +		return;
> +	}
> +
>  	/* If a Task Management Function is active, wait for it to complete
>  	 * before continuing with remove.
>  	 */
> @@ -2685,7 +2679,7 @@ static struct pci_driver cxlflash_driver = {
>  	.id_table = cxlflash_pci_table,
>  	.probe = cxlflash_probe,
>  	.remove = cxlflash_remove,
> -	.shutdown = cxlflash_shutdown,
> +	.shutdown = cxlflash_remove,

What's the justification for using cxlflash_remove() as the shutdown 
hook, rather than just not having a shutdown hook at all?

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
