Return-Path: <SRS0=Hff1=NE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85B31C004D3
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 09:03:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ED7DA207DD
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 09:03:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WwE3MZqF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED7DA207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42g46L71vTzDrNS
	for <linuxppc-dev@archiver.kernel.org>; Wed, 24 Oct 2018 20:03:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="WwE3MZqF";
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
 header.b="WwE3MZqF"; dkim-atps=neutral
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk
 [IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42g42018sBzDrNV
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Oct 2018 19:59:20 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AYjQXz6bWR7JipRLfWzRXi6RiUNUoM4GnTU6Fp8/nso=; b=WwE3MZqF54u7xkalUcVPZwax+
 EPpJ3cJ3Se6npXOhNxieBaET0Oq/+iqGjBmoay2rtPFxktt76MdNVyrzVWAoCbicmg3LXwcvtSgvR
 4iNDOGN4TuaOIDWQriyAFmqUz/W0vDCV6QK5dPr79Y8abhj+22fr2SWl2EuMLno3lG1EE=;
Received: from n2100.armlinux.org.uk
 ([2002:4e20:1eda:1:214:fdff:fe10:4f86]:57936)
 by pandora.armlinux.org.uk with esmtpsa
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 (envelope-from <linux@armlinux.org.uk>)
 id 1gFEyX-00018S-Cc; Wed, 24 Oct 2018 09:57:13 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
 (envelope-from <linux@n2100.armlinux.org.uk>)
 id 1gFEyP-0007Cw-2L; Wed, 24 Oct 2018 09:57:05 +0100
Date: Wed, 24 Oct 2018 09:57:00 +0100
From: Russell King - ARM Linux <linux@armlinux.org.uk>
To: Corentin Labbe <clabbe@baylibre.com>
Subject: Re: [PATCH v3 0/7] include: add
 setbits32/clrbits32/clrsetbits32/setbits64/clrbits64/clrsetbits64
Message-ID: <20181024085700.GR30658@n2100.armlinux.org.uk>
References: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1540366553-18541-1-git-send-email-clabbe@baylibre.com>
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

On Wed, Oct 24, 2018 at 07:35:46AM +0000, Corentin Labbe wrote:
> This patchset adds a new set of functions which are open-coded in lot of
> place.
> Basicly the pattern is always the same, "read, modify a bit, write"
> some driver and the powerpc arch already have thoses pattern them as functions. (like ahci_sunxi.c or dwmac-meson8b)

The advantage of them being open-coded is that it's _obvious_ to the
reviewer that there is a read-modify-write going on which, in a multi-
threaded environment, may need some locking (so it should trigger a
review of the locking around that code.)

With it hidden inside a helper which has no locking itself, it becomes
much easier to pass over in review, which means that races are much
more likely to go unspotted - and that is bad news.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
