Return-Path: <SRS0=9sKl=RI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18948C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 12:02:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B97A206DD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 12:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WrtRC6Jl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B97A206DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44DFrg5NXyzDqGX
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Mar 2019 23:02:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=infradead.org header.i=@infradead.org
 header.b="WrtRC6Jl"; dkim-atps=neutral
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44DFnk00bbzDqDV
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Mar 2019 23:00:09 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hE0McofzpbYyMCIP7PY4Mx7H3uVkhAMZLNHwgz2cNXw=; b=WrtRC6Jlvyb7DLuZp7QYIc4Uz
 1Weq8+WvEwAnOIhQW4UJoIW58RIKrxuJnkIs3BkH79pI2I5AEFwx92a27Izdcc6xxgKBBdY3dVqTx
 c+dNf+Q7+/9R/2/sZkqTIsKBNUtJ8WNUSdfifg22MDPcCZV66Vf4QxLcyVUqpXYtmKb5qX9id+Hq1
 e0zcT/rcjO3HC0J1NOIukJ1SX5iP7gzr4nPDnnGKsJiZiUB/ieEjqtvQQ0nlSTGNBdlk05rbYXHFW
 3a+U5wJ025sGBpJDLBkhy+i3X53wpUJ88Ci3o42M7FSf26NyqV5kok74JmwtEF8TsleiTFr0e6DQ0
 olWwq2OXA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h18jk-0005p5-8j; Tue, 05 Mar 2019 11:59:56 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 5CAA52007278A; Tue,  5 Mar 2019 12:59:52 +0100 (CET)
Date: Tue, 5 Mar 2019 12:59:52 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [RFC v3] sched/topology: fix kernel crash when a CPU is
 hotplugged in a memoryless node
Message-ID: <20190305115952.GH32477@hirez.programming.kicks-ass.net>
References: <20190304195952.16879-1-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190304195952.16879-1-lvivier@redhat.com>
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
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, Borislav Petkov <bp@suse.de>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 04, 2019 at 08:59:52PM +0100, Laurent Vivier wrote:
> This happens because initially powerpc code computes
> sched_domains_numa_masks of offline nodes as if they were merged with
> node 0 (because firmware doesn't provide the distance information for
> memoryless/cpuless nodes):
> 
>   node   0   1   2   3
>     0:  10  40  10  10
>     1:  40  10  40  40
>     2:  10  40  10  10
>     3:  10  40  10  10

*groan*... what does it do for things like percpu memory? ISTR the
per-cpu chunks are all allocated early too. Having them all use memory
out of node-0 would seem sub-optimal.

> We should have:
> 
>   node   0   1   2   3
>     0:  10  40  40  40
>     1:  40  10  40  40
>     2:  40  40  10  40
>     3:  40  40  40  10

Can it happen that it introduces a new distance in the table? One that
hasn't been seen before? This example only has 10 and 40, but suppose
the new node lands at distance 20 (or 80); can such a thing happen?

If not; why not?

> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 3f35ba1d8fde..24831b86533b 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1622,8 +1622,10 @@ void sched_init_numa(void)
>  				return;
>  
>  			sched_domains_numa_masks[i][j] = mask;
> +			if (!node_state(j, N_ONLINE))
> +				continue;
>  
> -			for_each_node(k) {
> +			for_each_online_node(k) {
>  				if (node_distance(j, k) > sched_domains_numa_distance[i])
>  					continue;
>  

So you're relying on sched_domain_numa_masks_set/clear() to fix this up,
but that in turn relies on the sched_domain_numa_levels thing to stay
accurate.

This all seems very fragile and unfortunate.
