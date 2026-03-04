Return-Path: <linuxppc-dev+bounces-17657-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E1CCEDEC03
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 03:24:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fQdMG4mS5z3bt7;
	Wed, 04 Mar 2026 14:24:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1236::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772594682;
	cv=none; b=YR8gFceIk8+EobzKwHcBLPiIt2AfuW5axQcpRTlD+4xCSyVOt/ob5d5Jo1y2/Le/VlGil/mCsPEKfNq/W1aI9ORKKbR2tk0SHo/vb45tm1XZA+RMvFAFrJVNe/P2NK42NnNC/vGPRWbP37FHW75eEtHM4nCg0StzZz4j6Hof0XpeoRAhiq75CgSjKaXwo8tNxYDtjJP7vdrklUKeOYMMK+zLKvKKPvPls/exmIakeWQDhjo8MkYiLPassySIk0wdOGaOyPNblU3u4ar6qrt6L7kKJKc3APyOKM/1EITDbID2y93Z8b3eGlQEyFvgyOjKtgyB6ReyUOtf3g9OcTJlIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772594682; c=relaxed/relaxed;
	bh=uwaew1TASwLFpWF0VG/+hJg8qwclvjQWd4Xpfif75xM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cBk6O8uZpp+JQJJFGnRxJXp9Zl//MvwmDCnHQnFCin9ekPnaG2uM8jNlncRN0u/EaHgWGjusSbEcjGZGSwByAfGL5k5WZANbk5K9tIcuO5/tVvGER0h7RTfjik0giA/WZmWAthzco21OnyenhNpMrzU9WNKhI06P22yepMOqui7IykxSasWbMEsm/7UxmS2BIHUqho4ye8l4TuxvTBf6csb5bU881x/qsNE5aqYEYc0e2QFuoUnCaF48gxptkrM0wRhI2hQM+VE174VIBYB7VJTOXwGlM6lxlP7oRn5JVKqU+UAovfVKheRlaxn32SIX/5WIKIq92v/6LcHCPUF/6A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Y55ilsFI; dkim-atps=neutral; spf=none (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=casper.20170209 header.b=Y55ilsFI;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=none (no SPF record) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1236::1; helo=casper.infradead.org; envelope-from=willy@infradead.org; receiver=lists.ozlabs.org)
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQdMD2XBlz2yLH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Mar 2026 14:24:38 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=uwaew1TASwLFpWF0VG/+hJg8qwclvjQWd4Xpfif75xM=; b=Y55ilsFIY2uEBOFXIvrtEYMcxx
	V/JrCLDxgjkhM/9AmmOM6p2YDvZEp3at1c81Mie4L08hbvdW5XczTSkOpKUYldRXpbRkzcpST75rE
	JSYtWs4lPnRkwt7VLpWnZS8EYTQrG9i0BWDSDV+inn6J4BRublQVBcsZz3JeLdeZOhCHNoqKY6jbX
	slhEqOeUTLTlm9sVqBgehi2kNsWbfS4dhEWJs3o+XtyJnOKyJLFluQ6KxU+iVO6wjIpviTd1Jv27X
	wgrr6MdnWMKHkAWtXiFA2/xvfrUlXJBSn38A1vOyJKFa1OXMKd+jiad+JQnbO2GJUwecYvLglkRKO
	MBiTn2xw==;
Received: from willy by casper.infradead.org with local (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vxcqD-0000000Cdoe-3gHX;
	Wed, 04 Mar 2026 03:24:05 +0000
Date: Wed, 4 Mar 2026 03:24:05 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org,
	david@kernel.org, ziy@nvidia.com, matthew.brost@intel.com,
	joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com,
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com,
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
	npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
	baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz,
	jannh@google.com, rppt@kernel.org, mhocko@suse.com,
	pfalcato@suse.de, kees@kernel.org, maddy@linux.ibm.com,
	npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org,
	borntraeger@linux.ibm.com, frankja@linux.ibm.com,
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, svens@linux.ibm.com,
	gerald.schaefer@linux.ibm.com, linux-mm@kvack.org,
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH v3 2/3] mm: replace vma_start_write() with
 vma_start_write_killable()
Message-ID: <aael1XWaOJN134la@casper.infradead.org>
References: <20260226070609.3072570-1-surenb@google.com>
 <20260226070609.3072570-3-surenb@google.com>
 <74bffc7a-2b8c-40ae-ab02-cd0ced082e18@lucifer.local>
 <CAJuCfpHBfhKFeWAtQo4r-ofVtO=5MvG+OToEgc2DEY+cuZDSGw@mail.gmail.com>
 <aadeHiMqhHF0EQkt@casper.infradead.org>
 <CAJuCfpFB1ON8=rkqu3MkrbD2mVBeHLK4122nm9RH31fH3hT2Hw@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpFB1ON8=rkqu3MkrbD2mVBeHLK4122nm9RH31fH3hT2Hw@mail.gmail.com>

On Tue, Mar 03, 2026 at 04:02:50PM -0800, Suren Baghdasaryan wrote:
> On Tue, Mar 3, 2026 at 2:18 PM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Tue, Mar 03, 2026 at 02:11:31PM -0800, Suren Baghdasaryan wrote:
> > > On Mon, Mar 2, 2026 at 6:53 AM Lorenzo Stoakes
> > > <lorenzo.stoakes@oracle.com> wrote:
> > > > Overall I'm a little concerned about whether callers can handle -EINTR in all
> > > > cases, have you checked? Might we cause some weirdness in userspace if a syscall
> > > > suddenly returns -EINTR when before it didn't?
> > >
> > > I did check the kernel users and put the patchset through AI reviews.
> > > I haven't checked if any of the affected syscalls do not advertise
> > > -EINTR as a possible error. Adding that to my todo list for the next
> > > respin.
> >
> > This only allows interruption by *fatal* signals.  ie there's no way
> > that userspace will see -EINTR because it's dead before the syscall
> > returns to userspace.  That was the whole point of killable instead of
> > interruptible.
> 
> Ah, I see. So, IIUC, that means any syscall can potentially fail with
> -EINTR and this failure code doesn't need to be documented. Is that
> right?

We could literally return any error code -- it never makes it to
userspace.  I forget where it is, but if you follow the syscall
return to user path, a dying task never makes it to running a single
instruction.

