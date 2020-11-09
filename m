Return-Path: <SRS0=+X3i=EP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EDB5C2D0A3
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2020 12:42:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4764520659
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2020 12:42:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4764520659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CV9cy3xkGzDqLy
	for <linuxppc-dev@archiver.kernel.org>; Mon,  9 Nov 2020 23:42:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 4CV9Ws3k5NzDqNj
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 Nov 2020 23:38:12 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 0A9CY4kY014413;
 Mon, 9 Nov 2020 06:34:05 -0600
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 0A9CY3EW014410;
 Mon, 9 Nov 2020 06:34:03 -0600
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 9 Nov 2020 06:34:03 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Gabriel Paubert <paubert@iram.es>
Subject: Re: [PATCH] powerpc: add compile-time support for lbarx, lwarx
Message-ID: <20201109123403.GH2672@gate.crashing.org>
References: <20201107032328.2454582-1-npiggin@gmail.com>
 <20201107071213.GA30735@lt-gp.iram.es>
 <0810564117125.202011.20201107114257.GG2672@gate.crashing.org>
 <20201108200152.GA16446@lt-gp.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201108200152.GA16446@lt-gp.iram.es>
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
Cc: linuxppc-dev@lists.ozlabs.org, Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Nov 08, 2020 at 09:01:52PM +0100, Gabriel Paubert wrote:
> On Sat, Nov 07, 2020 at 05:42:57AM -0600, Segher Boessenkool wrote:
> > On Sat, Nov 07, 2020 at 08:12:13AM +0100, Gabriel Paubert wrote:
> > > On Sat, Nov 07, 2020 at 01:23:28PM +1000, Nicholas Piggin wrote:
> > > > ISA v2.06 (POWER7 and up) as well as e6500 support lbarx and lwarx.
> > > 
> > > Hmm, lwarx exists since original Power AFAIR,
> > 
> > Almost: it was new on PowerPC.
> 
> I stand corrected. Does this mean that Power1 (and 2 I believe) had 
> no SMP support?

As I understand it, that's correct.  Of course you always can do SMP "by
hand" -- you can do all synchronisation via software (perhaps using some
knowledge of the specific hardware you're running on), it's just slow
(and usually not portable).  Compare to SMP on 603 for example.


Segher
