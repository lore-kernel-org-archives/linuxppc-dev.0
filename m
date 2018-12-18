Return-Path: <SRS0=nim+=O3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F1C8C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 14:24:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF570217D7
	for <linuxppc-dev@archiver.kernel.org>; Tue, 18 Dec 2018 14:24:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF570217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43K0fB6k9fzDqVl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Dec 2018 01:24:50 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43K0bm3tPPzDqMS
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Dec 2018 01:22:44 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 55CA8B11B;
 Tue, 18 Dec 2018 14:22:40 +0000 (UTC)
Date: Tue, 18 Dec 2018 15:22:39 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH V4 0/3] * mm/kvm/vfio/ppc64: Migrate compound pages out
 of CMA region
Message-ID: <20181218142239.GL30879@dhcp22.suse.cz>
References: <20181121092259.16482-1-aneesh.kumar@linux.ibm.com>
 <20181207151226.cb00ace433738cf550e66885@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181207151226.cb00ace433738cf550e66885@linux-foundation.org>
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri 07-12-18 15:12:26, Andrew Morton wrote:
> On Wed, 21 Nov 2018 14:52:56 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> wrote:
> 
> > Subject: [PATCH V4 0/3] * mm/kvm/vfio/ppc64: Migrate compound pages out of CMA region
> 
> Asterisk in title is strange?
> 
> > ppc64 use CMA area for the allocation of guest page table (hash page table). We won't
> > be able to start guest if we fail to allocate hash page table. We have observed
> > hash table allocation failure because we failed to migrate pages out of CMA region
> > because they were pinned. This happen when we are using VFIO. VFIO on ppc64 pins
> > the entire guest RAM. If the guest RAM pages get allocated out of CMA region, we
> > won't be able to migrate those pages. The pages are also pinned for the lifetime of the
> > guest.
> > 
> > Currently we support migration of non-compound pages. With THP and with the addition of
> >  hugetlb migration we can end up allocating compound pages from CMA region. This
> > patch series add support for migrating compound pages. The first path adds the helper
> > get_user_pages_cma_migrate() which pin the page making sure we migrate them out of
> > CMA region before incrementing the reference count. 
> 
> Very little review activity.  Perhaps Andrey and/or Michal can find the
> time..

I will unlikely find some time before the end of the year. Sorry about
that.
-- 
Michal Hocko
SUSE Labs
