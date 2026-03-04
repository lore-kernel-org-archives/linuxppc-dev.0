Return-Path: <linuxppc-dev+bounces-17755-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F36EFCE42
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Mar 2026 20:00:06 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fR3Rm4S3Bz3cBN;
	Thu, 05 Mar 2026 07:00:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772643213;
	cv=none; b=IYYcAxjKp2FnkjLR+065KRxIZzDSWed5XA6XT2TmsvqX2HsedXi9SAHmYHdRKnA0mvQoLXXlgM9YQq9R+w/WW+7gc5LZolY5tTFtBq+xQjMtYTowuHGlV7/fPqkCK5wwpL/HGITX482/bC2hC54R1Gnma9kTuBYw8csj3ZDTxe0gTzkepEFAPfpCZ9bf//D/kYjmU5RJhldcU84UpV2d/1Ya8Yhv+iMZJpAEIiavLO42E0uTUs1wLEI8/W44RaeAlUIeCb/1Ja6l0ycEmyhizG1wo3eJT7nKjWTEoPfKvAwRZ8n/xMSBhHoaUSgTYVyFMQOSitM/VIM30g2jn9DhiA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772643213; c=relaxed/relaxed;
	bh=2sR/y/6RjXKZA2Xb/NJXLggqVzGt3wK9gVfzabs/UkM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xvq9ZLmBQscwRk/L3izwYHUjDBfnEGSCXwHg0/Q/X507YRZSN373aeBWuMDuin5HyqD00l2k01Dy75xiCkjPzeYWmPmQ6pKtdixmGzxsdSXlCEMNegkXlRAyeB9AjpND9VlXS42kPSF6JrTcgAOXNz/bzQhfR7YagxxHgY+/xZwiuSvHGKycYAGHqKoiS/loRvyolw0vcGebNQhBAyaTnEL6xGCkiiDrTuYd+iSB4esuOWzB8OWOhJ5tzzS32zmtgIUPNsLnt5Men5Ky0ETnq6eVNkP1yX4fseTP99k+Ximgvmyzwwb0veIIDoeO6WuGPZiQzp4KAFpajDAach/NWA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p8cv67e9; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=p8cv67e9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fQzJX6b0tz3bt9
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2026 03:53:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id A5EFE43D55;
	Wed,  4 Mar 2026 16:53:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E293FC4CEF7;
	Wed,  4 Mar 2026 16:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772643210;
	bh=sDB+az1bAXOGbWMmUUUu0SDGfeabr+ekuNO1hj8thSQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p8cv67e9ssUeWrFJGzAnKEG//LYmeqoUbvIrlKriZR7tjoP6HIKPNDX8pAccTwBH3
	 kXINSbiaDo1xDJrz/JeaCLaBaVqAnxS7nhEA2lvzOiuDnxxjG11JLenaxDm+s3Lxj2
	 gBLGMkVgja0Q4hASgoNQuIwIlGSxpW6FrxNNdPNh4/g6M+m2IOlHz4cIUNw50qQg28
	 S1E1hSZaFUqKAdRvL5ekKo6FKeATDlnWWE64vY5pnnLHk4JSh7QwNEnHPKQCu7T+j6
	 PIJ1RxF0irx8ZP6DGic6mucNZ5qkVhr+BkuZBSZI1pTlvap4lmikyHjbTLgwLSHuAZ
	 l9ami0VnilBOQ==
Date: Wed, 4 Mar 2026 16:53:27 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Matthew Wilcox <willy@infradead.org>
Cc: Suren Baghdasaryan <surenb@google.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, 
	matthew.brost@intel.com, joshua.hahnjy@gmail.com, rakie.kim@sk.com, byungchul@sk.com, 
	gourry@gourry.net, ying.huang@linux.alibaba.com, apopple@nvidia.com, 
	baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, 
	jannh@google.com, rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, 
	kees@kernel.org, maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	imbrenda@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	svens@linux.ibm.com, gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, 
	linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: Re: [PATCH v3 2/3] mm: replace vma_start_write() with
 vma_start_write_killable()
Message-ID: <76aff8f9-1c08-449a-a034-f3b93440d1a8@lucifer.local>
References: <20260226070609.3072570-1-surenb@google.com>
 <20260226070609.3072570-3-surenb@google.com>
 <74bffc7a-2b8c-40ae-ab02-cd0ced082e18@lucifer.local>
 <CAJuCfpHBfhKFeWAtQo4r-ofVtO=5MvG+OToEgc2DEY+cuZDSGw@mail.gmail.com>
 <aadeHiMqhHF0EQkt@casper.infradead.org>
 <CAJuCfpFB1ON8=rkqu3MkrbD2mVBeHLK4122nm9RH31fH3hT2Hw@mail.gmail.com>
 <aael1XWaOJN134la@casper.infradead.org>
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
In-Reply-To: <aael1XWaOJN134la@casper.infradead.org>

On Wed, Mar 04, 2026 at 03:24:05AM +0000, Matthew Wilcox wrote:
> On Tue, Mar 03, 2026 at 04:02:50PM -0800, Suren Baghdasaryan wrote:
> > On Tue, Mar 3, 2026 at 2:18 PM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Tue, Mar 03, 2026 at 02:11:31PM -0800, Suren Baghdasaryan wrote:
> > > > On Mon, Mar 2, 2026 at 6:53 AM Lorenzo Stoakes
> > > > <lorenzo.stoakes@oracle.com> wrote:
> > > > > Overall I'm a little concerned about whether callers can handle -EINTR in all
> > > > > cases, have you checked? Might we cause some weirdness in userspace if a syscall
> > > > > suddenly returns -EINTR when before it didn't?
> > > >
> > > > I did check the kernel users and put the patchset through AI reviews.
> > > > I haven't checked if any of the affected syscalls do not advertise
> > > > -EINTR as a possible error. Adding that to my todo list for the next
> > > > respin.
> > >
> > > This only allows interruption by *fatal* signals.  ie there's no way
> > > that userspace will see -EINTR because it's dead before the syscall
> > > returns to userspace.  That was the whole point of killable instead of
> > > interruptible.
> >
> > Ah, I see. So, IIUC, that means any syscall can potentially fail with
> > -EINTR and this failure code doesn't need to be documented. Is that
> > right?
>
> We could literally return any error code -- it never makes it to
> userspace.  I forget where it is, but if you follow the syscall
> return to user path, a dying task never makes it to running a single
> instruction.

Thanks for that Matthew, that makes life easier then.

We can probably replace some of the more horrid if (err == -EINTR) stuff with
fatal_signal_pending(current) to be clearer as a result.

Cheers, Lorenzo

