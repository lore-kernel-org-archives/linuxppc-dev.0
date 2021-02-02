Return-Path: <SRS0=8mZb=HF=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4831C433DB
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 02:49:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1906664F68
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 02:49:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1906664F68
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DVmNf6gBszDwlq
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Feb 2021 13:49:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4DVbcj66kFzDqTd
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2021 07:14:13 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 112KAiAK011475;
 Tue, 2 Feb 2021 14:10:44 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 112KAhnm011470;
 Tue, 2 Feb 2021 14:10:43 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 2 Feb 2021 14:10:43 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v4 11/23] powerpc/syscall: Rename syscall_64.c into
 syscall.c
Message-ID: <20210202201042.GB30983@gate.crashing.org>
References: <cover.1611585031.git.christophe.leroy@csgroup.eu>
 <ff9dd4accdc897013594768833d54444e4823bf9.1611585031.git.christophe.leroy@csgroup.eu>
 <1611656343.yaxha7r2q4.astroid@bobo.none>
 <d9993f034db848d1afeffa322373b811@AcuMS.aculab.com>
 <1611791083.sqnnh21vv0.astroid@bobo.none>
 <0cf90825-da89-6464-98d4-dc7490bff557@csgroup.eu>
 <1612247170.ea0f766ml4.astroid@bobo.none>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1612247170.ea0f766ml4.astroid@bobo.none>
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 David Laight <David.Laight@ACULAB.COM>, Paul Mackerras <paulus@samba.org>,
 "msuchanek@suse.de" <msuchanek@suse.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Feb 02, 2021 at 04:38:31PM +1000, Nicholas Piggin wrote:
> > So to avoid confusion, I'll rename it. But I think "interrupt" is maybe not the right name. An 
> > interrupt most of the time refers to IRQ.
> 
> That depends what you mean by interrupt and IRQ.

In the PowerPC architecture, an exception is an abnormal condition, and
that can often cause an interrupt.  What Christophe colloquially calls
an "IRQ" here is called an external exception c.q. external interrupt.

> But if you say irq it's more likely to mean
> a device interrupt, and "interrupt" usually refres to the asynch
> ones.

Power talks about "instruction-caused interrupts", for one aspect of the
difference here; and "precise" / "imprecise" interrupts for another.

> So it's really fine to use the proper arch-specific names for things
> in arch code. I'm trying to slowly change names from exception to
> interrupt.

Thanks :-)

> > For me system call is not an interrupt in the way it 
> > doesn't unexpectedly interrupt a program flow. In powerpc manuals it is generally called exceptions, 
> > no I'm more inclined to call it exception.c
> 
> Actually that's backwards. Powerpc manuals (at least the one I look at) 
> calls them all interrupts including system calls, and also the system
> call interrupt is actually the only one that doesn't appear to be
> associated with an exception.

Yeah.  You could easily make such an exception, which is set when you
execute a system call instruction, and cleared when the interrupt is
taken, of course; but the architecture doesn't.

> And on the other hand you can deal with exceptions in some cases without
> taking an interrupt at all. For example if you had MSR[EE]=0 you could
> change the decrementer or execute msgclr or change HMER SPR etc to clear
> various exceptions without ever taking the interrupt.

A well-known example is the exception bits in the FPSCR, which do not
cause an interrupt unless the corresponding enable bits are also set.


Segher
