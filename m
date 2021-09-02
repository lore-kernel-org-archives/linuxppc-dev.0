Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B565C433F5
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Sep 2021 21:54:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7950D60E8B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  2 Sep 2021 21:54:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7950D60E8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4H0vq16fvKz2ynB
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Sep 2021 07:54:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4H0vpT2T3fz2xrg
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Sep 2021 07:54:23 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 182Lq4Oi018195;
 Thu, 2 Sep 2021 16:52:04 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 182Lq3wk018191;
 Thu, 2 Sep 2021 16:52:03 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 2 Sep 2021 16:52:03 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v2 1/2] powerpc/64s: system call scv tabort fix for
 corrupt irq soft-mask state
Message-ID: <20210902215203.GM1583@gate.crashing.org>
References: <20210901165418.1412891-1-npiggin@gmail.com>
 <65ed1ac8-f4af-742a-1d2a-e5db7e71a920@csgroup.eu>
 <1630553233.5hjr91skvz.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1630553233.5hjr91skvz.astroid@bobo.none>
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
Cc: Eirik Fuller <efuller@redhat.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Sep 02, 2021 at 01:33:10PM +1000, Nicholas Piggin wrote:
> Excerpts from Christophe Leroy's message of September 2, 2021 3:21 am:
> >> -	/* Firstly we need to enable TM in the kernel */
> >> +	/* We need to enable TM in the kernel, and disable EE (for scv) */
> >>   	mfmsr	r10
> >>   	li	r9, 1
> >>   	rldimi	r10, r9, MSR_TM_LG, 63-MSR_TM_LG
> >> +	LOAD_REG_IMMEDIATE(r9, MSR_EE)
> >> +	andc	r10, r10, r9
> > 
> > Why not use 'rlwinm' to mask out MSR_EE ?
> > 
> > Something like
> > 
> > 	rlwinm	r10, r10, 0, ~MSR_EE
> 
> Mainly because I'm bad at powerpc assembly. Why do you think I'm trying 
> to change as much as possible to C?

The actual bit (bit 31, i.e. with value 1UL << 32) cannot be cleared
with rlwinm (only the low 32 bits can).  There are many ways to do it
using two insns of course.

> Actually there should really be no need for mfmsr either, I wanted to
> rewrite the thing entirely as
> 
> 	ld      r10,PACAKMSR(r13)
> 	LOAD_REG_IMMEDIATE(r9, MSR_TM)
> 	or	r10,r10,r9
> 	mtmsrd	r10
> 
> But I thought that's not a minimal bug fix.

That (LOAD_REG_IMMEDIATE+or) can be done with just two insns, not three
as written:
  li r0,1
  rldimi r10,r0,32,31
(you can write that last insns as
  rldimi r10,r0,MSR_TM_LG,MSR_TM_LG-1
if you insist :-) )

It isn't like a few integer computational insns will kill you here of
course, there are much more important cycles to shave off :-)


Segher
