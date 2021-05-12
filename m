Return-Path: <SRS0=OS5J=KH=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E72C433ED
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 May 2021 14:34:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F27A61411
	for <linuxppc-dev@archiver.kernel.org>; Wed, 12 May 2021 14:33:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F27A61411
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FgHNP4Yspz308x
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 May 2021 00:33:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4FgHMy73Nlz2xZN
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 May 2021 00:33:34 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 14CEV6Yp018137;
 Wed, 12 May 2021 09:31:06 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 14CEV5SC018136;
 Wed, 12 May 2021 09:31:05 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Wed, 12 May 2021 09:31:05 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] powerpc: Force inlining of csum_add()
Message-ID: <20210512143105.GW10366@gate.crashing.org>
References: <f7f4d4e364de6e473da874468b903da6e5d97adc.1620713272.git.christophe.leroy@csgroup.eu>
 <20210511105154.GJ10366@gate.crashing.org>
 <e996ef13-c25c-5e9c-edd2-444eded88802@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e996ef13-c25c-5e9c-edd2-444eded88802@csgroup.eu>
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, May 12, 2021 at 02:56:56PM +0200, Christophe Leroy wrote:
> Le 11/05/2021 à 12:51, Segher Boessenkool a écrit :
> >Something seems to have decided this asm is more expensive than it is.
> >That isn't always avoidable -- the compiler cannot look inside asms --
> >but it seems it could be improved here.
> >
> >Do you have (or can make) a self-contained testcase?
> 
> I have not tried, and I fear it might be difficult, because on a kernel 
> build with dozens of calls to csum_add(), only ip6_tunnel.o exhibits such 
> an issue.

Yeah.  Sometimes you can force some of the decisions, but that usually
requires knowing too many GCC internals :-/

> >>And there is even one completely unused instance of csum_add().
> >
> >That is strange, that should never happen.
> 
> It seems that several .o include unused versions of csum_add. After the 
> final link, one remains (in addition to the used one) in vmlinux.

But it is a static function, so it should not end up in any object file
where it isn't used.

> >>In the non-inlined version, the first sum with 0 was performed.
> >>Here it is skipped.
> >
> >That is because of how __builtin_constant_p works, most likely.  As we
> >discussed elsewhere it is evaluated before all forms of loop unrolling.
> 
> But we are not talking about loop unrolling here, are we ?

Oh, right you are, but that doesn't change much.  The
_builtin_constant_p(len) is evaluated long before the compiler sees len
is a constant here.

> It seems that the reason here is that __builtin_constant_p() is evaluated 
> long after GCC decided to not inline that call to csum_add().

Yes, it seems we do not currently do even trivial inlining except very
early in the compiler.

Thanks,


Segher
