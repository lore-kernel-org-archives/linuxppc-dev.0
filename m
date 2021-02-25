Return-Path: <SRS0=yiwx=H3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44150C433DB
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 15:28:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 689A864F14
	for <linuxppc-dev@archiver.kernel.org>; Thu, 25 Feb 2021 15:28:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 689A864F14
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DmcB84x26z3d30
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Feb 2021 02:28:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4Dmc9n6JKvz30Q7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Feb 2021 02:27:57 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 11PFPmoY020918;
 Thu, 25 Feb 2021 09:25:48 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 11PFPlFi020917;
 Thu, 25 Feb 2021 09:25:47 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 25 Feb 2021 09:25:47 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Daniel Axtens <dja@axtens.net>
Subject: Re: [RFC PATCH 4/8] powerpc/ppc_asm: use plain numbers for registers
Message-ID: <20210225152547.GE28121@gate.crashing.org>
References: <20210225031006.1204774-1-dja@axtens.net>
 <20210225031006.1204774-5-dja@axtens.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210225031006.1204774-5-dja@axtens.net>
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
Cc: linuxppc-dev@lists.ozlabs.org, llvmlinux@lists.linuxfoundation.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Feb 25, 2021 at 02:10:02PM +1100, Daniel Axtens wrote:
> This is dumb but makes the llvm integrated assembler happy.
> https://github.com/ClangBuiltLinux/linux/issues/764

> -#define	r0	%r0

> +#define	r0	0

This is a big step back (compare 9a13a524ba37).

If you use a new enough GAS, you can use the -mregnames option and just
say "r0" directly (so not define it at all, or define it to itself).

===
        addi 3,3,3
        addi r3,r3,3
        addi %r3,%r3,3

        addi 3,3,3
        addi r3,r3,r3
        addi %r3,%r3,%r3
===

$ as t.s -o t.o -mregnames
t.s: Assembler messages:
t.s:6: Warning: invalid register expression
t.s:7: Warning: invalid register expression


Many people do not like bare numbers.  It is a bit like not wearing
seatbelts (but so is all assembler code really: you just have to pay
attention).  A better argument is that it is harder to read for people
not used to assembler code like this.

We used to have "#define r0 0" etc., and that was quite problematic.
Like that "addi r3,r3,r3" example, but also, people wrote "r0" where
only a plain 0 is allowed (like in "lwzx r3,0,r3": "r0" would be
misleading there!)


Segher
