Return-Path: <SRS0=Sqku=EL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B97CFC00A89
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2020 11:03:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E26A22072E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2020 11:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E26A22072E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CRgcc3xN5zDqxL
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2020 22:03:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4CRgb44zPFzDqVq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2020 22:02:24 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 0A5B0Gla016486;
 Thu, 5 Nov 2020 05:00:16 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 0A5B0FXA016485;
 Thu, 5 Nov 2020 05:00:15 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Thu, 5 Nov 2020 05:00:15 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: Kernel panic from malloc() on SUSE 15.1?
Message-ID: <20201105110015.GY2672@gate.crashing.org>
References: <CAKkwB_S6Bs_+5At2aajbQbJg==WE_4NLdhSK=Bj+td67215Htg@mail.gmail.com>
 <878sbjuqe6.fsf@mpe.ellerman.id.au>
 <CAKkwB_RD0_=9SSwyYn-8Vo2dr2Li4X-v_KJ4qBWZRgxZuGUeRw@mail.gmail.com>
 <87lffgt8b9.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lffgt8b9.fsf@mpe.ellerman.id.au>
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
Cc: Carl Jacobsen <cjacobsen@storix.com>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 05, 2020 at 09:19:22PM +1100, Michael Ellerman wrote:
> Carl Jacobsen <cjacobsen@storix.com> writes:
> This doesn't make a lot of sense.
> 
> > Bad kernel stack pointer 7fffffffeac0 at 700
> 
> "at 700" is the regs->nip value, and suggests we're trying to handle a
> program check, which is either a trap or BUG or WARN, or illegal
> instruction or several other things.

> > REGS: c00000001ec2fd40 TRAP: 0300   Tainted: G (4.12.14-197.18-default)
> 
> But then here it says TRAP = 0x300, which is != 0x700.
> 
> The trap number is hardcoded in the bad stack handling code, and I don't
> see how we can end up with nip == 0x700 but the trap value == 0x300.
> 
> > MSR: 8000000000001000 <SF,ME> CR: 44000844  XER: 20000000
> 
> And here the MSR says you were in big endian mode, but you said before
> your machine was ppc64le.

It looks like you got a DSI (the 300), but for some reason that
interrupt was not taken in LE mode, so the instruction at 300 was read
as a lot of gobbledygook, not a valid insn, and the processor took a
program interrupt (the 700).

(MSR[RI]=0, but there can be other causes for that of course.)


Segher
