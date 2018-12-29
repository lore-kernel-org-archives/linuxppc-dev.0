Return-Path: <SRS0=BvUY=PG=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C109C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 12:43:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C2C520857
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 12:43:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C2C520857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Rjt60YdbzDqCb
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Dec 2018 23:43:26 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Rjpm5Zn1zDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Dec 2018 23:40:32 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wBTBeH3g022098;
 Sat, 29 Dec 2018 05:40:18 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id wBTBeGi7022093;
 Sat, 29 Dec 2018 05:40:16 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Sat, 29 Dec 2018 05:40:15 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] powerpc: Fix -mcpu= options for SPE-only compiler
Message-ID: <20181229114012.GB28554@gate.crashing.org>
References: <20181226141511.3ag7uf6rvdgzlmxt@decadent.org.uk>
 <20181226234552.GA28554@gate.crashing.org>
 <99f1a5d8ffcb3539b653a5f123ef32735f389af4.camel@decadent.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <99f1a5d8ffcb3539b653a5f123ef32735f389af4.camel@decadent.org.uk>
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
Cc: linuxppc-dev@lists.ozlabs.org, debian-kernel@lists.debian.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Dec 27, 2018 at 02:32:07AM +0000, Ben Hutchings wrote:
> On Wed, 2018-12-26 at 17:45 -0600, Segher Boessenkool wrote:
> > Hi!
> > 
> > On Wed, Dec 26, 2018 at 02:15:11PM +0000, Ben Hutchings wrote:
> > > GCC for Debian's "powerpcspe" architecture only supports 32-bit
> > > SPE targets, and using -mcpu=powerpc or -mcpu=powerpc64 is a fatal
> > > error.
> > 
> > I don't see where your patch touches -mcpu=powerpc, and I don't see how
> > it would make a difference either?

[ I now see that error fwiw.  Yuck. ]

> Look at the assignments that are conditional on HAS_BIARCH.

Sure, you change how HAS_BIARCH is set.  That has more effects than just
not using -mcpu=powerpc (which is fine, but the message is confusing).

> > > +ifdef CONFIG_PPC64
> > >  ifdef CONFIG_PPC_BOOK3S_64
> > >  ifdef CONFIG_CPU_LITTLE_ENDIAN
> > >  CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=power8
> > > @@ -177,6 +178,7 @@ endif
> > >  else
> > >  CFLAGS-$(CONFIG_GENERIC_CPU) += -mcpu=powerpc64
> > >  endif
> > > +endif
> > 
> > How can CONFIG_PPC_BOOK3S_64 be true while CONFIG_PPC64 is fals?  That
> > does not make a lot of sense.
> 
> But there is an "else" part here.

Yeah I see.  It would be better to have fewer nested conditionals here
instead of more...


Segher
