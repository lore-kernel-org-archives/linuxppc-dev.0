Return-Path: <linuxppc-dev+bounces-28000-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC2EDC982FA
	for <linuxppc-dev@archiver.kernel.org>; Wed, 23 Sep 2026 09:13:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hqWV91CxXz2xk7;
	Wed, 23 Sep 2026 19:13:37 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=95.215.58.151
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790154817;
	cv=none; b=nwp7dXsIBf5yk+ErK7YWOue1dnzGuMtrARI3vBTHxyDdV2c1rTnALOrZTf/PLaaGx7IIQYfseZTL2IHHKsehPMVyY+g+HydhF9MdWGmiq4HmgEZlJP4P/I2t7akQsw5EbL7EzDoohN+rouD9jFFm6Gni0kRO5bRqQOJk4s/AhGk+3y/IjgZDPiqKu8YSYBgO3dOZiLO0gqtMZueet06L7BDoNP5WWQnaDe+qL7rQHBArwNTi5bAY1oP77E19+XE0wh/k5uGXkxVXZUhnumce0Ih4JneWRcpPCWM2wT7v0A7cI5p38Hya+iIfomLHx5q00tfHFfCHGcwZZVbWPT6b5g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790154817; c=relaxed/relaxed;
	bh=MqDx2uNPV3E/fiWMTSd/dV4UjPLeNNzFK2C1QLD5Gus=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CO1dq89sQ+hDpkJI+bJMt2UHhxr0r7ZyGn2RzvJJd2XX74Q8j/qDWLyKo1+R/5HJ1NVkc9V681yMn4RtiVTMBhZUZb+/KbikSRLYqNOxnn8CW5L5b5LNtJoEoXmQexCcUr7DXrk02RGtEmZVPZURroybiwY0BRWRIelsMpd/H3koCGMgf96qrlyvg/NcNVsTiz8RDfNLjLQLXmnFj5ISyCy5/ugTELnnCxcYIDQ+4Gui+DaBtSr0z5ZbhyRb/Vmyy+apAWNIvkoTYeO6fOnGYOK7LEn2SHAAZ6nMsVKYkQtBZ+ius0hRs2H5+bSNovx2RPkbKNI3TAOJ8STJJE+6Qg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev; dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cnsBnZaq; dkim-atps=neutral; spf=pass (client-ip=95.215.58.151; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org) smtp.mailfrom=linux.dev
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=cnsBnZaq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.dev (client-ip=95.215.58.151; helo=mta1.migadu.com; envelope-from=lance.yang@linux.dev; receiver=lists.ozlabs.org)
Received: from mta1.migadu.com (out-151.mta1.migadu.com [95.215.58.151])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hqWV445w8z2xBK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Sep 2026 19:13:31 +1000 (AEST)
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
DKIM-Signature: a=rsa-sha256; bh=MqDx2uNPV3E/fiWMTSd/dV4UjPLeNNzFK2C1QLD5Gus=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1790154793; v=1; x=1790759593;
 b=cnsBnZaqlKuzFKjBCZrA3WMFV/Im3vFSfZKhMAkPNScjMRtBbIeu1iPgD69t/jRSwurtgL+O
 a2Vz7xXdr71XVinWlSHycoN2BSBPZJL3h9qKMiFw6YSU7oP6LrE/ZuZOurGBSQd24Ahu+OsgUVE
 cQ03ChwaT7l3ZkN+fDeLMHXc=
X-Envelope-To: linuxppc-dev@lists.ozlabs.org
Received: by smtp.migadu.com with ESMTPS id ad223138143f3bbe;
	Wed, 23 Sep 2026 09:13:09 +0000
X-Mizu-Trace-ID: ad223138143f3bbe
X-Migadu-Flow: FLOW_OUT
From: Lance Yang <lance.yang@linux.dev>
To: ljs@kernel.org
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	nico.pache@linux.dev,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	usama.arif@linux.dev,
	kas@kernel.org,
	guoren@kernel.org,
	bcain@kernel.org,
	geert@linux-m68k.org,
	dinguyen@kernel.org,
	schuster.simon@siemens-energy.com,
	jonas@southpole.se,
	stefan.kristiansson@saunalahti.fi,
	shorne@gmail.com,
	dalias@libc.org,
	glaubitz@physik.fu-berlin.de,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	linux@armlinux.org.uk,
	vgupta@kernel.org,
	monstr@monstr.eu,
	chris@zankel.net,
	jcmvbkbc@gmail.com,
	will@kernel.org,
	aneesh.kumar@kernel.org,
	npiggin@gmail.com,
	peterz@infradead.org,
	davem@davemloft.net,
	andreas@gaisler.com,
	richard.henderson@linaro.org,
	mattst88@gmail.com,
	linmag7@gmail.com,
	catalin.marinas@arm.com,
	mark.rutland@arm.com,
	chenhuacai@kernel.org,
	kernel@xen0n.name,
	tsbogend@alpha.franken.de,
	James.Bottomley@HansenPartnership.com,
	deller@gmx.de,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	chleroy@kernel.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	tglx@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	vbabka@kernel.org,
	rppt@kernel.org,
	surenb@google.com,
	mhocko@suse.com,
	jgg@ziepe.ca,
	jhubbard@nvidia.com,
	peterx@redhat.com,
	ysato@users.sourceforge.jp,
	shakeel.butt@linux.dev,
	corbet@lwn.net,
	rdunlap@infradead.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-openrisc@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-snps-arc@lists.infradead.org,
	linux-arch@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org,
	hughd@google.com,
	qi.zheng@linux.dev,
	linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 07/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for m68k-coldfire
Date: Wed, 23 Sep 2026 17:13:03 +0800
Message-ID: <20260923091303.19671-1-lance.yang@linux.dev>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-7-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-7-fe1ad1f1e303@kernel.org>
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


On Tue, Sep 22, 2026 at 04:35:38PM +0100, Lorenzo Stoakes (ARM) wrote:
>Similar to sun3, the coldfire variant of m68k uses 2-level page tables.
>
>Update its __pte_free_tlb() function to use tlb_remove_ptdesc() in order
>that, with CONFIG_MMU_GATHER_RCU_TABLE_FREE, page tables are freed under
>RCU.
>
>The page tables occupy a page each and have no odd semantics, so this
>change suffices to allow enabling of CONFIG_MMU_GATHER_RCU_TABLE_FREE for
>m68k-coldfire, so do so.
>
>This forms part of an overall effort to switch every architecture to this
>mode.
>
>Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
>Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
>---

Yep, ColdFire PTE freeing now goes through tlb_remove_ptdesc() :)

Feel free to add:

Acked-by: Lance Yang <lance.yang@linux.dev>

