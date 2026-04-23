Return-Path: <linuxppc-dev+bounces-20013-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F877F589B0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Apr 2026 12:48:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g1bVq62ykz2yGX;
	Thu, 23 Apr 2026 22:48:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=91.218.175.181
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776948515;
	cv=none; b=cl6erQ0Wq42S8olVbyyN8JeSUel7NBYwHjd2qlpEa/wJZCNUVySA9yUFfRODDSwFbmjZC/IrO4i4zfcFiKL/fC/vkNnIYypycp6VE2PZ2sA/IXfKiGiWWrVoVftSA5NIxw7uk2YNX4dpZy3WTJGf8StHMs/MV180TuY3Ujj6vQMsDeph2RVet4zgtjmVssN6VbwefTOarlD5ScT7Lln7C5UIz9j+pyw9Gylzl+afIb+J8pXQa1HyncRUxn3LWQzRXntXt/8X6zsdCDahhqQMA3V6USYACMXh6cOAJxQ70T3lbLyvdyJwVZXkmFVEubSRJyLtpfcif3G9ny/TkZW06g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776948515; c=relaxed/relaxed;
	bh=mzyqTkwD3Tq3eWJj43nY/4NCn6uElngPKF2N7BctSd4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=HRXimq2QOX0gV5Vv6yU3LXJ6/uEKKSsgMct+wgBCMpbOAxccP81KAEciRyYmgsyx15BMGro1++J5m/ytprhFhlLx8lC8ONVY6myw1Pky+CioosKnfDCa8gonWbBbJHiunIq8/xQ9Uf8GXQIEI1YqlL4Om+FfiSQs3j7hzdvoDAqHiOTr0qDulJocMOJy5jGPNtgag3ir9GcfcTjwPfAtDW45hdYbrKuq4zxkM45MuMhvYDnCElEVOOD76iVpxIC4S04M77tV9DHm4Vd4sICNcdIiD3PLVgZFayMvklRDIv1YykLpUZXEbt7iMLeefKGSZXkqakO0+xyBcF96aP5Reg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eCIMj6Zf; dkim-atps=neutral; spf=pass (client-ip=91.218.175.181; helo=out-181.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eCIMj6Zf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=91.218.175.181; helo=out-181.mta0.migadu.com; envelope-from=muchun.song@linux.dev; receiver=lists.ozlabs.org)
Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g1bVj0K5fz2y8d
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 22:48:27 +1000 (AEST)
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1776948488;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mzyqTkwD3Tq3eWJj43nY/4NCn6uElngPKF2N7BctSd4=;
	b=eCIMj6ZffdfaEQ/eCdUmx55xZEnSNjMOWnXKRPikt4j4906Q1SttxKiVjKU8rlNbvJpCby
	erUQIBtSxfqPziAXNQuEfEecz4uegx50F+rqJgqHbsujB4xw/yqILQ/i2jg0Vq6Ad0Vpcj
	qd6Rxnai0Y+qvbwrtDxUe9CV+iyEcm4=
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
Subject: Re: [PATCH v5 v5 4/6] mm/sparse-vmemmap: Fix DAX vmemmap accounting
 with optimization
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260423053237.a44b68034673bb35a1e042cd@linux-foundation.org>
Date: Thu, 23 Apr 2026 20:43:02 +0800
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
Message-Id: <D642D89B-CC3C-46A0-B1D6-3DC2C4DDB874@linux.dev>
References: <20260423071911.1962859-1-songmuchun@bytedance.com>
 <20260423071911.1962859-5-songmuchun@bytedance.com>
 <1cbae635-a115-4270-bae2-64145d16f936@kernel.org>
 <1ADE7CE5-F02D-42B2-B7AC-FE0D6E86042D@linux.dev>
 <20260423053237.a44b68034673bb35a1e042cd@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT



> On Apr 23, 2026, at 20:32, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Thu, 23 Apr 2026 20:04:21 +0800 Muchun Song <muchun.song@linux.dev> =
wrote:
>=20
>> Ah, looks like I need to update the patch to fix this.
>=20
> OK.  Please have a think about which patches we should backport into
> -stable.  Possibly all 6!  And the timing of this backport.

In theory, I think all of these require backporting, and each carries a =
certain
level of potential impact.

>=20
> Ideally, split the series up into one series for 7.1-rcX+stable, =
another
> series for 7.2.rc1.

Given that these issues have existed for a long time and the trigger
frequency is very low, I suggest we take a more conservative timing.

We can prioritize getting the series into 7.2-rc1 first. Once they have
'baked' in the mainline for a while without issues, we can then proceed
with the backport to -stable (7.1.x). This avoids rushing risky changes
into stable branches.

Thanks,
Muchun




