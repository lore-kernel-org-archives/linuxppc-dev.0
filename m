Return-Path: <SRS0=BvUY=PG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5962FC43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 02:57:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B1A32218FD
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 02:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FiDeuYOX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B1A32218FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43RSsb323SzDqMt
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 13:57:07 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FiDeuYOX";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=schmitzmic@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="FiDeuYOX"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43RSpj0YczzDqF7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Dec 2018 13:54:36 +1100 (AEDT)
Received: by mail-pf1-x442.google.com with SMTP id i12so11147829pfo.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Dec 2018 18:54:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:references:cc:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-transfer-encoding;
 bh=WUAtqobh7Xcno2LIvb7W9X+mq0KfYPosTfTprbHNNSo=;
 b=FiDeuYOXGUwhSjaswYEv3T7Sex4I/j9YGWf2+VEd0YidfDCswDHCepi6zqLxfyDI/W
 jVMoSvw6wP01D9SWQx08fmyrmGZpmrKZHmu44wly67YiVpb5QEAdSGVR16k+6piEtssV
 EWLEqwa6CdJa13JwzKvS25yi9wSbY65mhyc1HvHyDtL5H4bETcmuyI6v0bhq++nQbRaq
 3Hnh0qqDh74Yh0J57c5C2l2ntDEkDuXXsE79rwnYsYTdJaW8Zi0ZYtnbfLSsMnHIfuma
 9THW0KUGI1wEs2Ucny4DN0RAE/V9Hk9UXsNONf2mNcVTzZaluHxY8OTI0hW1AoSOnuIs
 VRVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:cc:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding;
 bh=WUAtqobh7Xcno2LIvb7W9X+mq0KfYPosTfTprbHNNSo=;
 b=hGFwUTMD3HEgSzk8knRlmT4wVTMyieJHb5hzWA0ZeoQ/QubvqETGvBRRsWNLdtRN/n
 6Wn1oPwBxrdgaLXKZ42JjGK8b9+FHW9IMAKjkt8MQv4o8S0zF0uxi92D3sIt6HSS/laB
 VsF14Ht/0JfGfIEWiPVERvlngEmsA4jpAA89Ilc5KpPSx9ZitZDgofY1qquLw2mfkIvK
 OE3f2wZDfJdTQSocHiZWObxY5zH/iu/Ui51BASKsiXtJZI2e3ro6OycQFVfVr2frtEWc
 Z/iLaOeAXzzHfISacDZvtiAanenGzZOeCbzPNInTJFgael2TIC7L3OBv7YtKdj6wGhZt
 oKFA==
X-Gm-Message-State: AJcUukcmbhxv9sHQ5pUvbBKKw49qsIFDou1S667jm5fBr4fvn2JBiDsR
 +AHi51N18IbIdhytNT6XsRPnONVo
X-Google-Smtp-Source: ALg8bN4aQji1O24JaqrLyf4HHDrY9L+ySaCDNZFmrl6fJEVAqbkpZ0jOD9AUqCYz57z9dkS64vlVuQ==
X-Received: by 2002:a63:1e17:: with SMTP id e23mr384531pge.130.1546052074054; 
 Fri, 28 Dec 2018 18:54:34 -0800 (PST)
Received: from [192.168.1.101] (122-58-176-92-adsl.sparkbb.co.nz.
 [122.58.176.92])
 by smtp.gmail.com with ESMTPSA id h185sm41475180pfg.143.2018.12.28.18.54.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 28 Dec 2018 18:54:33 -0800 (PST)
Subject: Re: [PATCH v8 01/25] scsi/atari_scsi: Don't select CONFIG_NVRAM
To: Finn Thain <fthain@telegraphics.com.au>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>
References: <cover.1545784679.git.fthain@telegraphics.com.au>
 <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <1ece01a1-dc68-daa3-218c-4b3d45375861@gmail.com>
Date: Sat, 29 Dec 2018 15:54:24 +1300
User-Agent: Mozilla/5.0 (X11; Linux ppc; rv:45.0) Gecko/20100101 Icedove/45.4.0
MIME-Version: 1.0
In-Reply-To: <e68fcc3ec0a6cd4e14f763366d4d9445890b9b82.1545784679.git.fthain@telegraphics.com.au>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linux-m68k@lists.linux-m68k.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Finn,

Am 26.12.2018 um 13:37 schrieb Finn Thain:
> On powerpc, setting CONFIG_NVRAM=n builds a kernel with no NVRAM support.
> Setting CONFIG_NVRAM=m enables the /dev/nvram misc device module without
> enabling NVRAM support in drivers. Setting CONFIG_NVRAM=y enables the
> misc device (built-in) and also enables NVRAM support in drivers.
>
> m68k shares the valkyriefb driver with powerpc, and since that driver uses
> NVRAM, it is affected by CONFIG_ATARI_SCSI, because of the use of
> "select NVRAM".
>
> Adopt the powerpc convention on m68k to avoid surprises.
>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> Tested-by: Christian T. Steigies <cts@debian.org>

Acked-by: Michael Schmitz <schmitzmic@gmail.com>

> ---
> This patch temporarily disables CONFIG_NVRAM on Atari, to prevent build
> failures when bisecting the rest of this patch series. It gets enabled
> again with the introduction of CONFIG_HAVE_ARCH_NVRAM_OPS, once the
> nvram_* global functions have been moved to an ops struct.
> ---
>  drivers/char/Kconfig      | 5 +----
>  drivers/scsi/Kconfig      | 6 +++---
>  drivers/scsi/atari_scsi.c | 7 ++++---
>  3 files changed, 8 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 9d03b2ff5df6..5b54595dfe30 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -236,7 +236,7 @@ source "drivers/char/hw_random/Kconfig"
>
>  config NVRAM
>  	tristate "/dev/nvram support"
> -	depends on ATARI || X86 || GENERIC_NVRAM
> +	depends on X86 || GENERIC_NVRAM
>  	---help---
>  	  If you say Y here and create a character special file /dev/nvram
>  	  with major number 10 and minor number 144 using mknod ("man mknod"),
> @@ -254,9 +254,6 @@ config NVRAM
>  	  should NEVER idly tamper with it. See Ralf Brown's interrupt list
>  	  for a guide to the use of CMOS bytes by your BIOS.
>
> -	  On Atari machines, /dev/nvram is always configured and does not need
> -	  to be selected.
> -
>  	  To compile this driver as a module, choose M here: the
>  	  module will be called nvram.
>
> diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
> index 640cd1b31a18..924eb69e7fc4 100644
> --- a/drivers/scsi/Kconfig
> +++ b/drivers/scsi/Kconfig
> @@ -1381,14 +1381,14 @@ config ATARI_SCSI
>  	tristate "Atari native SCSI support"
>  	depends on ATARI && SCSI
>  	select SCSI_SPI_ATTRS
> -	select NVRAM
>  	---help---
>  	  If you have an Atari with built-in NCR5380 SCSI controller (TT,
>  	  Falcon, ...) say Y to get it supported. Of course also, if you have
>  	  a compatible SCSI controller (e.g. for Medusa).
>
> -	  To compile this driver as a module, choose M here: the
> -	  module will be called atari_scsi.
> +	  To compile this driver as a module, choose M here: the module will
> +	  be called atari_scsi. If you also enable NVRAM support, the SCSI
> +	  host's ID is taken from the setting in TT RTC NVRAM.
>
>  	  This driver supports both styles of NCR integration into the
>  	  system: the TT style (separate DMA), and the Falcon style (via
> diff --git a/drivers/scsi/atari_scsi.c b/drivers/scsi/atari_scsi.c
> index 89f5154c40b6..99e5729d910d 100644
> --- a/drivers/scsi/atari_scsi.c
> +++ b/drivers/scsi/atari_scsi.c
> @@ -755,9 +755,10 @@ static int __init atari_scsi_probe(struct platform_device *pdev)
>  	if (ATARIHW_PRESENT(TT_SCSI) && setup_sg_tablesize >= 0)
>  		atari_scsi_template.sg_tablesize = setup_sg_tablesize;
>
> -	if (setup_hostid >= 0) {
> +	if (setup_hostid >= 0)
>  		atari_scsi_template.this_id = setup_hostid & 7;
> -	} else {
> +#ifdef CONFIG_NVRAM
> +	else
>  		/* Test if a host id is set in the NVRam */
>  		if (ATARIHW_PRESENT(TT_CLK) && nvram_check_checksum()) {
>  			unsigned char b = nvram_read_byte(16);
> @@ -768,7 +769,7 @@ static int __init atari_scsi_probe(struct platform_device *pdev)
>  			if (b & 0x80)
>  				atari_scsi_template.this_id = b & 7;
>  		}
> -	}
> +#endif
>
>  	/* If running on a Falcon and if there's TT-Ram (i.e., more than one
>  	 * memory block, since there's always ST-Ram in a Falcon), then
>
