Return-Path: <SRS0=FJkp=VL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_2 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBEEC31E40
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Jul 2019 01:33:53 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B657F20838
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Jul 2019 01:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B657F20838
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45mThY463pzDqhl
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Jul 2019 11:33:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45mTfb3CsWzDqhF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Jul 2019 11:32:07 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x6E1Vikx009138;
 Sat, 13 Jul 2019 20:31:45 -0500
Message-ID: <67befaf7d091ff684534e027bd303d80c752466d.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH kernel] powerpc/xive: Drop deregistered irqs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org
Date: Sun, 14 Jul 2019 11:31:43 +1000
In-Reply-To: <9b1fbde4-0884-223e-446c-373f73c366e0@ozlabs.ru>
References: <20190712082036.40440-1-aik@ozlabs.ru>
 <abbee9db2fa0abdaa2e01bb92bab920773a2ad8d.camel@kernel.crashing.org>
 <3a34190f-560e-0b42-af38-0e39cef0beea@ozlabs.ru>
 <d735f761b3d1cc1cd6df5fd566c75cae661fe4e7.camel@kernel.crashing.org>
 <9b1fbde4-0884-223e-446c-373f73c366e0@ozlabs.ru>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
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
Cc: Greg Kurz <groug@kaod.org>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Alistair Popple <alistair@popple.id.au>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 2019-07-13 at 18:53 +1000, Alexey Kardashevskiy wrote:
> 
> On 13/07/2019 09:47, Benjamin Herrenschmidt wrote:
> > On Fri, 2019-07-12 at 19:37 +1000, Alexey Kardashevskiy wrote:
> > > 
> > 
> > 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kernel/irq.c#n614
> > > 
> > > If so, then in order to do EOI, I'll need the desc which is gone,
> > > or
> > > I am missing the point?
> > 
> > All you need is drop the local CPU priority.
> 
> I know that, the question was how. I cannot use irq_chip in
> arch/powerpc/kernel/irq.c and I do not want to add
> ppc_md.enable_irqs().

Well, best is probably to do just that though, but call it something
like ppc_md.orphan_irq() or something like that instead. Another option
as you mention is to try to scrub queues, but that's trickier to do due
to the lockless nature of the queue handling.

Cheers,
Ben.


