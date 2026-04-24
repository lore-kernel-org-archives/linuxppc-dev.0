Return-Path: <linuxppc-dev+bounces-20079-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C4D0FE5215
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 11:59:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g2BND6n60z2yYs;
	Fri, 24 Apr 2026 21:59:56 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.185
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777031996;
	cv=none; b=XInv8QGtwHVhkpqNo7zP2jh9R72ewK7CI7SJBm2UXxV8PqLLVEbjOc3M4STvQuAFTJQQ9t7eIlLxZIj+fBJxkNqKBAVffE1DP33jsBSHmE1TG2lc9ClTOtX2NhMLvHFnK6n3DIUbuQLvVAnznS/JjWYTIzZ/oClOX1o3SKoxX9C6aurV3+sQqd8T1mg1kP3UCNCoG3y7JhR2VKCPbdhuwOsTd38pD27q6jukuPooYy8O9tjlCED0dUAL3bwE5L6YDIggmTQlw9rGxuqPB62uIT/lb+t3ZVpt8awdviCgUoxf/lkBV1C5u7LMA1RqlQONo3myiWeC3+jS2ri51xTkmg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777031996; c=relaxed/relaxed;
	bh=IHQYPzAV990Uhew6eBIq9GNsVsyr4/52nVfMb6QSTqQ=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=I4H+1unaXBe7DS8+8hHjW6XUfPBSFMElVTNiRYgH9L5tN3ZQXeHXKhfYHYjYCJkrncWs2b4PCw0I2NZ58gk+TTBgy51SPggijYWRKnGbVOrPqfyJ7qz5OIMgmff74GOAjJDudiM7Y+elWY6OWXzV//LlZymK5cM5Eozw37gWZ4jjT4+ndmBsVdf/M3lF7e1npqBwpCIbYigq7R3rjRV4jnIZ47R1Wr+exXGOhpjXwQtQuZ8vvsLqLjT0+aaPM83ta4rdt6O7Spp87qVrBMZGYsGxBmjmoNw0xxYQqAnFY8qK47cCT720GlaAi3+nY/kGsXwdDVeoo8MvDTfW6vmOuA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Pp+Vu8IM; dkim-atps=neutral; spf=pass (client-ip=91.218.175.185; helo=out-185.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Pp+Vu8IM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.185; helo=out-185.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g2BN91VhMz2yTQ
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 21:59:51 +1000 (AEST)
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777031967;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IHQYPzAV990Uhew6eBIq9GNsVsyr4/52nVfMb6QSTqQ=;
	b=Pp+Vu8IMlRT1HXTy/rykslM1Plape2KDpGMSDX3NKXZ68euahDQGlPY8zAIrMbOEcYapEb
	ZGM7yA3d+S/yRj2l5FezOlNTDHGJWWQLHweIq05WAmXtCWycRusfEBhThWETI5BGIIT0th
	3cJOz5zV5HFizSDxO8DsXIHMwEIoprI=
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
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v6 7/7] mm/memory_hotplug: Factor out altmap freeing
 checks
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260424032039.a43516455eb1ef7c7fd7867e@linux-foundation.org>
Date: Fri, 24 Apr 2026 19:58:32 +0800
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 Muchun Song <songmuchun@bytedance.com>,
 Oscar Salvador <osalvador@suse.de>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com,
 linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <8C537157-7EE6-4542-A922-6D34C3A88F47@linux.dev>
References: <20260424025547.3806072-1-songmuchun@bytedance.com>
 <20260424025547.3806072-8-songmuchun@bytedance.com>
 <6dd8e62b-97e3-4261-92c7-ba3a02ae6397@kernel.org>
 <20260424032039.a43516455eb1ef7c7fd7867e@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 24, 2026, at 18:20, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Fri, 24 Apr 2026 09:34:43 +0200 "David Hildenbrand (Arm)" =
<david@kernel.org> wrote:
>=20
>> On 4/24/26 04:55, Muchun Song wrote:
>>> Use a small helper to centralize altmap freeing after verifying that =
all
>>> vmemmap pages were released. This keeps the check consistent between =
the
>>> normal teardown path and the memory hotplug error paths.
>>>=20
>>> Suggested-by: David Hildenbrand (Arm) <david@kernel.org>
>>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>>> ---
>>=20
>> Thanks!
>>=20
>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>>=20
>> Andrew usually prefers sending non-fixes separately,
>=20
> Patches which are destined for the current -rc cycle (and possibly
> -stable) (aka "hotfixes") take a different route into mainline from
> regular next-merge-window material.  They go into different branches
> and they have different timing.
>=20
> If a patchset has a mixture of hotfixes (upstream next week) and
> regular patches (upstream mid June) then I have to pull the series
> apart, stage some things into one branch and other things in another
> branch, rework the cover letter etc etc.  Problems with this are:
>=20
> - what goes upstream doesn't map well onto what was presented on the
>  mailing list.
>=20
> - the hotfixes (upstream next week) may have dependencies on the
>  regular patches (upstream mid June).  This is backwards.
>=20
> Much depends on the urgency of the hotfixes.
>=20
> In this case, iirc, the determination is "not very urgent at all".  So
> the series is OK as-is - it's all "upstream mid June".
>=20
> This is still a bit suboptimal because when the -stable maintainers =
get
> onto backporting the cc:stable patches (after mid June), they may
> encounter merge/build/runtime issues due to the absence of the
> non-hotfix patches from this series.
>=20
> So generally, it is best for authors to have a think about these
> timing/priority issues and to present the patches in a suitable =
fashion
> - hotfixes/-stable patches in one series then non-hotfixes in a =
second,
> later series.  This way their presentation matches what goes upstream
> and we reduce the possibility of problems when the -stable maintainers
> get onto backporting.

Thanks for the clarification! Since I'm heading into the next revision
anyway, I=E2=80=99ll go ahead and split the series.

I'll drop the non-fix patches for now and focus this series on the
bugfixes to ensure a smooth merge. The regular patches will follow
in a separate submission later.

Thanks,
Muchun.



