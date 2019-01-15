Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AF9C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 22:58:20 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E97A1208E4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 22:58:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E97A1208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tmux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fQjj3HYdzDqWR
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 09:58:17 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fQgz6wYyzDqW1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 09:56:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=tmux.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 43fQgz5rwFz8tRJ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 09:56:47 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 43fQgz54Wsz9sDn; Wed, 16 Jan 2019 09:56:47 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=fail (mailfrom) smtp.mailfrom=tmux.org
 (client-ip=2001:41d0:a:1408::1; helo=atom2.tmux.org;
 envelope-from=tobiasu@tmux.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=tmux.org
X-Greylist: delayed 415 seconds by postgrey-1.36 at bilbo;
 Wed, 16 Jan 2019 09:56:46 AEDT
Received: from atom2.tmux.org (unknown [IPv6:2001:41d0:a:1408::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 43fQgy3Ph5z9sD4
 for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2019 09:56:46 +1100 (AEDT)
Received: by atom2.tmux.org (Postfix, from userid 1000)
 id 7016761F9D; Tue, 15 Jan 2019 22:49:45 +0000 (UTC)
Date: Tue, 15 Jan 2019 23:49:45 +0100
From: Tobias Ulmer <tobiasu@tmux.org>
To: linuxppc-dev@ozlabs.org
Subject: G5 Quad hangs early on 4.20.2 / 5.0-rc2+
Message-ID: <20190115224945.fvyrjjf3mjywq7u6@atom2.tmux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20170113 (1.7.2)
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

Hi,

both the latest stable 4.20.2 and 5.0 rc2+ hang early on the G5 Quad.

Surely I'm not the first to run into this, but I couldn't find any
discussion or bug report. Sorry if you're already aware.

You can see it hang here (5.0 rc2+, 4.20.2 is nearly identical) until
the watchdog triggers a reboot:

https://i.imgur.com/UiCVRuG.jpg

If I had to make an uneducated guess, it seems to boot into the same
codepath twice (mpic was already initialized, then it starts again right
after smp bringup). Maybe on a second CPU?

To narrow it down a little, my last known good was 4.18.9
