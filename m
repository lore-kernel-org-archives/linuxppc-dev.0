Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0298EC43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 09:38:22 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35D7820825
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 09:38:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HdG1U4+q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35D7820825
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wbrq1NK7zF3bg
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 20:38:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="HdG1U4+q";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=armlinux.org.uk
 (client-ip=2001:4d48:ad52:3201:214:fdff:fe10:1be6;
 helo=pandora.armlinux.org.uk;
 envelope-from=linux+linuxppc-dev=lists.ozlabs.org@armlinux.org.uk;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none)
 header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=armlinux.org.uk header.i=@armlinux.org.uk
 header.b="HdG1U4+q"; dkim-atps=neutral
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wbnW2tRDzF3Dy
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 20:35:26 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=09YY7YoaoRCvHZorbu+qP8nq6GqCbLlUMgeWiTCmBHk=; b=HdG1U4+q5nR8d0DJ8KQfm+QlO
 xGOWi6ElBRfTk7cvQzNG2zi6josIoDi7GxVNBDPkX8YqZnX/sqsnHC/KXrvDiyB/Zm+ZkUgyt4JAq
 yqm4+yoR1WC8si23eO7UKCczECSRkYyDjfen+3UqQzGofjmNxktOKPsQ9/EH+wYdyoFDI=;
Received: from n2100.armlinux.org.uk
 ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:44148)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gNE25-0001yc-1J; Thu, 15 Nov 2018 09:33:53 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gNE21-00022d-QO; Thu, 15 Nov 2018 09:33:49 +0000
Date: Thu, 15 Nov 2018 09:33:48 +0000
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: LABBE Corentin <clabbe@baylibre.com>
Subject: Re: [PATCH v3 0/7] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64
Message-ID: <20181115093348.GV30658@n2100.armlinux.org.uk>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
 <20181024085700.GR30658@n2100.armlinux.org.uk>
 <20181115093034.GB23965@Red>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181115093034.GB23965@Red>
User-Agent: Mutt/1.5.23 (2014-03-12)
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
Cc: Gilles.Muller@lip6.fr, maxime.ripard@bootlin.com,
 dri-devel@lists.freedesktop.org, linux-ide@vger.kernel.org,
 linux-sunxi@googlegroups.com, paulus@samba.org,
 linux-amlogic@lists.infradead.org, cocci@systeme.lip6.fr,
 narmstrong@baylibre.com, airlied@linux.ie, wens@csie.org, joabreu@synopsys.com,
 agust@denx.de, alexandre.torgue@st.com, alistair@popple.id.au,
 nicolas.palix@imag.fr, oss@buserror.net, Julia.Lawall@lip6.fr,
 linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
 peppe.cavallaro@st.com, linux-arm-kernel@lists.infradead.org,
 michal.lkml@markovi.net, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 khilman@baylibre.com, carlo@caione.org, tj@kernel.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, Nov 15, 2018 at 10:30:34AM +0100, LABBE Corentin wrote:
> On Wed, Oct 24, 2018 at 09:57:00AM +0100, Russell King - ARM Linux wrote:
> > On Wed, Oct 24, 2018 at 07:35:46AM +0000, Corentin Labbe wrote:
> > > This patchset adds a new set of functions which are open-coded in lot of
> > > place.
> > > Basicly the pattern is always the same, "read, modify a bit, write"
> > > some driver and the powerpc arch already have thoses pattern them as functions. (like ahci_sunxi.c or dwmac-meson8b)
> > 
> > The advantage of them being open-coded is that it's _obvious_ to the
> > reviewer that there is a read-modify-write going on which, in a multi-
> > threaded environment, may need some locking (so it should trigger a
> > review of the locking around that code.)
> > 
> > With it hidden inside a helper which has no locking itself, it becomes
> > much easier to pass over in review, which means that races are much
> > more likely to go unspotted - and that is bad news.
> > 
> 
> Hello
> 
> I understand your fear, but I think the benefit overhaul thoses.
> Furthermore, drivers which I have converted does not need such locking.
> 
> If you want I can rename the header to linux/setbits-non-atomic.h for making obvious the lack of locking.

It'd probably be better in the function name - it then doesn't get
"lost" that it's non-atomic when it's included via other headers.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
