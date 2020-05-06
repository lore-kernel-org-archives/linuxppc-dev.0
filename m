Return-Path: <SRS0=xicG=6U=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8357CC47247
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 01:00:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3D69206E6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 01:00:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="CfKgaMPw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3D69206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49Gytg6vyCzDqkG
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 11:00:11 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49Gyrt1X5czDqbY
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2020 10:58:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=CfKgaMPw; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49Gyrs6Rvnz9sNH;
 Wed,  6 May 2020 10:58:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1588726718;
 bh=LPwUPskRUylEnt488CUGD3+xVeRXzadcQSMeFeiwYhI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=CfKgaMPwihzGc88U25ozzKu6O2Qy0OYmccWV5l9GMUh9hMqBrlxrjTID4z5sbsyXY
 xW3QqGFhm4YvBeW383Fi2L8J9HTY04RauUThBqI2Ro4iVx/hhQFRc4ncwBoWM4lolA
 +FK5HpcgmZCs42ZtKvszFSgA00NCkSJu3ZXWS8+dbqjqLQBWMtGA8XZq6fRp13M9EA
 4zHVH35BlhfuZrah0k0u6JQNDE2k2ip06YhyHjN8zmf0yv6SVuX2IUexdbg+8lul5c
 mu0fB+JgGD9tGen59jolvNPewqvwcY3oyzQKHUqILkMx5H7aFq4001zHS7FjBWH3iH
 0rkclfFmAFjUg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH v4 1/2] powerpc/uaccess: Implement unsafe_put_user() using
 'asm goto'
In-Reply-To: <20200505153245.GN31009@gate.crashing.org>
References: <23e680624680a9a5405f4b88740d2596d4b17c26.1587143308.git.christophe.leroy@c-s.fr>
 <87sggecv81.fsf@mpe.ellerman.id.au>
 <20200505153245.GN31009@gate.crashing.org>
Date: Wed, 06 May 2020 10:58:55 +1000
Message-ID: <87pnbhdgkw.fsf@mpe.ellerman.id.au>
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
Cc: linux-kernel@vger.kernel.org, npiggin@gmail.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Segher Boessenkool <segher@kernel.crashing.org> writes:
> Hi!
>
> On Wed, May 06, 2020 at 12:27:58AM +1000, Michael Ellerman wrote:
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>> > unsafe_put_user() is designed to take benefit of 'asm goto'.
>> >
>> > Instead of using the standard __put_user() approach and branch
>> > based on the returned error, use 'asm goto' and make the
>> > exception code branch directly to the error label. There is
>> > no code anymore in the fixup section.
>> >
>> > This change significantly simplifies functions using
>> > unsafe_put_user()
>> >
>> ...
>> >
>> > Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>> > ---
>> >  arch/powerpc/include/asm/uaccess.h | 61 +++++++++++++++++++++++++-----
>> >  1 file changed, 52 insertions(+), 9 deletions(-)
>> >
>> > diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
>> > index 9cc9c106ae2a..9365b59495a2 100644
>> > --- a/arch/powerpc/include/asm/uaccess.h
>> > +++ b/arch/powerpc/include/asm/uaccess.h
>> > @@ -196,6 +193,52 @@ do {								\
>> >  })
>> >  
>> >  
>> > +#define __put_user_asm_goto(x, addr, label, op)			\
>> > +	asm volatile goto(					\
>> > +		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
>> > +		EX_TABLE(1b, %l2)				\
>> > +		:						\
>> > +		: "r" (x), "m<>" (*addr)				\
>> 
>> The "m<>" here is breaking GCC 4.6.3, which we allegedly still support.
>
> [ You shouldn't use 4.6.3, there has been 4.6.4 since a while.  And 4.6
>   is nine years old now.  Most projects do not support < 4.8 anymore, on
>   any architecture.  ]

Moving up to 4.6.4 wouldn't actually help with this though would it?

Also I have 4.6.3 compilers already built, I don't really have time to
rebuild them for 4.6.4.

The kernel has a top-level minimum version, which I'm not in charge of, see:

https://www.kernel.org/doc/html/latest/process/changes.html?highlight=gcc


There were discussions about making 4.8 the minimum, but I'm not sure
where they got to.

>> Plain "m" works, how much does the "<>" affect code gen in practice?
>> 
>> A quick diff here shows no difference from removing "<>".
>
> It will make it impossible to use update-form instructions here.  That
> probably does not matter much at all, in this case.
>
> If you remove the "<>" constraints, also remove the "%Un" output modifier?

So like this?

diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
index 62cc8d7640ec..ca847aed8e45 100644
--- a/arch/powerpc/include/asm/uaccess.h
+++ b/arch/powerpc/include/asm/uaccess.h
@@ -207,10 +207,10 @@ do {								\
 
 #define __put_user_asm_goto(x, addr, label, op)			\
 	asm volatile goto(					\
-		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
+		"1:	" op "%X1 %0,%1	# put_user\n"		\
 		EX_TABLE(1b, %l2)				\
 		:						\
-		: "r" (x), "m<>" (*addr)				\
+		: "r" (x), "m" (*addr)				\
 		:						\
 		: label)
 


cheers
