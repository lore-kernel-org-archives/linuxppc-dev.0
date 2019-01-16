Return-Path: <SRS0=yyDT=PY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D72C43387
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 07:00:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 04B6E2082F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 07:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 04B6E2082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43fdQc0kYMzDqTw
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Jan 2019 18:00:56 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43fdKl6zxDzDqV7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jan 2019 17:56:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43fdKl4D9rz9sDB; Wed, 16 Jan 2019 17:56:43 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43fdKl2MSdz9sD4;
 Wed, 16 Jan 2019 17:56:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tobias Ulmer <tobiasu@tmux.org>, linuxppc-dev@ozlabs.org
Subject: Re: G5 Quad hangs early on 4.20.2 / 5.0-rc2+
In-Reply-To: <20190115224945.fvyrjjf3mjywq7u6@atom2.tmux.org>
References: <20190115224945.fvyrjjf3mjywq7u6@atom2.tmux.org>
Date: Wed, 16 Jan 2019 17:56:39 +1100
Message-ID: <87r2ddxf88.fsf@concordia.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Tobias Ulmer <tobiasu@tmux.org> writes:
> Hi,
>
> both the latest stable 4.20.2 and 5.0 rc2+ hang early on the G5 Quad.
>
> Surely I'm not the first to run into this, but I couldn't find any
> discussion or bug report. Sorry if you're already aware.

Actually you're probably the first to hit it :)

I have a quad but it never gets to openfirmware and I haven't had time
to look into why.

My iMac G5 and dual G5 are booting OK though.

> You can see it hang here (5.0 rc2+, 4.20.2 is nearly identical) until
> the watchdog triggers a reboot:
>
> https://i.imgur.com/UiCVRuG.jpg
>
> If I had to make an uneducated guess, it seems to boot into the same
> codepath twice (mpic was already initialized, then it starts again right
> after smp bringup). Maybe on a second CPU?

Can you compare to a working boot log, does that give us any clues?

Can you post your full .config for the non-working case.

cheers
