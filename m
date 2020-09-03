Return-Path: <SRS0=NZKl=CM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1660C433E9
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 12:30:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276A9206EB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 12:30:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276A9206EB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Bj0WD1JpGzDqsW
	for <linuxppc-dev@archiver.kernel.org>; Thu,  3 Sep 2020 22:30:00 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Bj0R970TkzDqkS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Sep 2020 22:26:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4Bj0R86w3Nz9sTS; Thu,  3 Sep 2020 22:26:28 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
In-Reply-To: <20200828100852.426575-1-aneesh.kumar@linux.ibm.com>
References: <20200828100852.426575-1-aneesh.kumar@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/book3s64/radix: Fix boot failure with large
 amount of guest memory
Message-Id: <159913592782.5893.11673409396364673972.b4-ty@ellerman.id.au>
Date: Thu,  3 Sep 2020 22:26:28 +1000 (AEST)
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
Cc: Shirisha Ganta <shiganta@in.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 28 Aug 2020 15:38:52 +0530, Aneesh Kumar K.V wrote:
> If the hypervisor doesn't support hugepages, the kernel ends up allocating a large
> number of page table pages. The early page table allocation was wrongly
> setting the max memblock limit to ppc64_rma_size with radix translation
> which resulted in boot failure as shown below.
> 
> Kernel panic - not syncing:
> early_alloc_pgtable: Failed to allocate 16777216 bytes align=0x1000000 nid=-1 from=0x0000000000000000 max_addr=0xffffffffffffffff
>  CPU: 0 PID: 0 Comm: swapper Not tainted 5.8.0-24.9-default+ #2
>  Call Trace:
>  [c0000000016f3d00] [c0000000007c6470] dump_stack+0xc4/0x114 (unreliable)
>  [c0000000016f3d40] [c00000000014c78c] panic+0x164/0x418
>  [c0000000016f3dd0] [c000000000098890] early_alloc_pgtable+0xe0/0xec
>  [c0000000016f3e60] [c0000000010a5440] radix__early_init_mmu+0x360/0x4b4
>  [c0000000016f3ef0] [c000000001099bac] early_init_mmu+0x1c/0x3c
>  [c0000000016f3f10] [c00000000109a320] early_setup+0x134/0x170
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/book3s64/radix: Fix boot failure with large amount of guest memory
      https://git.kernel.org/powerpc/c/103a8542cb35b5130f732d00b0419a594ba1b517

cheers
