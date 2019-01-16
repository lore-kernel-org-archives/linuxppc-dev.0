Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6E3C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 01:17:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2DB3D20657
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 01:17:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2DB3D20657
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fTp75s7gzDqTw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 12:17:19 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fTmH3h2VzDqSt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 12:15:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43fTmH23qDz8tkv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 12:15:43 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43fTmH1Zqmz9sDn; Wed, 16 Jan 2019 12:15:43 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43fTmD6N2Jz9sDT
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2019 12:15:40 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x0G1FFmb013345;
 Tue, 15 Jan 2019 19:15:23 -0600
Message-ID: <8f112153558ae8ffdefba905d83329c8e896d3a9.camel@kernel.crashing.org>
Subject: Re: G5 Quad hangs early on 4.20.2 / 5.0-rc2+
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tobias Ulmer <tobiasu@tmux.org>, linuxppc-dev@ozlabs.org
Date: Wed, 16 Jan 2019 12:15:14 +1100
In-Reply-To: <20190115224945.fvyrjjf3mjywq7u6@atom2.tmux.org>
References: <20190115224945.fvyrjjf3mjywq7u6@atom2.tmux.org>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2019-01-15 at 23:49 +0100, Tobias Ulmer wrote:
> Hi,
> 
> both the latest stable 4.20.2 and 5.0 rc2+ hang early on the G5 Quad.
> 
> Surely I'm not the first to run into this, but I couldn't find any
> discussion or bug report. Sorry if you're already aware.
> 
> You can see it hang here (5.0 rc2+, 4.20.2 is nearly identical) until
> the watchdog triggers a reboot:
> 
> https://i.imgur.com/UiCVRuG.jpg
> 
> If I had to make an uneducated guess, it seems to boot into the same
> codepath twice (mpic was already initialized, then it starts again right
> after smp bringup). Maybe on a second CPU?
> 
> To narrow it down a little, my last known good was 4.18.9

I don't think it's an MPIC related problem but it does appear to hang
about when interrupts get turned on.

I have one of these critters in the office, but I'm working remotely
this week so I won't be able to dig into this until next week.

It might help if you could bisect in the meantime.

Cheers,
Ben.


