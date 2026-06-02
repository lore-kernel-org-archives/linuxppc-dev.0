Return-Path: <linuxppc-dev+bounces-21912-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26D36CD6E57
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Jun 2026 15:42:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gVFSV6mqGz2xKh;
	Wed, 03 Jun 2026 01:42:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780414922;
	cv=none; b=MERdJUsF+2iULE3sPevnTCLgkOz/sSr4OYafDSgRPCdCMaCxXleE4kb/rYpVhdeNVoG2s71YyxlUJK0ktlaGA82xXDjJH/LLM1COu+vhAdXQ8Ilqsc96774K5xe++VoiuJRY8FhX0lvo1gFy6QB4Wez6bRWIig94mORSDHD9+HJ2b5EKktK0cJFVKAniqcRBW6Z1YOMlZsPcPzN14is8uVZiYtE3R4Tkb8nLJZfSdeGEWQOsxb51rYWlFjgcC8pgyz/okerO4hW3rQ4zHdMnFzqXSVg9LtyWtGdM4/mj3c6nvoCRomNRdSpJKJLlplfF8rJiTr0gL1XeS0vaLrFLNA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780414922; c=relaxed/relaxed;
	bh=Vjyqcof3ur0VsBuQ27nsiijAuIUGnyHJR2TBn7uQ1bA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=EaAYX0/kIKTPelYmAcNDZ6vRYuKv7N30Gui7jCSfpJNNT89fawJjVYeGrUTxrLdLw/ROdfV5s0OxVE+USix3dwaa8PPDp9B9udVsnaO4tzAahLgQB/f6/t3YX+tuAerKRpwhLNGgJroPwixhM8wuXuXuKW9UWTHIrTLY0p00jbq4rFeI4W5+8oI8JfX60mj2rUw2BgkfYFYmrLY4uMF8/CrRk5KDD7cXCdQhj6gqOYDVepTyHtkPmU5aXBJT5bY2PDCzAZ0w2eMOoETD94eA8YH90bA0dHdSE07YVDn+uP5bqPjUt9YcYLTTFLuTykJvQgzpWKEiP0v18nbwpUM86A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U5nLAucj; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U5nLAucj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=rppt@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gVFSV2F9zz2xLm
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2026 01:42:02 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 269CD601EE;
	Tue,  2 Jun 2026 15:42:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A3E1F00898;
	Tue,  2 Jun 2026 15:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780414919;
	bh=Vjyqcof3ur0VsBuQ27nsiijAuIUGnyHJR2TBn7uQ1bA=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=U5nLAucjBQDIwq7yJtoAo3oZmrJdkEqlXpFMLCL0wCgSNs56Q1QG8UQ2nIM4l71kh
	 Fea2t+TqzlJ90MjzHpqV9BMz8BgdQna2uruvigNJp70yVRAfr6LJbthE5RxUeVcD0/
	 LOES8GA3Aj6LYog7tXS+tu1fMxb4SznjqNZjkQAxS4BhwdEZbpgGFeepkOv6SxLxXK
	 GW2Qp26bTTYyKVDktap1k545sMZyoRjtoeLq0jZOcf4Bl8Ju5HWmwLOl6zemPklVON
	 OoIaFKEJHR6a9dx/8booAcrG4au9Cjgih+fkkVA/wBJvrA58JX72Jj0RffeydvtvSV
	 tfnhUtwxe2qjQ==
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 18/19] mm/hugetlb: Remove unused bootmem cma field
From: Mike Rapoport <rppt@kernel.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Madhavan Srinivasan <maddy@linux.ibm.com>, 
 Michael Ellerman <mpe@ellerman.id.au>, Muchun Song <muchun.song@linux.dev>, 
 Mike Rapoport <rppt@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Nicholas Piggin <npiggin@gmail.com>, 
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, 
 linuxppc-dev@lists.ozlabs.org, Mike Kravetz <mike.kravetz@oracle.com>
In-Reply-To: <20260602101039.1867613-19-songmuchun@bytedance.com>
References: <20260602101039.1867613-1-songmuchun@bytedance.com>
 <20260602101039.1867613-19-songmuchun@bytedance.com>
Date: Tue, 02 Jun 2026 18:41:34 +0300
Message-Id: <178041489401.457517.7510742037477989122.b4-review@b4>
X-Mailer: b4 0.15.2

On Tue, 02 Jun 2026 18:10:38 +0800, Muchun Song <songmuchun@bytedance.com> wrote:
> struct huge_bootmem_page no longer needs to keep the CMA pointer. The
> bootmem path only needs to remember whether a huge page came from CMA,
> which is already encoded in the flags field.
> 
> Set HUGE_BOOTMEM_CMA when the page is allocated and drop the unused cma
> field together with the redundant assignments.

It looks like the commit does more refactoring, please mention it in the
changelog.

-- 
Sincerely yours,
Mike.


