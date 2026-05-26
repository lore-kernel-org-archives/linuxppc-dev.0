Return-Path: <linuxppc-dev+bounces-21521-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CDE8CD5BB1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 May 2026 15:34:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gPxcm0Yn4z2xtC;
	Wed, 27 May 2026 01:34:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779809655;
	cv=none; b=fr6A+GiIkB4Qt+InCJetqjnzlCgQS34Fnaf8uRg82nJlp2tXPbvZOVLSal5wdzDK4ndzXkosSl+oJevTGRAvhc5BxDssIzI3dJH8vBhMMjzjA5crFl/GMul1e6FQ6qSIj3/goAVHkvNRD8KK2szK3P/RUxiHu1xmcKbXXHS8p3NRyblx0WXdNpBT25WtIUKCx3MumZUdRGm77OCudYvQGk2kLKj2j3et4EWC3MG1Okx5UR2tf6H7e7LGURo6mkkTw+8d+pETyKb+4YhRJ7XhiMoRfLLuU5byZQ2/LWPWqMwmRu64RSsxNMlsbTPIixoRvlu9sFvWfbgeSwWRhRdy3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779809655; c=relaxed/relaxed;
	bh=IXtklErhcuWlv2r8L97+xvorQ7UpGoL4ZF+VJDkPygU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C1LZW/1BRpSYmisjYupjV+Uep0V9Egch6jg6ivhxNqgHsftkbOxOnW1WOp0M2ZYYh/2tAuCITW1AK44clNyjO7mb28bKDI1X2Z6JnTjL8zr8A9+sfvE6qipKEEBs2xk+8e1oAz1cePeA4CuSw1Adv3nzz++4tQsntrCc5FNLq34/4StZycQv03vjVxn4CyYz2B5hD4wzgJ1ooJs3+hyLxRALrKirlVxlVWXW3mMb5uhnyLVgUHDJWzEK97Bd2qWTC8ICtruD++k1OX0LUfyCvGSnhmSJp26y8soglMULe/VsHoE+SFO+xxScFZJNoDBVFoQsIXfTfQrKzWsXYPVG/Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Noq6FzjX; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Noq6FzjX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ljs@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gPxck73Yhz2xsW
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 01:34:14 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 986D34362A;
	Tue, 26 May 2026 15:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5FAF1F00A3C;
	Tue, 26 May 2026 15:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779809651;
	bh=IXtklErhcuWlv2r8L97+xvorQ7UpGoL4ZF+VJDkPygU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Noq6FzjXAHednyJbKDsO7gWlmRYH4wZD0QhvuTN+ag2i1VdurKmvBGP3bOfMJCqvU
	 8kjwZvotf99uxGidiSuhzx7jYl16j0j9D5Yy+Ia0rEVFPucuDOg4YzNa4k3kD5Caql
	 cOvHKMZEdCkn6xBAgqAbnQEdTy1mWt1ZyuPL6nPS3yKF2BtW7gtEowzkU10F/6E0sj
	 qQ72PTZCTU8zRN6nz5ooPdaaDrJoW5P+Y3vgo8M1qA9dygwm5nF6SDZ5t2jHBQrPRo
	 Mw4mppN1KUMAVp0SjeJl63QoEfTyTcLoZY3AGxngefu9qBzd2UnGgPGypTmdUHd5W5
	 d3hKUeNpi6bxA==
Date: Tue, 26 May 2026 16:33:56 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Yin Tirui <yintirui@huawei.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	Matthew Wilcox <willy@infradead.org>, David Hildenbrand <david@kernel.org>, 
	Juergen Gross <jgross@suse.com>, Jonathan Cameron <jic23@kernel.org>, 
	Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Peter Xu <peterx@redhat.com>, Luiz Capitulino <luizcap@redhat.com>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, "H . Peter Anvin" <hpa@zytor.com>, 
	Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, 
	"Liam R . Howlett" <liam@infradead.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Anshuman Khandual <anshuman.khandual@arm.com>, 
	Rohan McLure <rmclure@linux.ibm.com>, Kevin Brodsky <kevin.brodsky@arm.com>, 
	Alistair Popple <apopple@nvidia.com>, Andrew Donnellan <andrew+kernel@donnellan.id.au>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Baoquan He <bhe@redhat.com>, Thomas Huth <thuth@redhat.com>, 
	Coiby Xu <coxu@redhat.com>, Dan Williams <djbw@kernel.org>, 
	Yu-cheng Yu <yu-cheng.yu@intel.com>, Lu Baolu <baolu.lu@linux.intel.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Rik van Riel <riel@surriel.com>, wangkefeng.wang@huawei.com, 
	chenjun102@huawei.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org, x86@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH mm-unstable RFC v4 0/7] mm: add huge pfnmap support for
 remap_pfn_range()
Message-ID: <ahW7rut_WP17KADW@lucifer>
References: <20260526145003.88445-1-yintirui@huawei.com>
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
In-Reply-To: <20260526145003.88445-1-yintirui@huawei.com>

Allow me to be mildly pedantic (sorry :)

One thing I'd like to highlight here is that remap_pfn_range() is, in the long
run, deprecated.

mmap_prepare callbacks will indicate a PFN remap mmap_action, which will do the
heavy lifting (see [0]).

So perhaps worth referring to 'PFN remapping' or something?

(Since we already have mmap_prepare() in use, it's also kinda inaccurate to
say remap_pfn_range() :)

[0]: https://www.kernel.org/doc/html/next/filesystems/mmap_prepare.html

Sorry, this is pretty nitpicky :)

Cheers, Lorenzo

