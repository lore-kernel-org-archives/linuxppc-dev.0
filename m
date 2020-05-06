Return-Path: <SRS0=xicG=6U=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D12DC28CBC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 18:33:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8812206D5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 18:33:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8812206D5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49HQFY03JqzDqvx
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 May 2020 04:33:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 49HPVJ2QSwzDr9v
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 May 2020 03:59:03 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 046HwoSC014327;
 Wed, 6 May 2020 12:58:50 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 046HwnT3014321;
 Wed, 6 May 2020 12:58:49 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Wed, 6 May 2020 12:58:49 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 1/2] powerpc/uaccess: Implement unsafe_put_user() using
 'asm goto'
Message-ID: <20200506175849.GT31009@gate.crashing.org>
References: <23e680624680a9a5405f4b88740d2596d4b17c26.1587143308.git.christophe.leroy@c-s.fr>
 <87sggecv81.fsf@mpe.ellerman.id.au>
 <20200505153245.GN31009@gate.crashing.org>
 <87pnbhdgkw.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87pnbhdgkw.fsf@mpe.ellerman.id.au>
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
Cc: linux-kernel@vger.kernel.org, npiggin@gmail.com,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, May 06, 2020 at 10:58:55AM +1000, Michael Ellerman wrote:
> >> The "m<>" here is breaking GCC 4.6.3, which we allegedly still support.
> >
> > [ You shouldn't use 4.6.3, there has been 4.6.4 since a while.  And 4.6
> >   is nine years old now.  Most projects do not support < 4.8 anymore, on
> >   any architecture.  ]
> 
> Moving up to 4.6.4 wouldn't actually help with this though would it?

Nope.  But 4.6.4 is a bug-fix release, 91 bugs fixed since 4.6.3, so you
should switch to it if you can :-)

> Also I have 4.6.3 compilers already built, I don't really have time to
> rebuild them for 4.6.4.
> 
> The kernel has a top-level minimum version, which I'm not in charge of, see:
> 
> https://www.kernel.org/doc/html/latest/process/changes.html?highlight=gcc

Yes, I know.  And it is much preferred not to have stricter requirements
for Power, I know that too.  Something has to give though :-/

> There were discussions about making 4.8 the minimum, but I'm not sure
> where they got to.

Yeah, just petered out I think?

All significant distros come with a 4.8 as system compiler.

> >> Plain "m" works, how much does the "<>" affect code gen in practice?
> >> 
> >> A quick diff here shows no difference from removing "<>".
> >
> > It will make it impossible to use update-form instructions here.  That
> > probably does not matter much at all, in this case.
> >
> > If you remove the "<>" constraints, also remove the "%Un" output modifier?
> 
> So like this?
> 
> diff --git a/arch/powerpc/include/asm/uaccess.h b/arch/powerpc/include/asm/uaccess.h
> index 62cc8d7640ec..ca847aed8e45 100644
> --- a/arch/powerpc/include/asm/uaccess.h
> +++ b/arch/powerpc/include/asm/uaccess.h
> @@ -207,10 +207,10 @@ do {								\
>  
>  #define __put_user_asm_goto(x, addr, label, op)			\
>  	asm volatile goto(					\
> -		"1:	" op "%U1%X1 %0,%1	# put_user\n"	\
> +		"1:	" op "%X1 %0,%1	# put_user\n"		\
>  		EX_TABLE(1b, %l2)				\
>  		:						\
> -		: "r" (x), "m<>" (*addr)				\
> +		: "r" (x), "m" (*addr)				\
>  		:						\
>  		: label)

Like that.  But you will have to do that to *all* places we use the "<>"
constraints, or wait for more stuff to fail?  And, there probably are
places we *do* want update form insns used (they do help in some loops,
for example)?


Segher
