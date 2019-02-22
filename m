Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0BEC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:21:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F153720823
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:21:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F153720823
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445S6d19rbzDqPj
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 21:21:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445RN84PmXzDq7W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 20:47:52 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 445RN8200mz9s9y; Fri, 22 Feb 2019 20:47:51 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 8cfaf106918a8c13abb24c641556172afbb9545c
X-Patchwork-Hint: ignore
In-Reply-To: <20190211002002.26038-1-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v2,
 1/2] powerpc/64s: Fix logic when handling unknown CPU features
Message-Id: <445RN8200mz9s9y@ozlabs.org>
Date: Fri, 22 Feb 2019 20:47:51 +1100 (AEDT)
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
Cc: syzkaller@googlegroups.com, dvyukov@google.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-02-11 at 00:20:01 UTC, Andrew Donnellan wrote:
> From: Michael Ellerman <mpe@ellerman.id.au>
> 
> In cpufeatures_process_feature(), if a provided CPU feature is unknown and
> enable_unknown is false, we erroneously print that the feature is being
> enabled and return true, even though no feature has been enabled, and
> may also set feature bits based on the last entry in the match table.
> 
> Fix this so that we only set feature bits from the match table if we have
> actually enabled a feature from that table, and when failing to enable an
> unknown feature, always print the "not enabling" message and return false.
> 
> Coincidentally, some older gccs (<GCC 7), when invoked with
> -fsanitize-coverage=trace-pc, cause a spurious uninitialised variable
> warning in this function:
> 
>   arch/powerpc/kernel/dt_cpu_ftrs.c: In function âcpufeatures_process_featureâ:
>   arch/powerpc/kernel/dt_cpu_ftrs.c:686:7: warning: âmâ may be used uninitialized in this function [-Wmaybe-uninitialized]
>     if (m->cpu_ftr_bit_mask)
> 
> An upcoming patch will enable support for kcov, which requires this option.
> This patch avoids the warning.
> 
> Fixes: 5a61ef74f269 ("powerpc/64s: Support new device tree binding for discovering CPU features")
> Reported-by: Segher Boessenkool <segher@kernel.crashing.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> [ajd: add commit message]
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/8cfaf106918a8c13abb24c641556172a

cheers
