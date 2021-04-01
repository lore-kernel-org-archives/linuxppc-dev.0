Return-Path: <SRS0=m4lh=I6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B05C433B4
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 09:53:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EA39761056
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 09:53:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EA39761056
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F9z6D1fK3z304X
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Apr 2021 20:53:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20161025 header.b=HAt0FUlX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430;
 helo=mail-pf1-x430.google.com; envelope-from=npiggin@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=HAt0FUlX; dkim-atps=neutral
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com
 [IPv6:2607:f8b0:4864:20::430])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F9z5n1K2Cz301L
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Apr 2021 20:53:31 +1100 (AEDT)
Received: by mail-pf1-x430.google.com with SMTP id 11so1072558pfn.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Apr 2021 02:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:subject:to:cc:references:in-reply-to:mime-version
 :message-id:content-transfer-encoding;
 bh=F4k3xltC/mdSm/joM9oLpm2TwHoO0oN2DqAFlf1TJDM=;
 b=HAt0FUlXreQHPqvvmqmfz8BJ0iDeU+/1hovAiob8HxWZDxwRSBR8b2HBUQ+JM29+ja
 r/JMZ4JH/lI1zrRHX+zJc5EK++ITEGUwo077AZmYLIY8UZB8nA1pM7EpdEa3bHFLK8WP
 LtnxGgPL5OL1o69ZapT7VZTVURaqDEj5tZSXIazgFtGg7S5TM3iL8KBB0aipCBRRPwzv
 OpXdOjorrfY0AK3Qo5zGgGF+NdOe8qjx0Fr06SEW1Mbmem7vRmwuL+MmFPMrLVyS4bzU
 Id6XflW8BveQXLjv3cpjFHznAS6QMiESZABrLmxeD1cJI9SVLNTUzugXGAfLZ5NfHD26
 TbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
 :mime-version:message-id:content-transfer-encoding;
 bh=F4k3xltC/mdSm/joM9oLpm2TwHoO0oN2DqAFlf1TJDM=;
 b=iwh8sZxTwOZjGlW09/sDqB+n8EfBhUezg4EBkH0seyjpGsFZtiEhvP3mh+UigamdZu
 g/tyAxCk+jguxHKUPw1fuCGrZwLBFkRhhZMLE7qz6YgMpVevVvjP1lG1fS/G0gnsmJv5
 vnaxyESVyxUDg9I4SmDZZ3x0fYa5c5yfDOlGSXwimasMIMRaZ3x7Xsl5YDzS5CeXv7tG
 45GQJYdAWD9Dt09yp2OG8oPYiw46kdvzk7g2bY91vR/fDJZ6Yxkjic6aUGd2HkD/bn2B
 xZr/L91RmwrAnCdxTSTDbpD0ErzRFPFfC2yb3NUDEJQNfO/r1uhSUalI5IZtimvD1hwR
 QCIA==
X-Gm-Message-State: AOAM532czZz31PljzGqPog7oJG9zvGnclCWsOdvon4iAlCJYrUEyyFeR
 Eh56Li3RTYkAhZnPe12StYA=
X-Google-Smtp-Source: ABdhPJzR8DjIT+RPNAptiXqmIPQZZw3Cz1vI7wkbRy9K7DqINSFVZ2CtCEvmM9f6qJIJWOT/mhKUOw==
X-Received: by 2002:a05:6a00:cc7:b029:203:6bc9:3edf with SMTP id
 b7-20020a056a000cc7b02902036bc93edfmr6736719pfv.23.1617270808940; 
 Thu, 01 Apr 2021 02:53:28 -0700 (PDT)
Received: from localhost ([1.128.222.7])
 by smtp.gmail.com with ESMTPSA id gb1sm5004177pjb.21.2021.04.01.02.53.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Apr 2021 02:53:28 -0700 (PDT)
Date: Thu, 01 Apr 2021 19:53:23 +1000
From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 13/46] KVM: PPC: Book3S 64: Move GUEST_MODE_SKIP test
 into KVM
To: Paul Mackerras <paulus@ozlabs.org>
References: <20210323010305.1045293-1-npiggin@gmail.com>
 <20210323010305.1045293-14-npiggin@gmail.com>
 <YGVbApPydgwAU8cP@thinks.paulus.ozlabs.org>
In-Reply-To: <YGVbApPydgwAU8cP@thinks.paulus.ozlabs.org>
MIME-Version: 1.0
Message-Id: <1617270768.urf3tmz6b4.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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
Cc: Fabiano Rosas <farosas@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Excerpts from Paul Mackerras's message of April 1, 2021 3:32 pm:
> On Tue, Mar 23, 2021 at 11:02:32AM +1000, Nicholas Piggin wrote:
>> Move the GUEST_MODE_SKIP logic into KVM code. This is quite a KVM
>> internal detail that has no real need to be in common handlers.
>>=20
>> Also add a comment explaining why this thing exists.
>=20
> [snip]
>=20
>> diff --git a/arch/powerpc/kvm/book3s_64_entry.S b/arch/powerpc/kvm/book3=
s_64_entry.S
>> index 7a039ea78f15..a5412e24cc05 100644
>> --- a/arch/powerpc/kvm/book3s_64_entry.S
>> +++ b/arch/powerpc/kvm/book3s_64_entry.S
>> @@ -1,6 +1,7 @@
>>  /* SPDX-License-Identifier: GPL-2.0-only */
>>  #include <asm/asm-offsets.h>
>>  #include <asm/cache.h>
>> +#include <asm/exception-64s.h>
>>  #include <asm/kvm_asm.h>
>>  #include <asm/kvm_book3s_asm.h>
>>  #include <asm/ppc_asm.h>
>> @@ -20,9 +21,12 @@ kvmppc_interrupt:
>>  	 * guest R12 saved in shadow VCPU SCRATCH0
>>  	 * guest R13 saved in SPRN_SCRATCH0
>>  	 */
>> -#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>>  	std	r9,HSTATE_SCRATCH2(r13)
>>  	lbz	r9,HSTATE_IN_GUEST(r13)
>> +	cmpwi	r9,KVM_GUEST_MODE_SKIP
>> +	beq-	.Lmaybe_skip
>> +.Lno_skip:
>> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>>  	cmpwi	r9,KVM_GUEST_MODE_HOST_HV
>>  	beq	kvmppc_bad_host_intr
>>  #ifdef CONFIG_KVM_BOOK3S_PR_POSSIBLE
>> @@ -34,3 +38,48 @@ kvmppc_interrupt:
>>  #else
>>  	b	kvmppc_interrupt_pr
>>  #endif
>=20
> It's a bit hard to see without more context, but I think that in the
> PR-only case (CONFIG_KVM_BOOK3S_HV_POSSIBLE undefined), this will
> corrupt R9.  You need to restore R9 before the unconditional branch to
> kvmppc_interrupt_pr.  (I realize this code gets modified further, but
> I'd rather not break bisection.)

Very good catch, thanks.

Thanks,
Nick
