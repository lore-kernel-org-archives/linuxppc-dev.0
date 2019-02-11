Return-Path: <SRS0=3oxj=QS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF24FC169C4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 08:09:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 705F920863
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 08:09:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 705F920863
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43ydjW4BclzDqNC
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Feb 2019 19:09:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ydgh6ryqzDqJq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 19:07:44 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x1B86w2Y026260;
 Mon, 11 Feb 2019 02:07:00 -0600
Message-ID: <5dadc1b0aee62ce8371cabaa35ea4bbe6b71f48f.camel@kernel.crashing.org>
Subject: Re: [PATCH v1 03/16] powerpc/32: move LOAD_MSR_KERNEL() into
 head_32.h and use it
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
 <npiggin@gmail.com>
Date: Mon, 11 Feb 2019 19:06:58 +1100
In-Reply-To: <b074648b-8896-5591-16fe-3ecaf5c7553a@c-s.fr>
References: <cover.1549630193.git.christophe.leroy@c-s.fr>
 <1946d8ed86a92a9a6827ec260d0d9c99e0d88184.1549630193.git.christophe.leroy@c-s.fr>
 <749f719a0881531cad2071a7011dc5e894812d3d.camel@kernel.crashing.org>
 <b074648b-8896-5591-16fe-3ecaf5c7553a@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 2019-02-11 at 07:26 +0100, Christophe Leroy wrote:
> 
> Le 11/02/2019 à 01:21, Benjamin Herrenschmidt a écrit :
> > On Fri, 2019-02-08 at 12:52 +0000, Christophe Leroy wrote:
> > >   /*
> > > + * MSR_KERNEL is > 0x8000 on 4xx/Book-E since it include MSR_CE.
> > > + */
> > > +.macro __LOAD_MSR_KERNEL r, x
> > > +.if \x >= 0x8000
> > > +       lis \r, (\x)@h
> > > +       ori \r, \r, (\x)@l
> > > +.else
> > > +       li \r, (\x)
> > > +.endif
> > > +.endm
> > > +#define LOAD_MSR_KERNEL(r, x) __LOAD_MSR_KERNEL r, x
> > > +
> > 
> > You changed the limit from >= 0x10000 to >= 0x8000 without a
> > corresponding explanation as to why...
> 
> Yes, the existing LOAD_MSR_KERNEL() was buggy because 'li' takes a 
> signed u16, ie between -0x8000 and 0x7999.

Ah yes, I was only looking at the "large" case which is fine...

> By chance it was working because until now nobody was trying to set 
> MSR_KERNEL | MSR_EE.
> 
> Christophe

