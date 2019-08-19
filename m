Return-Path: <SRS0=1Kal=WP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C439C3A59B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Aug 2019 08:00:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 062922184E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Aug 2019 07:59:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 062922184E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46BmYT3gxNzDqtQ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Aug 2019 17:59:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46BmWL09lQzDqZx
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Aug 2019 17:58:05 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x7J7vnxs028798;
 Mon, 19 Aug 2019 02:57:49 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x7J7vmIb028797;
 Mon, 19 Aug 2019 02:57:48 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 19 Aug 2019 02:57:48 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc: optimise WARN_ON()
Message-ID: <20190819075748.GY31406@gate.crashing.org>
References: <20190817090442.C5FEF106613@localhost.localdomain>
 <20190818120135.GV31406@gate.crashing.org>
 <f1c0d9d9-d978-794f-82ce-494d2e52d743@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f1c0d9d9-d978-794f-82ce-494d2e52d743@c-s.fr>
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

On Mon, Aug 19, 2019 at 07:40:42AM +0200, Christophe Leroy wrote:
> Le 18/08/2019 à 14:01, Segher Boessenkool a écrit :
> >On Sat, Aug 17, 2019 at 09:04:42AM +0000, Christophe Leroy wrote:
> >>Unlike BUG_ON(x), WARN_ON(x) uses !!(x) as the trigger
> >>of the t(d/w)nei instruction instead of using directly the
> >>value of x.
> >>
> >>This leads to GCC adding unnecessary pair of addic/subfe.
> >
> >And it has to, it is passed as an "r" to an asm, GCC has to put the "!!"
> >value into a register.
> >
> >>By using (x) instead of !!(x) like BUG_ON() does, the additional
> >>instructions go away:
> >
> >But is it correct?  What happens if you pass an int to WARN_ON, on a
> >64-bit kernel?
> 
> On a 64-bit kernel, an int is still in a 64-bit register, so there would 
> be no problem with tdnei, would it ? an int 0 is the same as an long 0, 
> right ?

The top 32 bits of a 64-bit register holding an int are undefined.  Take
as example

  int x = 42;
  x = ~x;

which may put ffff_ffff_ffff_ffd5 into the reg, not 0000_0000_ffff_ffd5
as you might expect or want.  For tw instructions this makes no difference
(they only look at the low 32 bits anyway); for td insns, it does.

> It is on 32-bit kernel that I see a problem, if one passes a long long 
> to WARN_ON(), the forced cast to long will just drop the upper size of 
> it. So as of today, BUG_ON() is buggy for that.

Sure, it isn't defined what types you can pass to that macro.  Another
thing that makes inline functions much saner to use.

> >(You might want to have 64-bit generate either tw or td.  But, with
> >your __builtin_trap patch, all that will be automatic).
> 
> Yes I'll discard this patch and focus on the __builtin_trap() one which 
> should solve most issues.

But see my comment there about the compiler knowing all code after an
unconditional trap is dead.


Segher
