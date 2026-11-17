Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790C606A31C
	for <linuxppc-dev@archiver.kernel.org>; Tue, 17 Nov 2026 17:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jz6RDtB7
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jTWzf5Sndz2xl0;
	Wed, 18 Nov 2026 04:33:34 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1230"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1794936814;
	cv=none; b=DAHHh+rqv8/+N/pBrErs4oq+OfXsQddD2m/KAC0fYJh/leTIe/8hmHs07Amh6qxrH2ZyeKwK8F5LT6ASsCgZtKixKEehpS481/GI4tfQIIC3z3Untw2x7RRUTg+Oxmnts5GhACIZkQtGB/o+BHFqWOjGP9mCQi11eW7Wzn3jO8ODrcrGC2Nvw5IVeCH2KxKj68xfEB3ma1SFdzXXlS+Y2rAQTbQasVSbZJxAo8Rij0s8HJbW+yssVuSdfDvgPJiizTz4CD06fyEPZx7ZOr5YY2IkaHSgNtJMlkz23s8riHHUTFuve6cvu7Jq0O6rwz+8wtHArjjOISKjzm/VzKCTcA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1794936814; c=relaxed/relaxed;
	bh=cG/RevFyBwamCzEOUkqHEPh0sTKsf/ViK8cvhO4n35k=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References:
	 MIME-version:Content-type; b=Swul4ysNTNYAfj5wowFe3zeYHGr9euqnqNfLfUFmsT72y35Xfo+99nvuLUf8ym4t3GkzH+AxQ+YaMfz/UvPRguPjiYm2B+GwrSTWn9RKLbb61zjYggK3HnpFGDmbSSJ6qT1l/MFgHCpRWuwKxsFG8HFPh7zKAjr4LWWF/HIc9tNmdSNnA7goTYmBKys3w9/0RX8wqrg29qQ5ixnHaVktCpOSSL+q5EUH96OIh+l0CShYjs72sJJ2oaHF+gVSLZI+cs8MX+2G4oH0VO5Jrc/s+bqBCQ9JgtnROzvyB9PjGED2Wn0wuOUlHt9Yz9Ao/etWPxylQ8lG21kXIaTlKM8bnQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jz6RDtB7; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Jz6RDtB7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1230; helo=mail-dl1-x1230.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-dl1-x1230.google.com (mail-dl1-x1230.google.com [IPv6:2607:f8b0:4864:20::1230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jTWzd2cdxz2xL4
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2026 04:33:32 +1100 (AEDT)
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-1438d9363fbso869533c88.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2026 09:33:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794936809; x=1795541609; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=cG/RevFyBwamCzEOUkqHEPh0sTKsf/ViK8cvhO4n35k=;
        b=Jz6RDtB7BQv9KJWVTLkMX4BkaFBAm+NGbzPdNCOE/Ztkf4Zn+eGDM6DJ38Frpt0Umo
         9w0yNzntHfJLhfW6CuXs1qLkYTQFKqJm/TaSvVJpFwyS9A7Q8kAIpRN4eyumfFnojvLz
         xnn3/jvjmASpXWNMtwoQ0lQDXcxwpXHBawUDHl7NXYNRXjduhfdPc11TnjboSfRsk22E
         lKa/EcK6OMT6ZRxJn2vscWRMQsEXNRHSpBtKfUzbyWxyeHcn75WldclfF4NO3Jd4vZtD
         sq1WhVVDh8+LePanBO7D03EXrN8fqGW7joutGujoGsoqiYoIj9qXNiMZuyTf6o71gxV6
         8tFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794936809; x=1795541609;
        h=content-transfer-encoding:content-type:mime-version:references
         :message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cG/RevFyBwamCzEOUkqHEPh0sTKsf/ViK8cvhO4n35k=;
        b=GVgU8b+nnMwyn2qmx9F/UH+tv0PpIHHUfrQCO+ICUkBafgBhv5YTVysahEFncXPnIy
         QeTAVofSemmWa4pHbav5SP5Bw0cnCx/w+3HxP8D93e66ljRytmJ5EqRui1Z7r3VYGEWT
         EtT0JejfAwFxW8TVq24TIkMT14uf/Nm/bXzjxDhmqyihhkPsWwXO/F6AUPqDl9JEl/Ti
         7V0Taylwz5ZlDk/oxbu8ljNFP8HAix0D1rLL7U4vvm/PQQYePeATm+kgYKGJJwWze/O8
         WFs6cbWVd/g/RNNQen0KfSafZvATTuR17RGlkY4sBqrPhstcvVFLNF9m/1kQFeINj4bG
         k+ig==
X-Forwarded-Encrypted: i=1; AL+hErEd860ijD4G6D8Rh9QFGCZ9W/WWYDtZN6WzXZMU8WNqL1lZBaqQCfkubY7qiHbJ7Uy50Tpc2bBddhy7mVM=@lists.ozlabs.org
X-Gm-Message-State: APuU4Z+oPbL68q95pWifcarJSviRnVpm4YMa1gr0zjWuqlXLa00I+vuZ
	SId+Ly5dN2DQHn8iD8m4C+xBYyceyxEtMo0M06Vj2gEp/TyPoe63x+6Z
X-Gm-Gg: AYBFou1MrGy+hN0lI+ecLyvkXAAdjA+zbtznqXqB5vpkCXd0ItCfmnu75V+ZlM9ob+X
	IcyJEl5DySkGVZjIC5mIwyuUxDIItMiDCXBr35Z2ssb0Y/DwPVGyQIuW69pYV7Cb1Sm+3O5jIqb
	JuyC19A+GYNY0fg28T4LCcnReB7ik7fcyKgNruiICXGtalgaucZrvYUOXdAKl29yhb6NybgwygH
	VhObI+J0xS3UvCcdx/bCNIBM1/z9MPnyoEX7E42zBFFH/igaV6AvCbU4bpsfEiyvHVZTWOL+eYv
	kJ+WjucZECM360krEKNgiBaecbA/Ey0i8dSyz/SQFHWOOS5pk4Cd8g7ERhWYZX4vaPTe6fUbozi
	C82E3ooJWp/pJB0RFAjD4yJOw/udVBSnimwWGSHPh468XcDINpAL6dvKunx+cZHMNFSeGD3sDJM
	4Bx1KzROS3kULkhQ/6Pu5qf3S4q1zdIfuzqZxPzXezbDJqlbmN7ckBU3NvsGlynDHH9FPdw7Alm
	+DDYAUWTrDP3IEOgx7xRUpAENUmimE3u2ZVE95J3r5EN3QJAZib3HPk1FcBknFKPIiHlu3wHk0G
	LARv714jfDMU/gVNA6bnAbynr4Y=
X-Received: by 2002:a05:7022:408a:b0:19d:233:989d with SMTP id a92af1059eb24-1b543bdb320mr248657c88.14.1794936809265;
        Tue, 17 Nov 2026 09:33:29 -0800 (PST)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b5031b98e5sm46314627c88.14.2026.11.17.09.33.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 09:33:28 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linuxppc-dev@lists.ozlabs.org
Cc: Madhavan Srinivasan <maddy@linux.ibm.com>, Venkat Rao Bagalkote <venkat88@linux.ibm.com>, linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, Hari Bathini <hbathini@linux.ibm.com>
Subject: Re: [PATCHv2 1/3] powerpc/execmem: Don't leave kprobes insn pages W+X when CONFIG_MODULES=n
In-Reply-To: <9a7963a6-0033-45ab-90d5-b1f580a4882c@kernel.org>
Date: Tue, 17 Nov 2026 22:45:05 +0530
Message-ID: <v75v752e.ritesh.list@gmail.com>
References: <cover.1794572365.git.ritesh.list@gmail.com> <f75f2cf97f44375fd2c8820e0caeab703cdb371c.1794572365.git.ritesh.list@gmail.com> <9a7963a6-0033-45ab-90d5-b1f580a4882c@kernel.org>
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

"Christophe Leroy (CS GROUP)" <chleroy@kernel.org> writes:

> Le 13/11/2026 à 13:31, Ritesh Harjani (IBM) a écrit :
>> commit 2e83e2ce34ff ("arch, mm: promote DEBUG_WX to CHECK_WX"), made
>> CHECK_WX default STRICT_KERNEL_RWX.
>> 
>> Now on powerpc, when we boot with CONFIG_KPROBES=y and CONFIG_MODULES=n,
>> we can see the following warning splat at boot:
>> 
>>      powerpc/mm: Found insecure W+X mapping at address 000000002ea08992/0xc008000000000000
>>      WARNING: arch/powerpc/mm/ptdump/ptdump.c:194 at note_page+0x4dc/0x4fc, CPU#0: swapper/0/1
>>      NIP [c0000000000ac204] note_page+0x4dc/0x4fc
>>      LR [c0000000000ac200] note_page+0x4d8/0x4fc
>>      Call Trace:
>>       note_page+0x4d8/0x4fc (unreliable)
>>       ptdump_pte_entry+0x70/0x94
>>       walk_pte_range_inner+0x15c/0x260
>>       walk_pgd_range+0x6d8/0xd5c
>>       walk_page_range_debug+0xa4/0xf0
>>       ptdump_walk_pgd+0xec/0x304
>>       ptdump_check_wx+0xd8/0x154
>>       kernel_init+0x94/0x26c
>>       ret_from_kernel_user_thread+0x14/0x1c
>>      Checked W+X mappings: FAILED, 1 W+X pages found
>> 
>> This happens because CHECK_WX noted a writeable + executable mapping.
>> 
>> This happens because execmem_arch_setup(), checks for
>> struct_modules_rwx_enabled(), while kprobes depenency on modules was
>> earlier removed via commit:
>>      7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
>> Since the insn slots are only written with patch_instruction(), which
>> does not need this mapping to be writable. This patch fixes it by
>> checking for strict_kernel_rwx_enabled() instead.
>> 
>> Fixes: 7582b7be16d0 ("kprobes: remove dependency on CONFIG_MODULES")
>> Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
>> ---
>>   arch/powerpc/mm/mem.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
>> index b617b69452cd..77b63b52d8f2 100644
>> --- a/arch/powerpc/mm/mem.c
>> +++ b/arch/powerpc/mm/mem.c
>> @@ -388,7 +388,7 @@ static void prealloc_execmem_pgtable(void) { }
>>   
>>   struct execmem_info __init *execmem_arch_setup(void)
>>   {
>> -	pgprot_t kprobes_prot = strict_module_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
>> +	pgprot_t kprobes_prot = strict_kernel_rwx_enabled() ? PAGE_KERNEL_ROX : PAGE_KERNEL_EXEC;
>>   	pgprot_t prot = strict_module_rwx_enabled() ? PAGE_KERNEL : PAGE_KERNEL_EXEC;
>
> Looking at this, I'd use PAGE_KERNEL_X instead of PAGE_KERNEL_EXEC.
>
> Then we could get rid of PAGE_KERNEL_EXEC completely for powerpc.
>

I think it's best if we keep the definition of PAGE_KERNEL_EXEC on
powerpc as PAGE_KERNEL_X, I think the core expects the arch to define
this, if not, then it defaults to PAGE_KERNEL e.g. see this:

include/linux/pgtable.h:
  #ifndef PAGE_KERNEL_EXEC
  # define PAGE_KERNEL_EXEC PAGE_KERNEL
  #endif

Also mm/execmem references PAGE_KERNEL_EXEC in __execmem_init().
Although it references only when execmem_arch_setup() is not defined by
the arch (which is not true for powerpc).


However, even though nothing breaks today, but later if there are other
users of PAGE_KERNEL_EXEC, then PAGE_KERNEL does not have X (execute) bit
enabled, so it might break in future. Plus looking at above, I believe
there is no harm in keeping it - since core expects the platform to
define it's own definition - due to all the other references it has.

Thoughts?

However, if you still think we should remove it (?) - then I feel let's
do that as a separate cleanup patch. Since this keeps the usage of EXEC
same between prot and kprobes_prot variables in patch-1, which we also
need to backport.


Thanks for the quick reviews!

-ritesh

