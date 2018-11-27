Return-Path: <SRS0=Iv+L=OG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F79CC43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 07:59:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F00432086B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 07:59:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F00432086B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 433x4n6DlTzDqfb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Nov 2018 18:59:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433x2h1cPBzDqcQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2018 18:57:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 433x2f3tQHz9s3C;
 Tue, 27 Nov 2018 18:57:14 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] mm: Replace all open encodings for NUMA_NO_NODE
In-Reply-To: <1543235202-9075-1-git-send-email-anshuman.khandual@arm.com>
References: <1543235202-9075-1-git-send-email-anshuman.khandual@arm.com>
Date: Tue, 27 Nov 2018 18:57:11 +1100
Message-ID: <87mupvgdgo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: hverkuil@xs4all.nl, linux-fbdev@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org, vkoul@kernel.org,
 dri-devel@lists.freedesktop.org, linux-block@vger.kernel.org,
 sparclinux@vger.kernel.org, iommu@lists.linux-foundation.org,
 intel-wired-lan@lists.osuosl.org, linux-alpha@vger.kernel.org,
 dmaengine@vger.kernel.org, jiangqi903@gmail.com, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
 linux-media@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Anshuman Khandual <anshuman.khandual@arm.com> writes:
> At present there are multiple places where invalid node number is encoded
> as -1. Even though implicitly understood it is always better to have macros
> in there. Replace these open encodings for an invalid node number with the
> global macro NUMA_NO_NODE. This helps remove NUMA related assumptions like
> 'invalid node' from various places redirecting them to a common definition.
>
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in V2:
>
> - Added inclusion of 'numa.h' header at various places per Andrew
> - Updated 'dev_to_node' to use NUMA_NO_NODE instead per Vinod
>
> Changes in V1: (https://lkml.org/lkml/2018/11/23/485)
>
> - Dropped OCFS2 changes per Joseph
> - Dropped media/video drivers changes per Hans
>
> RFC - https://patchwork.kernel.org/patch/10678035/
>
> Build tested this with multiple cross compiler options like alpha, sparc,
> arm64, x86, powerpc, powerpc64le etc with their default config which might
> not have compiled tested all driver related changes. I will appreciate
> folks giving this a test in their respective build environment.
>
> All these places for replacement were found by running the following grep
> patterns on the entire kernel code. Please let me know if this might have
> missed some instances. This might also have replaced some false positives.
> I will appreciate suggestions, inputs and review.
>
> 1. git grep "nid == -1"
> 2. git grep "node == -1"
> 3. git grep "nid = -1"
> 4. git grep "node = -1"
>
>  arch/alpha/include/asm/topology.h             |  3 ++-
>  arch/ia64/kernel/numa.c                       |  2 +-
>  arch/ia64/mm/discontig.c                      |  6 +++---
>  arch/ia64/sn/kernel/io_common.c               |  3 ++-
>  arch/powerpc/include/asm/pci-bridge.h         |  3 ++-
>  arch/powerpc/kernel/paca.c                    |  3 ++-
>  arch/powerpc/kernel/pci-common.c              |  3 ++-
>  arch/powerpc/mm/numa.c                        | 14 +++++++-------
>  arch/powerpc/platforms/powernv/memtrace.c     |  5 +++--

These powerpc changes all look fine.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>


cheers
