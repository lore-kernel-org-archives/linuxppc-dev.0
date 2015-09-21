Return-Path: <thenzl@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44CE71A0048
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Sep 2015 22:25:47 +1000 (AEST)
Subject: Re: [PATCH v2 21/30] cxlflash: Fix to prevent workq from accessing
 freed memory
To: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org,
 James Bottomley <James.Bottomley@HansenPartnership.com>,
 "Nicholas A. Bellinger" <nab@linux-iscsi.org>,
 Brian King <brking@linux.vnet.ibm.com>, Ian Munsie <imunsie@au1.ibm.com>,
 Daniel Axtens <dja@ozlabs.au.ibm.com>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>
References: <1442438635-49044-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <1442439105-50148-1-git-send-email-mrochs@linux.vnet.ibm.com>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
From: Tomas Henzl <thenzl@redhat.com>
Message-ID: <55FFF745.8080802@redhat.com>
Date: Mon, 21 Sep 2015 14:25:41 +0200
MIME-Version: 1.0
In-Reply-To: <1442439105-50148-1-git-send-email-mrochs@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 16.9.2015 23:31, Matthew R. Ochs wrote:
> The workq can process work in parallel with a remove event, leading
> to a condition where the workq handler can access freed memory.
>
> To remedy, the workq should be terminated prior to freeing memory. Move
> the termination call earlier in remove and use cancel_work_sync() instead
> of flush_work() as there is not a need to process any scheduled work when
> shutting down.
>
> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
> ---
>  drivers/scsi/cxlflash/main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/scsi/cxlflash/main.c b/drivers/scsi/cxlflash/main.c
> index 1856a73..1625aea 100644
> --- a/drivers/scsi/cxlflash/main.c
> +++ b/drivers/scsi/cxlflash/main.c
> @@ -736,12 +736,12 @@ static void cxlflash_remove(struct pci_dev *pdev)
>  		scsi_remove_host(cfg->host);
>  		/* Fall through */
>  	case INIT_STATE_AFU:
> +		cancel_work_sync(&cfg->work_q);
>  		term_afu(cfg);

You disable irqs after a call to cancel_work_sync.
That means a late int could trigger the workqueue again?
Please disable irqs earlier - as described in Documentation/PCI/pci.txt

>  	case INIT_STATE_PCI:
>  		pci_release_regions(cfg->dev);
>  		pci_disable_device(pdev);
>  	case INIT_STATE_NONE:
> -		flush_work(&cfg->work_q);
>  		free_mem(cfg);
>  		scsi_host_put(cfg->host);
>  		break;
