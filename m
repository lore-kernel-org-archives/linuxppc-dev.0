Return-Path: <SRS0=6/er=KP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 239AEC433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 11:45:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DA0960FE7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 11:45:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DA0960FE7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Fm7GY6Ch9z3bvM
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 21:45:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=altlinux.org (client-ip=194.107.17.57;
 helo=vmicros1.altlinux.org; envelope-from=ldv@altlinux.org;
 receiver=<UNKNOWN>)
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Fm7GC62Vxz2ykH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2021 21:45:23 +1000 (AEST)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
 by vmicros1.altlinux.org (Postfix) with ESMTP id 22E2372C8B8;
 Thu, 20 May 2021 14:45:22 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
 id 134867CC8A6; Thu, 20 May 2021 14:45:22 +0300 (MSK)
Date: Thu, 20 May 2021 14:45:22 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 2/2] powerpc/64s/syscall: Fix ptrace syscall info with
 scv syscalls
Message-ID: <20210520114521.GC1198@altlinux.org>
References: <20210520111931.2597127-1-npiggin@gmail.com>
 <20210520111931.2597127-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210520111931.2597127-2-npiggin@gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, May 20, 2021 at 09:19:31PM +1000, Nicholas Piggin wrote:
> The scv implementation missed updating syscall return value and error
> value get/set functions to deal with the changed register ABI. This
> broke ptrace PTRACE_GET_SYSCALL_INFO as well as some kernel auditing
> and tracing functions.
> 
> Fix. tools/testing/selftests/ptrace/get_syscall_info now passes when
> scv is used.
> 
> Fixes: 7fa95f9adaee ("powerpc/64s: system call support for scv/rfscv instructions")
> Reported-by: "Dmitry V. Levin" <ldv@altlinux.org>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Thanks, feel free to add
Reviewed-by: Dmitry V. Levin <ldv@altlinux.org>

Also consider adding
Cc: stable@vger.kernel.org # 5.9+


-- 
ldv
