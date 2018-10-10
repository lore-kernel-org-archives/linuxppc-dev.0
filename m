Return-Path: <SRS0=lRG+=MW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50AE9C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 08:01:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B28572064E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 08:01:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B28572064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42VRQ532sDzF2QM
	for <linuxppc-dev@archiver.kernel.org>; Wed, 10 Oct 2018 19:01:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=mhocko@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42VRLg477WzF116
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Oct 2018 18:58:51 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id BC818AC68;
 Wed, 10 Oct 2018 07:58:47 +0000 (UTC)
Date: Wed, 10 Oct 2018 09:58:44 +0200
From: Michal Hocko <mhocko@kernel.org>
To: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: Re: [PATCH] memblock: stop using implicit alignement to
 SMP_CACHE_BYTES
Message-ID: <20181010075844.GA5873@dhcp22.suse.cz>
References: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1538687224-17535-1-git-send-email-rppt@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: linux-mips@linux-mips.org, linux-ia64@vger.kernel.org,
 Catalin Marinas <catalin.marinas@arm.com>, linux-mm@kvack.org,
 Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Geert Uytterhoeven <geert@linux-m68k.org>,
 Matt Turner <mattst88@gmail.com>, linux-um@lists.infradead.org,
 linux-m68k@lists.linux-m68k.org, Thomas Gleixner <tglx@linutronix.de>,
 Guan Xuetao <gxt@pku.edu.cn>, linux-arm-kernel@lists.infradead.org,
 Chris Zankel <chris@zankel.net>, Michal Simek <monstr@monstr.eu>,
 Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
 Paul Burton <paul.burton@mips.com>, linux-alpha@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri 05-10-18 00:07:04, Mike Rapoport wrote:
> When a memblock allocation APIs are called with align = 0, the alignment is
> implicitly set to SMP_CACHE_BYTES.

I would add something like
"
Implicit alignment is done deep in the memblock allocator and it can
come as a surprise. Not that such an alignment would be wrong even when
used incorrectly but it is better to be explicit for the sake of clarity
and the prinicple of the least surprise.
"

> Replace all such uses of memblock APIs with the 'align' parameter explicitly
> set to SMP_CACHE_BYTES and stop implicit alignment assignment in the
> memblock internal allocation functions.
> 
> For the case when memblock APIs are used via helper functions, e.g. like
> iommu_arena_new_node() in Alpha, the helper functions were detected with
> Coccinelle's help and then manually examined and updated where appropriate.
> 
> The direct memblock APIs users were updated using the semantic patch below:
> 
> @@
> expression size, min_addr, max_addr, nid;
> @@
> (
> |
> - memblock_alloc_try_nid_raw(size, 0, min_addr, max_addr, nid)
> + memblock_alloc_try_nid_raw(size, SMP_CACHE_BYTES, min_addr, max_addr,
> nid)
> |
> - memblock_alloc_try_nid_nopanic(size, 0, min_addr, max_addr, nid)
> + memblock_alloc_try_nid_nopanic(size, SMP_CACHE_BYTES, min_addr, max_addr,
> nid)
> |
> - memblock_alloc_try_nid(size, 0, min_addr, max_addr, nid)
> + memblock_alloc_try_nid(size, SMP_CACHE_BYTES, min_addr, max_addr, nid)
> |
> - memblock_alloc(size, 0)
> + memblock_alloc(size, SMP_CACHE_BYTES)
> |
> - memblock_alloc_raw(size, 0)
> + memblock_alloc_raw(size, SMP_CACHE_BYTES)
> |
> - memblock_alloc_from(size, 0, min_addr)
> + memblock_alloc_from(size, SMP_CACHE_BYTES, min_addr)
> |
> - memblock_alloc_nopanic(size, 0)
> + memblock_alloc_nopanic(size, SMP_CACHE_BYTES)
> |
> - memblock_alloc_low(size, 0)
> + memblock_alloc_low(size, SMP_CACHE_BYTES)
> |
> - memblock_alloc_low_nopanic(size, 0)
> + memblock_alloc_low_nopanic(size, SMP_CACHE_BYTES)
> |
> - memblock_alloc_from_nopanic(size, 0, min_addr)
> + memblock_alloc_from_nopanic(size, SMP_CACHE_BYTES, min_addr)
> |
> - memblock_alloc_node(size, 0, nid)
> + memblock_alloc_node(size, SMP_CACHE_BYTES, nid)
> )
> 
> Suggested-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>

I do agree that this is an improvement. I would also add WARN_ON_ONCE on
0 alignment to catch some left overs. If we ever grown a user which
would explicitly require the zero alignment (I would be surprised) then
we can remove the warning.

Acked-by: Michal Hocko <mhocko@suse.com>
-- 
Michal Hocko
SUSE Labs
