Return-Path: <SRS0=Ik3v=5D=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F0E5C10DCE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2020 18:59:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9BED20724
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Mar 2020 18:58:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9BED20724
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48jK811wQNzDqxj
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2020 05:58:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (domain owner discourages use of this
 host) smtp.mailfrom=linux.com (client-ip=3.19.106.255; helo=gentwo.org;
 envelope-from=cl@linux.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=linux.com
Received: from gentwo.org (gentwo.org [3.19.106.255])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48jK5z08tZzDqwl
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Mar 2020 05:57:10 +1100 (AEDT)
Received: by gentwo.org (Postfix, from userid 1002)
 id 1FEAA3EF51; Wed, 18 Mar 2020 18:57:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by gentwo.org (Postfix) with ESMTP id 1DA593EF50;
 Wed, 18 Mar 2020 18:57:07 +0000 (UTC)
Date: Wed, 18 Mar 2020 18:57:07 +0000 (UTC)
From: Christopher Lameter <cl@linux.com>
X-X-Sender: cl@www.lameter.com
To: Michal Hocko <mhocko@kernel.org>
Subject: Re: [PATCH 3/3] mm/page_alloc: Keep memoryless cpuless node 0 offline
In-Reply-To: <20200316085425.GB11482@dhcp22.suse.cz>
Message-ID: <alpine.DEB.2.21.2003181855260.18605@www.lameter.com>
References: <20200311110237.5731-1-srikar@linux.vnet.ibm.com>
 <20200311110237.5731-4-srikar@linux.vnet.ibm.com>
 <alpine.DEB.2.21.2003151416230.14449@www.lameter.com>
 <20200316085425.GB11482@dhcp22.suse.cz>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, Mel Gorman <mgorman@suse.de>,
 "Kirill A. Shutemov" <kirill@shutemov.name>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Vlastimil Babka <vbabka@suse.cz>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 16 Mar 2020, Michal Hocko wrote:

> > We can dynamically number the nodes right? So just make sure that the
> > firmware properly creates memory on node 0?
>
> Are you suggesting that the OS would renumber NUMA nodes coming
> from FW just to satisfy node 0 existence? If yes then I believe this is
> really a bad idea because it would make HW/LPAR configuration matching
> to the resulting memory layout really hard to follow.

NUMA nodes are created by the OS based on information provided by the
firmware. Either the FW would need to ensure that a viable node 0 exists
or the bootstrap arch code could setup things to the same effect.

