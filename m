Return-Path: <SRS0=yMLg=3F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D963DC33CB1
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 14:03:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91FD82075B
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Jan 2020 14:03:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91FD82075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47z5Wt4DCNzDqC0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Jan 2020 01:03:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 47z5TD1HvRzDq6N
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Jan 2020 01:01:19 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 00GE11kf011998;
 Thu, 16 Jan 2020 08:01:01 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 00GE11aZ011997;
 Thu, 16 Jan 2020 08:01:01 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 16 Jan 2020 08:01:01 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: z constraint in powerpc inline assembly ?
Message-ID: <20200116140101.GQ3191@gate.crashing.org>
References: <d72263a1-fe17-3192-6930-35ec8394c699@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d72263a1-fe17-3192-6930-35ec8394c699@c-s.fr>
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
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi!

On Thu, Jan 16, 2020 at 07:11:36AM +0100, Christophe Leroy wrote:
> I'm trying to see if we could enhance TCP checksum calculations by 
> splitting inline assembly blocks to give GCC the opportunity to mix it 
> with other stuff, but I'm getting difficulties with the carry.
> 
> As far as I can read in the documentation, the z constraint represents 
> '‘XER[CA]’ carry bit (part of the XER register)'
> 
> I've tried the following, but I get errors. Can you help ?
> 
> unsigned long cksum(unsigned long a, unsigned long b, unsigned long c)
> {
> 	unsigned long sum;
> 	unsigned long carry;
> 
> 	asm("addc %0, %2, %3" : "=r"(sum), "=z"(carry) : "r"(a), "r"(b));
> 	asm("adde %0, %0, %2" : "+r"(sum), "+z"(carry) : "r"(c));
> 	asm("addze %0, %0" : "+r"(sum) : "z"(carry));
> 
> 	return sum;
> }

The only register allowed by "z" is a fixed register.  You cannot use "z"
in inline asm.

Just write this as C?  It should do a reasonable job of it.  If you want
*good* code, you need to write it in *actual* assembler code, anyway (hand
scheduled and everything).


Segher
