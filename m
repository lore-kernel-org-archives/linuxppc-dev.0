Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B65D3C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 13:50:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06C4A20851
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 13:50:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06C4A20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gQSM5K31zDqjZ
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Jan 2019 00:50:11 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gQBc3LRbzDqtn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Jan 2019 00:38:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43gQBc1ZYtz9sCX; Fri, 18 Jan 2019 00:38:16 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43gQBb6vlQz9sBn;
 Fri, 18 Jan 2019 00:38:15 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tobias Ulmer <tobiasu@tmux.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: G5 Quad hangs early on 4.20.2 / 5.0-rc2+
In-Reply-To: <20190117094214.26t72sdqknfzxvlx@atom2.tmux.org>
References: <20190115224945.fvyrjjf3mjywq7u6@atom2.tmux.org>
 <8f112153558ae8ffdefba905d83329c8e896d3a9.camel@kernel.crashing.org>
 <20190117094214.26t72sdqknfzxvlx@atom2.tmux.org>
Date: Fri, 18 Jan 2019 00:38:12 +1100
Message-ID: <87lg3j4d6j.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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

Tobias Ulmer <tobiasu@tmux.org> writes:
> On Wed, Jan 16, 2019 at 12:15:14PM +1100, Benjamin Herrenschmidt wrote:
>> On Tue, 2019-01-15 at 23:49 +0100, Tobias Ulmer wrote:
>> > Hi,
>> > 
>> > both the latest stable 4.20.2 and 5.0 rc2+ hang early on the G5 Quad.
>> > 
>> > Surely I'm not the first to run into this, but I couldn't find any
>> > discussion or bug report. Sorry if you're already aware.
>> > 
>> > You can see it hang here (5.0 rc2+, 4.20.2 is nearly identical) until
>> > the watchdog triggers a reboot:
>> > 
>> > https://i.imgur.com/UiCVRuG.jpg
>> > 
>> > If I had to make an uneducated guess, it seems to boot into the same
>> > codepath twice (mpic was already initialized, then it starts again right
>> > after smp bringup). Maybe on a second CPU?
>> > 
>> > To narrow it down a little, my last known good was 4.18.9
>> 
>> I don't think it's an MPIC related problem but it does appear to hang
>> about when interrupts get turned on.
>
> When they get turned on for the second time, for some reason. You can see the
> end of the first time just on top of the screen.
>
> It repeats part of the startup initialization right after it's done with
> smp bringup.
>
>> 
>> I have one of these critters in the office, but I'm working remotely
>> this week so I won't be able to dig into this until next week.
>> 
>> It might help if you could bisect in the meantime.
>
> I'm bisecting it now, but it's slow going since I don't have much time
> to babysit the machine. The problem shows up somewhere between v4.19 and
> v4.20.

Can you try:

58cfbac25b1f ("Revert "selftests/powerpc: Fix out-of-tree build errors"")

If that's bad and v4.19 is good that would isolate it to about 222
commits.

cheers
