Return-Path: <linuxppc-dev+bounces-28825-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11095CA5FDD
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Oct 2026 10:46:51 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hxj5639F8z2y2B;
	Sat, 03 Oct 2026 20:46:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:41d0:1004:224b::f3"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791018606;
	cv=none; b=LRVMt8eITau0b4NZUZJUha6kU0fSQFaYnZ8gH2Q/cqvdBtSkJ4sAx/E70zCAiBmotdj+qeP4aU7C5nYFy4GmdoF9Lg5lk1q4p2YkC7hwg0lmOS7vF9uQpPk63HzUKIFMU0CRz/G2Hcpt6FxXQH7ETpUlHSq4AO9WUG2xCG832RwGI3zfQGtCOAjnj6AnToqUyR6KhThSLjoJXhj0qwwTeGnag5A1cBq4+b3AnR/3pwd93AoqbEM0R3jZQ8Ixs51CKHnetIQf0lB+Eid6RLzqMc13UdYyeCHthM0NUc8nmBa0AaP+wXtS1WeP901Kzjvadyn9cSnEXrH2KrEXmoWN0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791018606; c=relaxed/relaxed;
	bh=mCLHBjEEWo1IfXlT1QxAWgydsRtPcpZpIx7GlZOc+iI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSMTWVQlbOLNvnT72b486Hjngk/Gn4GQDS93Z1bNPFcS2scqymGXBNzDEERJnhjsxhB5J4Q0fZDe1euAcvE4p7jWzNkOWQs/U4OYKKQhUOC6oZHfRrvddxLzx6hy5W/kqUbE3QwMGlXN4D+1vViTmK2MlxvX/Dx76u+1zmYIPtdRh5lRDE1l/pjfvc9xvarhxjlWFUhDd98nACpMahfjsLgdkHlBBUec+OdcoROZ6cvGqmlXzYZfq9uK8jUPa+rUU1I+VCSDZFRtkljCozwdDbkl7jQ/8sbQXPXaIwPlEnYK4VqUMOvRMtLXLZFZ5JP8B60amdpxytXVk2C/AFadDA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NfrGPrpy; dkim-atps=neutral; spf=pass (client-ip=2001:41d0:1004:224b::f3; helo=mta0.migadu.com; envelope-from=chen.yu@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NfrGPrpy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=2001:41d0:1004:224b::f3; helo=mta0.migadu.com; envelope-from=chen.yu@linux.dev; receiver=lists.ozlabs.org)
Received: from mta0.migadu.com (out-243.mta0.migadu.com [IPv6:2001:41d0:1004:224b::f3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hxfxR3QPRz2xnn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 03 Oct 2026 19:10:02 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=FSHH2lxVQ7W/7ZcDn6MGkBGZpq4xldC6pMHimCeppLE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791018584; v=1; x=1791623384;
 b=NfrGPrpynlfLGKKORwxbqUJ9jWekm+WhjRX1N2s2hao7SjcpaAeK2noOCaX0NLjgWfPunq2h
 RWP6+EQsQnVKK5BQXIA3e1fyZBYiGMq23N2ycS6ztlgwzYu0jAevs/xitss7nAXiVcmGE6qQkXG
 c+T/RSTvjEIus7/mxlYtNBfI=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id 2747b1746997b9b8;
	Sat, 03 Oct 2026 09:09:43 +0000
X-Mizu-Trace-ID: 2747b1746997b9b8
X-Migadu-Flow: FLOW_OUT
Date: Sat, 3 Oct 2026 17:10:04 +0800
From: Chen Yu <chen.yu@linux.dev>
To: K Prateek Nayak <kprateek.nayak@amd.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-mips@vger.kernel.org,
	loongarch@lists.linux.dev, driver-core@lists.linux.dev,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Thomas Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
	WANG Xuerui <kernel@xen0n.name>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [RFC PATCH v3 00/13] lib, sched: Introduce sparsebitmap (sbm)
Message-ID: <asDGbBEHkDouWOwC@three-body>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261001192849.74788-1-kprateek.nayak@amd.com>

Hello Prateek!

Thanks for bringing this interesting topic,

On Thu, Oct 01, 2026 at 07:28:36PM +0000, K Prateek Nayak wrote:
> 
> Problem
> =======
> 
>                                             %cycles vs global mask operation
> 
> global mask                                     : 100.0000%  (var: 3.28%)
> per-NUMA mask                                   :  32.9209%  (var: 7.77%)
> per-LLC mask                                    :   1.2977%  (var: 4.85%)
> per-LLC mask (u8 operation; no LOCK prefix)     :   0.4930%  (var: 0.83%)
> 

This shows a significant latency improvement, especially in the per-LLC (u64, u8) case.
May I know if schbench / sched-messaging were used?

> 
> Future work
> ===========
> 
> o Interoperability with cpumaks since sbm lose the crucial optimizations
>   that come naturally from for_each_cpu_and() iterations.
>
> o Different data representation - using the u8 variant for updates and
>   then perform a "gather" operation to build a dense mask.
> 
> o Extending sbm work to help in wakeup (and possibly resurrect Mel's
>   optimization from [4] in some form). The current sbm is still far away
>   from being used for wakeups since  updates  to sbm leaf, even on a
>   16CPUs per LLC system is visible in benchmark performance (~8-10%).
> 

If we leverage sbm for the wakeup path, it is a per-LLC mask, there seems to be
no much difference from Mel Gorman's proposal of allocating per sd_share
unsigned long idle_cpus_span[]? The frequent update to this mask might still cause
c2c latency within 1 LLC. A wild guess is that maybe the u8 version is more suitable,
because it has only max-to-8 CPUs touching the mask at the same time?

My understanding is that the major case that sbm could fit is turning the global bitmask
into a per-LLC bitmask, because it mainly avoids CPUs on different LLC/node writing the
same cache line frequently (nohz.idle_cpus_mask set via nohz_balance_enter_idle() on
many CPUs, etc), which might cause a costly cache RFO event storm. Meanwhile, with sbm,
at the reader side, _nohz_idle_balance() could start scanning from the current CPU to find
an idle CPU, so as to avoid the costly HITM event - the reader is on LLC1, while the writer
is on LLC0 - so maybe:

for_each_cpu_wrap(balance_cpu, nohz.idle_cpus_mask, this_cpu+1)

could start from this_cpu's LLC sibling first, rather than this_cpu + 1, because this_cpu+1
might not always be the LLC sibling of this_cpu.

I found that in the current code, there are also other global mask:
rd->rto_mask(mentioned by Pan Deng when running ffmpeg[1])
rd->dlo_mask
tick_broadcast_**mask
maybe they can also be converted into sbm.

[1] https://lore.kernel.org/lkml/a3207ebf537bbe5605ff5454f63b5604d83a04a0.1753076363.git.pan.deng@intel.com/

thanks,
Chenyu 

