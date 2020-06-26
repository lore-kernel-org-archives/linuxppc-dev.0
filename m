Return-Path: <SRS0=Zm8d=AH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3720CC433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 04:47:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9942F20775
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 04:47:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9942F20775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49tPVp5j33zDqcY
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Jun 2020 14:46:58 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49tPRV113bzDqWW
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Jun 2020 14:44:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 49tPRT6R2Mz9sSS; Fri, 26 Jun 2020 14:44:05 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, kvm-ppc@vger.kernel.org,
 paulus@ozlabs.org
In-Reply-To: <20200611120159.680284-1-aneesh.kumar@linux.ibm.com>
References: <20200611120159.680284-1-aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH] powerpc/kvm/book3s64/nested: Fix kernel crash with nested
 kvm
Message-Id: <159314666257.1149515.13073891259313686170.b4-ty@ellerman.id.au>
Date: Fri, 26 Jun 2020 14:44:05 +1000 (AEST)
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

On Thu, 11 Jun 2020 17:31:59 +0530, Aneesh Kumar K.V wrote:
> __pa() do check for addr value passed and if < PAGE_OFFSET
> results in BUG.
> 
>  #define __pa(x)								\
> ({									\
> 	VIRTUAL_BUG_ON((unsigned long)(x) < PAGE_OFFSET);		\
> 	(unsigned long)(x) & 0x0fffffffffffffffUL;			\
> })
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/kvm/book3s64: Fix kernel crash with nested kvm & DEBUG_VIRTUAL
      https://git.kernel.org/powerpc/c/c1ed1754f271f6b7acb1bfdc8cfb62220fbed423

cheers
