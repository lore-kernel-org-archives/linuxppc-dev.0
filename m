Return-Path: <SRS0=1Kal=WP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FEC7C3A5A1
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Aug 2019 14:44:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8AFD2082C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Aug 2019 14:44:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8AFD2082C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46BxWk0yPbzDqFL
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Aug 2019 00:44:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46BxMs4mW7zDqsj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2019 00:37:13 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7JEb1pp023153;
 Mon, 19 Aug 2019 09:37:01 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x7JEb09r023152;
 Mon, 19 Aug 2019 09:37:00 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 19 Aug 2019 09:37:00 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 3/3] powerpc: use __builtin_trap() in BUG/WARN macros.
Message-ID: <20190819143700.GK31406@gate.crashing.org>
References: <a6781075192afe0c909ce7d091de7931183a5d93.1566219503.git.christophe.leroy@c-s.fr>
 <20510ce03cc9463f1c9e743c1d93b939de501b53.1566219503.git.christophe.leroy@c-s.fr>
 <20190819132313.GH31406@gate.crashing.org>
 <dbafc03a-6eda-d9a3-c451-d242f03b01d9@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dbafc03a-6eda-d9a3-c451-d242f03b01d9@c-s.fr>
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

On Mon, Aug 19, 2019 at 04:08:43PM +0200, Christophe Leroy wrote:
> Le 19/08/2019 à 15:23, Segher Boessenkool a écrit :
> >On Mon, Aug 19, 2019 at 01:06:31PM +0000, Christophe Leroy wrote:
> >>Note that we keep using an assembly text using "twi 31, 0, 0" for
> >>inconditional traps because GCC drops all code after
> >>__builtin_trap() when the condition is always true at build time.
> >
> >As I said, it can also do this for conditional traps, if it can prove
> >the condition is always true.
> 
> But we have another branch for 'always true' and 'always false' using 
> __builtin_constant_p(), which don't use __builtin_trap(). Is there 
> anything wrong with that ?:

The compiler might not realise it is constant when it evaluates the
__builtin_constant_p, but only realises it later.  As the documentation
for the builtin says:
  A return of 0 does not indicate that the
  value is _not_ a constant, but merely that GCC cannot prove it is a
  constant with the specified value of the '-O' option.

(and there should be many more and more serious warnings here).

> #define BUG_ON(x) do {						\
> 	if (__builtin_constant_p(x)) {				\
> 		if (x)						\
> 			BUG();					\
> 	} else {						\
> 		if (x)						\
> 			__builtin_trap();			\
> 		BUG_ENTRY("", 0);				\
> 	}							\
> } while (0)

I think it may work if you do

#define BUG_ON(x) do {						\
	if (__builtin_constant_p(x)) {				\
		if (x)						\
			BUG();					\
	} else {						\
		BUG_ENTRY("", 0);				\
		if (x)						\
			__builtin_trap();			\
	}							\
} while (0)

or even just

#define BUG_ON(x) do {						\
	BUG_ENTRY("", 0);					\
	if (x)							\
		__builtin_trap();				\
	}							\
} while (0)

if BUG_ENTRY can work for the trap insn *after* it.

> >Can you put the bug table asm *before* the __builtin_trap maybe?  That
> >should make it all work fine...  If you somehow can tell what machine
> >instruction is that trap, anyway.
> 
> And how can I tell that ?

I don't know how BUG_ENTRY works exactly.


Segher
