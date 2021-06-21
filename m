Return-Path: <SRS0=Gjys=LP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1C62C4743C
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jun 2021 13:55:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1610560232
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jun 2021 13:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1610560232
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4G7rdp1Kb8z3bxf
	for <linuxppc-dev@archiver.kernel.org>; Mon, 21 Jun 2021 23:55:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=srs0=5kvv=lp=kernel.crashing.org=segher@ozlabs.org;
 receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4G7rdL2QtBz2yXP
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jun 2021 23:55:17 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by ozlabs.org (Postfix) with ESMTP id 4G7rdD4phHz9sWQ
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Jun 2021 23:55:12 +1000 (AEST)
Received: by ozlabs.org (Postfix)
 id 4G7rdD3bWqz9sWM; Mon, 21 Jun 2021 23:55:12 +1000 (AEST)
Authentication-Results: ozlabs.org;
 spf=permerror (SPF Permanent Error: Unknown mechanism
 found: ip:192.40.192.88/32) smtp.mailfrom=kernel.crashing.org
 (client-ip=63.228.1.57; helo=gate.crashing.org;
 envelope-from=segher@kernel.crashing.org; receiver=<UNKNOWN>)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 by ozlabs.org (Postfix) with ESMTP id 4G7rdD01htz9sVp;
 Mon, 21 Jun 2021 23:55:09 +1000 (AEST)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id 15LDs7KT011803;
 Mon, 21 Jun 2021 08:54:07 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id 15LDs7uO011802;
 Mon, 21 Jun 2021 08:54:07 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Mon, 21 Jun 2021 08:54:07 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Paul Mackerras <paulus@ozlabs.org>
Subject: Re: [PATCH v2 2/9] powerpc: Add Microwatt device tree
Message-ID: <20210621135407.GB5077@gate.crashing.org>
References: <YMwWPcsaWzMlDPqQ@thinks.paulus.ozlabs.org>
 <YMwWkPcXlGDSQ9Q3@thinks.paulus.ozlabs.org>
 <20210619142616.GW5077@gate.crashing.org>
 <YM8v2ricaCzGi2vv@thinks.paulus.ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YM8v2ricaCzGi2vv@thinks.paulus.ozlabs.org>
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sun, Jun 20, 2021 at 10:08:58PM +1000, Paul Mackerras wrote:
> On Sat, Jun 19, 2021 at 09:26:16AM -0500, Segher Boessenkool wrote:
> > On Fri, Jun 18, 2021 at 01:44:16PM +1000, Paul Mackerras wrote:
> > > Microwatt currently runs with MSR[HV] = 0,
> > 
> > That isn't compliant though?  If your implementation does not have LPAR
> > it must set MSR[HV]=1 always.
> 
> True - but if I actually do that, Linux starts trying to use hrfid
> (for example in masked_Hinterrupt), which Microwatt doesn't have.
> Something for Nick to fix. :)

That looks like it needs fixing, yes (it is hard to actually read).  But
one thing you can do to make this Just Work is to make hrfid do exactly
the same as rfid, i.e. decode hrfid (01000 10010) as rfid (00000 10010).
That probably makes things run already, you don't even need to alias
to SPRs HSRRn (01001 1101n) to SRRn (00000 1101n) :-)


Segher
