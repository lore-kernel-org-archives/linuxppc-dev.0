Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E3EC282CB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 11:30:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 590B920821
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 11:30:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590B920821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v2S52hzQzDqKN
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 22:30:13 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v2Ly2M8lzDqHm
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 22:25:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43v2Ly0LH2z9sMx; Tue,  5 Feb 2019 22:25:45 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 579b9239c1f38665b21e8d0e6ee83ecc96dbd6bb
X-Patchwork-Hint: ignore
In-Reply-To: <20190123062138.22644-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: arch/powerpc/radix: Fix kernel crash with mremap
Message-Id: <43v2Ly0LH2z9sMx@ozlabs.org>
Date: Tue,  5 Feb 2019 22:25:45 +1100 (AEDT)
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
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-01-23 at 06:21:38 UTC, "Aneesh Kumar K.V" wrote:
> With support for split pmd lock, we use pmd page pmd_huge_pte pointer to store
> the deposited page table. In those config when we move page tables we need to
> make sure we move the depoisted page table to the right pmd page. Otherwise this
> can result in crash when we withdraw of deposited page table because we can find
> the pmd_huge_pte NULL.
> 
> c0000000004a1230 __split_huge_pmd+0x1070/0x1940
> c0000000004a0ff4 __split_huge_pmd+0xe34/0x1940 (unreliable)
> c0000000004a4000 vma_adjust_trans_huge+0x110/0x1c0
> c00000000042fe04 __vma_adjust+0x2b4/0x9b0
> c0000000004316e8 __split_vma+0x1b8/0x280
> c00000000043192c __do_munmap+0x13c/0x550
> c000000000439390 sys_mremap+0x220/0x7e0
> c00000000000b488 system_call+0x5c/0x70
> 
> Fixes: 675d995297d4 ("powerpc/book3s64: Enable split pmd ptlock.")
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/579b9239c1f38665b21e8d0e6ee83ecc

cheers
