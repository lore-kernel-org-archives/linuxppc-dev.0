Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFEBCC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 14:57:12 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AF74222AB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 14:57:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AF74222AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ypm62VfDzDqN3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 01:57:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=softfail (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=195.135.220.15; helo=mx1.suse.de; envelope-from=mhocko@kernel.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ypfZ34DZzDqRy
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 01:52:22 +1100 (AEDT)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DBADFAE67;
 Mon, 11 Feb 2019 14:52:18 +0000 (UTC)
Date: Mon, 11 Feb 2019 15:52:17 +0100
From: Michal Hocko <mhocko@kernel.org>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH] x86, numa: always initialize all possible nodes
Message-ID: <20190211145217.GE15609@dhcp22.suse.cz>
References: <20190114082416.30939-1-mhocko@kernel.org>
 <20190124141727.GN4087@dhcp22.suse.cz>
 <3a7a3cf2-b7d9-719e-85b0-352be49a6d0f@intel.com>
 <20190125105008.GJ3560@dhcp22.suse.cz>
 <20190211134909.GA107845@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190211134909.GA107845@gmail.com>
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
Cc: Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
 linux-mm@kvack.org, Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 LKML <linux-kernel@vger.kernel.org>, Pingfan Liu <kernelfans@gmail.com>,
 Dave Hansen <dave.hansen@intel.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon 11-02-19 14:49:09, Ingo Molnar wrote:
> 
> * Michal Hocko <mhocko@kernel.org> wrote:
> 
> > On Thu 24-01-19 11:10:50, Dave Hansen wrote:
> > > On 1/24/19 6:17 AM, Michal Hocko wrote:
> > > > and nr_cpus set to 4. The underlying reason is tha the device is bound
> > > > to node 2 which doesn't have any memory and init_cpu_to_node only
> > > > initializes memory-less nodes for possible cpus which nr_cpus restrics.
> > > > This in turn means that proper zonelists are not allocated and the page
> > > > allocator blows up.
> > > 
> > > This looks OK to me.
> > > 
> > > Could we add a few DEBUG_VM checks that *look* for these invalid
> > > zonelists?  Or, would our existing list debugging have caught this?
> > 
> > Currently we simply blow up because those zonelists are NULL. I do not
> > think we have a way to check whether an existing zonelist is actually 
> > _correct_ other thatn check it for NULL. But what would we do in the
> > later case?
> > 
> > > Basically, is this bug also a sign that we need better debugging around
> > > this?
> > 
> > My earlier patch had a debugging printk to display the zonelists and
> > that might be worthwhile I guess. Basically something like this
> > 
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index 2e097f336126..c30d59f803fb 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -5259,6 +5259,11 @@ static void build_zonelists(pg_data_t *pgdat)
> >  
> >  	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
> >  	build_thisnode_zonelists(pgdat);
> > +
> > +	pr_info("node[%d] zonelist: ", pgdat->node_id);
> > +	for_each_zone_zonelist(zone, z, &pgdat->node_zonelists[ZONELIST_FALLBACK], MAX_NR_ZONES-1)
> > +		pr_cont("%d:%s ", zone_to_nid(zone), zone->name);
> > +	pr_cont("\n");
> >  }
> 
> Looks like this patch fell through the cracks - any update on this?

I was waiting for some feedback. As there were no complains about the
above debugging output I will make it a separate patch and post both
patches later this week. I just have to go through my backlog pile after
vacation.
-- 
Michal Hocko
SUSE Labs
