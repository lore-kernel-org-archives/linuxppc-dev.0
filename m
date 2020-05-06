Return-Path: <SRS0=xicG=6U=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73105C47247
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 02:54:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2967820735
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 02:54:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2967820735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49H1R41pnVzDqg7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 12:54:56 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49H1Lc1ltszDqHP
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2020 12:51:04 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 49H1Lc0mtXz9sRY; Wed,  6 May 2020 12:51:04 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49H1Lc0HT8z9sRf; Wed,  6 May 2020 12:51:03 +1000 (AEST)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 02c04e374e176ae3a3f64a682f80702f8d2fb65d
In-Reply-To: <158737294432.26700.4830263187856221314.stgit@hbathini.in.ibm.com>
To: Hari Bathini <hbathini@linux.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH v3 1/2] powerpc/fadump: use static allocation for reserved
 memory ranges
Message-Id: <49H1Lc0HT8z9sRf@ozlabs.org>
Date: Wed,  6 May 2020 12:51:03 +1000 (AEST)
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
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>,
 Vasant Hegde <hegdevasant@linux.ibm.com>, stable@vger.kernel.org,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2020-04-20 at 08:56:09 UTC, Hari Bathini wrote:
> At times, memory ranges have to be looked up during early boot, when
> kernel couldn't be initialized for dynamic memory allocation. In fact,
> reserved-ranges look up is needed during FADump memory reservation.
> Without accounting for reserved-ranges in reserving memory for FADump,
> MPIPL boot fails with memory corruption issues. So, extend memory
> ranges handling to support static allocation and populate reserved
> memory ranges during early boot.
> 
> Fixes: dda9dbfeeb7a ("powerpc/fadump: consider reserved ranges while releasing memory")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>
> Reviewed-by: Mahesh Salgaonkar <mahesh@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/02c04e374e176ae3a3f64a682f80702f8d2fb65d

cheers
