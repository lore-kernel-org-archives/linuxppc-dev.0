Return-Path: <linuxppc-dev+bounces-18484-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35081108B8EC
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2026 10:04:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fcdSr5lXYz2yYY;
	Fri, 20 Mar 2026 21:04:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774001052;
	cv=none; b=nrB7wMvUbLuaEXRM6xzc302WrDUpiJZRlRcmXygnQt5BUeV5UcEToO3RSDocBUClRWORfjF3qSUHp2+B1PT9PVcon3WyFiTst7LE3Mfits3X2haxxpwa8ImvHbhgtZeglDUPoZBowxFXrpnsP2yzBspx0KTkKEUDOndGA5KBluXM/r42GLFjkyykaKLK8PRw4V9NXRD7NaWgErkb40yY2BeR0fx29I/e/E2B0nFlAAAQ+Tv47lR4FGTiEwasSHKGVTQi0XWb2tbnPsQ3j4WvuKFfY9EcEg4VzDO1loA3Twv2T2fTrmiQDulVqPXOPWIZKcPrKL/MeZascmQyOQxMEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774001052; c=relaxed/relaxed;
	bh=TO1zuzNcun0kkWR0GSCmWT/+8q/5K9hCcXkZoI8wkhM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TEXOgNzB04YRgzv2QjHj7OzTwuNE4wBbdWxMqUzU0nXKHhNRNZ99rDduy6uAggQ52nc5onJG4eHjeu2gvLYZTvLRIKMcnCNAdyIimuNlvNeyWU5bvd6jMv21V96VHg8ieYJz+yhn0bpJpihDch7QULcTLPyXFbpl6gza/Ydlwf0q4K7PchQ/6b68RwxQ8ysgA21OLsVbl/KDq1hl+WJoas0AhuKTC0XCKzlHSyKhSlFFA6IM42Jp7BHqTMS4xFYgPI1xsyYBWCjmRJ3wuXXdD+ARH6QoqMtCV2NIQi8I9yyQh2KI1OsqvIVKosf13zE4jYAf46ZjhHuzOLK0zMVU2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vAzNcrs8; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vAzNcrs8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fcdSq5qDdz2yY1
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2026 21:04:11 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BC3CF60127;
	Fri, 20 Mar 2026 10:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22ADDC4CEF7;
	Fri, 20 Mar 2026 10:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774001048;
	bh=NQpsBeY5EaadXVFBxdOq2KBH0GUNgPBbX8h8P+4LcqI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=vAzNcrs8BNxVujqkG0WrRcxfbGidYf6UY2B9j2wpPS73gPa9CErzvvHuXkHT5s3MR
	 5mWouqCj4ulvQYSX2gQ0oeuYWbQhMr3B0IR/nJS4TcF+OEjR+zmBU/sIjqSVVSsL0W
	 C/IK4z4Z23+U0QSh28UkwodQL+Mr6P7XEcQVKXPrnIIRz+UunLW9iJ2nh7O8NTsA3L
	 MG3EwvZtxvk5AOmzYxXXkBtommmTKLw070xlnQs0ejRB5W/N+Ch44k1T2oEWB2N2GH
	 SJc6rzEWEiFmEyb28TIZla0WZ1PJY1+D/NNbiLn70ecSKmqZcRVkafJSgmy4rT5CHS
	 kIduEphstAAdA==
Message-ID: <1105e346-e850-45c2-92be-6c255a110658@kernel.org>
Date: Fri, 20 Mar 2026 11:03:54 +0100
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
Subject: Re: [PATCH v3 18/23] mm: update vma_supports_mlock() to use new VMA
 flags
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
 <8bd076169508ea4640f66f91c4b84b433a3476f1.1773846935.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
In-Reply-To: <8bd076169508ea4640f66f91c4b84b433a3476f1.1773846935.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/18/26 16:50, Lorenzo Stoakes (Oracle) wrote:
> We now have the ability to test all of this using the new vma_flags_t
> approach, so let's do so.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


> ---
>  mm/internal.h | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/internal.h b/mm/internal.h
> index 80d8651441a7..708d240b4198 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -1252,7 +1252,9 @@ static inline struct file *maybe_unlock_mmap_for_io(struct vm_fault *vmf,
>  
>  static inline bool vma_supports_mlock(const struct vm_area_struct *vma)
>  {
> -	if (vma->vm_flags & (VM_SPECIAL | VM_DROPPABLE))
> +	if (vma_test_any_mask(vma, VMA_SPECIAL_FLAGS))
> +		return false;
> +	if (vma_test_single_mask(vma, VMA_DROPPABLE))
>  		return false;
>  	if (vma_is_dax(vma) || is_vm_hugetlb_page(vma))
>  		return false;


