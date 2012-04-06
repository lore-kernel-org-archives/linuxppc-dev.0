Return-Path: <sshtylyov@mvista.com>
Received: from mail-bk0-f51.google.com (mail-bk0-f51.google.com
 [209.85.214.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A699B7022
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2012 22:12:04 +1000 (EST)
Received: by bkwj10 with SMTP id j10so2005100bkw.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 06 Apr 2012 05:12:01 -0700 (PDT)
Message-ID: <4F7EDD35.3070203@mvista.com>
Date: Fri, 06 Apr 2012 16:10:29 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: "Thang Q. Nguyen" <tqnguyen@apm.com>
Subject: Re: [PATCH 1/1] [v3] Add support 2 SATA ports for Maui and change
 filename from sata_dwc_460ex.c to sata_dwc_4xx.c
References: <1333690265-27857-1-git-send-email-tqnguyen@apm.com>
In-Reply-To: <1333690265-27857-1-git-send-email-tqnguyen@apm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Phong Vo <pvo@apm.com>, devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org, Rob Herring <rob.herring@calxeda.com>,
 linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 06-04-2012 9:31, Thang Q. Nguyen wrote:

> Signed-off-by: Thang Q. Nguyen<tqnguyen@apm.com>
> ---
> Changes for v2:
>         - Use git rename feature to change the driver to the newname and for
>           easier review.

> Changes for v3:
> 	- Remove materials not related to 2 SATA ports support. They will
> 	 be added in another patches.

>   drivers/ata/Makefile                             |    2 +-
>   drivers/ata/{sata_dwc_460ex.c =>  sata_dwc_4xx.c} |  820 +++++++++++-----------
>   2 files changed, 430 insertions(+), 392 deletions(-)
>   rename drivers/ata/{sata_dwc_460ex.c =>  sata_dwc_4xx.c} (73%)

> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_4xx.c
> similarity index 73%
> rename from drivers/ata/sata_dwc_460ex.c
> rename to drivers/ata/sata_dwc_4xx.c
> index 69f7cde..07e9b36 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_4xx.c
[...]
> @@ -16,6 +14,15 @@
>    * under  the terms of  the GNU General  Public License as published by the
>    * Free Software Foundation;  either version 2 of the  License, or (at your
>    * option) any later version.
> + *
> + * CHANGES:
> + * - Version 1.4:
> + *   + Change filename from sata_dwc_460ex.c to sata_dwc_4xx.c
> + *   + This driver supports more than one SATA port. Each SATA port has its
> + *     own private attribute. Move sata_dwc_host_priv structure to
> + *     sata_dwc_device and sata_dwc_device_port structures.
> + *   + Change to use ata_bmdma_qc_issue and ata_bmdma_error_handler because
> + *     the ata_sff_qc_issue and ata_sff_error_handler no longer support DMA.

    This modification looks like a bug fix, and so should be separated and 
posted before the dual-port patch.

    I'll try to do more deltailed review on the weekend.

MBR, Sergei
