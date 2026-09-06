Return-Path: <linuxppc-dev+bounces-26624-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3775AC79F85
	for <linuxppc-dev@archiver.kernel.org>; Sun,  6 Sep 2026 10:47:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hd6NV19KCz2y32;
	Sun, 06 Sep 2026 20:47:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788691658;
	cv=none; b=ZYFmP8J9JizVUT9OafF4CKCV/MqJMTdpaU0eni+bJJfm+evQJbuCtMKibh8/9gyxe2coGAn4igYJQY3biKteFociYjlqbvakcJFilGFZjPiGcXwPhGMTIm82LNnASNNYhylbjxYKOXXleaWOPnrngd7rIvhcCXOW1WNz/UTQLNkNfpv7PbnMRRa7BDhKGpCTnqd/dms2ptK8Sky7MGKcgGYG21Zgq3QZp0onDQUDc/fOVUf1SQrX4EZyqX8EXZKluqDsGtjW9bmIGyLv0Qzb7X+dU02Ij289L6OfYXORyCJM8FFwW8cdiDV9FKcghTS+GUIIime75SZi6SsiiNU6YA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788691658; c=relaxed/relaxed;
	bh=W6DNGqDYfT3d8o6uHJqWVZo4/oRgPdSR1cxwF3mU6L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tfc/s/S+iUNOo7ZJleO1zOhjx5g+vOsAAdRu+vz0bQZ3LJ8pbD9/UrIHuSzMy49rEoUUv7KhMMCmZCoontXiq9sqdhgmZ00HBwnF5RX1u0MyF+7rVH4dqcDVuvLUR3+sfl+AO3ZizSRohcf1phxXvkRfY9Mr6WUCMygwAR01wNi7Qme2Tw03gQNp6gl2SF81dQRxR2p00N540SKuIP0UyRFywzccYPbJoeFYRaRtVS+aM3YUG6TV2h6z0Tklgh75X8FBpYVNBXvVxD8/aO0bROEODNuXHtA7gJsZJdVQBy5r/zrxqX+t+txhDARvEtJUSinSop2dM+n8YC9Zgrls5A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPTf9X6D; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kPTf9X6D;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hd6NT16m1z2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 06 Sep 2026 20:47:37 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 3723D600AA;
	Sun,  6 Sep 2026 10:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E62E81F00A3A;
	Sun,  6 Sep 2026 10:47:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788691653;
	bh=W6DNGqDYfT3d8o6uHJqWVZo4/oRgPdSR1cxwF3mU6L4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kPTf9X6DCXVGxujdL6WGrcgDganHIgiyQ9VBs+LBDov8fdt4oMm5QEcC94AO24BYc
	 TkkmPvx8FbDlhKTM6cspMGdzaoKTbNDizMXQFr2Ou+agCaepmZ498pKLqlNoto3itn
	 quYCQ6taSHLzKo3HO4C30x8EOugzHLGsst1sBQBoecwdIe6WN7ivDDl+TfjUhlVxxN
	 y1tR2o0H7eQnDNUnFFgerBVzhIzOm92pIl3LFErLMVMRM1LjWpCFmUOwYTk0sgiYYt
	 0/uqFL4lj269UqdlzS9uR2f9+KxXdifPrgtFTgHRtEyjQg3ZdZnZ+uCbWT4hVa+u5J
	 zZG0AXACyM3pA==
Date: Sun, 6 Sep 2026 13:47:24 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	Aditya Gupta <adityag@linux.ibm.com>,
	Alexander Graf <graf@amazon.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Baoquan He <baoquan.he@linux.dev>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Hari Bathini <hbathini@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Mahesh Salgaonkar <mahesh@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shivang Upadhyay <shivangu@linux.ibm.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>, kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org, Tarun Sahu <tarunsahu@google.com>
Subject: Re: [RFC PATCH 2/3] powerpc: add support for Kexec HandOver (KHO)
Message-ID: <ap1EvH00nKze9Kj4@kernel.org>
References: <20260821105609.983622-1-sourabhjain@linux.ibm.com>
 <20260821105609.983622-3-sourabhjain@linux.ibm.com>
 <2vxza4qfznyo.fsf@kernel.org>
 <7bb84b8a-c394-4895-9e22-632dc506cbb6@linux.ibm.com>
 <2vxz5x0ox7p9.fsf@kernel.org>
 <8fa790a7-f387-48f6-ac76-11cf71ef5589@linux.ibm.com>
 <2vxzwlt1vvet.fsf@kernel.org>
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
In-Reply-To: <2vxzwlt1vvet.fsf@kernel.org>

On Fri, Sep 04, 2026 at 06:22:18PM +0200, Pratyush Yadav wrote:
> On Fri, Sep 04 2026, Sourabh Jain wrote:
> > On 02/09/26 16:04, Pratyush Yadav wrote:
> >> On Sun, Aug 23 2026, Sourabh Jain wrote:
> >>
> >>> On 21/08/26 17:26, Pratyush Yadav wrote:
> >>>> On Fri, Aug 21 2026, Sourabh Jain wrote:
> [...]
> >>> I agree that this is one way to work around the low-memory reservation problem.
> >>> However, there are a few things that come into play here:
> >>>
> >>> 1. On powerpc, the crashkernel reservation can go up to 64 GB for kdump. With
> >>> the
> >>>     current default scratch memory reservation policy, this could result in
> >>> reserving
> >>>     up to 256 GB of scratch memory: 200% for the high-memory reservation and
> >>> another
> >>>     200% for per-node memory.
> >> That calculation looks off. It _should_ be 200% once not twice. So 128
> >> GB total. If the allocation came out via the global area, it should
> >> _only_ be accounted to the global scratch size. Similarly, only the
> >> allocations made specifically on that node should be counted for the
> >> per-node scratch size.
> >
> > For example, if a system has only one node and 64 GB is allocated from
> > that node before the kernel starts calculating the per-node and global
> > allocations for scratch memory, wouldn't the per-node allocation also be 64 GB?
> >
> > If so, wouldn't that result in 200% of 64 GB being allocated for the global
> > area and another 200% of 64 GB for the per-node area, resulting in 256 GB
> > of total scratch memory allocation? Or am I missing something here?
> 
> It shouldn't. If the 64 GB of allocation was done with NUMA_NO_NODE, and
> it _happened_ to land on node X, it should not be counted for per-node
> sizing. It should count towards the global pool. Only allocations that
> were explicitly requested with node X should be count for that node's
> scratch size.
> 
> So on a one node system where 64G of memory is allocated with
> NUMA_NO_NODE and 8G is allocated with node X, we should get 128G of
> global scratch and 16G of per-node scratch, giving us a total of 144G.
> 
> I took a quick look and it looks like the problem might be that the
> calculation for global scratch includes _all_ nodes in it. See
> memblock_reserved_kern_size():
> 
> 	for_each_reserved_mem_region(r) {
> 		...
>                 
> 		if (nid == memblock_get_region_node(r) || !numa_valid_node(nid))
> 			if (r->flags & MEMBLOCK_RSRV_KERN)
> 				total += size;
> 	}
> 
> And for global scratch we pass nid as NUMA_NO_NODE.
> 
> For KHO we could just drop the || !numa_valid_node(), but
> memblock_estimated_nr_free_pages() seems to depend on that behaviour. It
> wants to get _all_ allocations across all nodes. KHO only wants
> allocations explicitly made with NUMA_NO_NODE.
> 
> But disclaimer: all this is from reading the code for maybe 15 minutes.
> I didn't run anything and might be missing something. So please
> double-check what I am saying.

That sounds about right, although I didn't check anything at all :)
 
> > BTW, do you know the rationale behind the 200% value?
> >
> > I couldn't find any explanation for it in the commit message of
> > 3dc92c311498c ("kexec: add Kexec HandOver (KHO) generation helpers")
> 
> We need to ask Alex (or maybe Mike?; I forget who added this).
> 
> But if I were to guess, I don't think there is much science involved
> behind the number. Since the scratch lives across all kexecs, it needs
> to be large enough in case the next kernel uses more memory. 200% sounds
> "large enough".

Yeah, that was the rationale indeed :)

> -- 
> Regards,
> Pratyush Yadav

-- 
Sincerely yours,
Mike.

