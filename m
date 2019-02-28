Return-Path: <SRS0=68wk=RD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E923C43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 14:36:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E15092184A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Feb 2019 14:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E15092184A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 449FTp5C74zDqT4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 01:35:58 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=mhocko@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 449FRm3ZyQzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Mar 2019 01:34:11 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DCD5EAFF6;
 Thu, 28 Feb 2019 14:34:06 +0000 (UTC)
Date: Thu, 28 Feb 2019 15:34:05 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH v8 1/4] mm/cma: Add PF flag to force non cma alloc
Message-ID: <20190228143405.GF10588@dhcp22.suse.cz>
References: <20190227144736.5872-1-aneesh.kumar@linux.ibm.com>
 <20190227144736.5872-2-aneesh.kumar@linux.ibm.com>
 <1d083bf9-0beb-0c49-9aab-c6bc14da46ea@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1d083bf9-0beb-0c49-9aab-c6bc14da46ea@suse.cz>
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
Cc: Andrea Arcangeli <aarcange@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu 28-02-19 13:20:03, Vlastimil Babka wrote:
> On 2/27/19 3:47 PM, Aneesh Kumar K.V wrote:
> > This patch adds PF_MEMALLOC_NOCMA which make sure any allocation in that context
> > is marked non-movable and hence cannot be satisfied by CMA region.
> > 
> > This is useful with get_user_pages_longterm where we want to take a page pin by
> > migrating pages from CMA region. Marking the section PF_MEMALLOC_NOCMA ensures
> > that we avoid unnecessary page migration later.
> > 
> > Suggested-by: Andrea Arcangeli <aarcange@redhat.com>
> > Reviewed-by: Andrea Arcangeli <aarcange@redhat.com>
> > Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> 
> +CC scheduler guys
> 
> Do we really take the last available PF flag just so that "we avoid
> unnecessary page migration later"?
> If yes, that's a third PF_MEMALLOC flag, should we get separate variable
> for gfp context at this point?

Yes, that sounds like a reasonable thing to do. Just note that xfs still
uses current_{set,restore}* api to handle PF_MEMALLOC_NOFS so that would
have to be moved over to the memalloc_nofs_{save,restore} API.

-- 
Michal Hocko
