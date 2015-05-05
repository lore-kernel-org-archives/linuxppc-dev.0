Return-Path: <runaway@candw.ms>
Received: from mail-vn0-f46.google.com (mail-vn0-f46.google.com
 [209.85.216.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F6771A066A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 May 2015 21:37:33 +1000 (AEST)
Received: by vnbf62 with SMTP id f62so16649619vnb.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 May 2015 04:37:30 -0700 (PDT)
Message-ID: <5548AB77.4000208@candw.ms>
Date: Tue, 05 May 2015 07:37:27 -0400
From: Julian Margetson <runaway@candw.ms>
MIME-Version: 1.0
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Ian Munsie <imunsie@au1.ibm.com>,
 Tejun Heo <tj@kernel.org>, linux-ide@vger.kernel.org
Subject: Re: [PATCH 1/1] ata: select DW_DMAC in case of SATA_DWC
References: <1430817243-98654-1-git-send-email-andriy.shevchenko@linux.intel.com>
In-Reply-To: <1430817243-98654-1-git-send-email-andriy.shevchenko@linux.intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thank you.
this resolves the build issue .

On 5/5/2015 5:14 AM, Andy Shevchenko wrote:
> Since sata_dwc_460ex.c was moved to generic DMA driver we have to ensure that
> user can still compile it.
>
> Fixes: 8b3444852a2b (sata_dwc_460ex: move to generic DMA driver)
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>   drivers/ata/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
> index ee5209f..9dca4b9 100644
> --- a/drivers/ata/Kconfig
> +++ b/drivers/ata/Kconfig
> @@ -270,6 +270,7 @@ config ATA_PIIX
>   config SATA_DWC
>   	tristate "DesignWare Cores SATA support"
>   	depends on 460EX
> +	select DW_DMAC
>   	help
>   	  This option enables support for the on-chip SATA controller of the
>   	  AppliedMicro processor 460EX.
