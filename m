Return-Path: <linuxppc-dev+bounces-21310-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C5DCD5BAA
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 May 2026 08:40:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gLhgn50hvz2xdL;
	Thu, 21 May 2026 18:40:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.172
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779352837;
	cv=none; b=Rz+t0WV9WQ/SDgysZjASA/JfdMJoQ6gmX/Y69qymANEumtCl1irtN/vwidvH5tHE+12k6IFULabI5OvrFuthBz5aRpVpSPygGqrHkeEv4+2fqlPt3mg5byIzR9wVvewXb+LbbKdL9YJgW9IltrmWWZcmvmHt/Q1eupAzxCpS4qaYVl8KqrB+w3DokNFMniDAiaBFeg3moZvTVxRoobITJAA+zcajyxmbFD4C9aFGTqCLU98hH39EKun6rJ4pVL+kogSVo393KJ6W4hrRsVcqL5gqJHdNzZZOjKBT+UQWwU3Ls+lCKNfLXUzD53iVfxwMCsdZ13rOxS4nEEfFYQ1rCw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779352837; c=relaxed/relaxed;
	bh=E4k19jfrGZognz9ylmmH1ahmwrZE9nXMy8Z2zTJ2/qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UPj7MAIv3Knw5t2I6zdetHct+JRZtALr9daXhtUR2OEU8FpttA1LLhoL6JRq1DRrH8RXPGeQT4tqzUs/DRoDN9DGt3lvhJFdsk3QGX0uG0z5Af2okFjDrA93MoIcOobjKv0xZ3dmYOO310av06ZaeUnd/0V+OPsoKsOox3v093urRrSy8oxi4fePjDtPO+4kM1OMeEUsvpkhq6vNe4MPbEkSyyFHWqH1PzoHtjQYrR3sV5+6eQEuPYzUvILAA4FCTQC+P7g33Dq8mkb/E+TczRiRIb017x7v2CvVYSadKjibXitEObLu707faKmP8yuQds+kpCusSyNZFT2pCEpTgA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=I0/Fo/D6; dkim-atps=neutral; spf=pass (client-ip=95.215.58.172; helo=out-172.mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=I0/Fo/D6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.172; helo=out-172.mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gLhgk6KP1z2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2026 18:40:33 +1000 (AEST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779352813;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E4k19jfrGZognz9ylmmH1ahmwrZE9nXMy8Z2zTJ2/qk=;
	b=I0/Fo/D6//GbWeFmyAxHEQejv6UqxNMM8i7TkpHyaSI9zoZcVjqtoUQJPFhUfu3nEYOP0V
	zr3OmOhOtORbSm2LamS6JBJ20lMiTgfL/wTSv1FNzblIQYdQf2s6waidmpIDqHZvB/ies0
	V3l/d4fkK8ZMWZulCQedS9XqNROMfZs=
From: Lance Yang <lance.yang@linux.dev>
To: david@kernel.org
Cc: davem@davemloft.net,
	andreas@gaisler.com,
	rppt@kernel.org,
	akpm@linux-foundation.org,
	agordeev@linux.ibm.com,
	gerald.schaefer@linux.ibm.com,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	ljs@kernel.org,
	liam@infradead.org,
	vbabka@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	sparclinux@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH 7/8] s390/mm: use free_reserved_page() in vmem_free_pages()
Date: Thu, 21 May 2026 16:39:35 +0800
Message-Id: <20260521083935.28252-1-lance.yang@linux.dev>
In-Reply-To: <20260511-bootmem_info_prep-v1-7-3fb0be6fc688@kernel.org>
References: <20260511-bootmem_info_prep-v1-7-3fb0be6fc688@kernel.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


On Mon, May 11, 2026 at 04:05:35PM +0200, David Hildenbrand (Arm) wrote:
>We never select CONFIG_HAVE_BOOTMEM_INFO_NODE on s390. Therefore,
>free_bootmem_page() nowadays always translates to free_reserved_page().

Yeah. After patch #04 there is no kmemleak handling left in
free_bootmem_page(), and on s390 it is just a wrapper around
free_reserved_page() :)

>Let's use free_reserved_page() to replace the free_bootmem_page() loop.
>We can stop including bootmem_info.h.
>
>Likely, vmemmap freeing code could be factored out into the core in the
>future.
>
>Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
>---

Nice cleanup, feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>

