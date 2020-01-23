Return-Path: <SRS0=YyhJ=3M=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2004C2D0DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jan 2020 12:35:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29CB124655
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jan 2020 12:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="XcDFF1F6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29CB124655
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 483MDm6W1yzDqTT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 23 Jan 2020 23:35:20 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 483M7s0cgkzDqRg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jan 2020 23:31:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=XcDFF1F6; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 483M7r0bhgz9sSH;
 Thu, 23 Jan 2020 23:31:04 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1579782664;
 bh=vvHlt/x8yUKYf+nz2OV13dtkaSiK0JSgmAVt6B2ldwU=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=XcDFF1F6y3fTk8tq1K8XQWrclXCC3LBJX5o7RCzFiNdgBW2TQ0S3QmB9AqGLHxrk9
 2Mjirn0e1OnxQ5oedT0kG1SYJZFPYdacZ+mU4aUSTRZ7ULER+33hVi1FDJtisTetC0
 s8ix3OdHy+NqsDBBHVmqpZR+YphcDFOhfMy5xUR7Tn2x0cjHgrWbJicQyEKzSYKM68
 IW6GqA06/2gL7IrO6MWwCd/B9NVeCAWgmJnZfOZaEm1HK+sqo1LBQZQY8XNNGL8dky
 TVM9IaaQC1iIxowbHFjZdKrpwL297gUB5DF+isxN3rcEMAIkgADPk4M3Q1ZqGGnWED
 TvCrztQ+nOF/A==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v2 6/6] powerpc: Implement user_access_begin and friends
In-Reply-To: <87iml2idi9.fsf@mpe.ellerman.id.au>
References: <12a4be679e43de1eca6e5e2173163f27e2f25236.1579715466.git.christophe.leroy@c-s.fr>
 <2a20d19776faba4d85dbe51ae00a5f6ac5ac0969.1579715466.git.christophe.leroy@c-s.fr>
 <87iml2idi9.fsf@mpe.ellerman.id.au>
Date: Thu, 23 Jan 2020 23:31:03 +1100
Message-ID: <87ftg6icc8.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Michael Ellerman <mpe@ellerman.id.au> writes:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> Today, when a function like strncpy_from_user() is called,
>> the userspace access protection is de-activated and re-activated
>> for every word read.
>>
>> By implementing user_access_begin and friends, the protection
>> is de-activated at the beginning of the copy and re-activated at the
>> end.
>>
>> Implement user_access_begin(), user_access_end() and
>> unsafe_get_user(), unsafe_put_user() and unsafe_copy_to_user()
>>
>> For the time being, we keep user_access_save() and
>> user_access_restore() as nops.
>
> That means we will run with user access enabled in a few more places, but
> it's only used sparingly AFAICS:
>
>   kernel/trace/trace_branch.c:    unsigned long flags = user_access_save();
>   lib/ubsan.c:    unsigned long flags = user_access_save();
>   lib/ubsan.c:    unsigned long ua_flags = user_access_save();
>   mm/kasan/common.c:      unsigned long flags = user_access_save();
>
> And we don't have objtool checking that user access enablement isn't
> leaking in the first place, so I guess it's OK for us not to implement
> these to begin with?

It looks like we can implement them on on all three KUAP
implementations.

For radix and 8xx we just return/set the relevant SPR.

For book3s/32/kup.h I think we'd just need to add a KUAP_CURRENT case to
allow_user_access()?

cheers
