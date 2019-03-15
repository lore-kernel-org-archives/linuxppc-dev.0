Return-Path: <SRS0=ejpM=RS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D36C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 14:28:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F77F2186A
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Mar 2019 14:28:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="SIuQIDiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F77F2186A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44LScG1Z8BzDqQS
	for <linuxppc-dev@archiver.kernel.org>; Sat, 16 Mar 2019 01:28:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="SIuQIDiW"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44LSZ229PCzDqPc
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Mar 2019 01:26:32 +1100 (AEDT)
Received: from localhost (unknown [76.14.1.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A291921872;
 Fri, 15 Mar 2019 14:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1552659989;
 bh=5NfJ9fNP7IYxIHE36OaxvdtPmt81EtaYZPuMMYyW4QU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=SIuQIDiWMWkB77idLoA1H5mfil5KfFK7yg+KM3bH5NvBxug45WYf69EHqC7o+mWSh
 Sqo0ZfAy747Mzl1VPCUsoU/GuXIVorVi9kLEN2/Tfv/2+aoi/XDOq1B0MgqbjtfYZk
 8uZDIMzTqFBvWqreZvB8jiluoRiifRtPoedTL8ps=
Date: Fri, 15 Mar 2019 07:26:28 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Subject: Re: [PATCH v2 10/45] drivers: tty: serial: zs: use devm_* functions
Message-ID: <20190315142628.GA30650@kroah.com>
References: <1552602855-26086-1-git-send-email-info@metux.net>
 <1552602855-26086-11-git-send-email-info@metux.net>
 <20190314225204.GB1795@kroah.com>
 <3734d588-6b9c-29e2-45b6-82e778f47602@metux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3734d588-6b9c-29e2-45b6-82e778f47602@metux.net>
User-Agent: Mutt/1.11.4 (2019-03-13)
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
 macro@linux-mips.org, jacmet@sunsite.dk, festevam@gmail.com,
 stefan.wahren@i2se.com, f.fainelli@gmail.com,
 bcm-kernel-feedback-list@broadcom.com, linux-imx@nxp.com,
 linux-serial@vger.kernel.org, slemieux.tyco@gmail.com, andy.gross@linaro.org,
 tklauser@distanz.ch, david.brown@linaro.org, rjui@broadcom.com,
 s.hauer@pengutronix.de, u.kleine-koenig@pengutronix.de,
 linuxppc-dev@lists.ozlabs.org, vz@mleia.com, matthias.bgg@gmail.com,
 andriy.shevchenko@linux.intel.com, baohua@kernel.org, sbranden@broadcom.com,
 eric@anholt.net, richard.genoud@gmail.com, "Enrico Weigelt,
 metux IT consult" <info@metux.net>, linux-kernel@vger.kernel.org,
 kernel@pengutronix.de, shawnguo@kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 15, 2019 at 10:06:16AM +0100, Enrico Weigelt, metux IT consult wrote:
> On 14.03.19 23:52, Greg KH wrote:
> > On Thu, Mar 14, 2019 at 11:33:40PM +0100, Enrico Weigelt, metux IT consult wrote:
> >> Use the safer devm versions of memory mapping functions.
> > 
> > What is "safer" about them?
> 
> Garbage collection :)

At times, but not when you do not use the api correctly :)

> Several drivers didn't seem to clean up properly (maybe these're just
> used compiled-in, so nobody noticed yet).

Yes, there are lots of drivers for devices that are never unloaded or
removed from the system.  The fact that no one has reported any problems
with them means that they are never used in situations like this.

> In general, I think devm_* should be the standard case, unless there's
> a really good reason to do otherwise.

No, you need to have a good reason why it needs to be changed, when you
can not verify that this actually resolves a problem.  As this patch
shows, you just replaced one api call with another, so nothing changed
at all, except you actually took up more memory and logic to do the same
thing :(

> > Isn't the whole goal of the devm* functions such that you are not
> > required to call "release" on them?
> 
> Looks that one slipped through, when I was doing that big bulk change
> in the middle of the night and not enough coffe ;-)
> 
> One problem here is that many drivers do this stuff in request/release
> port, instead of probe/remove. I'm not sure yet, whether we should
> rewrite that. There're also cases which do request/release, but no
> ioremap (doing hardcoded register accesses), others do ioremap w/o
> request/release.
> 
> IMHO, we should have a closer look at those and check whether that's
> really okay (just adding request/release blindly could cause trouble)

I agree, please feel free to audit these to verify they are all correct.
But that's not what you did here, so that's not a valid justification
for these patches to be accepted.

> > And also, why make the change, you aren't changing any functionality for
> > these old drivers at all from what I can tell (for the devm calls).
> > What am I missing here?
> 
> Okay, there's a bigger story behind, you can't know yet. Finally, I'd
> like to move everything to using struct resource and corresponding
> helpers consistently, so most of the drivers would be pretty simple
> at that point. (there're of course special cases, like devices w/
> multiple register spaces, etc)
> 
> Here's my wip branch:
> 
> https://github.com/metux/linux/commits/wip/serial-res
> 
> In this consolidation process, I'm trying to move everything to
> devm_*, to have it more generic (for now, I still need two versions
> of the request/release/ioremap/iounmap helpers - one w/ and one
> w/o devm).

Move everything in what part of the kernel?  The whole kernel or just
one subsystem?

> My idea was moving to devm first, so it can be reviewed/tested
> independently, before moving forward. Smaller, easily digestable
> pieces should minimize the risk of breaking anything. But if you
> prefer having this things squashed together, just let me know.

Small pieces are required, that's fine, but those pieces need to have a
justification for why they should be accepted at all points along the
way.

> In the queue are also other minor cleanups like using dev_err()
> instead of printk(), etc. Should I send these separately ?

Of course.

> By the way: do you have some public branch where you're collecting
> accepted patches, which I could base mine on ? (tty.git/tty-next ?)

Yes, that is the tree and branch, but remember that none of my trees can
open up until after -rc1 is out.

thanks,

greg k-h
