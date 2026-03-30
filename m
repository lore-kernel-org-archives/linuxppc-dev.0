Return-Path: <linuxppc-dev+bounces-19031-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B201061B20
	for <linuxppc-dev@archiver.kernel.org>; Mon, 30 Mar 2026 21:08:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fl3l52jdGz2xN8;
	Tue, 31 Mar 2026 08:08:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774880019;
	cv=none; b=eQ0uu/u4r8JIvJGJvrUKbEQMyvwu6sVEcX9QQG7r1rruTEUi5jJ0PL62jn3QZFsMmCsTmaAsi612qDKcfOJKFSKrPqoJmL6VbQh9ldnhFqsN819Mi4f9zkzo3DBGTTFoIzzspjlC8C6V4JmTW2LU6NJR6+ESBXOfKQjT0+WD+dx/K8DJO6sczMqWt+YGgDF7PDS0lbx8xksNC3w01Rz/LiCjjKswkZIlZTupXmsj0Qxv7KVU6JP6njAbr+6YjDg9Zap1GyT36yCoy/o/aEOfQE077qqfcMQX0X2/2Yb7m3pivciqZ8lIhiIiUdJRA0hg7uBt8/pz2NiRclyoPuNOQw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774880019; c=relaxed/relaxed;
	bh=mo7Ykh1aeGd+6cOaYYAPKUIZQKgmSZS6b8ZnYB3h/BQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QfSBGAG/RfCO5/EqQP7+/J6moSE8I6ba0kBwbiYIObKChqtRnsWCWw0Y/JgQh/RJ19SYtqrytpq5LWz7iBetD3BkFD/XIA8GzS6E741b4aGVpryMIE7GBVJMSafaR+WAFDxntpDH5TsuSgO5YF0l8FqzT4mZS70wfDEx65SzTdrTWvRgjsshVIpmsiUXv2oh14/sBemJ7HS4pcSO8KsprKVnZnUSZZlKFBz4uXMuVsc+xcB6jrGO9S9fNTeF1UE9SJfG5mljL7tRYt1EmLmIat7SBxIqLtkYZIzl6cAn3ZYfPt+dRAGDr7D+XT9E6/PN7p4EJQKaaebCmXpgoH4+ng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MEAQK5d5; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=MEAQK5d5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=kas@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fktX21Qdqz2xT6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2026 01:13:37 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C7C7860121;
	Mon, 30 Mar 2026 14:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C062DC2BCB2;
	Mon, 30 Mar 2026 14:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774880014;
	bh=jjLo/KYlHlqzqnNv0WJEH/7qGaF/R61RDSt36mroxZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MEAQK5d5EB6gZI/XdoMH99WzaT0SQw895GgjMM2o44etPdaYMo8lRMr9kAZIY2NbA
	 SO1cMXJRYUD3+HH25DF5VFA3K6lJajLHMItJxSRCuxUdnN0xPtR+eW1GZOt32v3K5n
	 haVWFFlD7n5YHw0L6haPCVb1op2KzaUgV1N/sM4+inyRJ72UoikQsSQc6fn2Gftj3n
	 U+z/PfV7vd+S/IoeQr652CyiHomAgwZysEosPxXuPuja69XH7dAfBNDEiaNje84dit
	 9vKjC+d3cqFGeTzjNxwgoH11Wc1tuyuK6jno0RFy5X7VoBQ37f53sfWQY9bsbNhZN+
	 GMab29MMkExgA==
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfauth.phl.internal (Postfix) with ESMTP id C1A88F40068;
	Mon, 30 Mar 2026 10:13:32 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 30 Mar 2026 10:13:32 -0400
X-ME-Sender: <xms:DIXKaUNo8x6eNHbeeDZrPNKYYCYRt0OVrzAoJgh21Ck-T_Mfa_mBEQ>
    <xme:DIXKaRGBSKHVnr7Q9isa4JQgjjTUBwhCwPLDyGiwqzESPwEPO4X3jHpNkyc2z-90c
    oMToV8ClUtLNC0kkMd3LOW0y7P6Zh3PYQMBDylDpqJxbIoVHHS60bs>
X-ME-Received: <xmr:DIXKad-K24OQojUNBnEsHGs60TyyM8zE7h0c-5BRxWHRNh8Nq5ysCXjNmoLDAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdeffeeludelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepmfhirhihlhcu
    ufhhuhhtshgvmhgruhcuoehkrghssehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueeijeeiffekheeffffftdekleefleehhfefhfduheejhedvffeluedvudefgfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhirh
    hilhhlodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieduudeivdeiheeh
    qddvkeeggeegjedvkedqkhgrsheppehkvghrnhgvlhdrohhrghesshhhuhhtvghmohhvrd
    hnrghmvgdpnhgspghrtghpthhtohepheekpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehushgrmhgrrdgrrhhifheslhhinhhugidruggvvhdprhgtphhtthhopegrkhhpmh
    eslhhinhhugidqfhhouhhnuggrthhiohhnrdhorhhgpdhrtghpthhtohepuggrvhhiuges
    khgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhjsheskhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepfihilhhlhiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopehlihhn
    uhigqdhmmheskhhvrggtkhdrohhrghdprhgtphhtthhopehfvhgulhesghhoohhglhgvrd
    gtohhmpdhrtghpthhtohephhgrnhhnvghssegtmhhpgigthhhgrdhorhhgpdhrtghpthht
    oheprhhivghlsehsuhhrrhhivghlrdgtohhm
X-ME-Proxy: <xmx:DIXKaaiJLRt5GSlkdiUmhFjWhOZ4nb9mM6WyYioqjMYyVB3fjl7zZQ>
    <xmx:DIXKaRl6F6N-NclA9PKNuHMnKIzG0RWjBeD5UGuU8RQ0Qx9rcJZM2Q>
    <xmx:DIXKae0HwbXVQA6um0VLymaQDy3iQOYfdome4H8abIelI6UOy6KafA>
    <xmx:DIXKab44LkdEFCFeip0pHXR6ZwEiGVu3SbVO6ZjPwnvL1WhiQsIDEA>
    <xmx:DIXKaciiUno2X6usDVDLFhSMU3fWh6eS__6EOM0QIwEfusfWP-DriSDe>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Mar 2026 10:13:32 -0400 (EDT)
Date: Mon, 30 Mar 2026 14:13:31 +0000
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
Subject: Re: [v3 05/24] mm: thp: handle split failure in zap_pmd_range()
Message-ID: <acqC010JLTfjHF0y@thinkstation>
References: <20260327021403.214713-1-usama.arif@linux.dev>
 <20260327021403.214713-6-usama.arif@linux.dev>
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
In-Reply-To: <20260327021403.214713-6-usama.arif@linux.dev>

On Thu, Mar 26, 2026 at 07:08:47PM -0700, Usama Arif wrote:
> zap_pmd_range() splits a huge PMD when the zap range doesn't cover the
> full PMD (partial unmap).  If the split fails, the PMD stays huge.
> Falling through to zap_pte_range() would dereference the huge PMD entry
> as a PTE page table pointer.
> 
> Skip the range covered by the PMD on split failure instead.

Ughh... This is hacky as hell.

> The skip is safe across all call paths into zap_pmd_range():
> 
> - exit_mmap() and OOM reaper: the zap range covers entire VMAs, so
>   every PMD is fully covered (next - addr == HPAGE_PMD_SIZE).  The
>   zap_huge_pmd() branch handles these without splitting.  The split
>   failure path is unreachable.
> 
> - munmap / mmap overlay: vma_adjust_trans_huge() (called from
>   __split_vma) splits any PMD straddling the VMA boundary before the
>   VMA is split.  If that PMD split fails, __split_vma() returns
>   -ENOMEM and the munmap is aborted before reaching zap_pmd_range().
>   The split failure path is unreachable.
> 
> - MADV_DONTNEED: advisory hint, the kernel is allowed to ignore it.
>   The pages remain valid and accessible.  A subsequent access returns
>   existing data without faulting.

Em, no. MADV_DONTNEED users expect memory to be zeroed after the
"advise" is complete. At very least you need to zero the skipped range.

And are you sure that the list of users is complete?

I am also worried about a possible new user that is not aware about this
skip-on-split-failure semantics.

I think it hast o be opt-in. Maybe a ZAP_FLAG_WHATEVER?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

