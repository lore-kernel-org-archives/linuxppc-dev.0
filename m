Return-Path: <SRS0=3K4h=OM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64514C04EB9
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 23:32:47 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F3A7520851
	for <linuxppc-dev@archiver.kernel.org>; Mon,  3 Dec 2018 23:32:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F3A7520851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4381WH6V2TzDqrj
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 10:32:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4381RJ4N8XzDqnK
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Dec 2018 10:29:16 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wB3NT4VO026917;
 Mon, 3 Dec 2018 17:29:04 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id wB3NT2KB026905;
 Mon, 3 Dec 2018 17:29:02 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 3 Dec 2018 17:29:01 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v3] powerpc/math-emu: Update macros from GCC
Message-ID: <20181203232901.GC3803@gate.crashing.org>
References: <20181203230746.27196-1-joel@jms.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181203230746.27196-1-joel@jms.id.au>
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
Cc: Nick Desaulniers <ndesaulniers@google.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Dec 04, 2018 at 09:37:46AM +1030, Joel Stanley wrote:
> The add_ssaaaa, sub_ddmmss, umul_ppmm and udiv_qrnnd macros originate
> from GCC's longlong.h which in turn was copied from GMP's longlong.h a
> few decades ago.
> 
> This was found when compiling with clang:
> 
>    arch/powerpc/math-emu/fnmsub.c:46:2: error: invalid use of a cast in a
>    inline asm context requiring an l-value: remove the cast or build with
>    -fheinous-gnu-extensions
>            FP_ADD_D(R, T, B);
>            ^~~~~~~~~~~~~~~~~
>    ...
> 
>    ./arch/powerpc/include/asm/sfp-machine.h:283:27: note: expanded from
>    macro 'sub_ddmmss'
>                   : "=r" ((USItype)(sh)),                                  \
>                           ~~~~~~~~~~^~~
> 
> Segher points out: this was fixed in GCC over 16 years ago
> ( https://gcc.gnu.org/r56600 ), and in GMP (where it comes from)
> presumably before that.
> 
> Update the add_ssaaaa, sub_ddmmss, umul_ppmm and udiv_qrnnd macros to
> the latest GCC version in order to git rid of the invalid casts. These
> were taken as-is from GCC's longlong in order to make future syncs
> obvious. Other parts of sfp-machine.h were left as-is as the file
> contains more features than present in longlong.h.
> 
> Link: https://github.com/ClangBuiltLinux/linux/issues/260
> Signed-off-by: Joel Stanley <joel@jms.id.au>

This looks fine, thanks!

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
