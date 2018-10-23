Return-Path: <SRS0=8rOk=ND=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E8ABC46475
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 21:41:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B990220671
	for <linuxppc-dev@archiver.kernel.org>; Tue, 23 Oct 2018 21:41:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B990220671
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42fmzm3950zF3Bh
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 08:41:24 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42fmxY0wHjzF37D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 08:39:28 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9NLdKBX005250;
 Tue, 23 Oct 2018 16:39:20 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id w9NLdIV4005244;
 Tue, 23 Oct 2018 16:39:18 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 23 Oct 2018 16:39:18 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Breno Leitao <leitao@debian.org>
Subject: Re: [PATCH 1/2] selftests/powerpc: Allocate base registers
Message-ID: <20181023213917.GS5205@gate.crashing.org>
References: <1540326197-15537-1-git-send-email-leitao@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540326197-15537-1-git-send-email-leitao@debian.org>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Oct 23, 2018 at 05:23:16PM -0300, Breno Leitao wrote:
> Some ptrace selftests are passing input operands using a constraint that
> can allocate any register for the operand, and using these registers on
> load/store operations.
> 
> If the register allocated by the compiler happens to be zero (r0), it might
> cause an invalid memory address access, since load and store operations
> consider the content of 0x0 address if the base register is r0, instead
> of the content of the r0 register. For example:
> 
> 	r1 := 0xdeadbeef
> 	r0 := 0xdeadbeef
> 	
> 	ld r2, 0(r1) /* will load into r2 the content of r1 address */
> 	ld r2, 0(r0) /* will load into r2 the context of 0x0 */

That isn't valid syntax: you have to write
	ld r2, 0(0)

(s/context/content/ btw)

> In order to avoid this possible problem, the inline assembly constraint
> should be aware that these registers will be used as a base register, thus,
> r0 should not be alocated.

(allocated)

The patch looks fine :-)

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
