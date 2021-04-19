Return-Path: <SRS0=9r0M=JQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15891C433B4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:14:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AABFC610A1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 04:14:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AABFC610A1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FNtkR39Mrz3gy5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Apr 2021 14:14:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FNtW75qX9z3clg
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Apr 2021 14:04:51 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FNtVv4RKdz9vHq; Mon, 19 Apr 2021 14:04:39 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Vaibhav Jain <vaibhav@linux.ibm.com>, linux-nvdimm@lists.01.org,
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210404163148.321346-1-vaibhav@linux.ibm.com>
References: <20210404163148.321346-1-vaibhav@linux.ibm.com>
Subject: Re: [PATCH v2] powerpc/mm: Add cond_resched() while removing hpte
 mappings
Message-Id: <161880478898.1398509.10526534460384650101.b4-ty@ellerman.id.au>
Date: Mon, 19 Apr 2021 13:59:48 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, 4 Apr 2021 22:01:48 +0530, Vaibhav Jain wrote:
> While removing large number of mappings from hash page tables for
> large memory systems as soft-lockup is reported because of the time
> spent inside htap_remove_mapping() like one below:
> 
>  watchdog: BUG: soft lockup - CPU#8 stuck for 23s!
>  <snip>
>  NIP plpar_hcall+0x38/0x58
>  LR  pSeries_lpar_hpte_invalidate+0x68/0xb0
>  Call Trace:
>   0x1fffffffffff000 (unreliable)
>   pSeries_lpar_hpte_removebolted+0x9c/0x230
>   hash__remove_section_mapping+0xec/0x1c0
>   remove_section_mapping+0x28/0x3c
>   arch_remove_memory+0xfc/0x150
>   devm_memremap_pages_release+0x180/0x2f0
>   devm_action_release+0x30/0x50
>   release_nodes+0x28c/0x300
>   device_release_driver_internal+0x16c/0x280
>   unbind_store+0x124/0x170
>   drv_attr_store+0x44/0x60
>   sysfs_kf_write+0x64/0x90
>   kernfs_fop_write+0x1b0/0x290
>   __vfs_write+0x3c/0x70
>   vfs_write+0xd4/0x270
>   ksys_write+0xdc/0x130
>   system_call+0x5c/0x70
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/mm: Add cond_resched() while removing hpte mappings
      https://git.kernel.org/powerpc/c/a5d6a3e73acbd619dd5b7b831762b755f9e2db80

cheers
