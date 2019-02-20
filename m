Return-Path: <SRS0=+mMX=Q3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52863C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 14:54:10 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0D8D2147C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Feb 2019 14:54:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0D8D2147C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444LGR6tqnzDqLh
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 01:54:07 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444LDR3Z9nzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 01:52:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 444LDR2Pj9z8t8q
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 01:52:23 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 444LDR22mqz9s9L; Thu, 21 Feb 2019 01:52:23 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 444LDQ3YT0z9s70
 for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2019 01:52:22 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x1KEpYL4023289;
 Wed, 20 Feb 2019 08:51:34 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x1KEpPRx023288;
 Wed, 20 Feb 2019 08:51:25 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Wed, 20 Feb 2019 08:51:25 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/64s: Fix possible corruption on big endian due to
 pgd/pud_present()
Message-ID: <20190220145112.GW14180@gate.crashing.org>
References: <20190214062339.7139-1-mpe@ellerman.id.au>
 <20190216105511.GA31125@350D> <20190216142206.GE14180@gate.crashing.org>
 <20190217062333.GC31125@350D> <87ef86dd9v.fsf@concordia.ellerman.id.au>
 <20190217215556.GH31125@350D> <87imxhrkdt.fsf@concordia.ellerman.id.au>
 <20190219201539.GT14180@gate.crashing.org>
 <87sgwi7lo1.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sgwi7lo1.fsf@concordia.ellerman.id.au>
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
Cc: erhard_f@mailbox.org, jack@suse.cz, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 aneesh.kumar@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Feb 20, 2019 at 10:18:38PM +1100, Michael Ellerman wrote:
> Segher Boessenkool <segher@kernel.crashing.org> writes:
> > On Mon, Feb 18, 2019 at 11:49:18AM +1100, Michael Ellerman wrote:
> >> Balbir Singh <bsingharora@gmail.com> writes:
> >> > Fair enough, my point was that the compiler can help out. I'll see what
> >> > -Wconversion finds on my local build :)
> >> 
> >> I get about 43MB of warnings here :)
> >
> > Yes, -Wconversion complains about a lot of things that are idiomatic C.
> > There is a reason -Wconversion is not in -Wall or -Wextra.
> 
> Actually a lot of those go away when I add -Wno-sign-conversion.
> 
> And what's left seems mostly reasonable, they all indicate the
> possibility of a bug I think.
> 
> In fact this works and would have caught the bug:
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
> index d8c8d7c9df15..3114e3f368e2 100644
> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
> @@ -904,7 +904,12 @@ static inline int pud_none(pud_t pud)
>  
>  static inline int pud_present(pud_t pud)
>  {
> +	__diag_push();
> +	__diag_warn(GCC, 8, "-Wconversion", "ulong -> int");
> +
>  	return !!(pud_raw(pud) & cpu_to_be64(_PAGE_PRESENT));
> +
> +	__diag_pop();
>  }
>  
>  extern struct page *pud_page(pud_t pud);
> 
> 
> 
> Obviously we're not going to instrument every function like that. But we
> could start instrumenting particular files.

So you want to instrument the functions that you know are buggy, using some
weird incantations to catch only those errors you already know about?

(I am worried this does not scale, in many dimensions).


Segher
