Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEF2BC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 22:34:01 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F17420851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 22:34:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F17420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gf4k2SmFzDqsQ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 09:33:58 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gf2n1pRHzDqsD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 09:32:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43gf2n0gsnz8tTB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 09:32:17 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43gf2n0FjFz9sLt; Fri, 18 Jan 2019 09:32:17 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=benh@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43gf2m31w8z9sDr
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2019 09:32:16 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x0HMW82Q007933;
 Thu, 17 Jan 2019 16:32:10 -0600
Message-ID: <ae9672a789b29a546c12149650f0a7f6ab6b762d.camel@kernel.crashing.org>
Subject: Re: G5 Quad hangs early on 4.20.2 / 5.0-rc2+
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Tobias Ulmer <tobiasu@tmux.org>
Date: Fri, 18 Jan 2019 09:32:07 +1100
In-Reply-To: <20190117094214.26t72sdqknfzxvlx@atom2.tmux.org>
References: <20190115224945.fvyrjjf3mjywq7u6@atom2.tmux.org>
 <8f112153558ae8ffdefba905d83329c8e896d3a9.camel@kernel.crashing.org>
 <20190117094214.26t72sdqknfzxvlx@atom2.tmux.org>
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2019-01-17 at 10:42 +0100, Tobias Ulmer wrote:
> On Wed, Jan 16, 2019 at 12:15:14PM +1100, Benjamin Herrenschmidt wrote:
> > On Tue, 2019-01-15 at 23:49 +0100, Tobias Ulmer wrote:
> > > Hi,
> > > 
> > > both the latest stable 4.20.2 and 5.0 rc2+ hang early on the G5 Quad.
> > > 
> > > Surely I'm not the first to run into this, but I couldn't find any
> > > discussion or bug report. Sorry if you're already aware.
> > > 
> > > You can see it hang here (5.0 rc2+, 4.20.2 is nearly identical) until
> > > the watchdog triggers a reboot:
> > > 
> > > https://i.imgur.com/UiCVRuG.jpg
> > > 
> > > If I had to make an uneducated guess, it seems to boot into the same
> > > codepath twice (mpic was already initialized, then it starts again right
> > > after smp bringup). Maybe on a second CPU?
> > > 
> > > To narrow it down a little, my last known good was 4.18.9
> > 
> > I don't think it's an MPIC related problem but it does appear to hang
> > about when interrupts get turned on.
> 
> When they get turned on for the second time, for some reason. You can see the
> end of the first time just on top of the screen.

No, that top of screen init is something else.

> It repeats part of the startup initialization right after it's done with
> smp bringup.

That's just the BootX console hanging over to the main console and
replaying the messages I think.

> > I have one of these critters in the office, but I'm working remotely
> > this week so I won't be able to dig into this until next week.
> > 
> > It might help if you could bisect in the meantime.
> 
> I'm bisecting it now, but it's slow going since I don't have much time
> to babysit the machine. The problem shows up somewhere between v4.19 and
> v4.20.

Ok, thanks.

I'll be back on monday or tuesday, let me know where you got up to then
and I'll take it from there. Also email me your .config please.

Cheers,
Ben.

> > Cheers,
> > Ben.
> > 
> > 

