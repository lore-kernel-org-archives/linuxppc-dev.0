Return-Path: <SRS0=vw+r=X4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 229D5C10F14
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Oct 2019 23:13:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA52F20842
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Oct 2019 23:13:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA52F20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46kphN2pmZzDqJm
	for <linuxppc-dev@archiver.kernel.org>; Fri,  4 Oct 2019 09:13:08 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46kpWt07MNzDqYS
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Oct 2019 09:05:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 46kpWs5sMBz9sPw; Fri,  4 Oct 2019 09:05:45 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 3439595d5b85f0af565f5a58e495d885537fb227
In-Reply-To: <20191003211010.9711-1-desnesn@linux.ibm.com>
To: "Desnes A. Nunes do Rosario" <desnesn@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] selftests/powerpc: Fix compiling error on tlbie_test due
 to newer gcc
Message-Id: <46kpWs5sMBz9sPw@ozlabs.org>
Date: Fri,  4 Oct 2019 09:05:45 +1000 (AEST)
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
Cc: aneesh.kumar@linux.ibm.com, desnesn@linux.ibm.com, shuah@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-10-03 at 21:10:10 UTC, "Desnes A. Nunes do Rosario" wrote:
> Newer versions of GCC demand that the size of the string to be copied must
> be explicitly smaller than the size of the destination. Thus, the NULL
> char has to be taken into account on strncpy.
> 
> This will avoid the following compiling error:
> 
>   tlbie_test.c: In function 'main':
>   tlbie_test.c:639:4: error: 'strncpy' specified bound 100 equals destination size [-Werror=stringop-truncation]
>       strncpy(logdir, optarg, LOGDIR_NAME_SIZE);
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>   cc1: all warnings being treated as errors
> 
> Signed-off-by: Desnes A. Nunes do Rosario <desnesn@linux.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/3439595d5b85f0af565f5a58e495d885537fb227

cheers
