Return-Path: <SRS0=n2Bs=OC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0E6EC43441
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 23:46:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3784B20861
	for <linuxppc-dev@archiver.kernel.org>; Fri, 23 Nov 2018 23:46:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3784B20861
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 431tHn4FFNzDqXL
	for <linuxppc-dev@archiver.kernel.org>; Sat, 24 Nov 2018 10:46:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linux-foundation.org
 (client-ip=140.211.169.12; helo=mail.linuxfoundation.org;
 envelope-from=akpm@linux-foundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-foundation.org
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 431tFM6h5MzDqWW
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Nov 2018 10:44:20 +1100 (AEDT)
Received: from localhost.localdomain (c-24-6-170-16.hsd1.ca.comcast.net
 [24.6.170.16])
 by mail.linuxfoundation.org (Postfix) with ESMTPSA id 3B646415;
 Fri, 23 Nov 2018 23:44:17 +0000 (UTC)
Date: Fri, 23 Nov 2018 15:44:15 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH] mm: Replace all open encodings for NUMA_NO_NODE
Message-Id: <20181123154415.42898a42e28a31488749738a@linux-foundation.org>
In-Reply-To: <1542966856-12619-1-git-send-email-anshuman.khandual@arm.com>
References: <1542966856-12619-1-git-send-email-anshuman.khandual@arm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-block@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux-foundation.org, intel-wired-lan@lists.osuosl.org,
 linux-alpha@vger.kernel.org, dmaengine@vger.kernel.org,
 sparclinux@vger.kernel.org, jiangqi903@gmail.com,
 linuxppc-dev@lists.ozlabs.org, ocfs2-devel@oss.oracle.com,
 linux-media@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 23 Nov 2018 15:24:16 +0530 Anshuman Khandual <anshuman.khandual@arm.com> wrote:

> At present there are multiple places where invalid node number is encoded
> as -1. Even though implicitly understood it is always better to have macros
> in there. Replace these open encodings for an invalid node number with the
> global macro NUMA_NO_NODE. This helps remove NUMA related assumptions like
> 'invalid node' from various places redirecting them to a common definition.
> 
> ...
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

The build testing is good, but I worry that some of the affected files
don't clearly have numa.h in their include paths, for the NUMA_NO_NODE
definition.

The first thing I looked it is arch/powerpc/include/asm/pci-bridge.h. 
Maybe it somehow manages to include numa.h via some nested include, but
if so, is that reliable across all config combinations and as code
evolves?

So I think that the patch should have added an explicit include of
numa.h, especially in cases where the affected file previously had no
references to any of the things which numa.h defines.

