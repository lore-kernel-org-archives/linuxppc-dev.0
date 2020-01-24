Return-Path: <SRS0=JQJc=3N=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 095DDC2D0CE
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jan 2020 08:46:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5680C2070A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jan 2020 08:46:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5680C2070A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 483t6d5LnqzDqd3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jan 2020 19:46:49 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 483t4k65VszDqN2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jan 2020 19:45:10 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 00O8ipf2015536;
 Fri, 24 Jan 2020 02:44:51 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 00O8ioUT015535;
 Fri, 24 Jan 2020 02:44:50 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Fri, 24 Jan 2020 02:44:50 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] powerpc/irq: don't use current_stack_pointer() in
 check_stack_overflow()
Message-ID: <20200124084450.GS3191@gate.crashing.org>
References: <bae3e75a0c7f9037e4012ee547842c04cd527931.1575871613.git.christophe.leroy@c-s.fr>
 <87d0b9iez3.fsf@mpe.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0b9iez3.fsf@mpe.ellerman.id.au>
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

Hi!

On Fri, Jan 24, 2020 at 04:46:24PM +1100, Michael Ellerman wrote:
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> >  static inline void check_stack_overflow(void)
> >  {
> >  #ifdef CONFIG_DEBUG_STACKOVERFLOW
> > -	long sp;
> > -
> > -	sp = current_stack_pointer() & (THREAD_SIZE-1);
> > +	register unsigned long r1 asm("r1");
> > +	long sp = r1 & (THREAD_SIZE - 1);
> 
> This appears to work but seems to be "unsupported" by GCC, and clang
> actually complains about it:
> 
>   /linux/arch/powerpc/kernel/irq.c:603:12: error: variable 'r1' is uninitialized when used here [-Werror,-Wuninitialized]
>           long sp = r1 & (THREAD_SIZE - 1);
>                     ^~
> 
> The GCC docs say:
> 
>   The only supported use for this feature is to specify registers for
>   input and output operands when calling Extended asm (see Extended
>   Asm).
> 
> https://gcc.gnu.org/onlinedocs/gcc-9.1.0/gcc/Local-Register-Variables.html#Local-Register-Variables

Yes.  Don't use local register variables any other way.  It *will* break.

> If I do this it seems to work, but feels a little dicey:
> 
> 	asm ("" : "=r" (r1));
> 	sp = r1 & (THREAD_SIZE - 1);

The only thing dicey about that is that you are writing to r1.  Heh.
Well that certainly is bad enough, the compiler does not know how to
handle that at all...  Of course you aren't *actually* changing
anything, so it might just work.


Segher
