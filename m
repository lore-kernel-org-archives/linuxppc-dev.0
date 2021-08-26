Return-Path: <SRS0=FZqe=NR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A65BC432BE
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Aug 2021 13:51:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56D5261038
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Aug 2021 13:51:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 56D5261038
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GwPQp5V33z2ynx
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Aug 2021 23:51:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4GwPQN1JMWz2yP5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Aug 2021 23:51:23 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 17QDlx1Q018576;
 Thu, 26 Aug 2021 08:47:59 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 17QDlwDa018574;
 Thu, 26 Aug 2021 08:47:58 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 26 Aug 2021 08:47:58 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v2 2/2] powerpc/bug: Provide better flexibility to
 WARN_ON/__WARN_FLAGS() with asm goto
Message-ID: <20210826134758.GZ1583@gate.crashing.org>
References: <b286e07fb771a664b631cd07a40b09c06f26e64b.1618331881.git.christophe.leroy@csgroup.eu>
 <389962b1b702e3c78d169e59bcfac56282889173.1618331882.git.christophe.leroy@csgroup.eu>
 <YSa1O4fcX1nNKqN/@Ryzen-9-3900X.localdomain>
 <87h7fcc2m4.fsf@mpe.ellerman.id.au>
 <3fad8702-278a-d9f9-1882-6958ce570bcc@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3fad8702-278a-d9f9-1882-6958ce570bcc@csgroup.eu>
User-Agent: Mutt/1.4.2.3i
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
Cc: llvm@lists.linux.dev, linux-kernel@vger.kernel.org,
 Nathan Chancellor <nathan@kernel.org>, clang-built-linux@googlegroups.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Aug 26, 2021 at 08:37:09AM +0200, Christophe Leroy wrote:
> Le 26/08/2021 à 05:21, Michael Ellerman a écrit :
> >This patch seems to fix it. Not sure if that's just papering over it 
> >though.
> >
> >diff --git a/arch/powerpc/include/asm/bug.h 
> >b/arch/powerpc/include/asm/bug.h
> >index 1ee0f22313ee..75fcb4370d96 100644
> >--- a/arch/powerpc/include/asm/bug.h
> >+++ b/arch/powerpc/include/asm/bug.h
> >@@ -119,7 +119,7 @@ __label_warn_on:					 \
> >  								\
> >  			WARN_ENTRY(PPC_TLNEI " %4, 0",		\
> >  				   BUGFLAG_WARNING | 
> >  				   BUGFLAG_TAINT(TAINT_WARN),	\
> >-				   __label_warn_on, "r" (x));	\
> >+				   __label_warn_on, "r" (!!(x))); \
> >  			break;					\
> >  __label_warn_on:						\
> >  			__ret_warn_on = true;			\
> 
> But for a simple WARN_ON() call:
> 
> void test(unsigned long b)
> {
> 	WARN_ON(b);
> }
> 
> Without your change with GCC you get:
> 
> 00000000000012d0 <.test>:
>     12d0:	0b 03 00 00 	tdnei   r3,0
>     12d4:	4e 80 00 20 	blr
> 
> 
> With the !! change you get:
> 
> 00000000000012d0 <.test>:
>     12d0:	31 23 ff ff 	addic   r9,r3,-1
>     12d4:	7d 29 19 10 	subfe   r9,r9,r3
>     12d8:	0b 09 00 00 	tdnei   r9,0
>     12dc:	4e 80 00 20 	blr

That is because the asm (unlike the builtin) cannot be optimised by the
compiler.


Segher
