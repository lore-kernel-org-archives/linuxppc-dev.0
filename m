Return-Path: <linuxppc-dev+bounces-18481-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 450FF1093192
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 08:48:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcbp16N3xz2yYY;
	Fri, 20 Mar 2026 19:48:57 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773996537;
	cv=none; b=ihOndAjlsxFuRDbgyNKVd0DjY9pJe0YSg+ZYBAJJcPLm1jlIRYqPiKltQxlHBOH0pgjA5rtKzAM/e18ft62D8HBBauMZFqXQZRFd+IO/mVT0ze5zZSjUh+wjuaLzrErprV1GIiBydfmLtUbDptZgg0Hp3ol+Pd3Wk62dS3wfp8Z8Jdqs8NJXTQfsoAR2EQoJBraZ7tczabdIaVjGZ8g2lh1ICp0WmAqVJkhfqLwKsF8DdqRXSBEVMiOSejEKZdaiva64/8IAy19PSeuJn8aOPPhudOZ2xWRzWK9j5hAw4frvN0gcTLFdgFl+XgCEVk9qEadRJiBpndbAuBXYI6v1LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773996537; c=relaxed/relaxed;
	bh=IIQYWNglnf1cpJWekLlvTi81VUzC2YvRS4Y7/+4rsT0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mfjGyyioalhOY2lCljugWlBiVeVAVpz55bGx43QlNhVtx4KPUZOYwrKcV1yjPuPf3Hf4D6O8NsLV+4xPpOEz3GGSKPCbhSyckKUA36V4mjI6JaJDuaeyxe9NrWkdnndpmAj5nBX5wvRV2neBpTzwmMLd8FEjVUgk7tljhm/HjKDh4Pzv7h2yIKw8d4S4UnI7zpkuTxHrVogPdBfHDWxAIyNZLTXve///tPxz0JyKTGVVeIqnqKBlOOf9bxuovRrRzpQaaKHTy9aBCsCzE3pk/eCLSDColAHo09bEhPyE8WRgVLDGNw6ErvL1/qQ4Fe+p7tv4J8Z/rkasz6WDPqdTCA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aVDuHUfd; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=aVDuHUfd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcbp072DDz2yY9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 19:48:56 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id D799E60121;
	Fri, 20 Mar 2026 08:48:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69C6FC4CEF7;
	Fri, 20 Mar 2026 08:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773996533;
	bh=AVThdTFHSI3D63/uFwXEr2OGdo0OiWz7degFLaawtVQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=aVDuHUfdDD8S+qMhhcb+8iyq+IuTk2K0qpRAv1mnSPjQTT7GWau5uX1CNTdDtfR/0
	 LFp++8Dnz2QwIE1kWsO/Av6uPpJORJ9xnJDFjFTcwzcgktO9VxcKv+wSUvrzz529wf
	 Jleh6q8+Izcw8eTwQjx9H+19qhhqrrp8JH/iFcDfQPCQTH5ptvLmvsD0tj3RuwnSdm
	 11tBmRkm8T9VJyB6mHacHEUYXp0QrFVfjmR41FNwWWw2f9UTt8GR5oY9fomV0MX3gt
	 Xge1GZpeSPAeqwc5HQZYEgN6ad+xpQ+XJTcqZodE/t9TJgLMJDqXmC2Sy8iqPyspGC
	 oOpqQ4TUqrEMQ==
Message-ID: <7bd728dc-f370-4e64-a120-bd8fdcd3207a@kernel.org>
Date: Fri, 20 Mar 2026 09:48:40 +0100
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
Subject: Re: [PATCH v3 13/23] mm/vma: introduce vma_test[_any[_mask]](), and
 make inlining consistent
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
 <7ea63af87bd35f20b204a14ad4912592e02b15a6.1773846935.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <7ea63af87bd35f20b204a14ad4912592e02b15a6.1773846935.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/26 16:50, Lorenzo Stoakes (Oracle) wrote:
> Introduce helper functions and macros to make it convenient to test flags
> and flag masks for VMAs, specifically:
> 
> * vma_test() - determine if a single VMA flag is set in a VMA.
> * vma_test_any_mask() - determine if any flags in a vma_flags_t value are
> 			set in a VMA.
> * vma_test_any() - Helper macro to test if any of specific flags are set.
> 
> Also, there are a mix of 'inline's and '__always_inline's in VMA helper
> function declarations, update to consistently use __always_inline.
> 
> Finally, update the VMA tests to reflect the changes.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


