Return-Path: <linuxppc-dev+bounces-18919-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2C610BA45E
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Mar 2026 09:25:34 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhwH14Qq9z2ydq;
	Fri, 27 Mar 2026 20:25:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774603533;
	cv=none; b=Oh4OynOtAakQk3m7hqBXbfEAVX9Az6brTlM8u1kV4aGqnd1Nf8GrCv2aGRB58DEwmP2qvlTfFvwMq0MqBbUHwno50ulZrCIYUmUFWk1gWvq6SgW0ZrZ/JIEERaupk3ygZJfrv563N47SAa7tm1koowzlj8NtiS/hpI5Qxe9p/QaTzjHmU9ZZZjgAuQFtEN/xHkBWynAneDIbtl2ZCFpMD8u3rsUaGQ6TatXA3WJ4m22bzVo2q+DwlHfJn9OTKH63Ke3KI2Y55HjznQunVbLtw12CEk0fU9T+YKLTyeQiJghQuFUX659tQN7mPDyOfL2PLN1O+e8j8td3TGhKxU4iDw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774603533; c=relaxed/relaxed;
	bh=q1ism79nJfn/cEtGypwqofF2VKU2iXSfP9bNn9U8VUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/KgKl1Qew+2rcpe6+RSh+N8RzGwdqW/rmfUkOMqT748ipyeqk3vXX2mm65PKgS720K3F1JQ6dGKoECRKiKyJO70F7Ry6XhCOZ6uQBCngbCftFE5sPNQ5pOkw4uFXoIB7drr4nHkapAF5wPhG3ZP4ninDH36ds7f/o4p4v/RqLhJWpg33dbuZzD7xlQAJEdaF+eYumCtUWdn1MzhUCjD6H+YHqgl1Znal1UHF10I7CPie6jEabUOBBuV3XZcYtSS2oWMLnChJsQsUYpsTGR5CAV4t1vNN9XHVJjV6VnmjueQMEFuD/oNAIe4CcOLuEmrvPHEH5rapKkWgDFtp/QFUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WmaF744H; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=WmaF744H;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhwH05MVpz2yVt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 20:25:32 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 7B9F96133B;
	Fri, 27 Mar 2026 09:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A7BEC19423;
	Fri, 27 Mar 2026 09:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774603530;
	bh=q1ism79nJfn/cEtGypwqofF2VKU2iXSfP9bNn9U8VUM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WmaF744HVRFoUZuE9WelikX7CssORJvCcgjqvHAlHItCZonH1f5u3pjVqPu2pmNwp
	 0sOJELio9ATZHzGY1mVGObw+Tj+ohu4ZlzfgUHHShjnGHOR4dUZH1xacEXI3dnxcCp
	 EPLuQMpDGTQFJ6BT1KDFfyUJZB6B2Qsux4f40zQaPLLMtx14hJ4SV9M9QHDzNZ1Hmg
	 qS/wTO148ZrNsrmGjIVpE0dqOE0Hznelj+tzTWUKV8e/iMqwYv814Ef3aQMBHHZ8F+
	 WqEr18L/sAwg5B4z4KKGy9OErz7dmEjltoJtuBoYAp8fZcOBM+JhLzwbWduY4hEBwv
	 PVr5K0M6Wu7Wg==
Date: Fri, 27 Mar 2026 09:25:21 +0000
From: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Usama Arif <usama.arif@linux.dev>, 
	Andrew Morton <akpm@linux-foundation.org>, willy@infradead.org, linux-mm@kvack.org, fvdl@google.com, 
	hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, kas@kernel.org, 
	baohua@kernel.org, dev.jain@arm.com, baolin.wang@linux.alibaba.com, 
	npache@redhat.com, Liam.Howlett@oracle.com, ryan.roberts@arm.com, 
	Vlastimil Babka <vbabka@kernel.org>, lance.yang@linux.dev, linux-kernel@vger.kernel.org, 
	kernel-team@meta.com, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	linuxppc-dev@lists.ozlabs.org, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [v3 00/24] mm: thp: lazy PTE page table allocation at PMD split
 time
Message-ID: <cf36f821-8285-4b9f-b1fd-e080292f4204@lucifer.local>
References: <20260327021403.214713-1-usama.arif@linux.dev>
 <48d7c810-d219-4346-9e8b-d70243445a91@kernel.org>
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
In-Reply-To: <48d7c810-d219-4346-9e8b-d70243445a91@kernel.org>

On Fri, Mar 27, 2026 at 09:51:31AM +0100, David Hildenbrand (Arm) wrote:
> >
> > RFC v2 -> v3: https://lore.kernel.org/all/de0dc7ec-7a8d-4b1a-a419-1d97d2e4d510@linux.dev/
>
> Note that we usually go from RFC to v1.
>
> I'll put this series on my review backlog, but it will take some time
> until I get to it (it won't make the next release either way :) ).

Yeah, please update to v1 from RFC because I'm looking at this and wondering
where v1, v2 was and why I didn't see them...

Generally I'd also advise un-RFC'ing a biiiig series IDEALLY be done early in a
merge window :)

We've pretty much shut the door to new series this cycle, but being so late in
the window at -rc5 would mean no way for this one anyway.

But in general it's going to be a rebase pain this, and I'd rather not see it
land in mm-unstable at this point, because that's supposed to be 'what's in the
next release' and it's stuff like this that leads to 'I am not sure what
mm-unstable represents any more' being a thing.

I think in an ideal world we'd ONLY see this in mm-new.

I wonder if we need some process for un-RFC'ing really, where somebody kinda
asks rather than it being a vibes thing as it is now (or a 'people don't reply
to my RFC' which yes I'm guilty of :)

Anyway this is more general points and not about you Usama, because - hey - all
this stuff is pretty unclear generally.

>
> --
> Cheers,
>
> David

Cheers, Lorenzo

