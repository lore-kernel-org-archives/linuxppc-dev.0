Return-Path: <linuxppc-dev+bounces-18485-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B82108B8E7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 10:04:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcdTg0pSRz2yYY;
	Fri, 20 Mar 2026 21:04:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774001095;
	cv=none; b=od9gPUXblQqv0sa1Xd1oncxpU79TkJDvb9ggtXw0fzR/awXD43rGEBbP5AVycUVDw2e353DVwIkzxwwu3S0R3AbC8r+ZNHZ7EtNY/+qI6yp0wUqnyGVSCUidpngXMF5QMAbUZ3hUar/vKlA11cEN3fBLQR6dsBLFEx4ZHlgPnbse49YLmwNc9m0WAU9U+8jU6O+V9oBZba4Tug4rhI67nc0HL3dBdtQnsS65aYXU2LJCFi8zcU/KEoWGV5gsNEhIPGJk/zuFslqL1Pk0Og1SiEWxFcCZWR51RR+xDZbJzwyclF6fajO97MOqUOYIGjbvUHdZKX8uEw4TlT9JexHtHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774001095; c=relaxed/relaxed;
	bh=rLnu6l4LZw7GzCP4ph/UkgXaEggcROJGe4czPjVlOqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ehQIrUkUD9aPv1cIa0jmnHnrKveqzF36r7MOYe49E7kkH/1BryC08Wpd7nd9s7KWAjwSp+k8iujlIsJfCoHHfxMqXZUxf0oiYt9KMsza8B5Abxxq0/GPK7cIALSlmtDBHqS1XJ8oXJEq7N+RXdKgFVJbASFhXw0XcoiCZ3m9jRFuMejQkGk9Yw3cd23DL7+ZY5+17Nb63nRE92jyUuW73kogv0yEkr8ZYyQMWcI4wBxc/6X1wOtgnNrPhB19B1Pwvz8z2NZqg5MPkE6QgAVaht3911iUfWQZ1e7LrRngrM3SW8afPHXxGB8IgO773EUVO0CqAffKmViuXdgmx50URQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=D+ceYj6Q; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=D+ceYj6Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcdTf1ysSz2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 21:04:54 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 96C7D4172F;
	Fri, 20 Mar 2026 10:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5136FC2BCB1;
	Fri, 20 Mar 2026 10:04:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774001091;
	bh=SlqXACEW1bvWaBbKKIpFc5l9X0bOJT5QGbTI1CG7U9Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=D+ceYj6QItOJroZYLEyyE2MBeFVEH6IM75Vi5G/PN8ZodL7Zj2nolMyC/N6rcOzkO
	 gTCj46ngQl60VkkqPpRigcsp0XQiO42A067h6OTJgyefrwGzF90ZZtEs132xst3EGv
	 ke8Hl2sGVHG/IkTdRc9G/zU6xxL8fF4oFp0Ar2N9JRwlsGuLC+7u/6vxBxw09AWcEj
	 wZJweQNUPpvxCo1otppn/Rx/k/XQG4Ouo5iXXkmaQrjxicqq3obmIZPMt/6B5YVhLa
	 1Sl2cxlTleUBCVRG3Iv6gjwGNTfScFbagjQpLmpHaNteEB95xldtKJALrkvf9Y3A4/
	 y7TCZZbtJpalA==
Message-ID: <17a34a6d-8fb0-4010-8318-faca575823e1@kernel.org>
Date: Fri, 20 Mar 2026 11:04:38 +0100
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
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/23] mm/vma: introduce vma_clear_flags[_mask]()
Content-Language: en-US
To: "Lorenzo Stoakes (Oracle)" <ljs@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Kees Cook <kees@kernel.org>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Vineet Gupta <vgupta@kernel.org>, Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Brian Cain <bcain@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Dinh Nguyen <dinguyen@kernel.org>, Madhavan Srinivasan
 <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Michal Hocko <mhocko@suse.com>, Paul Moore <paul@paul-moore.com>,
 Stephen Smalley <stephen.smalley.work@gmail.com>,
 Ondrej Mosnacek <omosnace@redhat.com>, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org,
 linux-fsdevel@vger.kernel.org, selinux@vger.kernel.org
References: <cover.1773846935.git.ljs@kernel.org>
 <b2edda6f00c10ef63013257f282cf155fb371b06.1773846935.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <b2edda6f00c10ef63013257f282cf155fb371b06.1773846935.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/26 16:50, Lorenzo Stoakes (Oracle) wrote:
> Introduce a helper function and helper macro to easily clear a VMA's flags
> using the new vma_flags_t vma->flags field:
> 
> * vma_clear_flags_mask() - Clears all of the flags in a specified mask in
> 			   the VMA's flags field.
> * vma_clear_flags() - Clears all of the specified individual VMA flag bits
> 		      in a VMA's flags field.
> 
> Also update the VMA tests to reflect the change.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>



