Return-Path: <SRS0=ZD8a=WX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8544C3A5A3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Aug 2019 18:28:28 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 462DF2070B
	for <linuxppc-dev@archiver.kernel.org>; Tue, 27 Aug 2019 18:28:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 462DF2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46Hy6x5ngczDqsp
	for <linuxppc-dev@archiver.kernel.org>; Wed, 28 Aug 2019 04:28:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46Hy4m2gPyzDqWn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Aug 2019 04:26:32 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7RIQHbP000982;
 Tue, 27 Aug 2019 13:26:17 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x7RIQGDG000979;
 Tue, 27 Aug 2019 13:26:16 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 27 Aug 2019 13:26:16 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 2/2] powerpc: cleanup hw_irq.h
Message-ID: <20190827182616.GB31406@gate.crashing.org>
References: <0f7e164afb5d1b022441559fe5a999bb6d3c0a23.1566893505.git.christophe.leroy@c-s.fr>
 <81f39fa06ae582f4a783d26abd2b310204eba8f4.1566893505.git.christophe.leroy@c-s.fr>
 <1566909844.x4jee1jjda.astroid@bobo.none>
 <20190827172909.GA31406@gate.crashing.org>
 <1410046b-e1a3-b892-2add-6c1d353cb781@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1410046b-e1a3-b892-2add-6c1d353cb781@c-s.fr>
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
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Aug 27, 2019 at 07:36:35PM +0200, Christophe Leroy wrote:
> Le 27/08/2019 à 19:29, Segher Boessenkool a écrit :
> >On Tue, Aug 27, 2019 at 10:48:24PM +1000, Nicholas Piggin wrote:
> >>Christophe Leroy's on August 27, 2019 6:13 pm:
> >>>+#define wrtee(val)	asm volatile("wrtee %0" : : "r" (val) : "memory")
> >>>+#define wrteei(val)	asm volatile("wrteei %0" : : "i" (val) : 
> >>>"memory")
> >>
> >>Can you implement just one macro that uses __builtin_constant_p to
> >>select between the imm and reg versions? I forgot if there's some
> >>corner cases that prevent that working with inline asm i constraints.
> >
> >static inline void wrtee(long val)
> >{
> >	asm volatile("wrtee%I0 %0" : : "n"(val) : "memory");
> >}
> 
> Great, didn't know that possibility.
> 
> Can it be used with any insn, for instance with add/addi ?
> Or with mr/li ?

Any instruction, yes.  %I<n> simply outputs an "i" if operand n is a
constant integer, and nothing otherwise.

So
  asm("add%I2 %0,%1,%2" : "=r"(dst) : "r"(src1), "ri"(src1));
works well.  I don't see how you would use it for li/mr...  You can do
  asm("add%I1 %0,0,%1" : "=r"(dst) : "ri"(src));
I suppose, but that is not really an mr.

> >(This output modifier goes back to the dark ages, some 2.4 or something).
> 
> Hope Clang support it ...

I don't know, sorry.  But it is used all over the place, see sfp-machine.h
for example, so maybe?


Segher
