Return-Path: <linuxppc-dev+bounces-18629-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 064CBD58B00
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Mar 2026 15:47:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4ffcxz4F4Gz2ySB;
	Tue, 24 Mar 2026 02:47:51 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774280871;
	cv=none; b=JSuz8Dlgs1+SWdBnxZfbhZlk4qBzDMU205pikn1ePqOgOXkc69Ij+dzJobVfWvl3HzVacJ09nG3Xy2u/5EoMxGtpEt5CPDiMt4nvQnJu39Y/1eMbeey1IbUCLjBpavyzrIrsma3TaK4tL4LYwRO5YaG5DrlRCxJwgAS9zB3R3vS4P/OeMPg7zTkO1njydtsckgqmlYjadkwcG5MXcqELik2cnLiF/px0DmlkpduJGuTr6VD1eD3ur3Oiz84gsf9wwCtwrBhDh8A+GQekynRYSgsy91VNSBd3Z5JDK8+ftyp3WVy2QN5yePxxii0QQYlkYAqrrFiFqA+d9SL2OMS4Yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774280871; c=relaxed/relaxed;
	bh=aJG7rviSzrQ4mxNP46Y9gYTa/9q/Y+t8JYvzFfU3sy0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QbMpWJxdwgVViarMZi0utNw1qoIbqyfluaVLTU5mU0odbPXwtmYnJZQ+mxERfPhd4iwG4vmzlB/rUZDyobRyU6sEmcJbjjCWk/WBGoxEGq2mtKY9Xo3uCKMnopgZ0HxQ5wbWIKtHqSTQjvKE2Ex3Jt/Sztv264iis1mY43yLMPz9troUNz/iayz+dXLesQq/D6lvQpaDoy9pREKRHZVCMCPFPZL+65HP2TOiMQgqmNj7F+AQYtHg3eHBfQ2iXI9zznD9ZLH8xT1XB+egCFaHwl3qFNGdYYbJTiHwiY+8YdrgUpMgt7kNDDI1kq7LEPgZBZZ1aDOsX6+mfEHNYkey4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KPjnpfdE; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=KPjnpfdE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=vbabka@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4ffcxx2G10z2xN5
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Mar 2026 02:47:49 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9DE7743B0D;
	Mon, 23 Mar 2026 15:47:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1465C2BC9E;
	Mon, 23 Mar 2026 15:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774280866;
	bh=ykDj0Ppke/lrsvnXc74bDdUkqngFPXP4WoK/RTIL1I0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=KPjnpfdELqJbpC4ncfqddvGU9IIIkup26qddC2aNixhFBIb9mHkF5A7epXJQ3KmSH
	 MuLQQp032z1JuZmOTzDCg5uhT0pMXLmk69mazn1wBoES5rRXYs+2i01B39tCb0fgwm
	 eMVmp2zxvVNKgA6OUptqx23bwS7Xpo/9N86ZlA8ang/MlqIECTmX5MKUewXXQzMnmh
	 QUNRieF4AKOOU9JlQtW5hTno4YlkFFGvDEgeAtLrbiTNsDF5KI83hQ66Af3sBzXk2x
	 2EQzT+rnWcdOU/touJNZDWaVify96eKObV19ON47GNNYH2ceCv+xCHG57JoxHjqvXU
	 vAON7QUwQBDNQ==
Message-ID: <cd30724b-15e3-4642-b19e-c464d0978282@kernel.org>
Date: Mon, 23 Mar 2026 16:47:32 +0100
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
Subject: Re: [PATCH v4 23/25] mm/vma: convert vma_modify_flags[_uffd]() to use
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
 <51afbb2b8c3681003cc7926647e37335d793836e.1774034900.git.ljs@kernel.org>
From: "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Content-Language: en-US
In-Reply-To: <51afbb2b8c3681003cc7926647e37335d793836e.1774034900.git.ljs@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 3/20/26 8:38 PM, Lorenzo Stoakes (Oracle) wrote:
> Update the vma_modify_flags() and vma_modify_flags_uffd() functions to
> accept a vma_flags_t parameter rather than a vm_flags_t one, and propagate
> the changes as needed to implement this change.
> 
> Also add vma_flags_reset_once() in replacement of vm_flags_reset_once(). We
> still need to be careful here because we need to avoid tearing, so maintain
> the assumption that the first system word set of flags are the only ones
> that require protection from tearing, and retain this functionality.
> 
> We can copy the remainder of VMA flags above 64 bits normally. But
> hopefully by the time that happens, we will have replaced the logic that
> requires these WRITE_ONCE()'s with something else.
> 
> We also replace instances of vm_flags_reset() with a simple write of VMA
> flags. We are no longer perform a number of checks, most notable of all the
> VMA flags asserts becase:
> 
> 1. We might be operating on a VMA that is not yet added to the tree.
> 
> 2. We might be operating on a VMA that is now detached.
> 
> 3. Really in all but core code, you should be using vma_desc_xxx().
> 
> 4. Other VMA fields are manipulated with no such checks.
> 
> 5. It'd be egregious to have to add variants of flag functions just to
>    account for cases such as the above, especially when we don't do so for
>    other VMA fields. Drivers are the problematic cases and why it was
>    especially important (and also for debug as VMA locks were introduced),
>    the mmap_prepare work is solving this generally.
> 
> Additionally, we can fairly safely assume by this point the soft dirty
> flags are being set correctly, so it's reasonable to drop this also.
> 
> Finally, update the VMA tests to reflect this.
> 
> Signed-off-by: Lorenzo Stoakes (Oracle) <ljs@kernel.org>

Acked-by: Vlastimil Babka (SUSE) <vbabka@kernel.org>


