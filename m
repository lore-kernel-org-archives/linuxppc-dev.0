Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 015EAC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 12:41:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2420821871
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 12:41:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="ebGH4hCE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2420821871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LQDz6Lz6zDqJM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 23:41:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2607:7c80:54:e::133; helo=bombadil.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2607:7c80:54:e::133])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LPv16Dt3zDqSP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Mar 2019 23:26:05 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IFl7tyDTxxjlEDrkxvda1xuKJBo+PzJ9ZHHegjIR54c=; b=ebGH4hCEm2810H85vbAXgXuei
 RLVEaFn7oSgEb/Zn7VBY5DEunlt33RUHDW5kHouJngY37aCll9nYQoyAq9Ws+CsFihYPdbU9Fa+mN
 StmingCxk5Kn1tsKY/79Fx+cx6HqqQG2rUUfvOlggHY4Gr0o0/9HtXzV2k0zFz0Wz4y2ef4C12uBv
 33/vTOGVQl4v5c14uDBqnnghJBq/aJjxfzIxLdPuB/9NaQkexXH1aLI8rywWIJuFpks4S2nu1NgZH
 DJLlTs+mEOOu5WNoReTBvSs0txqNHjxZw5J1GojE9EdZa9f79HjYiE1i2w1co6jGWMzYSI1+YOBIr
 bL9HlwQ+w==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h4luP-0006CR-Qd; Fri, 15 Mar 2019 12:25:58 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 49BE321419E57; Fri, 15 Mar 2019 13:25:56 +0100 (CET)
Date: Fri, 15 Mar 2019 13:25:56 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [RFC v3] sched/topology: fix kernel crash when a CPU is
 hotplugged in a memoryless node
Message-ID: <20190315122556.GE6058@hirez.programming.kicks-ass.net>
References: <20190304195952.16879-1-lvivier@redhat.com>
 <77b142fe-0886-1510-28bd-d432ea2c796a@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <77b142fe-0886-1510-28bd-d432ea2c796a@redhat.com>
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

On Fri, Mar 15, 2019 at 12:12:45PM +0100, Laurent Vivier wrote:

> Another way to avoid the nodes overlapping for the offline nodes at
> startup is to ensure the default values don't define a distance that
> merge all offline nodes into node 0.
> 
> A powerpc specific patch can workaround the kernel crash by doing this:
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 87f0dd0..3ba29bb 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -623,6 +623,7 @@ static int __init parse_numa_properties(void)
>         struct device_node *memory;
>         int default_nid = 0;
>         unsigned long i;
> +       int nid, dist;
> 
>         if (numa_enabled == 0) {
>                 printk(KERN_WARNING "NUMA disabled by user\n");
> @@ -636,6 +637,10 @@ static int __init parse_numa_properties(void)
> 
>         dbg("NUMA associativity depth for CPU/Memory: %d\n",
> min_common_depth);
> 
> +       for (nid = 0; nid < MAX_NUMNODES; nid ++)
> +               for (dist = 0; dist < MAX_DISTANCE_REF_POINTS; dist++)
> +                       distance_lookup_table[nid][dist] = nid;
> +
>         /*
>          * Even though we connect cpus to numa domains later in SMP
>          * init, we need to know the node ids now. This is because

What does that actually do? That is, what does it make the distance
table look like before and after you bring up the CPUs?

> Any comment?

Well, I had a few questions here:

  20190305115952.GH32477@hirez.programming.kicks-ass.net

that I've not yet seen answers to.
