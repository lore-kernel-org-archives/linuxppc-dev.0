Return-Path: <linuxppc-dev+bounces-28478-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF60DCA5FA1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 08:44:53 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvBZD1nChz2yvy;
	Tue, 29 Sep 2026 18:44:52 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.245
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790671492;
	cv=none; b=Z0/CpYm4NfVMu4lLBKZMQ9bqzIJhKuhBJFgncEjttjJqBiggcjGi8xUiWu5UeikNJTNnZf0VHVq9LbHNbLXaJ18z/KQ84umP1TD/D528sKwlHBZa+TIfQGBCt2ZtkDH15Q/FCdmbIMVjqfUHrSm6Dza0DIlF6xCNkFPhxO9BjCFCgLkACnQ3MVKAeDkZk72XbWin2ZG2idLG8q48OHQiyB5Stato/PPUG1/PrFoPhbZyFk7sS7LK0HkX4djDnZGrQ7Dn1Ado4Le7vbEAs2Cap0MPuGSrGdXEnJ4rOVRRE5QgABjsc4r2cwgeBTldm+jeQvfIIBjT64Oco6JLwHXmFg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790671492; c=relaxed/relaxed;
	bh=AIq4JLQVY9rAZekwghkIHYtXVxO8+vtHFHY+tB0MmZo=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=gmLlRH5aO2GjoYfNrVwnRbLqcjPow71cTRrKwV6KuM8V8nkyHwwHR37RmA3nenfEIyjV6Ea8vcnYuj9X5ZebyxsRDoIq6VF96gancwvCkDMFgR6zJ8APnsRs5a0d8oNuZwa4ffjL0oNzyrf1pfWK1nV8qd28oKcXMOqLjS5qqGYoQEVUZJgvnbjxixrvDkhwZc9Pl0pjlDGUGWTKAVV+4fTNxKcXO4pkxSZ4ZBIxVlwclafDsaFavKoYRiPZ7D1QzLVPfsmVjeTvs6nCPzMcOoE6/TzkWL9ZVsLn0XQEMRYyN8rDEGgM/lRfuR/1E/Oem9RSVP6N1moVRHKlCT/YCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jpnb5YLZ; dkim-atps=neutral; spf=pass (client-ip=95.215.58.245; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=jpnb5YLZ;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.245; helo=mta1.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-245.mta1.migadu.com [95.215.58.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvBZC0k73z2yft
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2026 18:44:50 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=AIq4JLQVY9rAZekwghkIHYtXVxO8+vtHFHY+tB0MmZo=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790671472; v=1; x=1791276272;
 b=jpnb5YLZUTaeVIpKJR7hFlBx38u0kCwIUa2zf+tJ1Dvz8tJ3xRjgQtT15IsL+rjui3tHu51F
 6HqOzO7QTzwJ5Xty+ayz6HuwtrV3GJoyWBUDto5YU4aEXMoZ+lw2rvPPsljKPpEYvvFUNXz2ASX
 OGunm0fuQci6D5dMs7tTsy8k=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by mta10.migadu.com with ESMTPS id 199085bad9bec430;
	Tue, 29 Sep 2026 08:44:32 +0000
X-Mizu-Trace-ID: 199085bad9bec430
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: Re: [PATCH v5 08/12] mm/sparse-vmemmap: move vmemmap optimization
 helpers to a public header
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <a31cc06a-c22f-41c2-851e-4827869e9df1@kernel.org>
Date: Tue, 29 Sep 2026 16:44:12 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jonathan Corbet <corbet@lwn.net>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-doc@vger.kernel.org,
 Lorenzo Stoakes <ljs@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Qi Zheng <qi.zheng@linux.dev>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Lance Yang <lance.yang@linux.dev>
Content-Transfer-Encoding: quoted-printable
Message-Id: <0481F7BE-F912-4E83-80F1-6E7990B447C1@linux.dev>
References: <20260927025441.741633-1-songmuchun@bytedance.com>
 <20260927025441.741633-9-songmuchun@bytedance.com>
 <a31cc06a-c22f-41c2-851e-4827869e9df1@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.11)



> On Sep 29, 2026, at 15:39, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> On 9/27/26 04:54, Muchun Song wrote:
>> The vmemmap optimization helpers currently live in mm/sparse.h,
>> which is an internal MM header. That works for MM code, but
>> prevents powerpc from using the same interfaces without including a
>> private header.
>>=20
>> Move the declarations and inline helpers to vmemmap-optimization.h.
>> This is a preparatory change for powerpc, which has its own vmemmap
>> optimization implementation and needs to use the common vmemmap
>> optimization interfaces from architecture code.
>=20
> Which raises the question why powerpc was special and will remain =
special. Wha's
> the big problem here that powerpc must do special things?

Good question. I also don't think PowerPC needs special handling,
but when HVO logic was introduced for PowerPC, it handled HVO on
its own. =46rom my preliminary analysis, the reason it didn't reuse
the generic logic initially may be related to the fact that
PowerPC's section size is 16M. With a 64k base page, a single page
can cover the vmemmap range of multiple sections, and the current
generic logic doesn't cover this case.

However, completely removing PowerPC's special handling is already
in my follow-up plan. We need to wait for the current series to enter
the mainline, and then we can proceed gradually.

>=20
> Change itself looks good.
>=20
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks for your review.

Muchun,
Thanks

>=20
> --=20
> Cheers,
>=20
> David


