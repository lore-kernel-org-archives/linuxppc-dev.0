Return-Path: <SRS0=oaAR=Z7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 659EEC43603
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Dec 2019 10:03:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAB6A207FD
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Dec 2019 10:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="C9i3VS3O"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAB6A207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47Wf0k30WPzDqPn
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Dec 2019 21:03:50 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47WdyN5MYBzDqHk
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Dec 2019 21:01:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.b="C9i3VS3O"; dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 47WdyM6xgYz9sNH;
 Mon,  9 Dec 2019 21:01:47 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1575885708;
 bh=1KtN7qLMllH/q+Kqm/un5INLnk57teTueciXuqp1oeE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=C9i3VS3O8PUjc+xREKhmGyaEW2QduQ/VPI/G/WEXjpO0ub/msUP/7uj/sr3HD97/Q
 WE0mc/lyJz9ZjlzEKraSGIH8dEWc+ddEOiC8GvaEnKRlnEf5/90UJl17RvQAXIjyld
 oPhHsPlD34c49T7fTJZyWNH0Qq1kFbJlW4k3ZdasBrqdrfH3OW2ETH1/q4koopCv6u
 A/imGS6PdY/M4EhRTn890uM6WnXyhT0vulAXVsfwzBMpNX4PaFH8e02geIAVbRnSnC
 rN72FCTBcHMu84sZAkBciqv/RyZp/OOibX+TK1hIBqH2rv1X+NXsROH2kd6Q/M2eWL
 HU742/gdGTklg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kajol Jain <kjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RESEND PATCH v2] powerpc/kernel/sysfs: Add PMU_SYSFS config
 option to enable PMU SPRs sysfs file creation
In-Reply-To: <20191205052558.2091-1-kjain@linux.ibm.com>
References: <20191205052558.2091-1-kjain@linux.ibm.com>
Date: Mon, 09 Dec 2019 21:01:44 +1100
Message-ID: <87d0cxrf5j.fsf@mpe.ellerman.id.au>
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
Cc: Nageswara R Sastry <nasastry@in.ibm.com>, kjain@linux.ibm.com,
 anju@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Kajol Jain <kjain@linux.ibm.com> writes:
> Many of the performance moniroting unit (PMU) SPRs are
> exposed in the sysfs. "perf" API is the primary interface to program
> PMU and collect counter data in the system. So expose these
> PMU SPRs in the absence of CONFIG_PERF_EVENTS.
>
> Patch adds a new CONFIG option 'CONFIG_PMU_SYSFS'. The new config
> option used in kernel/sysfs.c for PMU SPRs sysfs file creation and
> this new option is enabled only if 'CONFIG_PERF_EVENTS' option is
> disabled.
...
> diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
> index 12543e53fa96..f3ad579c559f 100644
> --- a/arch/powerpc/platforms/Kconfig.cputype
> +++ b/arch/powerpc/platforms/Kconfig.cputype
> @@ -417,6 +417,14 @@ config PPC_MM_SLICES
>  config PPC_HAVE_PMU_SUPPORT
>         bool
>  
> +config PMU_SYSFS
> +	bool
> +	default y if !PERF_EVENTS
> +	help
> +	  This option enables PMU SPR sysfs file creation. Since PMU SPRs are
> +	  intended to be used via "perf" interface, config option is enabled
> +	  only when CONFIG_PERF_EVENTS is disabled.

This could break existing users that expect the sysfs files to exist.

The situation we have is that all these registers are currently exposed
in sysfs, but we don't *think* anything/anyone is using them.

But we're not sure, so we can't just remove them entirely. And we also
can't make them incompatible with perf, because then a user has to
choose the sysfs files OR perf, which could break someone's setup.

So the option must be user selectable, it should not depend on
PERF_EVENTS, and it should be 'default n' (which is the default).

That way it's off by default, unless someone turns it on deliberately.

cheers
