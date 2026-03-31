Return-Path: <linuxppc-dev+bounces-19110-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0672A10F92EE
	for <linuxppc-dev@archiver.kernel.org>; Tue, 31 Mar 2026 18:47:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4flcYl4ynWz2yTH;
	Wed, 01 Apr 2026 05:47:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774982859;
	cv=none; b=kleZQhb8lbKBIA9W52QsHIYSvRm6IoCP+t9gt+aqoxYD/aOLrua0KsfR3A1rjQUgdWlo0U2hZFUsPBn8CGLD5MKdrf3G1Zdo024bwKw7YojZdcrL4qOQbUW+YE1zpxeCK0dwm1c1rdZRKAOKGFeUeTzuOTF/l6VMVvXQRX+cgAts8MarV18ZoahWpBAJBeVF0khgEu1XREVXgVRQjVAonyEdSP3BQci80MAYu/irzpHPmCW9sGoGh3Xq3pS06Ek9W6zI44uKcnuEE9QXeeLc0HV9WEKH5Qj5c/MaohDoIFspF0DCFAwQbi2YH+JyJulZrv2KVIsmd/4e49/shpIoCg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774982859; c=relaxed/relaxed;
	bh=x5fx/dab+pVL7aD9tN8uemN9eSReBjb0qsUrSrv1ddg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWoxiak7WY7t93tWfo9teWdWSXqxjQwcBb/zNk4X/nI56wb62n9bLIJndatcYlQqXucyv33XDWm7tiXEfSXk98rkLng2EVAgtQ2ZHmH6QDDWaSfjM9gBUxkzex7SPYE3TIA5zl1/a9wPBLJPOrEtvNLFGxVgj1zG8egAaJGwOVxRGn01ctp3G9Hx/AZ78bulNSACzcgt6DB4Kg5Ni6vjtZyW8Q5K5ftn7uGIcdLTq2CdEsEiXBZfRSYrBIpl2kG03EFUlgVgH4ogBDAo2U/D14RgdcnlP/ePEDwhZSQaT/wuZh5rFoomeFTljU468bs5pbzzwPtaMAAxtciW+slLyQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hCuxgfhk; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=hCuxgfhk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4flcYl0v1Mz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 01 Apr 2026 05:47:39 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7302A42DC1;
	Tue, 31 Mar 2026 18:47:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0779CC19423;
	Tue, 31 Mar 2026 18:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774982857;
	bh=CUmvYJ+q9fr0CWu9PeM2hiD4yICAuMHbTJnAtOumyIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hCuxgfhkhW2T2Q50p+f5sEFLu1o0vSZtLrAfwaZoDPLQotj+9CrNSTDt99ktgypf0
	 MqMjS1oLLVheBrOv/aoB/sQc9tYjtIjC/ON9njXZ8nlquEQUpcy2R2Dzu3FqVm9JRJ
	 737vuu2fWRDxzXosqSJOW5RbqspgpR3kk6iFFWJbqzbyiGMOEl6NrLLshNFasROsd4
	 IM20vPN1u5cNPCMCE1aKuMkErL4MqR9RU85mu2IOedMimZ6HxcwaaMDeifSkR2Ht24
	 990T0kFs1K2Gzus8kty9SgWt4RW2zATT8xfXIbGYhsrGnfOjyG2IoPG52Z5DLh85h0
	 r0nRshjuR/m8w==
Date: Tue, 31 Mar 2026 19:47:30 +0100
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Suren Baghdasaryan <surenb@google.com>, willy@infradead.org, 
	david@kernel.org, ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, 
	rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, 
	maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v6 2/6] mm: use vma_start_write_killable() in mm syscalls
Message-ID: <cf6975a6-336a-401b-b122-b9597b5710b7@lucifer.local>
References: <20260327205457.604224-1-surenb@google.com>
 <20260327205457.604224-3-surenb@google.com>
 <5d90d998-9b8d-435c-b684-260600311797@lucifer.local>
 <CAJuCfpE5w8r_6Ss=5ZPrEb1RQOTG6HyY8Pivac=iiyqFRZvD4g@mail.gmail.com>
 <20260331112921.854d4f6cc793dba0972ee9f1@linux-foundation.org>
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
In-Reply-To: <20260331112921.854d4f6cc793dba0972ee9f1@linux-foundation.org>

On Tue, Mar 31, 2026 at 11:29:21AM -0700, Andrew Morton wrote:
> On Tue, 31 Mar 2026 08:01:11 -0700 Suren Baghdasaryan <surenb@google.com> wrote:
>
> > > Instead? That is, assuming we really need to care about this at all.
> > >
> > > But I think I don't like this change at all?
> >
> > Yeah, this was the part I wasn't sure if it's worth adding. With your
> > vote confirming my scepticism I'll go ahead and remove the parts I
> > added to avoid extra vma_start_write_killable() call (3 instances in
> > all) and will post v7.
>
> Thanks.  I'll remove v6 from mm.git and shall await Lorenzo's advice on
> v7.
>

Ack, if we just drop the problematic bits we might still be fine for 7.1 :)

Cheers, Lorenzo

