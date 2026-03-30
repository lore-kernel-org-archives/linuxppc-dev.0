Return-Path: <linuxppc-dev+bounces-19032-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A35A1061B20
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 21:09:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fl3lM1PRfz2xGF;
	Tue, 31 Mar 2026 08:09:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774880864;
	cv=none; b=b9UDHajH+50S+eFwTlBQeScgjlDuBawn+h/nKi63sTp76HvN8MKNbKPb4WUSt1DVpJfczbVQqs1xoWesrrMUAN9d8cTvPQO/vPemcCGi3L9jvRE8Xx7RaTAS14Xjx0oc5bVYy6K88yEiJ57WXlWJ0DGDUz91FsiBuGi9crilkfPQaW3x+fV8xc2bGjyru9zgwHKsNwCFvG1Gq7tdZnu3MVP2kvqU2PuidrqqlYwXrTetr+OiNSfvwsYWPh393OMq+/7a/71HBYOs5UCrgkArNnnR9PMJHEF2km0sEpY1b+DmHNg7KU1l0Fxc9IQdDPXYYKJ0BXg7ndFXTd7eQPUquw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774880864; c=relaxed/relaxed;
	bh=lJF0nkHYYwbB7bPJSppNUiXtvmyMoKWGfkNBVqXLiIA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MFrXS4+wjkGJiXRLk/ARuUkJeWjWKQqMRuj0jwBX9Fciv6m3OYrtOmhx7N56fiuRaqsQERSdGxXSGbU/P8OjZPqlfijcanCYqR2STsvyaLuuq6V28dBZ8/PqcPncjNyzOu8iUQRvoPVFScAMl9iA6BjfGR4KX+ysWv4cIhUnKgNpLWb+76oqYcC8CIxpJiB/BuIdfczITFDLESj5/9KgNRGiILwakdS76qokneANbSw4KsI78Cl1j6WBVMXwmRkG8SfzRWeEzDnHeTN0FZmAp6JYP5EbbVhHNGk7MUJ+4PuoIlfRF/uF1DVarOQTqQ+jPy7Zi9WI2OltH5KMGqLOTA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ORlFdPeC; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ORlFdPeC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fktrJ0Wrmz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 01:27:43 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 74BE643F88;
	Mon, 30 Mar 2026 14:27:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CAC0C19423;
	Mon, 30 Mar 2026 14:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774880861;
	bh=ZRa33ROhxro9w//Ij9lOfu6+s/cl7vsBNnwHFqQHtM0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ORlFdPeCuOm5yvoR+5/YIS+vR3RfBgLQ/I6FN3Wq0OF3dtf6ino1EHB1KapTFT2Nh
	 +Ee0GMKAovN5DfBJFbWzgeCtgA3IoCG39QT8Z1kQpZ2aV6Whba6Kbw0dkFGgOraXri
	 n8vlPO+JPgx0mz9FXOVEVRDSeG0y7NQfttJeCznVCyHOXrTyAhleRZGNKvkczOQhkS
	 cj6nCo85qm5or660USUhYV6+h+H5Hag5DjgRgorkUfKzD8Or69cB9ZYCtCeik99KLL
	 xsnKBa195qmzONTRnad9P+47USjRnCIS02AkjPbE9RJNEayZ52NThOoPKAjulmArvB
	 OGOVnrnRkcVxQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.phl.internal (Postfix) with ESMTP id 7B2FAF4006E;
	Mon, 30 Mar 2026 10:27:39 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Mon, 30 Mar 2026 10:27:39 -0400
X-ME-Sender: <xms:W4jKafyFvdk9lq332v_h2kI_OMoE0HyTT9jRHQKItPxXled9JHibHw>
    <xme:W4jKae7EvQI39ix7CkxB7sHWWP_iXTJqaXP29YwQe898JeFNPkezukAfa9THGFYPd
    ri2uZipdzvFPWK0UZaEGMRFvqMASVrCDALi2ArCbCXXfSpQXKrClg>
X-ME-Received: <xmr:W4jKaQu8femLmzHgyXPuUowScraoeIiL3B29B2wYdeT8pwCkOBro19Kaq4h9Iw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeelvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefmihhrhihl
    ucfuhhhuthhsvghmrghuuceokhgrsheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpeeigfdvtdekveejhfehtdduueeuieekjeekvdfggfdtkeegieevjedvgeetvdeh
    gfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkih
    hrihhllhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqudeiudduiedvieeh
    hedqvdekgeeggeejvdekqdhkrghspeepkhgvrhhnvghlrdhorhhgsehshhhuthgvmhhovh
    drnhgrmhgvpdhnsggprhgtphhtthhopeehkedpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepuhhsrghmrgdrrghrihhfsehlihhnuhigrdguvghvpdhrtghpthhtoheprghkph
    hmsehlihhnuhigqdhfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegurghvihgu
    sehkvghrnhgvlhdrohhrghdprhgtphhtthhopehljhhssehkvghrnhgvlhdrohhrghdprh
    gtphhtthhopeifihhllhihsehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqmhhmsehkvhgrtghkrdhorhhgpdhrtghpthhtohepfhhvughlsehgohhoghhlvg
    drtghomhdprhgtphhtthhopehhrghnnhgvshestghmphigtghhghdrohhrghdprhgtphht
    thhopehrihgvlhesshhurhhrihgvlhdrtghomh
X-ME-Proxy: <xmx:W4jKaUDgxdV38pqQgWKfY12ZfMdTvJWoxYvp9yoj5tp3RF53aOKuZw>
    <xmx:W4jKaYiQvfcW-HNrAn_B0ybqz3tHT342qpIx-AbDXFclmWrv05HLeA>
    <xmx:W4jKab2kU5unsMyH8uDFEgy9e1PD_HS-cAPDw7Kv-YyDXjsjtk2FEQ>
    <xmx:W4jKaVu4XJ7ufDGcRqnJoyJup9ZEVEmnrVJd-_-hG8uC7QT6KNilag>
    <xmx:W4jKaeDXpzhBEJ10Mc7NaHxSHY66iH_IjaP4Rk2XV8ZLTe34eSpEa7l2>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 10:27:36 -0400 (EDT)
Date: Mon, 30 Mar 2026 14:27:31 +0000
From: Kiryl Shutsemau <kas@kernel.org>
To: Usama Arif <usama.arif@linux.dev>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@kernel.org, 
	Lorenzo Stoakes <ljs@kernel.org>, willy@infradead.org, linux-mm@kvack.org, fvdl@google.com, 
	hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev, baohua@kernel.org, 
	dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com, 
	Liam.Howlett@oracle.com, ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>, 
	lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com, 
	maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, 
	hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org
Subject: Re: [v3 07/24] mm: thp: retry on split failure in change_pmd_range()
Message-ID: <acqH5SNpSoWAkg7A@thinkstation>
References: <20260327021403.214713-1-usama.arif@linux.dev>
 <20260327021403.214713-8-usama.arif@linux.dev>
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
In-Reply-To: <20260327021403.214713-8-usama.arif@linux.dev>

On Thu, Mar 26, 2026 at 07:08:49PM -0700, Usama Arif wrote:
> change_pmd_range() splits a huge PMD when mprotect() targets a sub-PMD
> range or when VMA flags require per-PTE protection bits that can't be
> represented at PMD granularity.
> 
> If pte_alloc_one() fails inside __split_huge_pmd(), the huge PMD remains
> intact. Without this change, change_pte_range() would return -EAGAIN
> because pte_offset_map_lock() returns NULL for a huge PMD, sending the
> code back to the 'again' label to retry the split—without ever calling
> cond_resched().
> 
> Now that __split_huge_pmd() returns an error code, handle it explicitly:
> yield the CPU with cond_resched() and retry via goto again, giving other
> tasks a chance to free memory.
> 
> Trying to return an error all the way to change_protection_range would
> not work as it would leave a memory range with new protections, and
> others unchanged, with no easy way to roll back the already modified
> entries (and previous splits). __split_huge_pmd only requires an
> order-0 allocation and is extremely unlikely to fail.

I think this is wrong approach. We need to split page tables upfront
before going into depth of change_protection() and doing irreversible
changes.

Conceptually, it should be similar to vma_adjust_trans_huge() in vma
split/merge paths.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

