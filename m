Return-Path: <linuxppc-dev+bounces-18631-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D1F2D58B00
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 15:52:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffd2l5hBbz2ySB;
	Tue, 24 Mar 2026 02:51:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774281119;
	cv=none; b=WBt2Qel7GuNO9BVzXZs+sC+sBl/QImEFOG7QHDlOokLvJhQSY7opEz4l+t7nsEtMG89HxDgWb7zdUxkY7GEKvvI3hyFrRJZ1mN1EWpH02iFzoN07B5XjYHXrm1esVIDD1BltarInjKhcy7gY79/RbAizS8ugptw7M1kKGJsPjO+A824/M63LqaTCT89Lhae4NFDRqhBsf1/bcYQqRKiKDhd3FL5AEHo7XOC//3bxHgvXl9S8ukx4dZGZs4OHQ956R294AnKGVc/rH6/PLre0n9bHYUHd2iCNV70CH6YR7KgaaLJPtDGERQvzSbloyJR1SY+IvKVvO0VocslybNeiGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774281119; c=relaxed/relaxed;
	bh=2+P1LJbOhGaADXr0borEizC7CpTJv3YbpsxtYt/vS4k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=c9ArjwTXUZ2J9sBRPxgvwmt28W2+qKKY6j8CRGQlwaXhpuR46/hjd4JO1HMdB4kcFk3sZ+5cCUWSUJGnuBj7rg2wYUSr+yDRYG1jhomc9+uIeyObiKU7InTS8ZatSGDwZ++/fZ10WNks80XnIsa1B8i7+iOcnQSD+4DGp/aW7gdEhKksNptllJfCf2AzOjx3oGXhC4OaQPVwUII+qE12CeVOj91RtfGPu/t9CiveOS2CajPHiuWTrUo1LXRA93R4qamNcgrDSYqk/uontXBD4bObD9TFjNjnYS8EyWVpbCc+Xbm6ixZdPke36z7RsX8Oyk1Fc/3/ZtfVRKAsH28PNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o1THjGW8; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=o1THjGW8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffd2k650Vz2xN5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 02:51:58 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EE492600C4;
	Mon, 23 Mar 2026 15:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA5BC4CEF7;
	Mon, 23 Mar 2026 15:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774281115;
	bh=vZdm4GONA/O1jK4+M6185Q0giqh3AS1i2sFB5Pfd/2Y=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=o1THjGW87BBZn2ZRvUB/ZbG6Bpk46OGuXu9+rNxgEX1JPplRd0PmhhIVaepJQX2x+
	 tNfnZZ2oJ/LEW/V1kb+Kd4rSlee9+4uD+RKeGWfnc/xNRMj7aASQw2bbJQ+4aFpnT4
	 D5oU71wAa1icX022onJ8SXq1egN+wMrKLzs0GkJXDMxvnSocAjVWuUsitbcyyxaQfV
	 JJXP9c4lBWKh9RLPX/Xy30cKFsVybbnBnhAp26jeybHA0vntxV0OkXb/w0rzQv6/lE
	 VQ33MGCeDpT2FONGoMZBv7aFNGtJEznzEExGGKYXFQSBLYixZR0A4kZUSTFL4AAduW
	 zfBJEYhpa4mqQ==
Message-ID: <47f796ed-ac66-4a75-98c9-64afc8929f35@kernel.org>
Date: Mon, 23 Mar 2026 16:51:41 +0100
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
Subject: Re: [PATCH v4 25/25] mm: simplify VMA flag tests of excluded flags
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
References: <cover.1774034900.git.ljs@kernel.org>
 <d395c5dd837a9864f5efcec42175910afbe3ce73.1774034900.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
In-Reply-To: <d395c5dd837a9864f5efcec42175910afbe3ce73.1774034900.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/26 8:38 PM, Lorenzo Stoakes (Oracle) wrote:
> We have implemented flag mask comparisons of the form:
> 
> if ((vm_flags & (VM_FOO|VM_BAR|VM_BAZ) == VM_FOO) { ... }
> 
> Like-for-like in the code using a bitwise-and mask via vma_flags_and() and
> using vma_flags_same() to ensure the final result equals only the required
> flag value.
> 
> This is fine but confusing, make things clearer by instead explicitly
> excluding undesired flags and including the desired one via tests of the
> form:
> 
> 	if (vma_flags_test(&flags, VMA_FOO_BIT) &&
> 	    !vma_flags_test_any(&flags, VMA_BAR_BIT, VMA_BAZ_BIT)) { ... }
> 
> Which makes it easier to understand what is going on.
> 
> No functional change intended.
> 
> Suggested-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


