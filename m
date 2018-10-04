Return-Path: <SRS0=m9yV=MQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_NEOMUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D8E2C64EBC
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 10:31:31 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A24B2098A
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 10:31:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A24B2098A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=iram.es
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Qq1X3JdFzF3Jn
	for <linuxppc-dev@archiver.kernel.org>; Thu,  4 Oct 2018 20:31:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=iram.es
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=iram.es
 (client-ip=2001:720:418:ca03::84; helo=telmad-lavadora-l1mail2.puc.rediris.es;
 envelope-from=paubert@iram.es; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=iram.es
X-Greylist: delayed 722 seconds by postgrey-1.36 at bilbo;
 Thu, 04 Oct 2018 20:29:07 AEST
Received: from telmad-lavadora-l1mail2.puc.rediris.es
 (te-l1mail2-out02a.puc.rediris.es [IPv6:2001:720:418:ca03::84])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Qpyq4zWLzF3Fq
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Oct 2018 20:29:07 +1000 (AEST)
X-IPAS-Result: =?us-ascii?q?A2ETAACp57VblysYzoJbGwEBAQEDAQEBBwMBAQGBUgUBAQE?=
 =?us-ascii?q?LAQGDaY0Qiz6CDZZegXoNhGwChCMhNQwNAQMBAQEBAQECAgIQAQEBAQEIFgZYQ?=
 =?us-ascii?q?gEMAYRqAQEBAQIBOj8QCxIGCSUPOg4GgzSBegcBpSKKF4skF4IAhCSKVgKdBlA?=
 =?us-ascii?q?JiVmGXCKBPQ+HboYvlV6BJCADggkzGggwgyiCMo4jh3mGCwEB?=
X-IronPort-AV: E=Sophos;i="5.54,338,1534802400"; d="scan'208";a="279778279"
Received: from mta-out01.sim.rediris.es ([130.206.24.43])
 by smtpout.puc.rediris.es with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 04 Oct 2018 12:16:50 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mta-out01.sim.rediris.es (Postfix) with ESMTP id 3C0E2100552;
 Thu,  4 Oct 2018 12:16:50 +0200 (CEST)
Received: from mta-out01.sim.rediris.es ([127.0.0.1])
 by localhost (mta-out01.sim.rediris.es [127.0.0.1]) (amavisd-new, port 10032)
 with ESMTP id s4cV3sAc4i-Z; Thu,  4 Oct 2018 12:16:44 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by mta-out01.sim.rediris.es (Postfix) with ESMTP id 18089100554;
 Thu,  4 Oct 2018 12:16:44 +0200 (CEST)
X-Virus-Scanned: amavisd-new at mta-out01.sim.rediris.es
Received: from mta-out01.sim.rediris.es ([127.0.0.1])
 by localhost (mta-out01.sim.rediris.es [127.0.0.1]) (amavisd-new, port 10026)
 with ESMTP id VWi-3GGhoxk9; Thu,  4 Oct 2018 12:16:44 +0200 (CEST)
Received: from lt-gp.iram.es (gra-fw.iram.es [150.214.244.1])
 by mta-out01.sim.rediris.es (Postfix) with ESMTPA id BC0C7100552;
 Thu,  4 Oct 2018 12:16:43 +0200 (CEST)
Date: Thu, 4 Oct 2018 12:16:40 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Raz <raziebe@gmail.com>
Subject: Re: Looking for architecture papers
Message-ID: <20181004101640.t3o7v73fcipsjg3k@lt-gp.iram.es>
References: <CAPB=Z-rEoVWFFDBS_XhuOQyL+YxR8jScSAAQfO1X-n_Lbm=StA@mail.gmail.com>
 <87sh1nk70y.fsf@concordia.ellerman.id.au>
 <CAPB=Z-pLCkXcsAXD5YWt5pwPzFzJrdZsdDye_bZjE0-ea-Ur6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPB=Z-pLCkXcsAXD5YWt5pwPzFzJrdZsdDye_bZjE0-ea-Ur6A@mail.gmail.com>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Oct 04, 2018 at 10:41:13AM +0300, Raz wrote:
> Frankly, the more I read the more perplexed I get. For example,
> according to BOOK III-S, chapter 3,
> the MSR bits are differ from the ones described in
> arch/powerpc/include/asm/reg.h.
> Bit zero, is LE, but in the book it is 64-bit mode.

Just a problem of bit order definitions: IBM hardware definitions use
big-endian bit ordering, where bit 0 is the most significant bit.

> 
> Would someone be kind to explain what I do not understand?
> 
> Thank you

	Gabriel
