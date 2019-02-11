Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.4 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FSL_HELO_FAKE,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8466C169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 14:18:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D35B222B8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 14:18:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CCK4abFG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D35B222B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43yntv2pxCzDqQR
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 01:17:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2a00:1450:4864:20::342; helo=mail-wm1-x342.google.com;
 envelope-from=mingo.kernel.org@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="CCK4abFG"; 
 dkim-atps=neutral
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ynFl27DTzDqTj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 00:49:15 +1100 (AEDT)
Received: by mail-wm1-x342.google.com with SMTP id v26so17328809wmh.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 05:49:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=DVtdq8fU5yzV1rrZ0aSuQ/EzU0RuehB06aN26pxAuHw=;
 b=CCK4abFGXcAfhVXmnffelYC/DDGe1Z8EpvNin5P2hc8Xjf3/+ybQ8YCd/ZRN0kZuGj
 BtJlskKem5DzyYfhdYZHmjftoWVZgmMfalk4/ALI3ebW/mobd9JROaujzQjZum/b7y+K
 4aO9OawsNAE+/uV+eQpzZbhiratfAlXETcydv2Cjd9OF7KBxn61f/7JXIq5wVHbnKJ/a
 6jNF0S8ah01tkg6wGRZ630re0KbURzsbTKQqnDZbsbfuRjt9pnWjAIqZ8AnUWLTseo+H
 Gzreb6TV39Aw3LUHelip++YXvjHQF4A2T1KXhQVutCk1MVeORaw1FV7orcBxhYLTQjHn
 enmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
 :references:mime-version:content-disposition:in-reply-to:user-agent;
 bh=DVtdq8fU5yzV1rrZ0aSuQ/EzU0RuehB06aN26pxAuHw=;
 b=pYHdoeXCpG1AYRAGP96OJ9SVvJu+9MhkfAKTPLfhz6WNAl/x3Mc4P3xWBVGLZJ7bTF
 NAx/F50g595gVrm1m/Ml0gUtvfUItY6g73n7zSoJMBqGPkl32xO3pcCEKgBcI0YHm2Tm
 i5EHjY8SP/WW8x4Q5Duid7nMKN3vZgXVm0MaeSrsUl9nN403ySe5gAr6tN1+mCIB3Xbz
 2CYcX63ZVeStu8BgZCWPmRuJ5QdL06379fj22lfhf8OThSx+/uHvdQZQyadPPFP0EBO4
 kjxyb4sgtm8x6gZlE4O/VgNAMB8ooxBlvvHx7ez01GWK4Esllk3o1sSq12I0wGVJ8IhZ
 QfLQ==
X-Gm-Message-State: AHQUAuZqqWUuJNycrTXDKeLw4Onqs0PDEWF8lMzFznmy1fVRGhA0IuaB
 ch9Y6gRaHNTtbmRibn9bLPE=
X-Google-Smtp-Source: AHgI3IbnoKtqDyMN51wGAheblyAvac9xJv/j79dudDo+aSVyCoGxbXaU22La1kGx2XXQbkCFrKZ1+Q==
X-Received: by 2002:a1c:790c:: with SMTP id l12mr9002787wme.11.1549892952343; 
 Mon, 11 Feb 2019 05:49:12 -0800 (PST)
Received: from gmail.com (2E8B0CD5.catv.pool.telekom.hu. [46.139.12.213])
 by smtp.gmail.com with ESMTPSA id n9sm7499714wrx.80.2019.02.11.05.49.10
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 05:49:11 -0800 (PST)
Date: Mon, 11 Feb 2019 14:49:09 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Michal Hocko <mhocko@kernel.org>
Subject: Re: [RFC PATCH] x86, numa: always initialize all possible nodes
Message-ID: <20190211134909.GA107845@gmail.com>
References: <20190114082416.30939-1-mhocko@kernel.org>
 <20190124141727.GN4087@dhcp22.suse.cz>
 <3a7a3cf2-b7d9-719e-85b0-352be49a6d0f@intel.com>
 <20190125105008.GJ3560@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190125105008.GJ3560@dhcp22.suse.cz>
User-Agent: Mutt/1.9.4 (2018-02-28)
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


* Michal Hocko <mhocko@kernel.org> wrote:

> On Thu 24-01-19 11:10:50, Dave Hansen wrote:
> > On 1/24/19 6:17 AM, Michal Hocko wrote:
> > > and nr_cpus set to 4. The underlying reason is tha the device is bound
> > > to node 2 which doesn't have any memory and init_cpu_to_node only
> > > initializes memory-less nodes for possible cpus which nr_cpus restrics.
> > > This in turn means that proper zonelists are not allocated and the page
> > > allocator blows up.
> > 
> > This looks OK to me.
> > 
> > Could we add a few DEBUG_VM checks that *look* for these invalid
> > zonelists?  Or, would our existing list debugging have caught this?
> 
> Currently we simply blow up because those zonelists are NULL. I do not
> think we have a way to check whether an existing zonelist is actually 
> _correct_ other thatn check it for NULL. But what would we do in the
> later case?
> 
> > Basically, is this bug also a sign that we need better debugging around
> > this?
> 
> My earlier patch had a debugging printk to display the zonelists and
> that might be worthwhile I guess. Basically something like this
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 2e097f336126..c30d59f803fb 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -5259,6 +5259,11 @@ static void build_zonelists(pg_data_t *pgdat)
>  
>  	build_zonelists_in_node_order(pgdat, node_order, nr_nodes);
>  	build_thisnode_zonelists(pgdat);
> +
> +	pr_info("node[%d] zonelist: ", pgdat->node_id);
> +	for_each_zone_zonelist(zone, z, &pgdat->node_zonelists[ZONELIST_FALLBACK], MAX_NR_ZONES-1)
> +		pr_cont("%d:%s ", zone_to_nid(zone), zone->name);
> +	pr_cont("\n");
>  }

Looks like this patch fell through the cracks - any update on this?

Thanks,

	Ingo
