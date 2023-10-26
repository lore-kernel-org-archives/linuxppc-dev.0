Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB7ECC25B48
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Oct 2023 09:52:23 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; secure) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=WTQSftlB;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SGLgV2d0Rz3cWs
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Oct 2023 20:52:22 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=sipsolutions.net header.i=@sipsolutions.net header.a=rsa-sha256 header.s=mail header.b=WTQSftlB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sipsolutions.net (client-ip=2a01:4f8:242:246e::2; helo=sipsolutions.net; envelope-from=johannes@sipsolutions.net; receiver=lists.ozlabs.org)
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SGLfX2sy0z300g
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Oct 2023 20:51:31 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=JE/wzep2Kl9fulvu7hozBAZLnaAXZolsk/A0oBuPFR0=;
	t=1698313890; x=1699523490; b=WTQSftlB5iWGah88payNKi3UJmY9R1nfARzh0fdlyMBfQJ5
	a7wxobJCc7TvN3L5mJV4m9yutMT83kU0g1EH5KAX/fVJN8bxGg1y9LVVm9tbaoTM43mJUarXUyTqQ
	8+JKMSj2tIxZcmTTEuoLntEuiKW5pl2+8mo132oRvFCTVhX5sYuT1D4iXf82PjGDb+FmmkIM+hvw9
	1ugUCxe5wykfso1ql7RM33jPmwLqVP/UZ5k5E/nVI8pPTm3rPrxY+q6IDk0BQTDWNdk9Y7qKtXuKk
	uG5EAAf7O+fVnx0IBXv8GJSCVDnFSBck+CmZ1KI/FQ8OPcKsGRir6Ws+tU+0UtGg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qvx1A-00000003a91-3X6O;
	Thu, 26 Oct 2023 11:51:09 +0200
Message-ID: <14bd2e39338dd755f7bfde23a93563865580ee83.camel@sipsolutions.net>
Subject: Re: [PATCH 10/10] [RFC] wifi: remove ipw2100/ipw2200 drivers
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>, Philipp Hortmann
	 <philipp.g.hortmann@gmail.com>
Date: Thu, 26 Oct 2023 11:51:07 +0200
In-Reply-To: <87jzr9d883.fsf@kernel.org>
References: 	<CAEGMnwo6RFqADPO5FRkRUNL=GfV6DY8UuwgsypEYOD3LTnXdJg@mail.gmail.com>
	 <c608f328-387e-431b-b3c2-4b8fa0c4f11f@gmail.com>
	 <87jzr9d883.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
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
Cc: alexandre.belloni@bootlin.com, linux-kernel@vger.kernel.org, Witold Baryluk <witold.baryluk@gmail.com>, pavel@ucw.cz, gregory.greenman@intel.com, stf_xl@wp.pl, linux-staging@lists.linux.dev, ilw@linux.intel.com, geert@linux-m68k.org, kuba@kernel.org, stas.yakovlev@gmail.com, arnd@arndb.de, nicolas.ferre@microchip.com, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org, arnd@kernel.org, geoff@infradead.org, gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org, claudiu.beznea@tuxon.dev, quic_jjohnson@quicinc.com, davem@davemloft.net, Larry.Finger@lwfinger.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2023-10-26 at 12:49 +0300, Kalle Valo wrote:
> Philipp Hortmann <philipp.g.hortmann@gmail.com> writes:
>=20
> > On 10/26/23 00:27, Witold Baryluk wrote:
> > > I might be interested in modernizing the driver, but I have no idea
> > > how much effort it would be (in terms of changed fraction of code).
> > > 20k LOC is neither small or big, and not obvious (a lot of it would
> > > be unchanged), if it is a week of work, or months of work.
> >=20
> > Hi Witold,
> >=20
> > I am trying to do this with rtl8192e.
> > One possibility is to take the following patch series as a starting poi=
nt:
> > https://yhbt.net/lore/all/1414604649-9105-1-git-send-email-tvboxspy@gma=
il.com/
> >=20
> > For me as a beginner and hobbyist this is a huge task. I am happy when
> > I can finish it until next summer.
>=20
> We also have some docs available:
>=20
> https://docs.kernel.org/driver-api/80211/
>=20
> And I also recommend looking at our hwsim driver as that gives a good
> idea how a simple mac80211 driver works:
>=20

FWIW, I don't think this can be ported to mac80211 - only cfg80211. It's
a fullMAC device.

johannes
