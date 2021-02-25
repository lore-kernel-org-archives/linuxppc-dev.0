Return-Path: <SRS0=yiwx=H3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C22DC433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 16:01:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC83664E7A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 16:01:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC83664E7A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Dmcvw6MmRz3cY6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Feb 2021 03:01:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DmcvY68c4z30JD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2021 03:00:41 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 11PFwbDu023808;
 Thu, 25 Feb 2021 09:58:37 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 11PFwahK023807;
 Thu, 25 Feb 2021 09:58:36 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 25 Feb 2021 09:58:36 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Daniel Axtens <dja@axtens.net>
Subject: Re: [RFC PATCH 7/8] powerpc/purgatory: drop .machine specifier
Message-ID: <20210225155836.GG28121@gate.crashing.org>
References: <20210225031006.1204774-1-dja@axtens.net>
 <20210225031006.1204774-8-dja@axtens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225031006.1204774-8-dja@axtens.net>
User-Agent: Mutt/1.4.2.3i
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
Cc: linuxppc-dev@lists.ozlabs.org, llvmlinux@lists.linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 25, 2021 at 02:10:05PM +1100, Daniel Axtens wrote:
> It's ignored by future versions of llvm's integrated assembler (by not -11).
> I'm not sure what it does for us in gas.

It enables all insns that exist on 620 (the first 64-bit PowerPC CPU).

> --- a/arch/powerpc/purgatory/trampoline_64.S
> +++ b/arch/powerpc/purgatory/trampoline_64.S
> @@ -12,7 +12,7 @@
>  #include <asm/asm-compat.h>
>  #include <asm/crashdump-ppc64.h>
>  
> -	.machine ppc64
> +//upgrade clang, gets ignored	.machine ppc64

Why delete it if it is ignored?  Why add a cryptic comment?


Segher
