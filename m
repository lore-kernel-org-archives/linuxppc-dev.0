Return-Path: <SRS0=BcJT=SB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9918C43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 23:16:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2074520989
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 23:16:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2074520989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44Wvc41MlZzDqPv
	for <linuxppc-dev@archiver.kernel.org>; Sun, 31 Mar 2019 10:16:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44WvZ602CHzDqMS
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Mar 2019 10:14:20 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x2UNE8OW009809;
 Sat, 30 Mar 2019 18:14:09 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x2UNE5ku009804;
 Sat, 30 Mar 2019 18:14:05 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Sat, 30 Mar 2019 18:14:03 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Cree <mcree@orcon.net.nz>, George Spelvin <lkml@sdf.org>,
 linux-alpha@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: CONFIG_ARCH_SUPPORTS_INT128: Why not mips, s390, powerpc,
 and alpha?
Message-ID: <20190330231402.GM3969@gate.crashing.org>
References: <201903291307.x2TD772v013534@sdf.org>
 <20190329200015.ujmjrvn6ta67h74j@tower>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190329200015.ujmjrvn6ta67h74j@tower>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Mar 30, 2019 at 09:00:15AM +1300, Michael Cree wrote:
> It does move the umulh inside the loop but that seems sensible since
> the use of unlikely() implies that the loop is unlikely to be taken
> so on average it would be a good bet to start the calculation of
> umulh earlier since it has a few cycles latency to get the result,
> and it is pipelined so it can be calculated in the shadow of the
> mulq instruction on the same execution unit.

That may make sense, but it is not what happens, sorry.  It _starts off_
as part of the loop, and it is never moved outside.

The only difference between a likely loop and an unlikely loop here I've
seen (on all targets I tried) is that with a likely loop the loop target
is aligned, while with an unlikely loop it isn't.

> On the older CPUs
> (before EV6 which are not out-of-order execution) having the umulh
> inside the loop may be a net gain.

Yes.  Similarly, on Power you can often calculate the high mul at the same
time as the low mul, for no extra cost.  This may be true on many archs.


Segher
