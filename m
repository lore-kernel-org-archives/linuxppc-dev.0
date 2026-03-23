Return-Path: <linuxppc-dev+bounces-18630-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3E5CF4613C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 15:50:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffd0T1Fs7z2ySB;
	Tue, 24 Mar 2026 02:50:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774281001;
	cv=none; b=VX3kbG6w29BOLWPlfblLeZ28kycqIxDFTVGq0tDmWHYq1zwIVmTP2VFoykHx9SHIEuHY0ty6/aH3CIHGgs2VG3Ar6xlz+YEVcvHMP4TKZ5Ua2HsQEGqih6tz7kv4WGcEFKFWX76yoXMFnC0rJSkZAd3L+J7sastYHgjw8Y7gOoR6SlXekjiB8P7KE5Ke42C7hl/x3BFNRbfn9RPvQbulegTe2OWdLpQvIQ1E1tki72lLpTE6PhJifNVSKsvGA5fiOZtubvq4zgHD4yDcL2xvx85K1757OZhmLP8RUC6yqrtpd2VRs7AgTL69Yj+BdLqGG5qbKYT6QW6ZyBqXemOP+A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774281001; c=relaxed/relaxed;
	bh=pBxuE79q0h/5XA82Gqv80sB/5+DcRUE+NdGM983xYdA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdJk2KYOLO3tV0pcOIR25Cs/QgxqefdWO9Kz3ykxgOpyft/hq+32JVGJLXsNOxaRmXIiy+i5JMEQFOJufh/OGovCA0EWObMnj4M1JDg9RcZU+O2IqnXG6BALLLcBJNB9xr5gHl87IrTCgp7Eg05geXOfgLUrBQkTTWl19pgJlyZ1IkFfqQ/MCdbAYUY81svb4FWUOx0JxDUYDXQDkSYQliU/UqlAVzCTHqZsnze3s/po/Qp0C0ZXFcCyokr8pjoMw89h/FSYSAQmJyWUA0equKHvnaYVfp4cWvRyp70902dT9gOkCfYgFmfLcQFmtchpwrYRFozYvnpiY4QfC9+tfg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XdKC0tlg; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XdKC0tlg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffd0S1rYlz2xN5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 02:50:00 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 30C9443D7C;
	Mon, 23 Mar 2026 15:49:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79346C4CEF7;
	Mon, 23 Mar 2026 15:49:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774280998;
	bh=PE+T0jq3B8ZtYRDz678LEyuTz6jmDPCQy5RpPTYrDcc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XdKC0tlgf1MZ9+nFlKePnzFurNne6QPx1E6YWyTEqc5Cy4/MJ7viljpcXJeeYfD84
	 LwWQhNPsI2I9K0v1c33u+VAYFjbd8O5XNRv7oB6hk9aWRLevlIqBhXTN/OJlKMwQKf
	 P5Vz/q+wIiOUnPmbE+gPP+1XyMVrMVU51S9pyTagqqIblZpcRImI+DCS0rQGs9Ppmv
	 uI4cbcMRaN1v0kgvKPt9I+2sGELYGp/hsRsweEovyazf3HWaMCdkqf89a80XhZaKnl
	 owytQQeI/86OfShIGnWbjgDPLE70BmD03V3uE7cRvQ8417IfFC5O/o3RDSK2/SzDZz
	 cVIvEtMGRKwxg==
Message-ID: <3945a9c5-565f-4126-8d46-1db584b09e79@kernel.org>
Date: Mon, 23 Mar 2026 16:49:44 +0100
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
Subject: Re: [PATCH v4 24/25] mm/vma: convert __mmap_region() to use
 vma_flags_t
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
 <1fc33a404c962f02da778da100387cc19bd62153.1774034900.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
In-Reply-To: <1fc33a404c962f02da778da100387cc19bd62153.1774034900.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/26 8:38 PM, Lorenzo Stoakes (Oracle) wrote:
> Update the mmap() implementation logic implemented in __mmap_region() and
> functions invoked by it.  The mmap_region() function converts its input
> vm_flags_t parameter to a vma_flags_t value which it then passes to
> __mmap_region() which uses the vma_flags_t value consistently from then
> on.
> 
> As part of the change, we convert map_deny_write_exec() to using
> vma_flags_t (it was incorrectly using unsigned long before), and place it
> in vma.h, as it is only used internal to mm.
> 
> With this change, we eliminate the legacy is_shared_maywrite_vm_flags()
> helper function which is now no longer required.
> 
> We are also able to update the MMAP_STATE() and VMG_MMAP_STATE() macros to
> use the vma_flags_t value.
> 
> Finally, we update the VMA tests to reflect the change.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


