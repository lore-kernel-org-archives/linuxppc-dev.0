Return-Path: <SRS0=EPkL=OK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B73EC433F5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Sep 2021 21:25:57 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C93AA611AF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 20 Sep 2021 21:25:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C93AA611AF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HCyKG2vpwz2ybB
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Sep 2021 07:25:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4HCyJj319Tz2yN4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Sep 2021 07:25:24 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 18KLN6Wr012714;
 Mon, 20 Sep 2021 16:23:06 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 18KLN4s2012713;
 Mon, 20 Sep 2021 16:23:04 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 20 Sep 2021 16:23:04 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v4 1/3] powerpc/bitops: Use immediate operand when possible
Message-ID: <20210920212303.GZ1583@gate.crashing.org>
References: <db9d01d5c543c5add4b2beadb03d39e99c7ada2c.1632126669.git.christophe.leroy@csgroup.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db9d01d5c543c5add4b2beadb03d39e99c7ada2c.1632126669.git.christophe.leroy@csgroup.eu>
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

Hi!

On Mon, Sep 20, 2021 at 10:31:17AM +0200, Christophe Leroy wrote:
> Today we get the following code generation for bitops like
> set or clear bit:
> 
> 	c0009fe0:	39 40 08 00 	li      r10,2048
> 	c0009fe4:	7c e0 40 28 	lwarx   r7,0,r8
> 	c0009fe8:	7c e7 53 78 	or      r7,r7,r10
> 	c0009fec:	7c e0 41 2d 	stwcx.  r7,0,r8
> 
> 	c000d568:	39 00 18 00 	li      r8,6144
> 	c000d56c:	7c c0 38 28 	lwarx   r6,0,r7
> 	c000d570:	7c c6 40 78 	andc    r6,r6,r8
> 	c000d574:	7c c0 39 2d 	stwcx.  r6,0,r7
> 
> Most set bits are constant on lower 16 bits, so it can easily
> be replaced by the "immediate" version of the operation. Allow
> GCC to choose between the normal or immediate form.

You can also handle the second sixteen bits (the "shifted" half), by
using oris etc.  The "%eN" output modifier prints an "s" for this:
  /* If the low 16 bits are 0, but some other bit is set, write 's'.  */
But this doesn't handle non-constant arguments, so you're likely better
off using what you have noe.

> For clear bits, on 32 bits 'rlwinm' can be used instead of 'andc' for
> when all bits to be cleared are consecutive.

Or when all you want to keep are consecutive (you do handle that now :-) )

> On 64 bits we don't have any equivalent single operation for clearing,
> single bits or a few bits, we'd need two 'rldicl' so it is not
> worth it, the li/andc sequence is doing the same.

You can use rlwinm whenever you want to clear all top 32 bits.

A sometimes nice idiom is  ori x,x,N ; xori x,x,N  to clear the bits N
(or oris/xoris).  But it's two insns no matter what (but no spare
register is needed).

> Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>

> +static inline unsigned long test_and_clear_bits(unsigned long mask, volatile unsigned long *_p)
> +{
> +	unsigned long old, t;
> +	unsigned long *p = (unsigned long *)_p;
> +
> +	if (IS_ENABLED(CONFIG_PPC32) &&
> +	    __builtin_constant_p(mask) && is_rlwinm_mask_valid(mask)) {

is_rlwinm_mask_valid(~mask)?  So that test_and_clear_bits(0, ...) will
work with rlwinm, and test_and_clear_bits(0xffffffff, ...) will not make
gas scream bloody murder ("illegal bitmask").  Tha mask you pass to the
instruction is ~mask after all.

Looks great except that one nit.  Thanks :-)

Reviewed-by: Segher Boessenkool <segher@kernel.crashing.org>


Segher
