Return-Path: <sshtylyov@mvista.com>
Received: from mail-lpp01m010-f51.google.com (mail-lpp01m010-f51.google.com
 [209.85.215.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B3914B7071
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 21:08:09 +1000 (EST)
Received: by laap9 with SMTP id p9so4324160laa.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2012 04:08:04 -0700 (PDT)
Message-ID: <4F8D4EAC.1010301@mvista.com>
Date: Tue, 17 Apr 2012 15:06:20 +0400
From: Sergei Shtylyov <sshtylyov@mvista.com>
MIME-Version: 1.0
To: "Thang Q. Nguyen" <tqnguyen@apm.com>
Subject: Re: [PATCH 1/7] Add support hardreset
References: <1334652193-10487-1-git-send-email-tqnguyen@apm.com>
In-Reply-To: <1334652193-10487-1-git-send-email-tqnguyen@apm.com>
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

On 17-04-2012 12:43, Thang Q. Nguyen wrote:

>   The hardreset operation is currently not supported. This causes sometime the SATA driver does cause kernel crash because of none-determined state.a This patch will fix the issue.

> Signed-off-by: Thang Q. Nguyen<tqnguyen@apm.com>
> ---
>   drivers/ata/sata_dwc_460ex.c |   24 +++++++++++++++++++++++-
>   1 files changed, 23 insertions(+), 1 deletions(-)
>
> diff --git a/drivers/ata/sata_dwc_460ex.c b/drivers/ata/sata_dwc_460ex.c
> index 69f7cde..ae13ef1 100644
> --- a/drivers/ata/sata_dwc_460ex.c
> +++ b/drivers/ata/sata_dwc_460ex.c
> @@ -1581,10 +1581,31 @@ static void sata_dwc_qc_prep(struct ata_queued_cmd *qc)
>
>   static void sata_dwc_error_handler(struct ata_port *ap)
>   {
> -	ap->link.flags |= ATA_LFLAG_NO_HRST;
>   	ata_sff_error_handler(ap);
>   }

    Could eliminate this, switching to the default implementation...

MBR, Sergei
