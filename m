Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D110C433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Nov 2021 17:02:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HznP04VSRz3c5d
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Nov 2021 04:02:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=oNawTdMV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::731;
 helo=mail-qk1-x731.google.com; envelope-from=frowand.list@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20210112 header.b=oNawTdMV; dkim-atps=neutral
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com
 [IPv6:2607:f8b0:4864:20::731])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HznNM3M2Sz2yHM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Nov 2021 04:01:39 +1100 (AEDT)
Received: by mail-qk1-x731.google.com with SMTP id t6so3567063qkg.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Nov 2021 09:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=4l8EHpoHR/MUDumoB/hsOQmLQDeVna4zuNcu6MG7N2Y=;
 b=oNawTdMVSlhLmOCrDcR19sMj/RztqPP/+Xul1ST0ZdjZqP/GXamlE06D/eZB2NI71+
 tKrHOxVlG3T5aAXCdaXsBqOpttB7xDhe0zytOjT9XF/Y3kqcM15J6tnRSys3yPlVcfuj
 8EP1DG66Meqvt2KL14gdwqQ9jbr3N/44XS5CpoXDIWeaEKiqwkaLUHeulZyzxTbsYxOq
 T6Wi5OfXgyLiFxQ2A14taCw6JYR4yAQ9jvV+sjc9AENZn1PYPL5iPuP5LjAJLWFIOb9y
 2/kVWUspoQ1F3b/jzWi05rfUah5HK/mQ6U2zRluZPdRWkPa235jsXYLL3mGnRGdQT0aH
 XKQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=4l8EHpoHR/MUDumoB/hsOQmLQDeVna4zuNcu6MG7N2Y=;
 b=jfxoacnfT0bRrUnLfpg11Ce/2oodFge8EJ5/PhMME1b+4BFcrx2wsH3/phR6L3Cjpr
 gUEx91RHVK3K6rmyWaUeDYYt+PsyAxyccWHvbg0EXMwxfhhGLJF6FGUlNksPQ42gcej3
 DsIlfBfSAsBKZgM8pr48TfuJcb6Pu9wFkTQbpqO0PsG+tQSJeXSVYECrBMsLO4vKyFpb
 LQjm40HNe+quMhPdkWU2FWpF7u9HeelCdy+9bxaQ0z+Ee3DxZC5mi3NjY+hO3uyxNExO
 5nFtINiCeggjJNcJWgBXhLXGrljSNvd1qil4XUSyTk2+pEU7k4fxfi7Mdy9dT5zvr7SL
 pIeg==
X-Gm-Message-State: AOAM530eDIUfrS0imv4QLAuRZrT2DYThowMkQoXV3sVwO4ACzWURjCu8
 68hqwIYCSNL7Y/T4cLxG0gk=
X-Google-Smtp-Source: ABdhPJxMWf3VHGwZdkv0Dz7RlGUGqhel603IxJS5niNv9/50hWXBURFDisFz9q7IqpkQPDpH9JG1hg==
X-Received: by 2002:ae9:e907:: with SMTP id x7mr7705930qkf.150.1637773295831; 
 Wed, 24 Nov 2021 09:01:35 -0800 (PST)
Received: from [192.168.1.140] ([65.35.200.237])
 by smtp.gmail.com with ESMTPSA id x16sm158330qko.15.2021.11.24.09.01.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Nov 2021 09:01:35 -0800 (PST)
Subject: Re: [PATCH 0/3] of/fdt: Rework early FDT scanning functions
To: Rob Herring <robh@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 John Crispin <john@phrozen.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>
References: <20211118181213.1433346-1-robh@kernel.org>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <7c3286d4-2da4-b083-b3a4-88d32e475617@gmail.com>
Date: Wed, 24 Nov 2021 12:01:33 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211118181213.1433346-1-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
Cc: devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 11/18/21 1:12 PM, Rob Herring wrote:
> The early FDT scanning functions use of_scan_flat_dt() which implements 
> its own node walking method. This function predates libfdt and is an 
> unnecessary indirection. This series reworks 
> early_init_dt_scan_chosen(), early_init_dt_scan_root(), and 
> early_init_dt_scan_memory() to be called directly and use libfdt calls.
> 
> Ultimately, I want to remove of_scan_flat_dt(). Most of the remaining 
> of_scan_flat_dt() users are in powerpc.
> 
> Rob
> 
> 
> Rob Herring (3):
>   of/fdt: Rework early_init_dt_scan_chosen() to call directly
>   of/fdt: Rework early_init_dt_scan_root() to call directly
>   of/fdt: Rework early_init_dt_scan_memory() to call directly
> 
>  arch/mips/ralink/of.c                |  16 +---
>  arch/powerpc/kernel/prom.c           |  22 ++---
>  arch/powerpc/mm/nohash/kaslr_booke.c |   4 +-
>  drivers/of/fdt.c                     | 121 ++++++++++++++-------------
>  include/linux/of_fdt.h               |   9 +-
>  5 files changed, 79 insertions(+), 93 deletions(-)
> 


"checkpatch --strict" reports some "CHECK" issues, but review of the patches
for correctness becomes much more difficult if they are addressed, so they
should be ignored for this series.

-Frank
