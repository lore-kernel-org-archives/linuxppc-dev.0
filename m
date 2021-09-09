Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF70BC433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Sep 2021 14:38:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 348116115A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  9 Sep 2021 14:38:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 348116115A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H51ng632sz2yQG
	for <linuxppc-dev@archiver.kernel.org>; Fri, 10 Sep 2021 00:37:59 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=KE8n8Iol;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256
 header.s=desiato.20200630 header.b=KE8n8Iol; 
 dkim-atps=neutral
Received: from desiato.infradead.org (desiato.infradead.org
 [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4H51mr0Kcfz2xr0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Sep 2021 00:37:12 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=miXXbNQp7caQxshcYtg01AumgMhcOjaj3/whiABmZ9w=; b=KE8n8IolslkEzrZGA5k4fhia4/
 1+5m+Aymfe1VeQT9vjj17rJoJ2zZ75I3vM7dg/Bemu6d66krYhf8TND3wPCbj/cVYN9x5rdomH/rI
 G//1dQ4M2YKdkWIpYvjzA6SrnVAljknsqq6dq5JdvPGWHCWCbUzoMf3iDfDohROi9nKfTQx9NW5MR
 DDDU1mbZ4P+sKN8/SvbfWutM60cttZ0fJPya+8nKMLOO/PGya5vuB5nuglLmQmJLZyQMU4blv4Vjn
 ZIjlkkQ0tgYG+RXrykuhE7UIukgt5pAMK5n2JwERzDeseNUuGKOyu9TfZ2MSgnH5e13khcd61LbEI
 kRINjKNQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=noisy.programming.kicks-ass.net)
 by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mOLAX-001t5Y-BC; Thu, 09 Sep 2021 14:36:49 +0000
Received: from hirez.programming.kicks-ass.net
 (hirez.programming.kicks-ass.net [192.168.1.225])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (Client did not present a certificate)
 by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 020CB300094;
 Thu,  9 Sep 2021 16:36:47 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id B1C6420D13710; Thu,  9 Sep 2021 16:36:47 +0200 (CEST)
Date: Thu, 9 Sep 2021 16:36:47 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/3] perf: Add macros to specify onchip L2/L3 accesses
Message-ID: <YTob/xfn1gt901K4@hirez.programming.kicks-ass.net>
References: <20210904064932.307610-1-kjain@linux.ibm.com>
 <87ilzbmt7i.fsf@mpe.ellerman.id.au>
 <YTiBqbxe7ieqY2OE@hirez.programming.kicks-ass.net>
 <87czphnchp.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87czphnchp.fsf@mpe.ellerman.id.au>
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
Cc: mark.rutland@arm.com, atrajeev@linux.vnet.ibm.com, ak@linux.intel.com,
 daniel@iogearbox.net, rnsastry@linux.ibm.com,
 alexander.shishkin@linux.intel.com, Kajol Jain <kjain@linux.ibm.com>,
 linux-kernel@vger.kernel.org, acme@kernel.org, ast@kernel.org,
 linux-perf-users@vger.kernel.org, yao.jin@linux.intel.com, mingo@redhat.com,
 paulus@samba.org, maddy@linux.ibm.com, jolsa@kernel.org, namhyung@kernel.org,
 songliubraving@fb.com, linuxppc-dev@lists.ozlabs.org,
 kan.liang@linux.intel.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 09, 2021 at 10:45:54PM +1000, Michael Ellerman wrote:

> > The 'new' composite doesnt have a hops field because the hardware that
> > nessecitated that change doesn't report it, but we could easily add a
> > field there.
> >
> > Suppose we add, mem_hops:3 (would 6 hops be too small?) and the
> > corresponding PERF_MEM_HOPS_{NA, 0..6}
> 
> It's really 7 if we use remote && hop = 0 to mean the first hop.

I don't think we can do that, becaus of backward compat. Currently:

  lvl_num=DRAM, remote=1

denites: "Remote DRAM of any distance". Effectively it would have the new
hops field filled with zeros though, so if you then decode with the hops
field added it suddenly becomes:

 lvl_num=DRAM, remote=1, hops=0

and reads like: "Remote DRAM of 0 hops" which is quite daft. Therefore 0
really must denote a 'N/A'.

> If we're wanting to use some of the hop levels to represent
> intra-chip/package hops then we could possibly use them all on a really
> big system.
> 
> eg. you could imagine something like:
> 
>  L2 | 		        - local L2
>  L2 | REMOTE | HOPS_0	- L2 of neighbour core
>  L2 | REMOTE | HOPS_1	- L2 of near core on same chip (same 1/2 of chip)
>  L2 | REMOTE | HOPS_2	- L2 of far core on same chip (other 1/2 of chip)
>  L2 | REMOTE | HOPS_3	- L2 of sibling chip in same package
>  L2 | REMOTE | HOPS_4	- L2 on separate package 1 hop away
>  L2 | REMOTE | HOPS_5	- L2 on separate package 2 hops away
>  L2 | REMOTE | HOPS_6	- L2 on separate package 3 hops away
> 
> 
> Whether it's useful to represent all those levels I'm not sure, but it's
> probably good if we have the ability.

I'm thinking we ought to keep hops as steps along the NUMA fabric, with
0 hops being the local node. That only gets us:

 L2, remote=0, hops=HOPS_0 -- our L2
 L2, remote=1, hops=HOPS_0 -- L2 on the local node but not ours
 L2, remote=1, hops!=HOPS_0 -- L2 on a remote node

> I guess I'm 50/50 on whether that's enough levels, or whether we want
> another bit to allow for future growth.

Right, possibly safer to add one extra bit while we can.... I suppose.

