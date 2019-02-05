Return-Path: <SRS0=EZew=QM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CE9C282CC
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 12:26:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17B6420821
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 12:26:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17B6420821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43v3hq6bzRzDqPj
	for <linuxppc-dev@archiver.kernel.org>; Tue,  5 Feb 2019 23:26:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43v3Y26qV9zDqN0
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Feb 2019 23:19:34 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x15CJEAM024082;
 Tue, 5 Feb 2019 06:19:15 -0600
Message-ID: <e898ac7b25e7303628499ec2fda6a0251bf8863b.camel@kernel.crashing.org>
Subject: Re: [RFC/WIP] powerpc: Fix 32-bit handling of MSR_EE on exceptions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Date: Tue, 05 Feb 2019 23:19:14 +1100
In-Reply-To: <5a97253c-0ec4-d61f-fa9e-ea5da8590f32@c-s.fr>
References: <fe3a79e078c644d9c1379ef5f8c431d787b6d0c8.camel@kernel.crashing.org>
 <cbce315b-82f9-c748-92e4-97bb819c9098@c-s.fr>
 <ab9139902a64f8d0b187f7db0f8a16a5b85791ac.camel@kernel.crashing.org>
 <5a97253c-0ec4-d61f-fa9e-ea5da8590f32@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.4 (3.30.4-1.fc29) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
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
Cc: Diana Craciun <diana.craciun@nxp.com>, Scott Wood <oss@buserror.net>,
 Nick Piggin <npiggin@au1.ibm.com>, Laurentiu Tudor <laurentiu.tudor@nxp.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-02-05 at 10:45 +0100, Christophe Leroy wrote:
> > > I tested it on the 8xx with the below changes in addition. No issue seen
> > > so far.
> > 
> > Thanks !
> > 
> > I'll merge that in.
> 
> I'm currently working on a refactorisation and simplification of
> exception and syscall entry on ppc32.
> 
> I plan to take your patch in my serie as it helps quite a bit. I hope 
> you don't mind. I expect to come out with a series this week.

Ah ok, you want to take over the series then ? We still need to convert
all the other CPU variants... to be honest I've been distracted, and
taking some time off. I'll be leaving IBM by the end of next week, so I
don't really see myself finishing this work properly.

> > The main obscure area is that business with the irqsoff tracer and thus
> > the need to create stack frames around calls to trace_hardirqs_* ... we
> > do it in some places and not others, but I've not managed to make it
> > crash either. I need to get to the bottom of that, and possibly provide
> > proper macro helpers like ppc64 has to do it.
> 
> I can't see anything special around this in ppc32 code. As far as I 
> understand, a stack frame is put in place when there is a need to
> save and restore some volatile registers. At the places where nothing 
> needs to be saved, nothing is done. I think that's the normal way for 
> any function call, isn't it ?

Not exactly. There's an issue with one of the tracers using
__bultin_return_address(1) which can crash afaik if we don't have
"enough" stack frames on the stack, so there are cases where we need to
create one explicitly around the tracing calls bcs there's only one on
the actual stack.

I don't know the full details, I was planning on doing a bunch of tests
in sim to figure out exactly what happens and what needs to be done
(and whether our existing code is correct or not), but didn't get to it
so far.

Cheers,
Ben.
 

