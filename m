Return-Path: <James.Smart@Emulex.Com>
Received: from emulex.emulex.com (emulex.emulex.com [138.239.112.1])
	by ozlabs.org (Postfix) with ESMTP id 6C774DDDEB
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Mar 2007 01:14:40 +1100 (EST)
Message-ID: <45F40D02.9060900@emulex.com>
Date: Sun, 11 Mar 2007 10:06:58 -0400
From: James Smart <James.Smart@Emulex.Com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH] lpfc: avoid double-free during PCI error failure
References: <20070308221911.GC30703@austin.ibm.com>
In-Reply-To: <20070308221911.GC30703@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
	Bino.Sebastian@Emulex.Com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, rlary@us.ibm.com
Reply-To: James.Smart@Emulex.Com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

ACK...  Looks good...

-- james s


Linas Vepstas wrote:
> Bino, James,
> Please review, sign-off and forward upstream.
> 
> --linas
> 
> 
> If a PCI error is detected that cannot be recovered from, there
> will be a double call of lpfc_pci_remove_one(), with the second call
> resulting in a null-pointer dereference. The first call occurs in 
> lpfc_io_error_detected(), and the second call during pci device 
> remove. This patch eliminates the first call; its un-needed.
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> 
> ----
>  drivers/scsi/lpfc/lpfc_init.c |    5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> Index: linux-2.6.20-git16/drivers/scsi/lpfc/lpfc_init.c
> ===================================================================
> --- linux-2.6.20-git16.orig/drivers/scsi/lpfc/lpfc_init.c	2007-03-08 15:57:40.000000000 -0600
> +++ linux-2.6.20-git16/drivers/scsi/lpfc/lpfc_init.c	2007-03-08 16:03:18.000000000 -0600
> @@ -1817,10 +1817,9 @@ static pci_ers_result_t lpfc_io_error_de
>  	struct lpfc_sli *psli = &phba->sli;
>  	struct lpfc_sli_ring  *pring;
>  
> -	if (state == pci_channel_io_perm_failure) {
> -		lpfc_pci_remove_one(pdev);
> +	if (state == pci_channel_io_perm_failure)
>  		return PCI_ERS_RESULT_DISCONNECT;
> -	}
> +
>  	pci_disable_device(pdev);
>  	/*
>  	 * There may be I/Os dropped by the firmware.
> 
