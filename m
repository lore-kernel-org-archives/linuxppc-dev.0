Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46509606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 13:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PvvBbxxs
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jY6Qw4v9vz2xNC;
	Tue, 24 Nov 2026 00:36:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795440968;
	cv=none; b=jd3hoI486UPLWrTrmLVtiLIYenOlhae1OWDGJN+qP2wcj28Kq9hweZwGGOE1D4Dh6ug8CXxS8GTzEfPs7SJi+2GcbiuE6BDuTjZq4112G30ext5Ix7Nd8d+VDDBOsz7bnnHB/CNG8CsUCgYPEo3XmTZ8N0QVzzsSokh5if7aRMWsObqKtglzROCxp2vNJzCyRjYmqgxgQeX7N8Dd3bwDl6+Yy57BD1lRqajJr7PSHC084mCOAJLO6YiYXzB2mcZ4ualELC0OvNAP9A3GoKgElwi15cUKS4YUtoChTIFJREks+EZc4Ts14bJ8p/lfzIUlNaBfaY4ofnu5C7ntaJ2KZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795440968; c=relaxed/relaxed;
	bh=VbiiQPdCmN34F2RgnnrrSRWQpzSbde3XUaxkRXW3wms=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=eAMkYOYv2kVRjSr7Yu6755I3kN7zJEN2CnRgL2Hek6yLTw58aW1wuTmsQGAjqvwel79S/30E7ZstTMDIFey4mxhjpV1yb3UEnlCDssWqkbwN2Sgn1Fp/LSPQXKbz4AWRsVWmlO1rC06BX/24HZNSJmWIHZ3eaRJgkYDF+esZ4iaJfH5fVwICMANGKyJdDBJWlt8pFXa+6N05LpAZJl3qhpcyZDUJ5Xy/MYBomE643LjeSkrnIUgNfutnBart+x9jJiPEC66/T9xrP1WiOaj52MDWKI9Z1laFjk2WhCzfWxEEEjbsU7bPwe9P1G/ZeN8cM1no5pMwhCNx3ovmXOndKQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PvvBbxxs; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=PvvBbxxs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jY6Qv04dWz2xGF
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2026 00:36:05 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-8b6a88e4341so1390034b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 05:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795440963; x=1796045763; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=VbiiQPdCmN34F2RgnnrrSRWQpzSbde3XUaxkRXW3wms=;
        b=PvvBbxxs6kJM1fD6EC8/R9zpeBfzJ/Uvx3AVOQ6WUdRx6rtBJ8tVj4h1tQvILMDfe7
         ImXdrn7UPQ1Km0PeEjuEXRkBEPpAHec8s7KmjCMZzPVfzYSvCfbjCOC5T5fhW6HFtonQ
         WwFE700d4oxTU49Az6Szv1nBkBgPEqs0GgjfRA6UdSFvGZdPIeIMJLK1hAIxzAT0rOq/
         UxXMyxp3L0PVJmvn90pgWfGTjBUbLc46UbJ/3yvAPLjey63ruxNRxy8XPjrmDO/uLL7d
         rlasNvfW7TeA1j16jbqO8XRrEYqqd9Mc3/sNFpKlN65L2qFowZhiNXJN+Q6pcb9nH+tx
         Y86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795440963; x=1796045763;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=VbiiQPdCmN34F2RgnnrrSRWQpzSbde3XUaxkRXW3wms=;
        b=vGmZGccspk+huL7RtzKncxrmDFuM4QsxxnQG5cTRy2umEYtGkvs+B7Zd0MRK+BjGwk
         w0qYkxcn764c+jVkjrY8+H4C6X2rVJUOy/Yr0QgbCuXv1OKT7SnrlV/CtJSDS2CW75gC
         mSi3FHXGub7kYex9C8/Tn2Mv1a+nl22coSuLq1278gymkzA7jZMuFPzKDsabTwDSNcw7
         3/2l3Uz4ty6Q1oEhs3rz5fU4y87QbHxQPH8TTs9botNkYt8zt6gDUCXpDtLBcroJcaVH
         neSP6PRxEwMb6cg91r4oKU0qTsS3bTEPrgMm9Lpw83hayKL2Nc0dPjLwVMhTMdbXKrMq
         4VGA==
X-Forwarded-Encrypted: i=1; AL+hErE5Lm2u8z3/gkUGhCHTx5ZP/rAb+aXNZZ0matqE6DmhV19WGFTvEUZEdDGfDJ72uh/K7vghzSXE9V9N6Zo=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z81jp0zP5XD5S/Wrfw6KXRlZcD9MbU5W5OWtbHCTqOQi1sd9RQG
	0ufbhWFrsPvrAVRu5PQ3vUJw7mQgmLbg+4N/uRGxEf87+4AknvZ2pNuFTe5atQ==
X-Gm-Gg: AZFdTZd++9dJUa5L7Lnlvft6CfC6+enumNLEfWCTQPHGgDj9nx5PRaBEAAKSkIrb+wh
	MDLXDeb8jJioEq4KEq7kAA6mYG4N3YAwxpZmUr0ZwlDf16NbsEYUnkxLyvjdEFl/0TAoty+F49J
	Kj3G0LA1BuGC+LObNOPSzp9ZUtAbpHHTliWn6ByL3h/PwzXHbXc8LbN4JeLeZ0mOK9NF+Ey+yjP
	so07VEPTUjIPM9LrEu4eyGmFkTz5Jnn3/KYHMLSdw/gsULRktfOdV/meYkdyY6nZuaJeABKliVo
	8jPygXRERfbmxacZm1B9eIDDCU4ijIgxSrNfJ6AR8PDtDZXRYlhkVz9SuX6eamYKG0jWMpJ61yZ
	Qm/FJ/vOFi0UGozGyM3aDxL2hWhhCk/cuG6qPrNnO6FmiNU6SmnMui8GfK196f4r9mQq1u2fJtq
	lYrpVjcmNnQZReEnj0FsiS+9DrY8GS2e5/gYw/Bfb55ffcdqBwOCGcymKdJVn4B3TpG8uCzuW4E
	q8+u8qXbTYSJ0p+Nnm45Lu0XQwpjdRqtJuEdEVEociL9N7HEZ7m+TukWcM4XKtiQfkccfrjM5SI
	uVtJa7dIkLb1vIq/vn+TRLEgBDeC
X-Received: by 2002:a05:6a00:4094:b0:8a0:70d8:a2ee with SMTP id d2e1a72fcca58-8c87ded6498mr9540643b3a.60.1795440962556;
        Mon, 23 Nov 2026 05:36:02 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8c87285c263sm5570564b3a.11.2026.11.23.05.35.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 05:36:01 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCHv2 1/3] powerpc/execmem: Don't leave kprobes insn pages W+X when CONFIG_MODULES=n
In-Reply-To: <v75v752e.ritesh.list@gmail.com>
Date: Mon, 23 Nov 2026 19:03:55 +0530
Message-ID: <se0rk6yk.ritesh.list@gmail.com>
References: <cover.1794572365.git.ritesh.list@gmail.com> <f75f2cf97f44375fd2c8820e0caeab703cdb371c.1794572365.git.ritesh.list@gmail.com> <9a7963a6-0033-45ab-90d5-b1f580a4882c@kernel.org> <v75v752e.ritesh.list@gmail.com>
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
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-version: 1.0
Content-type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hi Christophe,

Ritesh Harjani (IBM) <ritesh.list@gmail.com> writes:

> "Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:
>
>> Le 13/11/2026 à 13:31, Ritesh Harjani (IBM) a écrit :
>>> commit 2e83e2ce34ff ("arch, mm: promote DEBUG_WX to CHECK_WX"), made
>>> CHECK_WX default STRICT_KERNEL_RWX.
>>> 
>>> Now on powerpc, when we boot with CONFIG_KPROBES=y and CONFIG_MODULES=n,
>>> we can see the following warning splat at boot:
>>> 
>>>      powerpc/mm: Found insecure W+X mapping at address 000000002ea08992/0xc008000000000000
>>>      WARNING: arch/powerpc/mm/ptdump/ptdump.c:194 at note_page+0x4dc/0x4fc, CPU#0: swapper/0/1
>>>      NIP [c0000000000ac204] note_page+0x4dc/0x4fc
>>>      LR [c0000000000ac200] note_page+0x4d8/0x4fc
>>>      Call Trace:
>>>       note_page+0x4d8/0x4fc (unreliable)
>>>       ptdump_pte_entry+0x70/0x94
>>>       walk_pte_range_inner+0x15c/0x260
>>>       walk_pgd_range+0x6d8/0xd5c
>>>       walk_page_range_debug+0xa4/0xf0
>>>       ptdump_walk_pgd+0xec/0x304
>>>       ptdump_check_wx+0xd8/0x154
>>>       kernel_init+0x94/0x26c
>>>       ret_from_kernel_user_thread+0x14/0x1c
>>>      Checked W+X mappings: FAILED, 1 W+X pages found
>>> 
>>> This happens because CHECK_WX noted a writeable + executable mapping.
>>> 
>>> This happens because execmem_arch_setup(), checks for
>>> struct_modules_rwx_enabled(), while kprobes depenency on modules was
>>> earlier removed via commit:
>>>      7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
>>> Since the insn slots are only written with patch_instruction(), which
>>> does not need this mapping to be writable. This patch fixes it by
>>> checking for strict_kernel_rwx_enabled() instead.
>>> 
>>> Fixes: 7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
>>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>>> ---
>>>   arch/powerpc/mm/mem.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>> 
>>> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
>>> index b617b69452cd..77b63b52d8f2 100644
>>> --- a/arch/powerpc/mm/mem.c
>>> +++ b/arch/powerpc/mm/mem.c
>>> @@ -388,7 +388,7 @@ static void prealloc_execmem_pgtable(void) { }
>>>   
>>>   struct execmem_info __init *execmem_arch_setup(void)
>>>   {
>>> -	pgprot_t kprobes_prot = strict_module_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
>>> +	pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
>>>   	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
>>
>> Looking at this, I'd use PAGE_KERNEL_X instead of PAGE_KERNEL_EXEC.
>>
>> Then we could get rid of PAGE_KERNEL_EXEC completely for powerpc.
>>
>
> I think it's best if we keep the definition of PAGE_KERNEL_EXEC on
> powerpc as PAGE_KERNEL_X, I think the core expects the arch to define
> this, if not, then it defaults to PAGE_KERNEL e.g. see this:
>
> include/linux/pgtable.h:
>   #ifndef PAGE_KERNEL_EXEC
>   # define PAGE_KERNEL_EXEC PAGE_KERNEL
>   #endif
>
> Also mm/execmem references PAGE_KERNEL_EXEC in __execmem_init().
> Although it references only when execmem_arch_setup() is not defined by
> the arch (which is not true for powerpc).
>
>
> However, even though nothing breaks today, but later if there are other
> users of PAGE_KERNEL_EXEC, then PAGE_KERNEL does not have X (execute) bit
> enabled, so it might break in future. Plus looking at above, I believe
> there is no harm in keeping it - since core expects the platform to
> define it's own definition - due to all the other references it has.
>
> Thoughts?
>
> However, if you still think we should remove it (?) - then I feel let's
> do that as a separate cleanup patch. Since this keeps the usage of EXEC
> same between prot and kprobes_prot variables in patch-1, which we also
> need to backport.
>

Gentle ping on above queries!

-ritesh

