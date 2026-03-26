Return-Path: <linuxppc-dev+bounces-18834-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6168710A1E63
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 18:34:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhXVX73YRz2yS4;
	Fri, 27 Mar 2026 05:34:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774550052;
	cv=none; b=SbgZnVttjit7nXOG4oGLg+e+RZgc1pZjk9SaECoS8isRu27sEhiAft8NIfTV47anFRRt+nmVmII+Bn+nouPOlalCzxDJ3mnb0b7yhCgp0H+Tkwj4cF/4yhqcdc5r4FUtaNZjKz1Av1H4mu7J1FvjF2YU8wwlVhTmy1QdMHFAH+ubKzTKN0jDPJkenKZSa92dDu89a9EaFeK4lHCys/K5CSDsnkhX3zPSjDYuedUXk0HcuW/pUwP8ymdr0KBhAE/ZbGXR2QXy8r83gp9uyyDk6NttsWBaDJiQMFnwOJNtwY3B+yw/eD58dxCioDns1/DX4Z6/5D1o9BTLOS2mQc681A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774550052; c=relaxed/relaxed;
	bh=iKxMcUILKrcA41tExDgHW7ilkZ2Ux1oLQWlph3sXKZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m6XJ78yDRfmPF74TNsyPvnj+NfDveLHUSxuaxB+9V0MR3LQ04blT3VsJ9LxxTgxghcJuChEGylt1iXSyvdbZLm8yepHmkakjFqrQs15OGVuP3z4rQ+2bxnX9WeHAWB1A+Obs+g3JRnTSIGsyOaLX5yMgLrhvCjD6IFmRtzupitfbSHiYjazTXOJuKEV88x0d7foOlRwFWonhas9QGjvt4aI5WDP131jgFQume8U2eRfLYw8RhBg/Kt54yTx48/MldNS+AKJgxIvNkFzqRjM9/QS/B1WdIx5Vh0EazgdcBpluI/8nTL77ZtRxFWq8w5N+SX0gbeaVx2PkFydVbW0x7A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vMFyyHhw; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vMFyyHhw;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhXVX1w0nz2xN8
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 05:34:12 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9699360054;
	Thu, 26 Mar 2026 18:34:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E9A8C116C6;
	Thu, 26 Mar 2026 18:33:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774550049;
	bh=iKxMcUILKrcA41tExDgHW7ilkZ2Ux1oLQWlph3sXKZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vMFyyHhwfuhV/t58V4SonKbUNr9vfN/ZVsId7D0+N+dAl+XkcTz7TfkAhjijHY5sa
	 3TcwVx8KTtIUsp2dHslBjevpXhVI/0F77MOmkq/MuhiJrIA+FrImOCXlcv3KYh+TLU
	 VIyzDHMqW2B/wNUMPzdOEtZ4R/n5QdljHnkh6X5NEsGL5dxSv82nk9/1pVzbOi3mz1
	 KvGa/MbDKepdeWVxHZBqBYBNdB4mPiP+eKWPOjoeTAKkaKUdhU2ksU9dZtH2HMQvKA
	 jP2S4wQfwaflYFLZl5k/jHlg1tFouZ0lgebV/uAEXh1Cd+6mumiydJyqo3hAugTpXC
	 4yKXShtnKHubA==
Date: Thu, 26 Mar 2026 18:33:57 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: akpm@linux-foundation.org, willy@infradead.org, david@kernel.org, 
	ziy@nvidia.com, matthew.brost@intel.com, joshua.hahnjy@gmail.com, 
	rakie.kim@sk.com, byungchul@sk.com, gourry@gourry.net, 
	ying.huang@linux.alibaba.com, apopple@nvidia.com, baolin.wang@linux.alibaba.com, 
	Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com, 
	baohua@kernel.org, lance.yang@linux.dev, vbabka@suse.cz, jannh@google.com, 
	rppt@kernel.org, mhocko@suse.com, pfalcato@suse.de, kees@kernel.org, 
	maddy@linux.ibm.com, npiggin@gmail.com, mpe@ellerman.id.au, chleroy@kernel.org, 
	borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, hca@linux.ibm.com, 
	gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com, 
	gerald.schaefer@linux.ibm.com, linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, 
	Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v5 0/6] Use killable vma write locking in most places
Message-ID: <98a33605-9419-4bc7-8b40-ea47fd598df4@lucifer.local>
References: <20260326080836.695207-1-surenb@google.com>
 <44216135-ce6e-4c06-acf9-af09e224ddd8@lucifer.local>
 <CAJuCfpG_xa5nxSRrvu4TnwhCrmocPkHpWEQbE_yeyN3L69Y6tQ@mail.gmail.com>
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
In-Reply-To: <CAJuCfpG_xa5nxSRrvu4TnwhCrmocPkHpWEQbE_yeyN3L69Y6tQ@mail.gmail.com>

+cc Roman

On Thu, Mar 26, 2026 at 11:24:35AM -0700, Suren Baghdasaryan wrote:
> On Thu, Mar 26, 2026 at 2:18 AM Lorenzo Stoakes (Oracle) <ljs@kernel.org> wrote:
> >
> > -cc old email
> >
> > (Gentle reminder to please send all new stuff to ljs@kernel.org - at some
> > point I'm going to set a rule to ignore kernel mail sent to the old address
> > so, if you need a response you should send to the new :)
>
> Ack, sorry about that and thanks for all the reviews, Lorenzo!
>
> I noticed Sashiko's concerns at [1] and a number of them are false
> positives but I see at least one new claim which might be legit. I'll
> check if it holds water.
>
> [1] https://sashiko.dev/#/patchset/20260326080836.695207-1-surenb%40google.com
>

Is worth letting Roman know which are valid and not, as that's useful
information for refining the prompts etc.

Cheers! Lorenzo

