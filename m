Return-Path: <linuxppc-dev+bounces-18449-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 517211090234
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Mar 2026 14:51:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fc7tN6Yybz2ynv;
	Fri, 20 Mar 2026 01:51:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1773931868;
	cv=none; b=DCc4v6M3hazF1trj91PspEpmqVTBMyQAOIgE3aY5hXGcz2EePJb17aEvAxCXvzOxnluGfgkChUZhA/dc1ESmbWe2EfaqH1jfHF1ZEtu6nea17YAnB5CKb8p+goed2W90RS6Bx9W7r/O0dQNdbY4fnwuLFWCAalKq+N5EWgkLLgjejdOgxuaLXX1ZUNlZJfVYYv7Z6aT3kYDnc1Xsp2I6QeBCOhTL4+sB5z4RO/emyOVnAEYc59imVBW/todthmLVbqdPDbGdZAhej7Bo65X9FqIpnfFLlWNCdiLXJg20ztJh/OHLBT9bVLzW9vWTvQfPSxTQ6FDBNVaWM8iTTcLaNw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1773931868; c=relaxed/relaxed;
	bh=aInfBWWVLqS+IZS5bb9QXC0z00kfS+2upSPaZ4RfgCg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LttgALFxGHjnIz26KpMNZ+LhvuNLDNN1G3EoqCtQYM5kgDqHwMKv855pfh6r4CF+TGgj0RjhwsLU6B0TH7KhqyugBJRSvOiFbf63cnzRqvp/gyMv5WiwynXwV2gcDkc4k7rADFnKQimyeJu2e4iEW/ha/ECJBYVjQc885lpG3jpX7906W88+Cnh/Fo8kCwT/eim2Cf6AgfuK9hiVB57GUxMTlWbUR61ywwFMA2+RyHLF41XWnyzT9vHUpRMgcw9vlWqrXmB8lO7RxKyXkWyZjmfwRzPYjM9JjWJmc2N1OYbAk9Beq7tK2GG6I2b9Peuq7b3nP63CzCLGVbhaE96NbA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tlQhb5U8; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=tlQhb5U8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fc7tM0hX5z2yng
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 01:51:06 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 492516011F;
	Thu, 19 Mar 2026 14:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB216C19424;
	Thu, 19 Mar 2026 14:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773931864;
	bh=NA2DgZthntn+Bg9p76vM8EhmWgvmuxh9uchtbNyldWI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tlQhb5U8pIGZhJaEn9uhM9ipP5ZvbmouNAA4Ihk1ejHR3ke0/ewxTzj1Uka5Mlbsz
	 pLFIkb5W+Mw6Rsis43iKa0qN6vLRn0ljIl1K4AqJpZBa80h16MTiD8oqj+iJM4WThc
	 kusDk2vZvs4JUK3T949S1jzI/YslUIbM6gzh5sJRM/vYH93dJ4dxbk4gkNrT+X16Rx
	 fUr3JhyrOpq3I7hQhysr+JmVqv9MscUTJ92KmOG7AbffJcsmGWC2CNA1DN6cSCgLY3
	 7MUiaGRvcclIs1U/sbbK8uxKQlHPcpehRaRJjgR5eByOaTptAwSYsjLR7y5Yus/f0a
	 wIhLrOmaLh76g==
Message-ID: <ee4029ba-87e9-4ec8-9391-c2c3a96bdbc7@kernel.org>
Date: Thu, 19 Mar 2026 15:50:50 +0100
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
Subject: Re: [PATCH v3 05/23] mm/vma: use new VMA flags for sticky flags logic
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
 <fd4276d39055290061f87e9fded20b6a6b712975.1773846935.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <fd4276d39055290061f87e9fded20b6a6b712975.1773846935.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/26 16:50, Lorenzo Stoakes (Oracle) wrote:
> Use the new vma_flags_t flags implementation to perform the logic around
> sticky flags and what flags are ignored on VMA merge.
> 
> We make use of the new vma_flags_empty(), vma_flags_diff_pair(), and
> vma_flags_and_mask() functionality.
> 
> Also update the VMA tests accordingly.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


