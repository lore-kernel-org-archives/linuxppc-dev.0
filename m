Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,UNPARSEABLE_RELAY autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7119C43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 08:11:56 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4F02070D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 08:11:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4F02070D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux-mips.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44N86L0RXgzDqMB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 19:11:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=linux-mips.org
 (client-ip=148.251.95.138; helo=cvs.linux-mips.org;
 envelope-from=macro@linux-mips.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux-mips.org
X-Greylist: delayed 380 seconds by postgrey-1.36 at bilbo;
 Mon, 18 Mar 2019 19:10:21 AEDT
Received: from cvs.linux-mips.org (eddie.linux-mips.org [148.251.95.138])
 by lists.ozlabs.org (Postfix) with ESMTP id 44N84Y5KvwzDqJf
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 19:10:21 +1100 (AEDT)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
 with ESMTP id S23990398AbfCRIDyrirCY (ORCPT
 <rfc822;linuxppc-dev@lists.ozlabs.org>);
 Mon, 18 Mar 2019 09:03:54 +0100
Date: Mon, 18 Mar 2019 08:03:54 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_*
 functions
In-Reply-To: <fd8d6a9b-3e85-9904-2195-1f1bbc42bd2d@metux.net>
Message-ID: <alpine.LFD.2.21.1903162132540.31531@eddie.linux-mips.org>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-11-git-send-email-info@metux.net>
 <20190314225204.GB1795@kroah.com>
 <3734d588-6b9c-29e2-45b6-82e778f47602@metux.net>
 <20190315142628.GA30650@kroah.com>
 <d81364fc-c5da-c1b2-f38a-3a23c701c50d@metux.net>
 <20190316032630.GB2499@kroah.com>
 <fd8d6a9b-3e85-9904-2195-1f1bbc42bd2d@metux.net>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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
Cc: linux-arm-msm@vger.kernel.org, yamada.masahiro@socionext.com,
 jacmet@sunsite.dk, festevam@gmail.com, stefan.wahren@i2se.com,
 f.fainelli@gmail.com, bcm-kernel-feedback-list@broadcom.com, linux-imx@nxp.com,
 linux-serial@vger.kernel.org, u.kleine-koenig@pengutronix.de,
 andy.gross@linaro.org, tklauser@distanz.ch, david.brown@linaro.org,
 rjui@broadcom.com, s.hauer@pengutronix.de, slemieux.tyco@gmail.com,
 linuxppc-dev@lists.ozlabs.org, vz@mleia.com, matthias.bgg@gmail.com,
 andriy.shevchenko@linux.intel.com, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, baohua@kernel.org, sbranden@broadcom.com,
 eric@anholt.net, richard.genoud@gmail.com,
 Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, shawnguo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 16 Mar 2019, Enrico Weigelt, metux IT consult wrote:

> > No, it's just that those systems do not allow those devices to be
> > removed because they are probably not on a removable bus.
> 
> Ok, devices (hw) might not be removable - that also the case for uarts
> builtin some SoCs, or the good old PC w/ 8250. But does that also mean
> that the driver should not be removable ?
> 
> IMHO, even if that's the case, it's still inconsistent. The driver then
> shouldn't support a remove at all (or even builtin only), not just
> incomplete remove.

 This device (as well as `dz') is typically used for the serial console as 
well, so being built-in is the usual configuration.  Nevertheless modular 
operation is supposed to be supported, however it may not have been 
verified for ages.

 A further complication is in the virtual console configuration one of the 
serial lines is dedicated for the keyboard, so again you want the driver 
built-in (although hooking up the virtual console keyboard this way has 
been broken with the conversion to the serial core in the 2.6 timeframe 
and I have never figured it out how it is supposed to be done correctly 
with the new serial infrastructure and SERIO_SERPORT; I believe some 
platforms do it with the use of horrible hacks rather than SERIO_SERPORT).

  Maciej
