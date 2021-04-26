Return-Path: <SRS0=DjYV=JX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D7BC433ED
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Apr 2021 21:26:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4617961040
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Apr 2021 21:26:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4617961040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FTdHm41ygz302y
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Apr 2021 07:26:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=209.85.167.172;
 helo=mail-oi1-f172.google.com; envelope-from=robherring2@gmail.com;
 receiver=<UNKNOWN>)
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com
 [209.85.167.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FTdHP6RScz2yRT
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Apr 2021 07:26:09 +1000 (AEST)
Received: by mail-oi1-f172.google.com with SMTP id d25so20296926oij.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Apr 2021 14:26:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=M+kfr4IPPCFa5xs3ch/ZaXobs80sSVS0cUKODNu4aNk=;
 b=pEQ+3ZtCjKrUby3Kh9uMn/CAnE+GDAu/G05HDxtqqlV9wQzV6MOZ7lOibN6/pW51uA
 mLIb3JAdCnOoNbCAeTaOv2rIEGxAILRfr4pOu6ta34txTZwZQA0m80zKWGcBHRjDdSpw
 O8Zua9Arw+W15g/jso7uMI9GoFWE7lp0XnuEJI6nJSeusVvxGBF+y0/f+bBoRRlRcO87
 01nxJVDf2mL8kT7Rb42l5zjvpayO6CdF48DUVdTcpyijQ5vHcLPnoOvnOqrZBkvYPuxB
 u6CNMqf0nn0yAXG1BEdyWy6YlIaVJ5dQ4wIvhHZrxuKYO+t1/IoYAxjKF66NUHAUTdqX
 SD9A==
X-Gm-Message-State: AOAM5337Rty04/r+LJ44rtGgZ9h3Yg8rOYk8efcUC9MLPlE/olpNmR3Q
 HCQW2LNDIUnvsaNil9RySQ==
X-Google-Smtp-Source: ABdhPJymQOo1uyvNJPBJdLq+1+tIGbTJ76YWtc9yIVl/sqkwqsFLlW1N8Tl5ylMP6eq+Do6LLCOacg==
X-Received: by 2002:aca:cf12:: with SMTP id f18mr13856265oig.75.1619472366628; 
 Mon, 26 Apr 2021 14:26:06 -0700 (PDT)
Received: from robh.at.kernel.org (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id g96sm3767686otg.39.2021.04.26.14.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Apr 2021 14:26:05 -0700 (PDT)
Received: (nullmailer pid 4113914 invoked by uid 1000);
 Mon, 26 Apr 2021 21:26:04 -0000
Date: Mon, 26 Apr 2021 16:26:04 -0500
From: Rob Herring <robh@kernel.org>
To: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
Subject: Re: [PATCH v2 2/2] powerpc: If kexec_build_elf_info() fails return
 immediately from elf64_load()
Message-ID: <20210426212604.GA4113688@robh.at.kernel.org>
References: <20210421163610.23775-1-nramas@linux.microsoft.com>
 <20210421163610.23775-2-nramas@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210421163610.23775-2-nramas@linux.microsoft.com>
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
Cc: devicetree@vger.kernel.org, kbuild-all@lists.01.org, lkp@intel.com,
 bauerman@linux.ibm.com, linuxppc-dev@lists.ozlabs.org,
 dan.carpenter@oracle.com, dja@axtens.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 21 Apr 2021 09:36:10 -0700, Lakshmi Ramasubramanian wrote:
> Uninitialized local variable "elf_info" would be passed to
> kexec_free_elf_info() if kexec_build_elf_info() returns an error
> in elf64_load().
> 
> If kexec_build_elf_info() returns an error, return the error
> immediately.
> 
> Signed-off-by: Lakshmi Ramasubramanian <nramas@linux.microsoft.com>
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Reviewed-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  arch/powerpc/kexec/elf_64.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Applied, thanks!
