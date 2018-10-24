Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8FEC004D3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 15:02:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 079912075D
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 15:02:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 079912075D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42gD4R23G5zDrJ7
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Oct 2018 02:01:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.194; helo=mail-qk1-f194.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qk1-f194.google.com (mail-qk1-f194.google.com
 [209.85.222.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42gD206483zDrHb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Oct 2018 01:59:52 +1100 (AEDT)
Received: by mail-qk1-f194.google.com with SMTP id v68-v6so3488717qka.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 07:59:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:subject:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R/btjJ9L+b4/KVg2qa4DcULbA2t9s3gZD8Imc3CZV2k=;
 b=XIlxi3ArfSSwEZOoCJFD8c2Q1zhj9meu80GfhDE34uyR9SE5mjD4HTFHroNQf31kHz
 Ktt/RhC57yBIHWCLcSZuxwbX89sPcSAcV+xrItc/ENH3B3iYg1TJcj7DysQ831x7gz0h
 bUgCQu/A0MZjE9PEyA8/0cOZ+R86YzAAQoLulG3Kn0oD/aVgXSmHo37Y1D/N71BfdG8G
 HjOhk+ZUgWyx6xzvdMz7tJXINYMB7qqgGArsy9/8UJEG6wdF0WUyv5Oz39FYtiY1LAFP
 vLZcsYlTopcj6YOq7mdlMRKB1xGBm+QTIvRzU3qLQRc8HdPFMDoXyWthcBJSsLRKX3pM
 Gjmw==
X-Gm-Message-State: AGRZ1gIUvUV6yoyXC7mGHT0LlQ9R3Jt9p7SYD/LUalZjJddn2YhbPAQ/
 5F49/SvDyQhng20fsS4dCllb3l7W
X-Google-Smtp-Source: AJdET5d1TT0aZcSodzqU1Vqdum5OPKjzHPs5LvNPp0CmH5ouXC77ow7vWBYnWJwVnKIAV9gLH9ur3w==
X-Received: by 2002:a0c:aecb:: with SMTP id n11mr2682888qvd.151.1540393189443; 
 Wed, 24 Oct 2018 07:59:49 -0700 (PDT)
Received: from [10.0.0.11] ([177.83.210.7])
 by smtp.gmail.com with ESMTPSA id q66-v6sm2924638qke.43.2018.10.24.07.59.47
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Oct 2018 07:59:48 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH 3/9] powerpc/mm: Remove extern from function definition
To: LEROY Christophe <christophe.leroy@c-s.fr>
References: <1540220060-30162-1-git-send-email-leitao@debian.org>
 <1540220060-30162-3-git-send-email-leitao@debian.org>
 <20181023173828.Horde.uVbl4TiimFw-HLaYHTWqNw9@messagerie.si.c-s.fr>
Message-ID: <3bd3ed6e-3390-a80f-59f8-c1cc0efaa10f@debian.org>
Date: Wed, 24 Oct 2018 11:59:45 -0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181023173828.Horde.uVbl4TiimFw-HLaYHTWqNw9@messagerie.si.c-s.fr>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

hi Christophe,

On 10/23/2018 12:38 PM, LEROY Christophe wrote:
> Breno Leitao <leitao@debian.org> a écrit :
>>
>> This patch removes the keyword from the definition part, while keeps
>> it in
>> the declaration part.
> 
> I think checkpatch also says that extern should be avoided in declarations.

Thanks for the review. I tried to look at this complain, but I didn't see
this behavior on checkpatch.pl from kernel 4.19. I created a commit that adds
a new extern prototype and checked the patch. Take a look:

# git show

	commit 720cd4ee7bf3c0607eaea79e209b719bac79508e
	Author: Breno Leitao <leitao@debian.org>
	Date:   Wed Oct 24 10:31:54 2018 -0400

	powerpc/mm: New test function

	New test function.

	Signed-off-by: Breno Leitao <leitao@debian.org>

	diff --git a/arch/powerpc/include/asm/hugetlb.h
	b/arch/powerpc/include/asm/hugetlb.h
	index 2d00cc530083..4a348e42cab6 100644
	--- a/arch/powerpc/include/asm/hugetlb.h
	+++ b/arch/powerpc/include/asm/hugetlb.h
	@@ -167,6 +167,8 @@ extern int huge_ptep_set_access_flags(struct vm_area_struct *vma,
				      unsigned long addr, pte_t *ptep,
				      pte_t pte, int dirty);

	+extern int test(int foo);
	+
	static inline pte_t huge_ptep_get(pte_t *ptep)
	{
		return *ptep;

	diff --git a/mm/hugetlb.c b/mm/hugetlb.c
	index 5c390f5a5207..2e8f5f77f7f6 100644
	--- a/mm/hugetlb.c
	+++ b/mm/hugetlb.c
	@@ -3204,6 +3204,11 @@ static void set_huge_ptep_writable(struct
	vm_area_struct *vma,
		update_mmu_cache(vma, address, ptep);
	}

	+int test(int foo)
	+{
	+	return foo;
	+}
	+
	bool is_hugetlb_entry_migration(pte_t pte)
	{
	swp_entry_t swp;


# scripts/checkpatch.pl -g HEAD

	total: 0 errors, 0 warnings, 19 lines checked

	Commit 720cd4ee7bf3 ("powerpc/mm: New test function") has no obvious
	style problems and is ready for submission.
