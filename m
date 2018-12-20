Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7370EC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 22:37:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D81DE206C0
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 22:37:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D81DE206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43LRTr2TgPzDr9Q
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Dec 2018 09:37:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43LRRb4mCbzDr1G
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Dec 2018 09:35:39 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id wBKMZGIx021490;
 Thu, 20 Dec 2018 16:35:18 -0600
Message-ID: <ab9139902a64f8d0b187f7db0f8a16a5b85791ac.camel@kernel.crashing.org>
Subject: Re: [RFC/WIP] powerpc: Fix 32-bit handling of MSR_EE on exceptions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Date: Fri, 21 Dec 2018 09:35:16 +1100
In-Reply-To: <cbce315b-82f9-c748-92e4-97bb819c9098@c-s.fr>
References: <fe3a79e078c644d9c1379ef5f8c431d787b6d0c8.camel@kernel.crashing.org>
 <cbce315b-82f9-c748-92e4-97bb819c9098@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.2 (3.30.2-2.fc29) 
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


> >   /*
> >    * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
> > @@ -205,20 +208,46 @@ transfer_to_handler_cont:
> >   	mflr	r9
> >   	lwz	r11,0(r9)		/* virtual address of handler */
> >   	lwz	r9,4(r9)		/* where to go when done */
> > +#if defined(CONFIG_PPC_8xx) && defined(CONFIG_PERF_EVENTS)
> > +	mtspr	SPRN_NRI, r0
> > +#endif
> 
> That's not part of your patch, it's already in the tree.

Yup rebase glitch.

 .../...

> I tested it on the 8xx with the below changes in addition. No issue seen 
> so far.

Thanks !

I'll merge that in.

The main obscure area is that business with the irqsoff tracer and thus
the need to create stack frames around calls to trace_hardirqs_* ... we
do it in some places and not others, but I've not managed to make it
crash either. I need to get to the bottom of that, and possibly provide
proper macro helpers like ppc64 has to do it.

Cheers,
Ben.

