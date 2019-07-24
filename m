Return-Path: <SRS0=ex+5=VV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 484B9C7618B
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jul 2019 14:11:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9E6120651
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Jul 2019 14:11:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9E6120651
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45ty1w1LxzzDqLn
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Jul 2019 00:11:16 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45txws0q5szDqMf
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Jul 2019 00:06:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 45txwr5QHsz9sMr; Thu, 25 Jul 2019 00:06:52 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45txwr1qBbz9sML;
 Thu, 25 Jul 2019 00:06:52 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christian Brauner <christian@brauner.io>
Subject: Re: [PATCH] powerpc: Wire up clone3 syscall
In-Reply-To: <20190722133701.g3w5g4crogqb7oi5@brauner.io>
References: <20190722132231.10169-1-mpe@ellerman.id.au>
 <20190722133701.g3w5g4crogqb7oi5@brauner.io>
Date: Thu, 25 Jul 2019 00:06:50 +1000
Message-ID: <87imrr5xxh.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christian Brauner <christian@brauner.io> writes:
> On Mon, Jul 22, 2019 at 11:22:31PM +1000, Michael Ellerman wrote:
>> Wire up the new clone3 syscall added in commit 7f192e3cd316 ("fork:
>> add clone3").
>> 
>> This requires a ppc_clone3 wrapper, in order to save the non-volatile
>> GPRs before calling into the generic syscall code. Otherwise we hit
>> the BUG_ON in CHECK_FULL_REGS in copy_thread().
>> 
>> Lightly tested using Christian's test code on a Power8 LE VM.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Thank you, Michael!
>
> One comment below, otherwise:
>
> Acked-by: Christian Brauner <christian@brauner.io>

Thanks.

...
>> diff --git a/arch/powerpc/kernel/syscalls/syscall.tbl b/arch/powerpc/kernel/syscalls/syscall.tbl
>> index f2c3bda2d39f..6886ecb590d5 100644
>> --- a/arch/powerpc/kernel/syscalls/syscall.tbl
>> +++ b/arch/powerpc/kernel/syscalls/syscall.tbl
>> @@ -516,3 +516,4 @@
>>  432	common	fsmount				sys_fsmount
>>  433	common	fspick				sys_fspick
>>  434	common	pidfd_open			sys_pidfd_open
>> +435	common	clone3				ppc_clone3
>
> Note that in v5.3-rc1 there's now a comment that 435 is reserved in
> there. So this will likely cause a merge conflict. You might want to
> base your change off of v5.3-rc1 instead to avoid that. :)

Thanks for the heads-up.

My fixes branch is already based off pre-rc1, and in general Linus can
handle a trivial merge conflict like that.

But given I had to send a v2 to fix the 32-bit build (doh!), I'll move
my fixes up past rc1 once Linus has merged what's in there now, and then
do this patch based on top of rc1, so there'll be no conflict.

cheers
