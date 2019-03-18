Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84172C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 11:29:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C03F92085A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 11:29:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HUMYqDlB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C03F92085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44NDV823WVzDqKL
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 22:29:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=infradead.org
 (client-ip=2001:8b0:10b:1231::1; helo=merlin.infradead.org;
 envelope-from=peterz@infradead.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=infradead.org
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44NDRg33r3zDqCh
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 22:27:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S2/dxFXAm03U45Rs8pY/i96tt6/fU95rFJjs1/nGlmE=; b=HUMYqDlBR8gH8twMBPth8dKUC
 q1+S0eXS+6JhX/WbndFij+Cqi/Y3wPcM2ay9gZwxo+fSwj+lQYIfNeTr3JRZFE+wCng6EbngBM7L/
 kJZNgAzAFwtLpDSUVX6xmP7TKaFGNv1s73tQFuq5quFebQ9GKcGlLxCwGNyPT7vQiw2ieOvOOiih6
 7hYQLqnar57uvNBEmUBSWstu+VAgF5BA0MUpxqrHk+LaRGXpVjePqBIyV31C61tzpBfeLJTo84uE5
 swGAyYtT4rOf6MxnbGy88vxyCffH84QC92qixV42qn85hhMeKmfAC6+l/etwJFUths7VB2RiQzeE3
 exnn0tvCg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100]
 helo=hirez.programming.kicks-ass.net)
 by merlin.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
 id 1h5qPr-0002Mi-VD; Mon, 18 Mar 2019 11:26:52 +0000
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
 id 5811D20A0FF82; Mon, 18 Mar 2019 12:26:50 +0100 (CET)
Date: Mon, 18 Mar 2019 12:26:50 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Subject: Re: [RFC v3] sched/topology: fix kernel crash when a CPU is
 hotplugged in a memoryless node
Message-ID: <20190318112650.GO6058@hirez.programming.kicks-ass.net>
References: <20190304195952.16879-1-lvivier@redhat.com>
 <20190305115952.GH32477@hirez.programming.kicks-ass.net>
 <20190318104730.GA4450@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190318104730.GA4450@linux.vnet.ibm.com>
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
Cc: Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, Borislav Petkov <bp@suse.de>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Mar 18, 2019 at 04:17:30PM +0530, Srikar Dronamraju wrote:
> > > node 0 (because firmware doesn't provide the distance information for
> > > memoryless/cpuless nodes):
> > > 
> > >   node   0   1   2   3
> > >     0:  10  40  10  10
> > >     1:  40  10  40  40
> > >     2:  10  40  10  10
> > >     3:  10  40  10  10
> > 
> > *groan*... what does it do for things like percpu memory? ISTR the
> > per-cpu chunks are all allocated early too. Having them all use memory
> > out of node-0 would seem sub-optimal.
> 
> In the specific failing case, there is only one node with memory; all other
> nodes are cpu only nodes.
> 
> However in the generic case since its just a cpu hotplug ops, the memory
> allocated for per-cpu chunks allocated early would remain.

What do you do in the case where there's multiple nodes with memory, but
only one with CPUs on?

Do you then still allocate the per-cpu memory for the CPUs that will
appear on that second node on node0?

> > > We should have:
> > > 
> > >   node   0   1   2   3
> > >     0:  10  40  40  40
> > >     1:  40  10  40  40
> > >     2:  40  40  10  40
> > >     3:  40  40  40  10
> > 
> > Can it happen that it introduces a new distance in the table? One that
> > hasn't been seen before? This example only has 10 and 40, but suppose
> > the new node lands at distance 20 (or 80); can such a thing happen?
> > 
> > If not; why not?
> 
> Yes distances can be 20, 40 or 80. There is nothing that makes the node
> distance to be 40 always.

This,

> > So you're relying on sched_domain_numa_masks_set/clear() to fix this up,
> > but that in turn relies on the sched_domain_numa_levels thing to stay
> > accurate.
> > 
> > This all seems very fragile and unfortunate.
> > 
> 
> Any reasons why this is fragile?

breaks that patch. The code assumes all the numa distances are known at
boot. If you add distances later, it comes unstuck.

It's not like you're actually changing the interconnects around at
runtime. Node topology really should be known at boot time.



What I _think_ the x86 BIOS does is, for each empty socket, iterate as
many logical CPUs (non-present) as it finds on Socket-0 (or whatever
socket is the boot socket).

Those non-present CPUs are assigned to their respective nodes. And
if/when a physical CPU is placed on the socket and the CPUs onlined, it
all 'works' (see ACPI SRAT).

I'm not entirely sure what happens on x86 when it boots with say a
10-core part and you then fill an empty socket with a 20-core part, I
suspect we simply will not use more than 10, we'll not have space
reserved in the Linux cpumasks for them anyway.

