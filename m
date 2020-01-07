Return-Path: <SRS0=KFH9=24=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B58AC33C99
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jan 2020 11:14:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00616207E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jan 2020 11:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="NNjdyez2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00616207E0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47sVBb5t2KzDqHk
	for <linuxppc-dev@archiver.kernel.org>; Tue,  7 Jan 2020 22:14:15 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47sV631SsLzDqJq
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2020 22:10:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="NNjdyez2"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 47sV625CzZz9sPn;
 Tue,  7 Jan 2020 22:10:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1578395418;
 bh=FdttSGyBEdoAdLSvtg+jrha4ZpaFZiw+Q50qu3iqJ/w=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=NNjdyez2nATWIlBZqPJni7meFJwACNd9+aBuQNckkcvDx1lwOp7lE4X/3+pTcDuo2
 kz/Lk9Iwv0PXuDPJrqoJmZOfuVYIoXkY+QP4LPTiXxl+hULcC9gJTyOaN52PdGYN9R
 QWU46MxOdEDOWf1HxegDo7KE0TsHTJQAX9bS7vgCHuWrSS5wvPMUbK0RZxOYw8idWv
 haNByRfvCX1EhpHcCSSPE26zVAtLGv6ZJj5oN9XEXWO2z7uTt1a5jIGkU8pYCQcKcO
 A6BtPzC48OYk6gZM9pXuhky6O4I1kN08L8GcwHAhbPEU4JtbyHPAWsv5yRIQEyHMAC
 AWsctvKubYkdg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kajol Jain <kjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] powerpc/kernel/sysfs: Add new config option PMU_SYSFS
 to enable PMU SPRs sysfs file creation
In-Reply-To: <20200106085423.13928-1-kjain@linux.ibm.com>
References: <20200106085423.13928-1-kjain@linux.ibm.com>
Date: Tue, 07 Jan 2020 22:10:18 +1100
Message-ID: <87o8vf1q05.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: kjain@linux.ibm.com, anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Kajol Jain <kjain@linux.ibm.com> writes:
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 12543e53fa96..58c72b9b8902 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -417,6 +417,12 @@ config PPC_MM_SLICES
>  config PPC_HAVE_PMU_SUPPORT
>         bool
>  
> +config PMU_SYSFS
> +	bool
> +	default n
> +	help
> +	  This option enables sysfs file creation for PMU SPRs like MMCR* and PMC*.

This isn't user-selectable. It needs a description after `bool` to be
user-selectable.

cheers
