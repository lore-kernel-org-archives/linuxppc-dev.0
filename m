Return-Path: <SRS0=vYn1=VB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02BC2C0651F
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jul 2019 15:54:50 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78AE02085A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Jul 2019 15:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78AE02085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45fjGZ36r7zDqSS
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jul 2019 01:54:46 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45fjDF3FSbzDqQK
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jul 2019 01:52:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 45fjDD6cxvz9sNw; Fri,  5 Jul 2019 01:52:44 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 548c54acba5bd1388d50727a9a126a42d0cd4ad0
In-Reply-To: <20190604030037.9424-1-mikey@neuling.org>
To: Michael Neuling <mikey@neuling.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v5 1/2] powerpc: silence a -Wcast-function-type warning in
 dawr_write_file_bool
Message-Id: <45fjDD6cxvz9sNw@ozlabs.org>
Date: Fri,  5 Jul 2019 01:52:44 +1000 (AEST)
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
Cc: Mathieu Malaterre <malat@debian.org>, hch@infradead.org, mikey@neuling.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-06-04 at 03:00:36 UTC, Michael Neuling wrote:
> From: Mathieu Malaterre <malat@debian.org>
> 
> In commit c1fe190c0672 ("powerpc: Add force enable of DAWR on P9
> option") the following piece of code was added:
> 
>    smp_call_function((smp_call_func_t)set_dawr, &null_brk, 0);
> 
> Since GCC 8 this triggers the following warning about incompatible
> function types:
> 
>   arch/powerpc/kernel/hw_breakpoint.c:408:21: error: cast between incompatible function types from 'int (*)(struct arch_hw_breakpoint *)' to 'void (*)(void *)' [-Werror=cast-function-type]
> 
> Since the warning is there for a reason, and should not be hidden behind
> a cast, provide an intermediate callback function to avoid the warning.
> 
> Fixes: c1fe190c0672 ("powerpc: Add force enable of DAWR on P9 option")
> Suggested-by: Christoph Hellwig <hch@infradead.org>
> Signed-off-by: Mathieu Malaterre <malat@debian.org>
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/548c54acba5bd1388d50727a9a126a42d0cd4ad0

cheers
