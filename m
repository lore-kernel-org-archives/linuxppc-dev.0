Return-Path: <SRS0=hR0M=QY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C0ACC43381
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 23:08:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4550D21773
	for <linuxppc-dev@archiver.kernel.org>; Sun, 17 Feb 2019 23:08:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ozlabs.org header.i=@ozlabs.org header.b="V5DV5M2b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4550D21773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 442jNG1qv1zDqMF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Feb 2019 10:08:30 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 442jLF4Cm3zDqKs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2019 10:06:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.org
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 secure) header.d=ozlabs.org header.i=@ozlabs.org header.b="V5DV5M2b"; 
 dkim-atps=neutral
Received: by ozlabs.org (Postfix, from userid 1003)
 id 442jLF2bF5z9sDX; Mon, 18 Feb 2019 10:06:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ozlabs.org; s=201707;
 t=1550444805; bh=epiJG+fzqGtGM/uZEpFY8WO7eQWYzGSh2MP0yWf5Kmk=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=V5DV5M2bGn2Zyf0hv8on6YmeqJFofOVXYjIBDv+EaX6420Hs9WAeGU4dFsTprxtft
 19Wc7qOfGazQHXWS3X9iw1vmgiPVlsEnVeyfpB1qMBFsC5XIJN4f+b6ju7JGeH+fhj
 XnWcXentt2qXeS9HyIreXYriUm9w49+Y7eO8f0o6TrtgVV2PHIQDGQBLfXoVktHzMz
 BMdVg9XtDn802N+zu4mJGnKPDzR0FF1SfO37xn/NwNz6D0oQK1IV6F24RJ6Ht9w9+4
 5vIqfLCsTY1Bd412h77o/J5CqoKnH1BJJ57f5JXcVrRplqa/IzsCbwCV2mMZ5Qt9df
 cA7JtuaidJqSQ==
Date: Mon, 18 Feb 2019 10:06:40 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6] powerpc/64s: reimplement book3s idle code in C
Message-ID: <20190217230640.GA922@blackberry>
References: <20181013120409.1993-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181013120409.1993-1-npiggin@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
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
Cc: "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 kvm-ppc@vger.kernel.org, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Oct 13, 2018 at 10:04:09PM +1000, Nicholas Piggin wrote:
> Reimplement Book3S idle code in C, moving POWER7/8/9 implementation
> speific HV idle code to the powernv platform code.
> 

[...]

> @@ -2760,21 +2744,47 @@ BEGIN_FTR_SECTION
>  	li	r4, LPCR_PECE_HVEE@higher
>  	sldi	r4, r4, 32
>  	or	r5, r5, r4
> -END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
> +FTR_SECTION_ELSE
> +	li	r3, PNV_THREAD_NAP
> +ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
>  	mtspr	SPRN_LPCR,r5
>  	isync
> -	li	r0, 0
> -	std	r0, HSTATE_SCRATCH0(r13)
> -	ptesync
> -	ld	r0, HSTATE_SCRATCH0(r13)
> -1:	cmpd	r0, r0
> -	bne	1b
> +
> +	mr	r0, r1
> +	ld	r1, PACAEMERGSP(r13)
> +	subi	r1, r1, STACK_FRAME_OVERHEAD
> +	std	r0, 0(r1)
> +	ld	r0, PACAR1(r13)
> +	std	r0, 8(r1)

This bit seems wrong to me.  If this is a secondary thread on POWER8,
we were already on the emergency stack, and now we've reset r1 back to
the top of the emergency stack and we're overwriting it.

I wonder why you didn't see secondary threads going off into lala land
in your tests?

Paul.
