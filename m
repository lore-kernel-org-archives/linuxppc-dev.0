Return-Path: <SRS0=vwdz=N7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DDA1C46463
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 18:23:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC9A220870
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 18:22:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC9A220870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zvFQ2znGzF3bV
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Nov 2018 05:22:34 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42zvCL68FbzF3Ln
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Nov 2018 05:20:46 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wAKIKWbw015018;
 Tue, 20 Nov 2018 12:20:33 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id wAKIKUZq015014;
 Tue, 20 Nov 2018 12:20:30 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Tue, 20 Nov 2018 12:20:30 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v2] powerpc/math-emu: Update macros from gmp-6.1.2
Message-ID: <20181120182029.GA23873@gate.crashing.org>
References: <20181114024412.19368-1-joel@jms.id.au>
 <CAKwvOd=P6eQsysnhYVjekbKzVMiGZH8K2nO=Y2gNaH6j+yAhSQ@mail.gmail.com>
 <CACPK8XcdMgrnUQsHH4-fHX2Cw7=zXPBhsDJUNGQJ1=hjh0P4CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACPK8XcdMgrnUQsHH4-fHX2Cw7=zXPBhsDJUNGQJ1=hjh0P4CQ@mail.gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nick Desaulniers <ndesaulniers@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, Nov 20, 2018 at 09:45:33AM +1030, Joel Stanley wrote:
> On Tue, 20 Nov 2018 at 05:24, Nick Desaulniers <ndesaulniers@google.com> wrote:
> > >
> > > The only functional change I noticed was this in udiv_qrnnd.
> > >
> > >     __r1 = (n1) % __d1;
> > >     __q1 = (n1) / __d1;
> > >
> > > Becomes this:
> > >
> > >     __q1 = (n1) / __d1;
> > >     __r1 = (n1) - __q1 * __d1;
> > >
> > > This is equivalent as it instead of calculating the remainder
> > > using modulo, it uses the result of integer division to subtract the
> > > count of 'whole' d1 from r1.
> >
> > I don't understand this; why was this functional change made?
> 
> I couldn't see why. It pre-dates GMP's mecurial history that  .

Perhaps it is to make it more likely only a single divide machine
instruction results.  Maybe for -O0, maybe for older GCC, maybe for GCC
targets that do not get this right.  It of course means exactly the same.

> AIUI the upstream source is GMP:
> 
>  https://gmplib.org/repo/gmp/file/tip/longlong.h
> 
> > If we're going to borrow implementations from GCC, let's borrow the
> > same implementation. Otherwise it's hard to have confidence in this
> > part of the patch.
> 
> I agree we should use the upstream source.
> 
> Segher, which tree contains the One True Upstream for longlong.h?

You should probably get your updates from the same place as was used to
get the file in the first place.  Or, don't worry so much about it, how
often is this updated?  Once in ten years, or twenty?

If you do not want to include bigger (maybe irrelevant) changes from
upstream, you have already forked, effectively.


Segher
