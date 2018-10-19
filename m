Return-Path: <SRS0=4s7t=M7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B02C8ECDE3D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 18:20:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E93762086E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 19 Oct 2018 18:20:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="T5bqeL5L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93762086E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42cDkF2gtgzF3c8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Oct 2018 05:20:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.b="T5bqeL5L";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=sifive.com
 (client-ip=2607:f8b0:4864:20::443; helo=mail-pf1-x443.google.com;
 envelope-from=palmer@sifive.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=sifive.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=sifive.com header.i=@sifive.com header.b="T5bqeL5L"; 
 dkim-atps=neutral
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com
 [IPv6:2607:f8b0:4864:20::443])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42cDgS73JzzF3by
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Oct 2018 05:18:24 +1100 (AEDT)
Received: by mail-pf1-x443.google.com with SMTP id l81-v6so16837134pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Oct 2018 11:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sifive.com; s=google;
 h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
 :content-transfer-encoding;
 bh=nmeckNFphp/x15aPxZY+QfLLPrluX8Ha3iNeceCHXR0=;
 b=T5bqeL5LfyW6P8gqFxda7vnjy6IAxOqPyFkv0PgB5x/+Qu7ZfuV3o3xTckTa9V7j2G
 jF6wwHddEDCK+1JLYoYg+udap+i4lWOA7klTDzmnGkfnebOjG6We5MAhTvm4VzVmdePH
 6sarJYOZ8BnDIJT2GW5ap+HewSnzP1LQlRMh7GPPw2cvXoUxFpVkksIJQeiWfeaRGduz
 pW1ZEIF133SYZFttuxW+RPkYBReeIujsNcqMSIcSjQzKB9uYQLjCOKDcISJojMpPuzi3
 dOegDod43mpUiqUfB7mi34SZ7/GlljCYAAd/pL+U9XYwz5ycYIivUIjWqeoics9ga0LT
 W8lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
 :mime-version:content-transfer-encoding;
 bh=nmeckNFphp/x15aPxZY+QfLLPrluX8Ha3iNeceCHXR0=;
 b=aQjsjtQJ0AyxwJB0n27YNOESl8D3WwY9UAuRteWcXvhFs7tLNwqZXeDeSCveKZbf2l
 0+Waj3SEP1M2FeRXDBp9jweI6zCRLU6iuma/qbtUdcU4DdZkanAGffW2ZrGRx07xQBGp
 LtJET1IgtHVyBDJIElRLmh5O/ArqT7pk+ZJhakiALZ1HBpwrtdpNfZOS+5gJhruMw8FG
 2drM4IoslEYPCmLErk5b1pT3uMvvaJ7BsVtTxy+zDXlFA/2rtleZXTpXPimmtlGZnsbL
 +C2vPFAOmwU7J/yxTMItssC58m+5Y3w2tdgelU1D4Pqmx1/5ZPHzlr6ntTLzgJyRmcvT
 Fz1A==
X-Gm-Message-State: ABuFfoiwVdsqWTCKdqkuTm4Yvvrv/Y1DfEK9sQTTc1sMnpf6HC+O1mKf
 LgqBWNN/d7qcMkI+YQNgpHCFSA==
X-Google-Smtp-Source: ACcGV60hu30sK8WGsyOOmc9OyGfiaulMhF1Tfiwp1vHNedYePnQLmlk7+2KpKHMdD2AVMwNv7Bt44A==
X-Received: by 2002:a63:3c46:: with SMTP id
 i6-v6mr33222663pgn.286.1539973103049; 
 Fri, 19 Oct 2018 11:18:23 -0700 (PDT)
Received: from localhost ([12.206.222.5])
 by smtp.gmail.com with ESMTPSA id e3-v6sm31153305pgc.71.2018.10.19.11.18.21
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 19 Oct 2018 11:18:22 -0700 (PDT)
Date: Fri, 19 Oct 2018 11:18:22 -0700 (PDT)
X-Google-Original-Date: Fri, 19 Oct 2018 11:11:52 PDT (-0700)
Subject: Re: [PATCH 6/9] PCI: consolidate PCI config entry in drivers/pci
In-Reply-To: <20181019120952.32763-7-hch@lst.de>
From: Palmer Dabbelt <palmer@sifive.com>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <mhng-153e4e0b-8fe9-4712-849f-f01455ef56f4@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
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
Cc: linux-arch@vger.kernel.org, linux-scsi@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux@dominikbrodowski.net,
 yamada.masahiro@socionext.com, alex.bou9@gmail.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 19 Oct 2018 05:09:49 PDT (-0700), Christoph Hellwig wrote:
> There is no good reason to duplicate the PCI menu in every architecture.
> Instead provide a selectable HAVE_PCI symbol that indicates availability
> of PCI support and the handle the rest in drivers/pci.
>
> Note that for powerpc we now select HAVE_PCI globally instead of the
> convoluted mess of conditional or or non-conditional support per board,
> similar to what we do e.g. on x86.  For alpha PCI is selected for the
> non-jensen configs as it was the default before, and a lot of code does
> not compile without PCI enabled.  On other architectures with limited
> PCI support that wasn't as complicated I've left the selection as-is.
>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Acked-by: Thomas Gleixner <tglx@linutronix.de>
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

...

> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
> index a344980287a5..071952cd4cae 100644
> --- a/arch/riscv/Kconfig
> +++ b/arch/riscv/Kconfig
> @@ -39,8 +39,10 @@ config RISCV
>  	select SPARSE_IRQ
>  	select SYSCTL_EXCEPTION_TRACE
>  	select HAVE_ARCH_TRACEHOOK
> +	select HAVE_PCI
>  	select MODULES_USE_ELF_RELA if MODULES
>  	select THREAD_INFO_IN_TASK
> +	select PCI_MSI if PCI
>  	select RISCV_TIMER
>  	select GENERIC_IRQ_MULTI_HANDLER
>  	select ARCH_HAS_PTE_SPECIAL
> @@ -216,28 +218,12 @@ source "kernel/Kconfig.hz"
>
>  endmenu
>
> -menu "Bus support"
> -
> -config PCI
> -	bool "PCI support"
> -	select PCI_MSI
> -	help
> -	  This feature enables support for PCI bus system. If you say Y
> -	  here, the kernel will include drivers and infrastructure code
> -	  to support PCI bus devices.
> -
> -	  If you don't know what to do here, say Y.
> -
>  config PCI_DOMAINS
>  	def_bool PCI
>
>  config PCI_DOMAINS_GENERIC
>  	def_bool PCI
>
> -source "drivers/pci/Kconfig"
> -
> -endmenu
> -
>  menu "Power management options"
>
>  source kernel/power/Kconfig

Reviewed-by: Palmer Dabbelt <palmer@sifive.com>

I'm assuming this will go in via PCI tree of some sort, so I'm not going to 
touch it any further.

Thanks for cleaning this up!
