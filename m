Return-Path: <SRS0=lnSH=6X=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD80C28CBC
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 08:37:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A49C24957
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 08:37:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A49C24957
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=popple.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49K0v628gCzDr1r
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 May 2020 18:37:38 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49K0sP687FzDr1c
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 May 2020 18:36:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=popple.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49K0sN3JVtz9sSc;
 Sat,  9 May 2020 18:36:08 +1000 (AEST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH RFC 2/4] powerpc: Add Microwatt platform
Date: Sat, 09 May 2020 18:36:05 +1000
Message-ID: <2771261.oJVn4HZnso@townsend>
In-Reply-To: <1589010752.ygtog0nhjc.astroid@bobo.none>
References: <20200509050103.GA1464954@thinks.paulus.ozlabs.org>
 <20200509050255.GC1464954@thinks.paulus.ozlabs.org>
 <1589010752.ygtog0nhjc.astroid@bobo.none>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
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
Cc: Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@ozlabs.org>, linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Saturday, 9 May 2020 5:58:57 PM AEST Nicholas Piggin wrote:
> Excerpts from Paul Mackerras's message of May 9, 2020 3:02 pm:
> > Microwatt is a FPGA-based implementation of the Power ISA.  It
> > currently only implements little-endian 64-bit mode, and does
> > not (yet) support SMP.
> > 
> > This adds a new machine type to support FPGA-based SoCs with a
> > Microwatt core.
> 
> Very cool!
> 
> Would there be any point sharing this with the "naked metal" platform
> Alistair has for booting POWER in L3 without OPAL? Or is it easy enough
> to have a several different simple 64s platforms?

It looks pretty similar at the moment, I've been meaning to clean those 
patches up and send them upstream but Paul has beaten me to it. The main 
difference so far is how the console is setup. For booting cache contained I 
was using a device tree pointing at a standard UART driver and enabling the 
standard OF platform device tree probing.

- Alistair

> I have an HPT conditional compile patch and a few other diet Kconfig
> things I'll now be better justified to try get merged :)
> 
> Thanks,
> Nick




