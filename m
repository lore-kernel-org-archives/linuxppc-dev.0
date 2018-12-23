Return-Path: <SRS0=dmdX=PA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91350C43387
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 14:13:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1324921849
	for <linuxppc-dev@archiver.kernel.org>; Sun, 23 Dec 2018 14:13:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1324921849
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43N4986pqdzDqgB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Dec 2018 01:13:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43N38c45ZpzDqWB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Dec 2018 00:28:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43N38b6LS9z9sPF; Mon, 24 Dec 2018 00:28:15 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43N38Z18hxz9sPC; Mon, 24 Dec 2018 00:28:13 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: a4e92ce8e4c8275bacfe3529d6ac85d54a233d87
X-Patchwork-Hint: ignore
In-Reply-To: <153475303684.22527.5892283110957277667.stgit@jupiter.in.ibm.com>
To: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v7,1/3] powerpc/fadump: Reservationless firmware assisted dump
Message-Id: <43N38Z18hxz9sPC@ozlabs.org>
Date: Mon, 24 Dec 2018 00:28:13 +1100 (AEDT)
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
Cc: Hari Bathini <hbathini@linux.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Ananth Narayan <ananth@in.ibm.com>, kernelfans@gmail.com,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2018-08-20 at 08:17:17 UTC, Mahesh J Salgaonkar wrote:
> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> 
> One of the primary issues with Firmware Assisted Dump (fadump) on Power
> is that it needs a large amount of memory to be reserved. On large
> systems with TeraBytes of memory, this reservation can be quite
> significant.
> 
> In some cases, fadump fails if the memory reserved is insufficient, or
> if the reserved memory was DLPAR hot-removed.
> 
> In the normal case, post reboot, the preserved memory is filtered to
> extract only relevant areas of interest using the makedumpfile tool.
> While the tool provides flexibility to determine what needs to be part
> of the dump and what memory to filter out, all supported distributions
> default this to "Capture only kernel data and nothing else".
> 
> We take advantage of this default and the Linux kernel's Contiguous
> Memory Allocator (CMA) to fundamentally change the memory reservation
> model for fadump.
> 
> Instead of setting aside a significant chunk of memory nobody can use,
> this patch uses CMA instead, to reserve a significant chunk of memory
> that the kernel is prevented from using (due to MIGRATE_CMA), but
> applications are free to use it. With this fadump will still be able
> to capture all of the kernel memory and most of the user space memory
> except the user pages that were present in CMA region.
> 
> Essentially, on a P9 LPAR with 2 cores, 8GB RAM and current upstream:
> [root@zzxx-yy10 ~]# free -m
>               total        used        free      shared  buff/cache   available
> Mem:           7557         193        6822          12         541        6725
> Swap:          4095           0        4095
> 
> With this patch:
> [root@zzxx-yy10 ~]# free -m
>               total        used        free      shared  buff/cache   available
> Mem:           8133         194        7464          12         475        7338
> Swap:          4095           0        4095
> 
> Changes made here are completely transparent to how fadump has
> traditionally worked.
> 
> Thanks to Aneesh Kumar and Anshuman Khandual for helping us understand
> CMA and its usage.
> 
> TODO:
> - Handle case where CMA reservation spans nodes.
> 
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@linux.vnet.ibm.com>
> Signed-off-by: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
> Signed-off-by: Hari Bathini <hbathini@linux.ibm.com>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a4e92ce8e4c8275bacfe3529d6ac85

cheers
