Return-Path: <linuxppc-dev+bounces-20132-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 232B8FF885D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 19:54:29 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3cpr13WNz2yfs;
	Mon, 27 Apr 2026 05:54:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777233268;
	cv=none; b=D9ISzMgtYLgnKirlX2sOjCHSBpqNlqbC+r4S8wiAs69sjSP2iR6mU4achH1mv5THGcPrf+ZW9EKCPtHkBNfjWqgxXNnm7EJp+2flD1xTC+z/GrBkixk4RywG6+tJ4SIYZwlX/lxyc0SOqMh6cqSrWLWwcxFHF3ys7i0tyMY8uXx79c17Z/5zdABGSHXO1fhfJ343sn+ouSqFFGguwJJ9lgPYLB7UrMzWPlBU3o9J6s4bTcVFJsk8nVqmHSR/1LspTzOlnyr5PcZ+DH++F6CLQ+MFMYhhRw4uzJXIK2V5Oj4hRaOye/LODrdDBsS7NMYpBDaSc2tawMda8AlEkdgYtg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777233268; c=relaxed/relaxed;
	bh=LNtWwGmEhkrT7WalqGhI+SvhUXQY3XRF/vj/IJ9Aq+E=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=lzC5ou0X91mk47AdE5plrKJ9sqesMRAuu2gOS3KE/h2g0z4CXM8EltCYP7I6v5/vLpjZMc6KDnqDkPem1yM1mZTEqgND89vQsbkZNI9ydS9BCFfyNNPFMX0j5GfB004FTmHwQwHWTF7DfpM25LJqgi4hv0Q6wOiORxxdVCoJVlTJplrU+fOnbhqkcO1bYxE6tjkt+zbaI2d5SYB9gdkyt6l31nDKm3i08fWvhndZoxKG3kwmKLktIAxYHKBipIOfOYimbwYwq3flcwf4rF/qUrqhfazM81gah3ptNKFrmAqH83+A4+AVbcADtTVUBRRenjPlBWtOa82MIvfJpo4eBw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Rp2Y7Zmj; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org) smtp.mailfrom=linux-foundation.org
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux-foundation.org header.i=@linux-foundation.org header.a=rsa-sha256 header.s=korg header.b=Rp2Y7Zmj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux-foundation.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=akpm@linux-foundation.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3cpq0x84z2ySV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Apr 2026 05:54:26 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AE8D943871;
	Sun, 26 Apr 2026 19:54:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D88F3C2BCAF;
	Sun, 26 Apr 2026 19:54:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1777233263;
	bh=2+t0bSo3wG70KgHsJncoi/FDJXRJNptMIoE1v74zA8I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Rp2Y7Zmj2dHc9UArOcwYWowJQ8wL5qBe9PYyZ86R9/kgcmunhNCvade1vNsLW3bCu
	 XfsUt3s9vHrnzI7Fqd3+hJ86TN8R77toJ4BhTMvg04xEPmUgkp+uKz+OekimhPaosx
	 UbzjpaxgPGGBHX55IHAq8lBaLfLtEclZwJAs7exQ=
Date: Sun, 26 Apr 2026 12:54:22 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Muchun Song <songmuchun@bytedance.com>
Cc: David Hildenbrand <david@kernel.org>, Muchun Song
 <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, Michael
 Ellerman <mpe@ellerman.id.au>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R . Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@kernel.org>, Mike
 Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, Michal
 Hocko <mhocko@suse.com>, Nicholas Piggin <npiggin@gmail.com>, Christophe
 Leroy <chleroy@kernel.org>, aneesh.kumar@linux.ibm.com,
 joao.m.martins@oracle.com, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/6] mm: Fix vmemmap optimization accounting and
 initialization
Message-Id: <20260426125422.f9fa79ec47db2e552d75e29b@linux-foundation.org>
In-Reply-To: <20260426092640.375967-1-songmuchun@bytedance.com>
References: <20260426092640.375967-1-songmuchun@bytedance.com>
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

On Sun, 26 Apr 2026 17:26:34 +0800 Muchun Song <songmuchun@bytedance.com> wrote:

> The series fixes several bugs in vmemmap optimization, mainly around
> incorrect page accounting and memmap initialization in DAX and memory
> hotplug paths. It also fixes pageblock migratetype initialization and
> struct page initialization for ZONE_DEVICE compound pages.

Thanks.  I'm assuming that none of this is urgent, so there's no need
to fast-track any of these fixes into 7.1-rcX?

So the cc:stable patches will be offered to -stable maintainers after
7.2-rc1 is released?

Sashiko might have found another bug in there btw
	https://sashiko.dev/#/patchset/20260426092640.375967-1-songmuchun@bytedance.com

