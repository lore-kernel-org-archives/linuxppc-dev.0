Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2919BC04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 12:12:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC7A22083C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 12:12:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC7A22083C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YckY4Sp2zDqmj
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 23:12:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YcWJ5ZXCzF3Nw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 23:02:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42YcWJ4cpmz9sDJ; Mon, 15 Oct 2018 23:02:20 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42YcWJ2sRmz9sBq;
 Mon, 15 Oct 2018 23:02:20 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 1/3] powerpc: Split user/kernel definitions of struct
 pt_regs
In-Reply-To: <20181013222756.2e9ca459@roar.ozlabs.ibm.com>
References: <20181013105646.5147-1-mpe@ellerman.id.au>
 <20181013222756.2e9ca459@roar.ozlabs.ibm.com>
Date: Mon, 15 Oct 2018 23:02:19 +1100
Message-ID: <87pnwbzad0.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nicholas Piggin <npiggin@gmail.com> writes:
> On Sat, 13 Oct 2018 21:56:44 +1100
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> We use a shared definition for struct pt_regs in uapi/asm/ptrace.h.
>> That means the layout of the structure is ABI, ie. we can't change it.
>> 
>> That would be fine if it was only used to describe the user-visible
>> register state of a process, but it's also the struct we use in the
>> kernel to describe the registers saved in an interrupt frame.
>> 
>> We'd like more flexibility in the content (and possibly layout) of the
>> kernel version of the struct, but currently that's not possible.
>> 
>> So split the definition into a user-visible definition which remains
>> unchanged, and a kernel internal one.
>> 
>> At the moment they're still identical, and we check that at build
>> time. That's because we have code (in ptrace etc.) that assumes that
>> they are the same. We will fix that code in future patches, and then
>> we can break the strict symmetry between the two structs.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Yeah this looks much better than my int_frame thing, thanks.

Thanks. More bug prone to :)

But hopefully it will pay off in the long run.

cheers
