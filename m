Return-Path: <SRS0=pcIm=NN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4DEFC32789
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 18:48:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7B6602082D
	for <linuxppc-dev@archiver.kernel.org>; Fri,  2 Nov 2018 18:48:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7B6602082D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42mrgG4KzVzF37w
	for <linuxppc-dev@archiver.kernel.org>; Sat,  3 Nov 2018 05:48:10 +1100 (AEDT)
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
 by lists.ozlabs.org (Postfix) with ESMTPS id 42mrb017rhzF31S
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Nov 2018 05:44:27 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wA2IiHl1002145;
 Fri, 2 Nov 2018 13:44:17 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id wA2IiE7f002121;
 Fri, 2 Nov 2018 13:44:14 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Fri, 2 Nov 2018 13:44:14 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH] powerpc/math-emu: Fix building with clang
Message-ID: <20181102184413.GU5994@gate.crashing.org>
References: <20181102033713.31916-1-joel@jms.id.au>
 <20181102173442.GT5994@gate.crashing.org>
 <CAKwvOd=3JFm+ReeJ5QfQJ77ypN6+qipB-3LfpVcK+umKud5dgA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOd=3JFm+ReeJ5QfQJ77ypN6+qipB-3LfpVcK+umKud5dgA@mail.gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org, joel@jms.id.au
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Nov 02, 2018 at 10:38:36AM -0700, Nick Desaulniers wrote:
> On Fri, Nov 2, 2018 at 10:34 AM Segher Boessenkool
> <segher@kernel.crashing.org> wrote:
> >
> > On Fri, Nov 02, 2018 at 02:07:13PM +1030, Joel Stanley wrote:
> > >   arch/powerpc/math-emu/fnmsub.c:46:2: error: invalid use of a cast in a
> > >   inline asm context requiring an l-value: remove the cast or build with
> > >   -fheinous-gnu-extensions
> >
> > (It is spelled lvalue).
> >
> > *All* of extended asm is a GNU extension, what is clang trying to say here?
> > Confused :-)
> 
> Isn't the result of a cast a temporary value?  Probably just need to
> move the case out of the inline asm block to a separate statement.
> Having the full backtrace should help.

The kernel's sfp-machine.h has casts in lvalues, inside macros.  All such
casts seem to be casts to compatible types (and if not, it probably won't
work with GCC either).


Segher
