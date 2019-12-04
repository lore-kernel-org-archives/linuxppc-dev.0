Return-Path: <SRS0=KnCP=Z2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DF02C43603
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Dec 2019 13:47:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DADF720675
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Dec 2019 13:47:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DADF720675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47SgC03KNXzDqPf
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Dec 2019 00:47:24 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47Sfr43mbWzDqFC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Dec 2019 00:31:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 47Sfr32TT0z9sRc; Thu,  5 Dec 2019 00:30:58 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 6f4679b956741d2da6ad3ebb738cbe1264ac8781
In-Reply-To: <20191204052909.59145-1-aneesh.kumar@linux.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [PATCH] powerpc/pmem: Fix kernel crash due to wrong range value
 usage in flush_dcache_range
Message-Id: <47Sfr32TT0z9sRc@ozlabs.org>
Date: Thu,  5 Dec 2019 00:30:58 +1100 (AEDT)
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
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2019-12-04 at 05:29:09 UTC, "Aneesh Kumar K.V" wrote:
> This patch fix the below kernel crash.
> 
>  BUG: Unable to handle kernel data access on read at 0xc000000380000000
>  Faulting instruction address: 0xc00000000008b6f0
> cpu 0x5: Vector: 300 (Data Access) at [c0000000d8587790]
>     pc: c00000000008b6f0: arch_remove_memory+0x150/0x210
>     lr: c00000000008b720: arch_remove_memory+0x180/0x210
>     sp: c0000000d8587a20
>    msr: 800000000280b033
>    dar: c000000380000000
>  dsisr: 40000000
>   current = 0xc0000000d8558600
>   paca    = 0xc00000000fff8f00   irqmask: 0x03   irq_happened: 0x01
>     pid   = 1220, comm = ndctl
> enter ? for help
>  memunmap_pages+0x33c/0x410
>  devm_action_release+0x30/0x50
>  release_nodes+0x30c/0x3a0
>  device_release_driver_internal+0x178/0x240
>  unbind_store+0x74/0x190
>  drv_attr_store+0x44/0x60
>  sysfs_kf_write+0x74/0xa0
>  kernfs_fop_write+0x1b0/0x260
>  __vfs_write+0x3c/0x70
>  vfs_write+0xe4/0x200
>  ksys_write+0x7c/0x140
>  system_call+0x5c/0x68
> 
> Fixes: 076265907cf9 ("powerpc: Chunk calls to flush_dcache_range in arch_*_memory")
> Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/6f4679b956741d2da6ad3ebb738cbe1264ac8781

cheers
