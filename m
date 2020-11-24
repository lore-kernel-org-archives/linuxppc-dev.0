Return-Path: <SRS0=+0eX=E6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92681C2D0E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 03:45:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D30C20857
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 03:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="X2Hov7WR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D30C20857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Cg90g5nVBzDqRL
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Nov 2020 14:45:55 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Cg8yW3VZkzDqQN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2020 14:44:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=X2Hov7WR; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Cg8yV6Rx8z9sRR;
 Tue, 24 Nov 2020 14:44:02 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1606189443;
 bh=3Gua/YhyqUI9nbF8lT6z3GSuabSiZjYuq56B8I/qSw0=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=X2Hov7WRadHpAL8SPRpp1vKYJu4vIsUOOkHP+sEOpwyWf3lUh9/qV/nyMO2Ga/CQ5
 IXUoys8LaffyM2BwwKIHzW4CFjnvzxxmD/9ZDd74oKqodmhVsyelspIBw5th8+3uYd
 1DjXuY+l3EGX9UgIeSifRHySPBbh+cvVTbpmQoRbEJ368rcbFZNlyyaFlvikgBUk1W
 YqYAdiGGmu2tp59BSfTy/TXGMYkO6X9iUD3ezyvmDbpaF1scJ0rHjkReFMyBs7ybWq
 xK3JGmgc6gzzRqKez0rf7KIyo5CuXBBl949+evJ2ns8SJKqZWZQ3BkpHM1Lj2uibdS
 ZGoLjg3HhxgXA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Bill Wendling <morbo@google.com>,
 Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v3 3/3] powerpc/64s: feature: Work around inline asm issues
In-Reply-To: <CAGG=3QUeXTU+8jqw40W_rhatsHCRiuTboL3enz9bpt_jaJC3TA@mail.gmail.com>
References: <20201118223513.2704722-1-morbo@google.com>
 <20201120224034.191382-1-morbo@google.com>
 <20201120224034.191382-4-morbo@google.com>
 <87d0041vaf.fsf@mpe.ellerman.id.au> <20201123063432.GG2672@gate.crashing.org>
 <CAGG=3QVjSAwU+ebvH=Lk5YVMxW7=ThvkJXGPw+95nYxxuurMig@mail.gmail.com>
 <20201123195622.GI2672@gate.crashing.org>
 <CAGG=3QXR=Yfh8PNa4m-kQLTBP4YKD8OGm_6fSUgeasQ1ar9b2g@mail.gmail.com>
 <20201123200846.GJ2672@gate.crashing.org>
 <CAGG=3QUeXTU+8jqw40W_rhatsHCRiuTboL3enz9bpt_jaJC3TA@mail.gmail.com>
Date: Tue, 24 Nov 2020 14:43:59 +1100
Message-ID: <87zh37zaf4.fsf@mpe.ellerman.id.au>
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
Cc: Nick Desaulniers <ndesaulniers@google.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Bill Wendling <morbo@google.com> writes:
> On Mon, Nov 23, 2020 at 12:10 PM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
>> On Mon, Nov 23, 2020 at 12:01:01PM -0800, Bill Wendling wrote:
>> > On Mon, Nov 23, 2020 at 11:58 AM Segher Boessenkool
>> > <segher@kernel.crashing.org> wrote:
>> > > > On Sun, Nov 22, 2020 at 10:36 PM Segher Boessenkool
>> > > > <segher@kernel.crashing.org> wrote:
>> > > > > "true" (as a result of a comparison) in as is -1, not 1.
>> > >
>> > > On Mon, Nov 23, 2020 at 11:43:11AM -0800, Bill Wendling wrote:
>> > > > What Segher said. :-) Also, if you reverse the comparison, you'll get
>> > > > a build error.
>> > >
>> > > But that means your patch is the wrong way around?
>> > >
>> > > -       .ifgt (label##4b- label##3b)-(label##2b- label##1b);    \
>> > > -       .error "Feature section else case larger than body";    \
>> > > -       .endif;                                                 \
>> > > +       .org . - ((label##4b-label##3b) > (label##2b-label##1b)); \
>> > >
>> > > It should be a + in that last line, not a -.
>> >
>> > I said so in a follow up email.
>>
>> Yeah, and that arrived a second after I pressed "send" :-)
>>
> Michael, I apologize for the churn with these patches. I believe the
> policy is to resend the match as "v4", correct?
>
> I ran tests with the change above. It compiled with no error. If I
> switch the labels around to ".org . + ((label##2b-label##1b) >
> (label##4b-label##3b))", then it fails as expected.

I wanted to retain the nicer error reporting for gcc builds, so I did it
like this:

diff --git a/arch/powerpc/include/asm/feature-fixups.h b/arch/powerpc/include/asm/feature-fixups.h
index b0af97add751..c4ad33074df5 100644
--- a/arch/powerpc/include/asm/feature-fixups.h
+++ b/arch/powerpc/include/asm/feature-fixups.h
@@ -36,6 +36,24 @@ label##2:						\
 	.align 2;					\
 label##3:
 
+
+#ifndef CONFIG_CC_IS_CLANG
+#define CHECK_ALT_SIZE(else_size, body_size)			\
+	.ifgt (else_size) - (body_size);			\
+	.error "Feature section else case larger than body";	\
+	.endif;
+#else
+/*
+ * If we use the ifgt syntax above, clang's assembler complains about the
+ * expression being non-absolute when the code appears in an inline assembly
+ * statement.
+ * As a workaround use an .org directive that has no effect if the else case
+ * instructions are smaller than the body, but fails otherwise.
+ */
+#define CHECK_ALT_SIZE(else_size, body_size)			\
+	.org . + ((else_size) > (body_size));
+#endif
+
 #define MAKE_FTR_SECTION_ENTRY(msk, val, label, sect)		\
 label##4:							\
 	.popsection;						\
@@ -48,9 +66,7 @@ label##5:							\
 	FTR_ENTRY_OFFSET label##2b-label##5b;			\
 	FTR_ENTRY_OFFSET label##3b-label##5b;			\
 	FTR_ENTRY_OFFSET label##4b-label##5b;			\
-	.ifgt (label##4b- label##3b)-(label##2b- label##1b);	\
-	.error "Feature section else case larger than body";	\
-	.endif;							\
+	CHECK_ALT_SIZE((label##4b-label##3b), (label##2b-label##1b)); \
 	.popsection;
 
 

I've pushed a branch with all your patches applied to:

  https://github.com/linuxppc/linux/commits/next-test


Are you able to give that a quick test? It builds clean with clang for
me, but we must be using different versions of clang because my branch
already builds clean for me even without your patches.

cheers
