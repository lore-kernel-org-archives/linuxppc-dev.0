Return-Path: <SRS0=2P8o=Z5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2311EC43603
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Dec 2019 17:42:59 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B161217BA
	for <linuxppc-dev@archiver.kernel.org>; Sat,  7 Dec 2019 17:42:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B161217BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 47VcHN2RzjzDqXl
	for <linuxppc-dev@archiver.kernel.org>; Sun,  8 Dec 2019 04:42:56 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 47VcFN695NzDqXW
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Dec 2019 04:41:12 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id xB7Hewkd008740;
 Sat, 7 Dec 2019 11:40:58 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id xB7HevGr008739;
 Sat, 7 Dec 2019 11:40:57 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Sat, 7 Dec 2019 11:40:57 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v4 2/2] powerpc/irq: inline call_do_irq() and
 call_do_softirq()
Message-ID: <20191207174057.GY3152@gate.crashing.org>
References: <20191121101552.GR16031@gate.crashing.org>
 <87y2w49rgo.fsf@mpe.ellerman.id.au> <20191125142556.GU9491@gate.crashing.org>
 <5fdb1c92-8bf4-01ca-f81c-214870c33be3@c-s.fr>
 <20191127145958.GG9491@gate.crashing.org>
 <2072e066-1ffb-867e-60ec-04a6bb9075c1@c-s.fr>
 <20191129184658.GR9491@gate.crashing.org>
 <ebc67964-e5a9-acd0-0011-61ba23692f7e@c-s.fr>
 <20191206205953.GQ3152@gate.crashing.org>
 <2a22feca-d6d6-6cb0-6c76-035234fa8742@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2a22feca-d6d6-6cb0-6c76-035234fa8742@c-s.fr>
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Dec 07, 2019 at 10:42:28AM +0100, Christophe Leroy wrote:
> Le 06/12/2019 à 21:59, Segher Boessenkool a écrit :
> >If the compiler can see the callee wants the same TOC as the caller has,
> >it does not arrange to set (and restore) it, no.  If it sees it may be
> >different, it does arrange for that (and the linker then will check if
> >it actually needs to do anything, and do that if needed).
> >
> >In this case, the compiler cannot know the callee wants the same TOC,
> >which complicates thing a lot -- but it all works out.
> 
> Do we have a way to make sure which TOC the functions are using ? Is 
> there several TOC at all in kernel code ?

Kernel modules have their own TOC, I think?

> >I think things can still go wrong if any of this is inlined into a kernel
> >module?  Is there anything that prevents this / can this not happen for
> >some fundamental reason I don't see?
> 
> This can't happen can it ?
> do_softirq_own_stack() is an outline function, defined in powerpc irq.c
> Its only caller is do_softirq() which is an outline function defined in 
> kernel/softirq.c
> 
> That prevents inlining, doesn't it ?

Hopefully, sure.  Would be nice if it was clearer that this works...  It
is too much like working by chance, the way it is :-(

> Anyway, until we clarify all this I'll limit my patch to PPC32 which is 
> where the real benefit is I guess.
> 
> At the end, maybe the solution should be to switch to IRQ stack 
> immediately in the exception entry as x86_64 do ?
> 
> And do_softirq_own_stack() could be entirely written in assembly like 
> x86_64 as well ?

Maybe?  I'm out of my depth there.


Segher
