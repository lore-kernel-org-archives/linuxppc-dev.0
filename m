Return-Path: <SRS0=k2O5=MV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24D2DC64EAD
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 10:39:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 966BC21479
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 10:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966BC21479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Ttym3fLCzF35n
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Oct 2018 21:39:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42TtwQ3kqgzF384
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Oct 2018 21:37:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42TtwQ383qz9s8F; Tue,  9 Oct 2018 21:37:42 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42TtwQ15wGz9s89;
 Tue,  9 Oct 2018 21:37:42 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc: Fix HMIs on big-endian with CONFIG_RELOCATABLE=y
In-Reply-To: <898c4d47e80562b843fcf4c7ba03eb6f4c9c5d5b.camel@kernel.crashing.org>
References: <e4bfa53ea8c777105359e1770df906909dde2c57.camel@kernel.crashing.org>
 <20181008170435.0ef2d573@roar.ozlabs.ibm.com>
 <898c4d47e80562b843fcf4c7ba03eb6f4c9c5d5b.camel@kernel.crashing.org>
Date: Tue, 09 Oct 2018 21:37:41 +1100
Message-ID: <87tvlv1k3u.fsf@concordia.ellerman.id.au>
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

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> On Mon, 2018-10-08 at 17:04 +1000, Nicholas Piggin wrote:
>> On Mon, 08 Oct 2018 15:08:31 +1100
>> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>> 
>> > HMIs will crash the kernel due to
>> > 
>> > 	BRANCH_LINK_TO_FAR(hmi_exception_realmode)
>> > 
>> > Calling into the OPD instead of the actual code.
>> > 
>> > Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> > ---
>> > 
>> > This hack fixes it for me, but it's not great. Nick, any better idea ?
>> 
>> Is it a hack because the ifdef gunk, or because there's something
>> deeper wrong with using the .sym?
>
> I'd say ifdef gunk, also the KVM use doesn't need it bcs the kvm entry
> isn't an OPD.
>
>> I guess all those handlers that load label address by hand could have
>> the bug silently creep in. Can we have them use the DOTSYM() macro?
>
> The KVM one doesnt have a dotsym does it ?
>
> Also should we load the TOC from the OPD ?

Technically yes. But I thought because we build with mcmodel=medium
we'll never actually get multiple TOCs in the kernel itself, so it
doesn't actually matter.

So this seems to work for now:

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 301a6a86a20f..e5566e248a02 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1149,7 +1149,7 @@ TRAMP_REAL_BEGIN(hmi_exception_early)
 	EXCEPTION_PROLOG_COMMON_2(PACA_EXGEN)
 	EXCEPTION_PROLOG_COMMON_3(0xe60)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	BRANCH_LINK_TO_FAR(hmi_exception_realmode) /* Function call ABI */
+	BRANCH_LINK_TO_FAR(DOTSYM(hmi_exception_realmode)) /* Function call ABI */
 	cmpdi	cr0,r3,0
 
 	/* Windup the stack. */


cheers
