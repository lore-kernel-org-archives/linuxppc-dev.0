Return-Path: <linuxppc-dev+bounces-18835-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6279F10AB800
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 18:38:43 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhXbk0KBnz2xGF;
	Fri, 27 Mar 2026 05:38:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774550321;
	cv=none; b=mam+whHavx3GmZsfzsDTTpnRrBpWuthajF/Xy7zG0zl2LWvnoB/ZEVEnelcOJljeyNPidApfV/Quu3W9KH99d8yL4ujzzKq++DbfGujDExAc1uHLH7KPiRdgHeCKpvHYwvbiByXakLV7TXw3aam4GsJuMCKUxhcNK5l9Ri9BiHVMmUK8r1GJ9CJCpeVydUlWBGRDR5uMn000X+aHC6V6VaggYO2ODXVmGLPNc2kH4GCM2dIo5By58QsmXFVXIVHlJQS1orRAr4QneKwr60rvNaL7r4cTyENWkj/iVLGTdGNojA3eZyEvPYZBh0jn8yeXU22/XnENCslqLzPYDRcgPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774550321; c=relaxed/relaxed;
	bh=a6gGB7CxcWdnQ+DPWeEBla1sMv2dX576ElrBQ3ycAD0=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CNU6MTa/3ufEySsHfMp0SuVYu5wqViQF9euR5UjLWW2JZEemar2AFpkT56fQh3XCEflY3XtziqsV5iZ8Cb35qbB3cEP/qL+Yjq/R16BHgRp7DDcRzdRjQsSheJtvQZJ8Hy550XXz763dN/WD12tUWLliar47L72qvy2ThJmmuXllZCqL6tkJK1795RJdzG5Hxp8imvq6YD4u34Q+/qL1MWR0LomYK3vZkNdp0ckQ1hyieZNn5+kbPOOhb3XPOR3qTGkJDqFidZB7KwKLzlniqWSxa61worjlhWKPYIvEYtYzMkfdWwEbuE7VYXHsau3DHg9R1TuIwnbWVQ0I0hN0uQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=taNmqBfM; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=taNmqBfM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhXbh6MZvz2xC3
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 05:38:40 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 63DAB600AC;
	Thu, 26 Mar 2026 18:38:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A040BC116C6;
	Thu, 26 Mar 2026 18:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1774550318;
	bh=ndiHyXCoO5k7Iqu/6caxL41+ed9KFd/MkCx3xUWmsEc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=taNmqBfM3BLswhWl/RJJAoUFuCiAqubMPHWGGMR3UdxU5KJrs8LMM7qcXQRrWVVpw
	 gJFt3VEicxOzMPC1XI2z5MNJGEAaclq1nCkD/zc1lZ5QXVXtp5hg6xhnKLTJn3wcS9
	 elOgQXcAU4TsAUSpKtEoqf8YzI3FpzELGjqsW4ls=
Date: Thu, 26 Mar 2026 11:38:37 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Sayali Patil <sayalip@linux.ibm.com>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, Shuah Khan
 <shuah@kernel.org>, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Ritesh Harjani <ritesh.list@gmail.com>, Zi
 Yan <ziy@nvidia.com>, Michal Hocko <mhocko@kernel.org>, Oscar Salvador
 <osalvador@suse.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Dev Jain
 <dev.jain@arm.com>, Liam.Howlett@oracle.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 09/13] selftests/mm: skip uffd-wp-mremap if UFFD
 write-protect is unsupported
Message-Id: <20260326113837.b2a030330adb7dead8acfeff@linux-foundation.org>
In-Reply-To: <e6f03352-4f09-4238-a47a-6d4e84101a6c@linux.ibm.com>
References: <cover.1773305677.git.sayalip@linux.ibm.com>
	<ed23ff57a80881c9d087d22709862af40addf49b.1773305678.git.sayalip@linux.ibm.com>
	<457dddf1-04ec-4d1e-8640-b04997fac4f1@kernel.org>
	<0e9cea41-7c49-446a-b67b-256584960516@linux.ibm.com>
	<20260324165606.d75200ac0e5458a5ffb83d5d@linux-foundation.org>
	<e6f03352-4f09-4238-a47a-6d4e84101a6c@linux.ibm.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
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
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 26 Mar 2026 23:31:10 +0530 Sayali Patil <sayalip@linux.ibm.com> wrote:

> >   	pagesize = getpagesize();
> >   	nr_thpsizes = detect_thp_sizes(thpsizes, ARRAY_SIZE(thpsizes));
> > _
> >
> Hi Andrew,
> I have some updates to [PATCH v2 04/13] selftests/mm: fix cgroup task 
> placement and tolerance in hugetlb_reparenting_test.sh, as Venkat 
> reported failures with the current version.
> 
> Should I send a v3 of the full series, or just a fixup patch for 
> hugetlb_reparenting_test.sh?

A full resend is fine, thanks.  I'll prepare a diff showing all the
changes since v2 for you to double-check and for people who already
reviewed v2.

> Also, if you prefer a v3, should I include 
> above fix for 
> selftests-mm-skip-uffd-wp-mremap-if-uffd-write-protect-is-unsupported as 
> well?

Yes please, integrate all fixups.  

You may choose to track those fixups the way I do:

[avagin@google.com: fix lock leak in mfill_get_vma()]
  Link: https://lkml.kernel.org/r/20260316173829.1126728-1-avagin@google.com
[akpm@linux-foundation.org: update mfill_copy_folio_retry()]
  Link: https://lkml.kernel.org/r/20260316173829.1126728-1-avagin@google.com
Link: https://lkml.kernel.org/r/20260306171815.3160826-6-rppt@kernel.org
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
Signed-off-by: Andrei Vagin <avagin@google.com>
Cc: Andrea Arcangeli <aarcange@redhat.com>
Cc: Axel Rasmussen <axelrasmussen@google.com>
...

Other people also do this sometimes, usually not.

