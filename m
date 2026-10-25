Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66986606A31B
	for <linuxppc-dev@archiver.kernel.org>; Sun, 25 Oct 2026 18:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=mess.org header.i=@mess.org header.a=rsa-sha256 header.s=2020 header.b=F3YnqwGu;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.a=rsa-sha256 header.s=2020 header.b=Sm+nybpg
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jCQ7b1DfGz2xfK;
	Mon, 26 Oct 2026 05:21:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=92.243.27.206
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1792952491;
	cv=none; b=hgO5eLPfaNz3hDumMFFIz8LkJ66YhhZ+gv5rsrEvFXEKOinoh/5i7MsAKSBiCbQzzUVsMwoIHurKS3PsRCOPLZRfYcyRW53YtqnMb79E83+FvuB5xflrq52P308evwl9dRIFHTXG9qp5om3znEekTyJfRTKRp4xLN2Pu5DtmtRxtz7UcY0qwWdG/hGsFrGEvscuPHjdqOgc6HDWvrG/YpCsVugha0nVd1YjTAfXiK4imm4lOQ29QRgQltsaUdX2g05XhNKjXzw5xNezCe90zCXQWC0RirVRZQSfZmsfAfgxdetlX5O7IdYlFIGdjWBuBsvUwdbaRk/LvkLX3fKSjWA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1792952491; c=relaxed/relaxed;
	bh=VDOcdCB/ceu9dI5E4YRp4YfJPK0E5eXFSxgtP8WA174=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xuwvx/xP4+hkDRcGuC4poG3nHLZasmM+pg7xgBDoc3SqWQCQjvvRsRDZ93TSASmjUz9CTKeB0YmjMH6lIGLIrY24j0HGTztnydlxueQ2swJeL69/BmkN2whLrXDDkVEFOvp5JKaafLbhpnhiEiOkhNFfzUT4yKt6tyBU6Vvud3Jf5i2U/BDMXXRedBw5DqPBvwLNgV5KriihqcEHO1VlQ4M0Tjbni2h2E01iUYFjFZWvblTiji5K930sp/d1aR4aZsB5FbxEe/pUIoHYILve6cbPQDUePWDh7AUQvnpr4l66Wr2K30O5W/z2adK3UpoGasi5UfPcDXY+WM67jzWAXg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mess.org; dkim=pass (2048-bit key; secure) header.d=mess.org header.i=@mess.org header.a=rsa-sha256 header.s=2020 header.b=F3YnqwGu; dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.a=rsa-sha256 header.s=2020 header.b=Sm+nybpg; dkim-atps=neutral; spf=pass (client-ip=92.243.27.206; helo=extorris.mess.org; envelope-from=sean@mess.org; receiver=lists.ozlabs.org) smtp.mailfrom=mess.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=mess.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=mess.org header.i=@mess.org header.a=rsa-sha256 header.s=2020 header.b=F3YnqwGu;
	dkim=pass (2048-bit key) header.d=mess.org header.i=@mess.org header.a=rsa-sha256 header.s=2020 header.b=Sm+nybpg;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=mess.org (client-ip=92.243.27.206; helo=extorris.mess.org; envelope-from=sean@mess.org; receiver=lists.ozlabs.org)
X-Greylist: delayed 409 seconds by postgrey-1.37 at boromir; Mon, 26 Oct 2026 05:21:27 AEDT
Received: from extorris.mess.org (extorris.mess.org [92.243.27.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4jCQ7W69rMz2xKx
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2026 05:21:27 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1792952073; bh=SG6RSnwIodkLZ0jf3XSL8EmtbeEd/IryHUB/gLOA6XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F3YnqwGuhsvrYZvAH39BK8qNJgHxHUrjCkKtalF0Icgm0LYU59etXOkNvb3Z0n1dC
	 jhlkrZl89uSYc0bpsrrAdiiHgdSwM9H5w3sTuDhdEK45MJpQeMAO4s//pDpfRC/Tkt
	 eNfT6zRTx1jL91eu5ZwjosnAoTS/6epCjx7XOGd1yaVB+uSbbI7ZIQCGFDTdVy8/p1
	 Y/eLNNMxg7qQ6nNIu9WcMXO1zAFtG5fthdUB4VYLPUq+XjOk6C9urRVljkYmkat3sU
	 Y4QPs5F1IjnvlQB2LKrY4+h462zkykYbPZ8pBp2yuLfjCaZ44xUq8raHPDi+71a4TL
	 BKecQDeciv6/w==
Received: by extorris.mess.org (Postfix, from userid 1004)
	id D61D840B2F; Sun, 25 Oct 2026 18:14:33 +0000 (GMT)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
	t=1792952068; bh=SG6RSnwIodkLZ0jf3XSL8EmtbeEd/IryHUB/gLOA6XU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Sm+nybpg9jdcn7afkvNGNByeL1yUB7PizyOdhpO14wGI4cTeFxDCeLVZjKdDdPfvR
	 q68nN50ZUQiHl80nWRverREUNl/eeGGsYwuHY/VnPHCX3dp4PI58t3rLqhi4eAKMFQ
	 TPd+mqbDmhXxKGqX8YPpCyiOKMxTNJJ1meb3bVNdc5PRn8ZoRRzeHAifkszwXtoTzA
	 7HY4Mj95eoG4L04K5fcN0iG3rXc6OwlY6xw9YJbdLE+T3DSQ1AzOHZdwrcdqoOtw6T
	 nNrl1AgZzLyocG00S4aFmYImVtnSw3QeExI+4tY54EEjNb9Ed6kGQkmVHgdSWJJkL2
	 dzx8a6uoLRxVg==
Received: from maru.home (host86-145-132-241.range86-145.btcentralplus.com [86.145.132.241])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by extorris.mess.org (Postfix) with ESMTPSA id BCB234015D;
	Sun, 25 Oct 2026 18:14:27 +0000 (GMT)
From: Sean Young <sean@mess.org>
To: linux-media@vger.kernel.org,
	Sean Young <sean@mess.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Benjamin Valentin <benpicco@googlemail.com>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 5/5] media: rc: struct rc_map should have entries and capacity
Date: Sun, 25 Oct 2026 18:13:45 +0000
Message-ID: <b77a020ae14ee606ed6e5f7a1ec528df23a4de09.1792951808.git.sean@mess.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1792951808.git.sean@mess.org>
References: <cover.1792951808.git.sean@mess.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
Precedence: list
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The len and size members are confusing names, entries and capacity make
more sense. All the defined keymaps should be using entries and not size.

Signed-off-by: Sean Young <sean@mess.org>
---
 .../media/rc/keymaps/rc-adstech-dvb-t-pci.c   |  2 +-
 drivers/media/rc/keymaps/rc-alink-dtu-m.c     |  2 +-
 drivers/media/rc/keymaps/rc-anysee.c          |  2 +-
 drivers/media/rc/keymaps/rc-apac-viewcomp.c   |  2 +-
 .../media/rc/keymaps/rc-astrometa-t2hybrid.c  |  2 +-
 drivers/media/rc/keymaps/rc-asus-pc39.c       |  2 +-
 drivers/media/rc/keymaps/rc-asus-ps3-100.c    |  2 +-
 .../rc/keymaps/rc-ati-tv-wonder-hd-600.c      |  2 +-
 drivers/media/rc/keymaps/rc-ati-x10.c         |  2 +-
 drivers/media/rc/keymaps/rc-avermedia-a16d.c  |  2 +-
 .../media/rc/keymaps/rc-avermedia-cardbus.c   |  2 +-
 drivers/media/rc/keymaps/rc-avermedia-dvbt.c  |  2 +-
 drivers/media/rc/keymaps/rc-avermedia-m135a.c |  2 +-
 .../rc/keymaps/rc-avermedia-m733a-rm-k6.c     |  2 +-
 drivers/media/rc/keymaps/rc-avermedia-rm-ks.c |  2 +-
 drivers/media/rc/keymaps/rc-avermedia.c       |  2 +-
 drivers/media/rc/keymaps/rc-avertv-303.c      |  2 +-
 .../media/rc/keymaps/rc-azurewave-ad-tu700.c  |  2 +-
 drivers/media/rc/keymaps/rc-beelink-gs1.c     |  2 +-
 drivers/media/rc/keymaps/rc-beelink-mxiii.c   |  2 +-
 drivers/media/rc/keymaps/rc-behold-columbus.c |  2 +-
 drivers/media/rc/keymaps/rc-behold.c          |  2 +-
 drivers/media/rc/keymaps/rc-budget-ci-old.c   |  2 +-
 drivers/media/rc/keymaps/rc-cec.c             |  2 +-
 drivers/media/rc/keymaps/rc-cinergy-1400.c    |  2 +-
 drivers/media/rc/keymaps/rc-cinergy.c         |  2 +-
 drivers/media/rc/keymaps/rc-ct-90405.c        |  2 +-
 drivers/media/rc/keymaps/rc-d680-dmb.c        |  2 +-
 drivers/media/rc/keymaps/rc-delock-61959.c    |  2 +-
 drivers/media/rc/keymaps/rc-dib0700-nec.c     |  2 +-
 drivers/media/rc/keymaps/rc-dib0700-rc5.c     |  2 +-
 .../media/rc/keymaps/rc-digitalnow-tinytwin.c |  2 +-
 drivers/media/rc/keymaps/rc-digittrade.c      |  2 +-
 drivers/media/rc/keymaps/rc-dm1105-nec.c      |  2 +-
 drivers/media/rc/keymaps/rc-dntv-live-dvb-t.c |  2 +-
 .../media/rc/keymaps/rc-dntv-live-dvbt-pro.c  |  2 +-
 drivers/media/rc/keymaps/rc-dreambox.c        |  2 +-
 drivers/media/rc/keymaps/rc-dtt200u.c         |  2 +-
 drivers/media/rc/keymaps/rc-dvbsky.c          |  2 +-
 drivers/media/rc/keymaps/rc-dvico-mce.c       |  2 +-
 drivers/media/rc/keymaps/rc-dvico-portable.c  |  2 +-
 drivers/media/rc/keymaps/rc-em-terratec.c     |  2 +-
 .../media/rc/keymaps/rc-encore-enltv-fm53.c   |  2 +-
 drivers/media/rc/keymaps/rc-encore-enltv.c    |  2 +-
 drivers/media/rc/keymaps/rc-encore-enltv2.c   |  2 +-
 drivers/media/rc/keymaps/rc-evga-indtube.c    |  2 +-
 drivers/media/rc/keymaps/rc-eztv.c            |  2 +-
 drivers/media/rc/keymaps/rc-flydvb.c          |  2 +-
 drivers/media/rc/keymaps/rc-flyvideo.c        |  2 +-
 drivers/media/rc/keymaps/rc-fusionhdtv-mce.c  |  2 +-
 drivers/media/rc/keymaps/rc-gadmei-rm008z.c   |  2 +-
 drivers/media/rc/keymaps/rc-geekbox.c         |  2 +-
 .../media/rc/keymaps/rc-genius-tvgo-a11mce.c  |  2 +-
 drivers/media/rc/keymaps/rc-gotview7135.c     |  2 +-
 drivers/media/rc/keymaps/rc-hauppauge.c       |  2 +-
 drivers/media/rc/keymaps/rc-hisi-poplar.c     |  2 +-
 drivers/media/rc/keymaps/rc-hisi-tv-demo.c    |  2 +-
 drivers/media/rc/keymaps/rc-imon-mce.c        |  2 +-
 drivers/media/rc/keymaps/rc-imon-pad.c        |  2 +-
 drivers/media/rc/keymaps/rc-imon-rsc.c        |  2 +-
 drivers/media/rc/keymaps/rc-iodata-bctv7e.c   |  2 +-
 drivers/media/rc/keymaps/rc-it913x-v1.c       |  2 +-
 drivers/media/rc/keymaps/rc-it913x-v2.c       |  2 +-
 drivers/media/rc/keymaps/rc-kaiomy.c          |  2 +-
 drivers/media/rc/keymaps/rc-khadas.c          |  2 +-
 drivers/media/rc/keymaps/rc-khamsin.c         |  2 +-
 drivers/media/rc/keymaps/rc-kworld-315u.c     |  2 +-
 drivers/media/rc/keymaps/rc-kworld-pc150u.c   |  2 +-
 .../rc/keymaps/rc-kworld-plus-tv-analog.c     |  2 +-
 .../media/rc/keymaps/rc-leadtek-y04g0051.c    |  2 +-
 drivers/media/rc/keymaps/rc-lme2510.c         |  2 +-
 drivers/media/rc/keymaps/rc-manli.c           |  2 +-
 drivers/media/rc/keymaps/rc-mecool-kii-pro.c  |  2 +-
 drivers/media/rc/keymaps/rc-mecool-kiii-pro.c |  2 +-
 .../rc/keymaps/rc-medion-x10-digitainer.c     |  2 +-
 drivers/media/rc/keymaps/rc-medion-x10-or2x.c |  2 +-
 drivers/media/rc/keymaps/rc-medion-x10.c      |  2 +-
 drivers/media/rc/keymaps/rc-minix-neo.c       |  2 +-
 drivers/media/rc/keymaps/rc-msi-digivox-ii.c  |  2 +-
 drivers/media/rc/keymaps/rc-msi-digivox-iii.c |  2 +-
 .../media/rc/keymaps/rc-msi-tvanywhere-plus.c |  2 +-
 drivers/media/rc/keymaps/rc-msi-tvanywhere.c  |  2 +-
 drivers/media/rc/keymaps/rc-mygica-utv3.c     |  2 +-
 drivers/media/rc/keymaps/rc-nebula.c          |  2 +-
 .../rc/keymaps/rc-nec-terratec-cinergy-xs.c   |  2 +-
 drivers/media/rc/keymaps/rc-norwood.c         |  2 +-
 drivers/media/rc/keymaps/rc-npgtech.c         |  2 +-
 drivers/media/rc/keymaps/rc-odroid.c          |  2 +-
 drivers/media/rc/keymaps/rc-pctv-sedna.c      |  2 +-
 drivers/media/rc/keymaps/rc-pine64.c          |  2 +-
 drivers/media/rc/keymaps/rc-pinnacle-color.c  |  2 +-
 drivers/media/rc/keymaps/rc-pinnacle-grey.c   |  2 +-
 .../media/rc/keymaps/rc-pinnacle-pctv-hd.c    |  2 +-
 drivers/media/rc/keymaps/rc-pixelview-002t.c  |  2 +-
 drivers/media/rc/keymaps/rc-pixelview-mk12.c  |  2 +-
 drivers/media/rc/keymaps/rc-pixelview-new.c   |  2 +-
 drivers/media/rc/keymaps/rc-pixelview.c       |  2 +-
 .../rc/keymaps/rc-powercolor-real-angel.c     |  2 +-
 drivers/media/rc/keymaps/rc-proteus-2309.c    |  2 +-
 drivers/media/rc/keymaps/rc-purpletv.c        |  2 +-
 drivers/media/rc/keymaps/rc-pv951.c           |  2 +-
 drivers/media/rc/keymaps/rc-rc6-mce.c         |  2 +-
 .../rc/keymaps/rc-real-audio-220-32-keys.c    |  2 +-
 drivers/media/rc/keymaps/rc-reddo.c           |  2 +-
 .../rc/keymaps/rc-siemens-gigaset-rc20.c      |  2 +-
 .../media/rc/keymaps/rc-snapstream-firefly.c  |  2 +-
 drivers/media/rc/keymaps/rc-streamzap.c       |  2 +-
 drivers/media/rc/keymaps/rc-su3000.c          |  2 +-
 drivers/media/rc/keymaps/rc-tanix-tx3mini.c   |  2 +-
 drivers/media/rc/keymaps/rc-tanix-tx5max.c    |  2 +-
 drivers/media/rc/keymaps/rc-tbs-nec.c         |  2 +-
 drivers/media/rc/keymaps/rc-technisat-ts35.c  |  2 +-
 drivers/media/rc/keymaps/rc-technisat-usb2.c  |  2 +-
 .../rc/keymaps/rc-terratec-cinergy-c-pci.c    |  2 +-
 .../rc/keymaps/rc-terratec-cinergy-s2-hd.c    |  2 +-
 .../media/rc/keymaps/rc-terratec-cinergy-xs.c |  2 +-
 drivers/media/rc/keymaps/rc-terratec-slim-2.c |  2 +-
 drivers/media/rc/keymaps/rc-terratec-slim.c   |  2 +-
 drivers/media/rc/keymaps/rc-tevii-nec.c       |  2 +-
 drivers/media/rc/keymaps/rc-tivo.c            |  2 +-
 .../rc/keymaps/rc-total-media-in-hand-02.c    |  2 +-
 .../media/rc/keymaps/rc-total-media-in-hand.c |  2 +-
 drivers/media/rc/keymaps/rc-trekstor.c        |  2 +-
 drivers/media/rc/keymaps/rc-tt-1500.c         |  2 +-
 .../media/rc/keymaps/rc-twinhan-dtv-cab-ci.c  |  2 +-
 drivers/media/rc/keymaps/rc-twinhan1027.c     |  2 +-
 drivers/media/rc/keymaps/rc-vega-s9x.c        |  2 +-
 drivers/media/rc/keymaps/rc-videomate-k100.c  |  2 +-
 drivers/media/rc/keymaps/rc-videomate-s350.c  |  2 +-
 .../media/rc/keymaps/rc-videomate-tv-pvr.c    |  2 +-
 .../media/rc/keymaps/rc-videostrong-kii-pro.c |  2 +-
 drivers/media/rc/keymaps/rc-wetek-hub.c       |  2 +-
 drivers/media/rc/keymaps/rc-wetek-play2.c     |  2 +-
 .../rc/keymaps/rc-winfast-usbii-deluxe.c      |  2 +-
 drivers/media/rc/keymaps/rc-winfast.c         |  2 +-
 drivers/media/rc/keymaps/rc-x96max.c          |  2 +-
 drivers/media/rc/keymaps/rc-xbox-360.c        |  2 +-
 drivers/media/rc/keymaps/rc-xbox-dvd.c        |  2 +-
 drivers/media/rc/keymaps/rc-zx-irdec.c        |  2 +-
 drivers/media/rc/rc-main.c                    | 80 ++++++++++---------
 include/media/rc-map.h                        |  8 +-
 141 files changed, 184 insertions(+), 182 deletions(-)

diff --git a/drivers/media/rc/keymaps/rc-adstech-dvb-t-pci.c b/drivers/media/rc/keymaps/rc-adstech-dvb-t-pci.c
index e24946c8fe20..8d85474f9866 100644
--- a/drivers/media/rc/keymaps/rc-adstech-dvb-t-pci.c
+++ b/drivers/media/rc/keymaps/rc-adstech-dvb-t-pci.c
@@ -62,7 +62,7 @@ static struct rc_map_table adstech_dvb_t_pci[] = {
 static struct rc_map_list adstech_dvb_t_pci_map = {
 	.map = {
 		.scan     = adstech_dvb_t_pci,
-		.size     = ARRAY_SIZE(adstech_dvb_t_pci),
+		.entries  = ARRAY_SIZE(adstech_dvb_t_pci),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_ADSTECH_DVB_T_PCI,
 	}
diff --git a/drivers/media/rc/keymaps/rc-alink-dtu-m.c b/drivers/media/rc/keymaps/rc-alink-dtu-m.c
index 9926259b43ee..f289184034a7 100644
--- a/drivers/media/rc/keymaps/rc-alink-dtu-m.c
+++ b/drivers/media/rc/keymaps/rc-alink-dtu-m.c
@@ -33,7 +33,7 @@ static struct rc_map_table alink_dtu_m[] = {
 static struct rc_map_list alink_dtu_m_map = {
 	.map = {
 		.scan     = alink_dtu_m,
-		.size     = ARRAY_SIZE(alink_dtu_m),
+		.entries  = ARRAY_SIZE(alink_dtu_m),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_ALINK_DTU_M,
 	}
diff --git a/drivers/media/rc/keymaps/rc-anysee.c b/drivers/media/rc/keymaps/rc-anysee.c
index e4bcbf889fed..c8b878ad71da 100644
--- a/drivers/media/rc/keymaps/rc-anysee.c
+++ b/drivers/media/rc/keymaps/rc-anysee.c
@@ -58,7 +58,7 @@ static struct rc_map_table anysee[] = {
 static struct rc_map_list anysee_map = {
 	.map = {
 		.scan     = anysee,
-		.size     = ARRAY_SIZE(anysee),
+		.entries  = ARRAY_SIZE(anysee),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_ANYSEE,
 	}
diff --git a/drivers/media/rc/keymaps/rc-apac-viewcomp.c b/drivers/media/rc/keymaps/rc-apac-viewcomp.c
index 80b096f02e99..ba1142f54e86 100644
--- a/drivers/media/rc/keymaps/rc-apac-viewcomp.c
+++ b/drivers/media/rc/keymaps/rc-apac-viewcomp.c
@@ -53,7 +53,7 @@ static struct rc_map_table apac_viewcomp[] = {
 static struct rc_map_list apac_viewcomp_map = {
 	.map = {
 		.scan     = apac_viewcomp,
-		.size     = ARRAY_SIZE(apac_viewcomp),
+		.entries  = ARRAY_SIZE(apac_viewcomp),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_APAC_VIEWCOMP,
 	}
diff --git a/drivers/media/rc/keymaps/rc-astrometa-t2hybrid.c b/drivers/media/rc/keymaps/rc-astrometa-t2hybrid.c
index 212b0d920901..4b82a5718be8 100644
--- a/drivers/media/rc/keymaps/rc-astrometa-t2hybrid.c
+++ b/drivers/media/rc/keymaps/rc-astrometa-t2hybrid.c
@@ -41,7 +41,7 @@ static struct rc_map_table t2hybrid[] = {
 static struct rc_map_list t2hybrid_map = {
 	.map = {
 		.scan     = t2hybrid,
-		.size     = ARRAY_SIZE(t2hybrid),
+		.entries  = ARRAY_SIZE(t2hybrid),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_ASTROMETA_T2HYBRID,
 	}
diff --git a/drivers/media/rc/keymaps/rc-asus-pc39.c b/drivers/media/rc/keymaps/rc-asus-pc39.c
index bd55b7c6f82a..0b433de53c48 100644
--- a/drivers/media/rc/keymaps/rc-asus-pc39.c
+++ b/drivers/media/rc/keymaps/rc-asus-pc39.c
@@ -64,7 +64,7 @@ static struct rc_map_table asus_pc39[] = {
 static struct rc_map_list asus_pc39_map = {
 	.map = {
 		.scan     = asus_pc39,
-		.size     = ARRAY_SIZE(asus_pc39),
+		.entries  = ARRAY_SIZE(asus_pc39),
 		.rc_proto = RC_PROTO_RC5,
 		.name     = RC_MAP_ASUS_PC39,
 	}
diff --git a/drivers/media/rc/keymaps/rc-asus-ps3-100.c b/drivers/media/rc/keymaps/rc-asus-ps3-100.c
index 9d63c1e4a17a..2541013a96aa 100644
--- a/drivers/media/rc/keymaps/rc-asus-ps3-100.c
+++ b/drivers/media/rc/keymaps/rc-asus-ps3-100.c
@@ -63,7 +63,7 @@ static struct rc_map_table asus_ps3_100[] = {
 static struct rc_map_list asus_ps3_100_map = {
 .map = {
 	.scan     = asus_ps3_100,
-	.size     = ARRAY_SIZE(asus_ps3_100),
+	.entries  = ARRAY_SIZE(asus_ps3_100),
 	.rc_proto = RC_PROTO_RC5,
 	.name     = RC_MAP_ASUS_PS3_100,
 }
diff --git a/drivers/media/rc/keymaps/rc-ati-tv-wonder-hd-600.c b/drivers/media/rc/keymaps/rc-ati-tv-wonder-hd-600.c
index 063237f0d2e2..694ac6aedde8 100644
--- a/drivers/media/rc/keymaps/rc-ati-tv-wonder-hd-600.c
+++ b/drivers/media/rc/keymaps/rc-ati-tv-wonder-hd-600.c
@@ -42,7 +42,7 @@ static struct rc_map_table ati_tv_wonder_hd_600[] = {
 static struct rc_map_list ati_tv_wonder_hd_600_map = {
 	.map = {
 		.scan     = ati_tv_wonder_hd_600,
-		.size     = ARRAY_SIZE(ati_tv_wonder_hd_600),
+		.entries  = ARRAY_SIZE(ati_tv_wonder_hd_600),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_ATI_TV_WONDER_HD_600,
 	}
diff --git a/drivers/media/rc/keymaps/rc-ati-x10.c b/drivers/media/rc/keymaps/rc-ati-x10.c
index 9f7cbe9a1ac8..812df1a3b458 100644
--- a/drivers/media/rc/keymaps/rc-ati-x10.c
+++ b/drivers/media/rc/keymaps/rc-ati-x10.c
@@ -102,7 +102,7 @@ static struct rc_map_table ati_x10[] = {
 static struct rc_map_list ati_x10_map = {
 	.map = {
 		.scan     = ati_x10,
-		.size     = ARRAY_SIZE(ati_x10),
+		.entries  = ARRAY_SIZE(ati_x10),
 		.rc_proto = RC_PROTO_OTHER,
 		.name     = RC_MAP_ATI_X10,
 	}
diff --git a/drivers/media/rc/keymaps/rc-avermedia-a16d.c b/drivers/media/rc/keymaps/rc-avermedia-a16d.c
index 98497f4f6f92..78e058231215 100644
--- a/drivers/media/rc/keymaps/rc-avermedia-a16d.c
+++ b/drivers/media/rc/keymaps/rc-avermedia-a16d.c
@@ -48,7 +48,7 @@ static struct rc_map_table avermedia_a16d[] = {
 static struct rc_map_list avermedia_a16d_map = {
 	.map = {
 		.scan     = avermedia_a16d,
-		.size     = ARRAY_SIZE(avermedia_a16d),
+		.entries  = ARRAY_SIZE(avermedia_a16d),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_AVERMEDIA_A16D,
 	}
diff --git a/drivers/media/rc/keymaps/rc-avermedia-cardbus.c b/drivers/media/rc/keymaps/rc-avermedia-cardbus.c
index 5832c2f8ab3f..f7dc7829d552 100644
--- a/drivers/media/rc/keymaps/rc-avermedia-cardbus.c
+++ b/drivers/media/rc/keymaps/rc-avermedia-cardbus.c
@@ -70,7 +70,7 @@ static struct rc_map_table avermedia_cardbus[] = {
 static struct rc_map_list avermedia_cardbus_map = {
 	.map = {
 		.scan     = avermedia_cardbus,
-		.size     = ARRAY_SIZE(avermedia_cardbus),
+		.entries  = ARRAY_SIZE(avermedia_cardbus),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_AVERMEDIA_CARDBUS,
 	}
diff --git a/drivers/media/rc/keymaps/rc-avermedia-dvbt.c b/drivers/media/rc/keymaps/rc-avermedia-dvbt.c
index 3157d0c1cee9..8b5d94294d75 100644
--- a/drivers/media/rc/keymaps/rc-avermedia-dvbt.c
+++ b/drivers/media/rc/keymaps/rc-avermedia-dvbt.c
@@ -51,7 +51,7 @@ static struct rc_map_table avermedia_dvbt[] = {
 static struct rc_map_list avermedia_dvbt_map = {
 	.map = {
 		.scan     = avermedia_dvbt,
-		.size     = ARRAY_SIZE(avermedia_dvbt),
+		.entries  = ARRAY_SIZE(avermedia_dvbt),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_AVERMEDIA_DVBT,
 	}
diff --git a/drivers/media/rc/keymaps/rc-avermedia-m135a.c b/drivers/media/rc/keymaps/rc-avermedia-m135a.c
index cc1318ad09d9..d008d0fd94ba 100644
--- a/drivers/media/rc/keymaps/rc-avermedia-m135a.c
+++ b/drivers/media/rc/keymaps/rc-avermedia-m135a.c
@@ -121,7 +121,7 @@ static struct rc_map_table avermedia_m135a[] = {
 static struct rc_map_list avermedia_m135a_map = {
 	.map = {
 		.scan     = avermedia_m135a,
-		.size     = ARRAY_SIZE(avermedia_m135a),
+		.entries  = ARRAY_SIZE(avermedia_m135a),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_AVERMEDIA_M135A,
 	}
diff --git a/drivers/media/rc/keymaps/rc-avermedia-m733a-rm-k6.c b/drivers/media/rc/keymaps/rc-avermedia-m733a-rm-k6.c
index ec6c866c9f5d..2d637d41bf11 100644
--- a/drivers/media/rc/keymaps/rc-avermedia-m733a-rm-k6.c
+++ b/drivers/media/rc/keymaps/rc-avermedia-m733a-rm-k6.c
@@ -69,7 +69,7 @@ static struct rc_map_table avermedia_m733a_rm_k6[] = {
 static struct rc_map_list avermedia_m733a_rm_k6_map = {
 	.map = {
 		.scan     = avermedia_m733a_rm_k6,
-		.size     = ARRAY_SIZE(avermedia_m733a_rm_k6),
+		.entries  = ARRAY_SIZE(avermedia_m733a_rm_k6),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_AVERMEDIA_M733A_RM_K6,
 	}
diff --git a/drivers/media/rc/keymaps/rc-avermedia-rm-ks.c b/drivers/media/rc/keymaps/rc-avermedia-rm-ks.c
index ee4fe5791add..d1f8ef394bdd 100644
--- a/drivers/media/rc/keymaps/rc-avermedia-rm-ks.c
+++ b/drivers/media/rc/keymaps/rc-avermedia-rm-ks.c
@@ -44,7 +44,7 @@ static struct rc_map_table avermedia_rm_ks[] = {
 static struct rc_map_list avermedia_rm_ks_map = {
 	.map = {
 		.scan     = avermedia_rm_ks,
-		.size     = ARRAY_SIZE(avermedia_rm_ks),
+		.entries  = ARRAY_SIZE(avermedia_rm_ks),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_AVERMEDIA_RM_KS,
 	}
diff --git a/drivers/media/rc/keymaps/rc-avermedia.c b/drivers/media/rc/keymaps/rc-avermedia.c
index b827536a1f5f..bd3c2a1df334 100644
--- a/drivers/media/rc/keymaps/rc-avermedia.c
+++ b/drivers/media/rc/keymaps/rc-avermedia.c
@@ -59,7 +59,7 @@ static struct rc_map_table avermedia[] = {
 static struct rc_map_list avermedia_map = {
 	.map = {
 		.scan     = avermedia,
-		.size     = ARRAY_SIZE(avermedia),
+		.entries  = ARRAY_SIZE(avermedia),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_AVERMEDIA,
 	}
diff --git a/drivers/media/rc/keymaps/rc-avertv-303.c b/drivers/media/rc/keymaps/rc-avertv-303.c
index 71d1da42528d..79dfa22000a1 100644
--- a/drivers/media/rc/keymaps/rc-avertv-303.c
+++ b/drivers/media/rc/keymaps/rc-avertv-303.c
@@ -58,7 +58,7 @@ static struct rc_map_table avertv_303[] = {
 static struct rc_map_list avertv_303_map = {
 	.map = {
 		.scan     = avertv_303,
-		.size     = ARRAY_SIZE(avertv_303),
+		.entries  = ARRAY_SIZE(avertv_303),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_AVERTV_303,
 	}
diff --git a/drivers/media/rc/keymaps/rc-azurewave-ad-tu700.c b/drivers/media/rc/keymaps/rc-azurewave-ad-tu700.c
index 56f8eb1f0d01..ac0cb8d49e28 100644
--- a/drivers/media/rc/keymaps/rc-azurewave-ad-tu700.c
+++ b/drivers/media/rc/keymaps/rc-azurewave-ad-tu700.c
@@ -67,7 +67,7 @@ static struct rc_map_table azurewave_ad_tu700[] = {
 static struct rc_map_list azurewave_ad_tu700_map = {
 	.map = {
 		.scan     = azurewave_ad_tu700,
-		.size     = ARRAY_SIZE(azurewave_ad_tu700),
+		.entries  = ARRAY_SIZE(azurewave_ad_tu700),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_AZUREWAVE_AD_TU700,
 	}
diff --git a/drivers/media/rc/keymaps/rc-beelink-gs1.c b/drivers/media/rc/keymaps/rc-beelink-gs1.c
index 6e767d88c707..0dee07289991 100644
--- a/drivers/media/rc/keymaps/rc-beelink-gs1.c
+++ b/drivers/media/rc/keymaps/rc-beelink-gs1.c
@@ -61,7 +61,7 @@ static struct rc_map_table beelink_gs1_table[] = {
 static struct rc_map_list beelink_gs1_map = {
 	.map = {
 		.scan     = beelink_gs1_table,
-		.size     = ARRAY_SIZE(beelink_gs1_table),
+		.entries  = ARRAY_SIZE(beelink_gs1_table),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_BEELINK_GS1,
 	}
diff --git a/drivers/media/rc/keymaps/rc-beelink-mxiii.c b/drivers/media/rc/keymaps/rc-beelink-mxiii.c
index 88fad9959a86..67aa4881b6e0 100644
--- a/drivers/media/rc/keymaps/rc-beelink-mxiii.c
+++ b/drivers/media/rc/keymaps/rc-beelink-mxiii.c
@@ -34,7 +34,7 @@ static struct rc_map_table beelink_mxiii[] = {
 static struct rc_map_list beelink_mxiii_map = {
 	.map = {
 		.scan     = beelink_mxiii,
-		.size     = ARRAY_SIZE(beelink_mxiii),
+		.entries  = ARRAY_SIZE(beelink_mxiii),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_BEELINK_MXIII,
 	}
diff --git a/drivers/media/rc/keymaps/rc-behold-columbus.c b/drivers/media/rc/keymaps/rc-behold-columbus.c
index 6bdc924ac3cf..f3929d61e34a 100644
--- a/drivers/media/rc/keymaps/rc-behold-columbus.c
+++ b/drivers/media/rc/keymaps/rc-behold-columbus.c
@@ -81,7 +81,7 @@ static struct rc_map_table behold_columbus[] = {
 static struct rc_map_list behold_columbus_map = {
 	.map = {
 		.scan     = behold_columbus,
-		.size     = ARRAY_SIZE(behold_columbus),
+		.entries  = ARRAY_SIZE(behold_columbus),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_BEHOLD_COLUMBUS,
 	}
diff --git a/drivers/media/rc/keymaps/rc-behold.c b/drivers/media/rc/keymaps/rc-behold.c
index 0251ce835f79..6ecdcdab4e78 100644
--- a/drivers/media/rc/keymaps/rc-behold.c
+++ b/drivers/media/rc/keymaps/rc-behold.c
@@ -114,7 +114,7 @@ static struct rc_map_table behold[] = {
 static struct rc_map_list behold_map = {
 	.map = {
 		.scan     = behold,
-		.size     = ARRAY_SIZE(behold),
+		.entries  = ARRAY_SIZE(behold),
 		.rc_proto = RC_PROTO_NECX,
 		.name     = RC_MAP_BEHOLD,
 	}
diff --git a/drivers/media/rc/keymaps/rc-budget-ci-old.c b/drivers/media/rc/keymaps/rc-budget-ci-old.c
index 8fda5d1e140b..9fba5b085deb 100644
--- a/drivers/media/rc/keymaps/rc-budget-ci-old.c
+++ b/drivers/media/rc/keymaps/rc-budget-ci-old.c
@@ -66,7 +66,7 @@ static struct rc_map_table budget_ci_old[] = {
 static struct rc_map_list budget_ci_old_map = {
 	.map = {
 		.scan     = budget_ci_old,
-		.size     = ARRAY_SIZE(budget_ci_old),
+		.entries  = ARRAY_SIZE(budget_ci_old),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_BUDGET_CI_OLD,
 	}
diff --git a/drivers/media/rc/keymaps/rc-cec.c b/drivers/media/rc/keymaps/rc-cec.c
index 068e22aeac8c..c566383bb960 100644
--- a/drivers/media/rc/keymaps/rc-cec.c
+++ b/drivers/media/rc/keymaps/rc-cec.c
@@ -165,7 +165,7 @@ static struct rc_map_table cec[] = {
 struct rc_map_list cec_map = {
 	.map = {
 		.scan		= cec,
-		.size		= ARRAY_SIZE(cec),
+		.entries	= ARRAY_SIZE(cec),
 		.rc_proto	= RC_PROTO_CEC,
 		.name		= RC_MAP_CEC,
 	}
diff --git a/drivers/media/rc/keymaps/rc-cinergy-1400.c b/drivers/media/rc/keymaps/rc-cinergy-1400.c
index 092c3533d712..61ef7d780b3e 100644
--- a/drivers/media/rc/keymaps/rc-cinergy-1400.c
+++ b/drivers/media/rc/keymaps/rc-cinergy-1400.c
@@ -57,7 +57,7 @@ static struct rc_map_table cinergy_1400[] = {
 static struct rc_map_list cinergy_1400_map = {
 	.map = {
 		.scan     = cinergy_1400,
-		.size     = ARRAY_SIZE(cinergy_1400),
+		.entries  = ARRAY_SIZE(cinergy_1400),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_CINERGY_1400,
 	}
diff --git a/drivers/media/rc/keymaps/rc-cinergy.c b/drivers/media/rc/keymaps/rc-cinergy.c
index 334a290a3b91..1f4ebe8bb187 100644
--- a/drivers/media/rc/keymaps/rc-cinergy.c
+++ b/drivers/media/rc/keymaps/rc-cinergy.c
@@ -51,7 +51,7 @@ static struct rc_map_table cinergy[] = {
 static struct rc_map_list cinergy_map = {
 	.map = {
 		.scan     = cinergy,
-		.size     = ARRAY_SIZE(cinergy),
+		.entries  = ARRAY_SIZE(cinergy),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_CINERGY,
 	}
diff --git a/drivers/media/rc/keymaps/rc-ct-90405.c b/drivers/media/rc/keymaps/rc-ct-90405.c
index d4638df37c53..9334023150a4 100644
--- a/drivers/media/rc/keymaps/rc-ct-90405.c
+++ b/drivers/media/rc/keymaps/rc-ct-90405.c
@@ -63,7 +63,7 @@ static struct rc_map_table ct_90405[] = {
 static struct rc_map_list ct_90405_map = {
 	.map = {
 		.scan     = ct_90405,
-		.size     = ARRAY_SIZE(ct_90405),
+		.entries  = ARRAY_SIZE(ct_90405),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_CT_90405,
 	}
diff --git a/drivers/media/rc/keymaps/rc-d680-dmb.c b/drivers/media/rc/keymaps/rc-d680-dmb.c
index 7870d36f2c69..bfcd795047c5 100644
--- a/drivers/media/rc/keymaps/rc-d680-dmb.c
+++ b/drivers/media/rc/keymaps/rc-d680-dmb.c
@@ -49,7 +49,7 @@ static struct rc_map_table rc_map_d680_dmb_table[] = {
 static struct rc_map_list d680_dmb_map = {
 	.map = {
 		.scan     = rc_map_d680_dmb_table,
-		.size     = ARRAY_SIZE(rc_map_d680_dmb_table),
+		.entries  = ARRAY_SIZE(rc_map_d680_dmb_table),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_D680_DMB,
 	}
diff --git a/drivers/media/rc/keymaps/rc-delock-61959.c b/drivers/media/rc/keymaps/rc-delock-61959.c
index 529435e8d416..bae63f6f3f4d 100644
--- a/drivers/media/rc/keymaps/rc-delock-61959.c
+++ b/drivers/media/rc/keymaps/rc-delock-61959.c
@@ -55,7 +55,7 @@ static struct rc_map_table delock_61959[] = {
 static struct rc_map_list delock_61959_map = {
 	.map = {
 		.scan     = delock_61959,
-		.size     = ARRAY_SIZE(delock_61959),
+		.entries  = ARRAY_SIZE(delock_61959),
 		.rc_proto = RC_PROTO_NECX,
 		.name     = RC_MAP_DELOCK_61959,
 	}
diff --git a/drivers/media/rc/keymaps/rc-dib0700-nec.c b/drivers/media/rc/keymaps/rc-dib0700-nec.c
index 0323049fd2b1..76440b02f9ec 100644
--- a/drivers/media/rc/keymaps/rc-dib0700-nec.c
+++ b/drivers/media/rc/keymaps/rc-dib0700-nec.c
@@ -97,7 +97,7 @@ static struct rc_map_table dib0700_nec_table[] = {
 static struct rc_map_list dib0700_nec_map = {
 	.map = {
 		.scan     = dib0700_nec_table,
-		.size     = ARRAY_SIZE(dib0700_nec_table),
+		.entries  = ARRAY_SIZE(dib0700_nec_table),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_DIB0700_NEC_TABLE,
 	}
diff --git a/drivers/media/rc/keymaps/rc-dib0700-rc5.c b/drivers/media/rc/keymaps/rc-dib0700-rc5.c
index d34e92eb92be..0536ee7bbf17 100644
--- a/drivers/media/rc/keymaps/rc-dib0700-rc5.c
+++ b/drivers/media/rc/keymaps/rc-dib0700-rc5.c
@@ -208,7 +208,7 @@ static struct rc_map_table dib0700_rc5_table[] = {
 static struct rc_map_list dib0700_rc5_map = {
 	.map = {
 		.scan     = dib0700_rc5_table,
-		.size     = ARRAY_SIZE(dib0700_rc5_table),
+		.entries  = ARRAY_SIZE(dib0700_rc5_table),
 		.rc_proto = RC_PROTO_RC5,
 		.name     = RC_MAP_DIB0700_RC5_TABLE,
 	}
diff --git a/drivers/media/rc/keymaps/rc-digitalnow-tinytwin.c b/drivers/media/rc/keymaps/rc-digitalnow-tinytwin.c
index d18b8f93a018..54eda79cc438 100644
--- a/drivers/media/rc/keymaps/rc-digitalnow-tinytwin.c
+++ b/drivers/media/rc/keymaps/rc-digitalnow-tinytwin.c
@@ -63,7 +63,7 @@ static struct rc_map_table digitalnow_tinytwin[] = {
 static struct rc_map_list digitalnow_tinytwin_map = {
 	.map = {
 		.scan     = digitalnow_tinytwin,
-		.size     = ARRAY_SIZE(digitalnow_tinytwin),
+		.entries  = ARRAY_SIZE(digitalnow_tinytwin),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_DIGITALNOW_TINYTWIN,
 	}
diff --git a/drivers/media/rc/keymaps/rc-digittrade.c b/drivers/media/rc/keymaps/rc-digittrade.c
index 129a81f59b4a..a2342fe1771d 100644
--- a/drivers/media/rc/keymaps/rc-digittrade.c
+++ b/drivers/media/rc/keymaps/rc-digittrade.c
@@ -47,7 +47,7 @@ static struct rc_map_table digittrade[] = {
 static struct rc_map_list digittrade_map = {
 	.map = {
 		.scan     = digittrade,
-		.size     = ARRAY_SIZE(digittrade),
+		.entries  = ARRAY_SIZE(digittrade),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_DIGITTRADE,
 	}
diff --git a/drivers/media/rc/keymaps/rc-dm1105-nec.c b/drivers/media/rc/keymaps/rc-dm1105-nec.c
index b82290ce925b..fd422670347e 100644
--- a/drivers/media/rc/keymaps/rc-dm1105-nec.c
+++ b/drivers/media/rc/keymaps/rc-dm1105-nec.c
@@ -49,7 +49,7 @@ static struct rc_map_table dm1105_nec[] = {
 static struct rc_map_list dm1105_nec_map = {
 	.map = {
 		.scan     = dm1105_nec,
-		.size     = ARRAY_SIZE(dm1105_nec),
+		.entries  = ARRAY_SIZE(dm1105_nec),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_DM1105_NEC,
 	}
diff --git a/drivers/media/rc/keymaps/rc-dntv-live-dvb-t.c b/drivers/media/rc/keymaps/rc-dntv-live-dvb-t.c
index 4b23335615cf..1bfe5a4403b2 100644
--- a/drivers/media/rc/keymaps/rc-dntv-live-dvb-t.c
+++ b/drivers/media/rc/keymaps/rc-dntv-live-dvb-t.c
@@ -51,7 +51,7 @@ static struct rc_map_table dntv_live_dvb_t[] = {
 static struct rc_map_list dntv_live_dvb_t_map = {
 	.map = {
 		.scan     = dntv_live_dvb_t,
-		.size     = ARRAY_SIZE(dntv_live_dvb_t),
+		.entries  = ARRAY_SIZE(dntv_live_dvb_t),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_DNTV_LIVE_DVB_T,
 	}
diff --git a/drivers/media/rc/keymaps/rc-dntv-live-dvbt-pro.c b/drivers/media/rc/keymaps/rc-dntv-live-dvbt-pro.c
index 46d8ea1b49a3..c0aeffa8a511 100644
--- a/drivers/media/rc/keymaps/rc-dntv-live-dvbt-pro.c
+++ b/drivers/media/rc/keymaps/rc-dntv-live-dvbt-pro.c
@@ -70,7 +70,7 @@ static struct rc_map_table dntv_live_dvbt_pro[] = {
 static struct rc_map_list dntv_live_dvbt_pro_map = {
 	.map = {
 		.scan     = dntv_live_dvbt_pro,
-		.size     = ARRAY_SIZE(dntv_live_dvbt_pro),
+		.entries  = ARRAY_SIZE(dntv_live_dvbt_pro),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_DNTV_LIVE_DVBT_PRO,
 	}
diff --git a/drivers/media/rc/keymaps/rc-dreambox.c b/drivers/media/rc/keymaps/rc-dreambox.c
index e1ec99ce3105..bc5a0d7d3bb2 100644
--- a/drivers/media/rc/keymaps/rc-dreambox.c
+++ b/drivers/media/rc/keymaps/rc-dreambox.c
@@ -128,7 +128,7 @@ static struct rc_map_table dreambox[] = {
 static struct rc_map_list dreambox_map = {
 	.map = {
 		.scan     = dreambox,
-		.size     = ARRAY_SIZE(dreambox),
+		.entries  = ARRAY_SIZE(dreambox),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_DREAMBOX,
 	}
diff --git a/drivers/media/rc/keymaps/rc-dtt200u.c b/drivers/media/rc/keymaps/rc-dtt200u.c
index eeb2f6e303d7..7a95da357a56 100644
--- a/drivers/media/rc/keymaps/rc-dtt200u.c
+++ b/drivers/media/rc/keymaps/rc-dtt200u.c
@@ -32,7 +32,7 @@ static struct rc_map_table dtt200u_table[] = {
 static struct rc_map_list dtt200u_map = {
 	.map = {
 		.scan     = dtt200u_table,
-		.size     = ARRAY_SIZE(dtt200u_table),
+		.entries  = ARRAY_SIZE(dtt200u_table),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_DTT200U,
 	}
diff --git a/drivers/media/rc/keymaps/rc-dvbsky.c b/drivers/media/rc/keymaps/rc-dvbsky.c
index 1fcd47bd8595..7e75abf59f7a 100644
--- a/drivers/media/rc/keymaps/rc-dvbsky.c
+++ b/drivers/media/rc/keymaps/rc-dvbsky.c
@@ -50,7 +50,7 @@ static struct rc_map_table rc5_dvbsky[] = {
 static struct rc_map_list rc5_dvbsky_map = {
 	.map = {
 		.scan     = rc5_dvbsky,
-		.size     = ARRAY_SIZE(rc5_dvbsky),
+		.entries  = ARRAY_SIZE(rc5_dvbsky),
 		.rc_proto = RC_PROTO_RC5,
 		.name     = RC_MAP_DVBSKY,
 	}
diff --git a/drivers/media/rc/keymaps/rc-dvico-mce.c b/drivers/media/rc/keymaps/rc-dvico-mce.c
index 4bb4222d259e..3d9043e7fbf5 100644
--- a/drivers/media/rc/keymaps/rc-dvico-mce.c
+++ b/drivers/media/rc/keymaps/rc-dvico-mce.c
@@ -59,7 +59,7 @@ static struct rc_map_table rc_map_dvico_mce_table[] = {
 static struct rc_map_list dvico_mce_map = {
 	.map = {
 		.scan     = rc_map_dvico_mce_table,
-		.size     = ARRAY_SIZE(rc_map_dvico_mce_table),
+		.entries  = ARRAY_SIZE(rc_map_dvico_mce_table),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_DVICO_MCE,
 	}
diff --git a/drivers/media/rc/keymaps/rc-dvico-portable.c b/drivers/media/rc/keymaps/rc-dvico-portable.c
index ba9ef9b75777..185a8073211e 100644
--- a/drivers/media/rc/keymaps/rc-dvico-portable.c
+++ b/drivers/media/rc/keymaps/rc-dvico-portable.c
@@ -50,7 +50,7 @@ static struct rc_map_table rc_map_dvico_portable_table[] = {
 static struct rc_map_list dvico_portable_map = {
 	.map = {
 		.scan     = rc_map_dvico_portable_table,
-		.size     = ARRAY_SIZE(rc_map_dvico_portable_table),
+		.entries  = ARRAY_SIZE(rc_map_dvico_portable_table),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_DVICO_PORTABLE,
 	}
diff --git a/drivers/media/rc/keymaps/rc-em-terratec.c b/drivers/media/rc/keymaps/rc-em-terratec.c
index 8a51fe632840..f7feebc16268 100644
--- a/drivers/media/rc/keymaps/rc-em-terratec.c
+++ b/drivers/media/rc/keymaps/rc-em-terratec.c
@@ -42,7 +42,7 @@ static struct rc_map_table em_terratec[] = {
 static struct rc_map_list em_terratec_map = {
 	.map = {
 		.scan     = em_terratec,
-		.size     = ARRAY_SIZE(em_terratec),
+		.entries  = ARRAY_SIZE(em_terratec),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_EM_TERRATEC,
 	}
diff --git a/drivers/media/rc/keymaps/rc-encore-enltv-fm53.c b/drivers/media/rc/keymaps/rc-encore-enltv-fm53.c
index 320e184f4298..3afe8feb2bae 100644
--- a/drivers/media/rc/keymaps/rc-encore-enltv-fm53.c
+++ b/drivers/media/rc/keymaps/rc-encore-enltv-fm53.c
@@ -54,7 +54,7 @@ static struct rc_map_table encore_enltv_fm53[] = {
 static struct rc_map_list encore_enltv_fm53_map = {
 	.map = {
 		.scan     = encore_enltv_fm53,
-		.size     = ARRAY_SIZE(encore_enltv_fm53),
+		.entries  = ARRAY_SIZE(encore_enltv_fm53),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_ENCORE_ENLTV_FM53,
 	}
diff --git a/drivers/media/rc/keymaps/rc-encore-enltv.c b/drivers/media/rc/keymaps/rc-encore-enltv.c
index 0b235d72e57d..81b6f6fcf5d0 100644
--- a/drivers/media/rc/keymaps/rc-encore-enltv.c
+++ b/drivers/media/rc/keymaps/rc-encore-enltv.c
@@ -85,7 +85,7 @@ static struct rc_map_table encore_enltv[] = {
 static struct rc_map_list encore_enltv_map = {
 	.map = {
 		.scan     = encore_enltv,
-		.size     = ARRAY_SIZE(encore_enltv),
+		.entries  = ARRAY_SIZE(encore_enltv),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_ENCORE_ENLTV,
 	}
diff --git a/drivers/media/rc/keymaps/rc-encore-enltv2.c b/drivers/media/rc/keymaps/rc-encore-enltv2.c
index d8057f41252d..5fb3142d707c 100644
--- a/drivers/media/rc/keymaps/rc-encore-enltv2.c
+++ b/drivers/media/rc/keymaps/rc-encore-enltv2.c
@@ -63,7 +63,7 @@ static struct rc_map_table encore_enltv2[] = {
 static struct rc_map_list encore_enltv2_map = {
 	.map = {
 		.scan     = encore_enltv2,
-		.size     = ARRAY_SIZE(encore_enltv2),
+		.entries  = ARRAY_SIZE(encore_enltv2),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_ENCORE_ENLTV2,
 	}
diff --git a/drivers/media/rc/keymaps/rc-evga-indtube.c b/drivers/media/rc/keymaps/rc-evga-indtube.c
index 95295f6882b1..159d3a17d1d5 100644
--- a/drivers/media/rc/keymaps/rc-evga-indtube.c
+++ b/drivers/media/rc/keymaps/rc-evga-indtube.c
@@ -34,7 +34,7 @@ static struct rc_map_table evga_indtube[] = {
 static struct rc_map_list evga_indtube_map = {
 	.map = {
 		.scan     = evga_indtube,
-		.size     = ARRAY_SIZE(evga_indtube),
+		.entries  = ARRAY_SIZE(evga_indtube),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_EVGA_INDTUBE,
 	}
diff --git a/drivers/media/rc/keymaps/rc-eztv.c b/drivers/media/rc/keymaps/rc-eztv.c
index 522e772f7c2b..a1deb8f42ce6 100644
--- a/drivers/media/rc/keymaps/rc-eztv.c
+++ b/drivers/media/rc/keymaps/rc-eztv.c
@@ -69,7 +69,7 @@ static struct rc_map_table eztv[] = {
 static struct rc_map_list eztv_map = {
 	.map = {
 		.scan     = eztv,
-		.size     = ARRAY_SIZE(eztv),
+		.entries  = ARRAY_SIZE(eztv),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_EZTV,
 	}
diff --git a/drivers/media/rc/keymaps/rc-flydvb.c b/drivers/media/rc/keymaps/rc-flydvb.c
index fcb3bcadd82d..ded68d454cee 100644
--- a/drivers/media/rc/keymaps/rc-flydvb.c
+++ b/drivers/media/rc/keymaps/rc-flydvb.c
@@ -50,7 +50,7 @@ static struct rc_map_table flydvb[] = {
 static struct rc_map_list flydvb_map = {
 	.map = {
 		.scan     = flydvb,
-		.size     = ARRAY_SIZE(flydvb),
+		.entries  = ARRAY_SIZE(flydvb),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_FLYDVB,
 	}
diff --git a/drivers/media/rc/keymaps/rc-flyvideo.c b/drivers/media/rc/keymaps/rc-flyvideo.c
index fcb70c9507cf..a80d787247dc 100644
--- a/drivers/media/rc/keymaps/rc-flyvideo.c
+++ b/drivers/media/rc/keymaps/rc-flyvideo.c
@@ -43,7 +43,7 @@ static struct rc_map_table flyvideo[] = {
 static struct rc_map_list flyvideo_map = {
 	.map = {
 		.scan     = flyvideo,
-		.size     = ARRAY_SIZE(flyvideo),
+		.entries  = ARRAY_SIZE(flyvideo),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_FLYVIDEO,
 	}
diff --git a/drivers/media/rc/keymaps/rc-fusionhdtv-mce.c b/drivers/media/rc/keymaps/rc-fusionhdtv-mce.c
index 43f73db91098..f327623846cd 100644
--- a/drivers/media/rc/keymaps/rc-fusionhdtv-mce.c
+++ b/drivers/media/rc/keymaps/rc-fusionhdtv-mce.c
@@ -71,7 +71,7 @@ static struct rc_map_table fusionhdtv_mce[] = {
 static struct rc_map_list fusionhdtv_mce_map = {
 	.map = {
 		.scan     = fusionhdtv_mce,
-		.size     = ARRAY_SIZE(fusionhdtv_mce),
+		.entries  = ARRAY_SIZE(fusionhdtv_mce),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_FUSIONHDTV_MCE,
 	}
diff --git a/drivers/media/rc/keymaps/rc-gadmei-rm008z.c b/drivers/media/rc/keymaps/rc-gadmei-rm008z.c
index 8a446d125789..f25e844f830b 100644
--- a/drivers/media/rc/keymaps/rc-gadmei-rm008z.c
+++ b/drivers/media/rc/keymaps/rc-gadmei-rm008z.c
@@ -54,7 +54,7 @@ static struct rc_map_table gadmei_rm008z[] = {
 static struct rc_map_list gadmei_rm008z_map = {
 	.map = {
 		.scan     = gadmei_rm008z,
-		.size     = ARRAY_SIZE(gadmei_rm008z),
+		.entries  = ARRAY_SIZE(gadmei_rm008z),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_GADMEI_RM008Z,
 	}
diff --git a/drivers/media/rc/keymaps/rc-geekbox.c b/drivers/media/rc/keymaps/rc-geekbox.c
index d3f2e960c925..dd33d1b3351a 100644
--- a/drivers/media/rc/keymaps/rc-geekbox.c
+++ b/drivers/media/rc/keymaps/rc-geekbox.c
@@ -26,7 +26,7 @@ static struct rc_map_table geekbox[] = {
 static struct rc_map_list geekbox_map = {
 	.map = {
 		.scan     = geekbox,
-		.size     = ARRAY_SIZE(geekbox),
+		.entries  = ARRAY_SIZE(geekbox),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_GEEKBOX,
 	}
diff --git a/drivers/media/rc/keymaps/rc-genius-tvgo-a11mce.c b/drivers/media/rc/keymaps/rc-genius-tvgo-a11mce.c
index e49828ea2b80..29d067bf14e8 100644
--- a/drivers/media/rc/keymaps/rc-genius-tvgo-a11mce.c
+++ b/drivers/media/rc/keymaps/rc-genius-tvgo-a11mce.c
@@ -57,7 +57,7 @@ static struct rc_map_table genius_tvgo_a11mce[] = {
 static struct rc_map_list genius_tvgo_a11mce_map = {
 	.map = {
 		.scan     = genius_tvgo_a11mce,
-		.size     = ARRAY_SIZE(genius_tvgo_a11mce),
+		.entries  = ARRAY_SIZE(genius_tvgo_a11mce),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_GENIUS_TVGO_A11MCE,
 	}
diff --git a/drivers/media/rc/keymaps/rc-gotview7135.c b/drivers/media/rc/keymaps/rc-gotview7135.c
index a044991e30ba..3982b4c15393 100644
--- a/drivers/media/rc/keymaps/rc-gotview7135.c
+++ b/drivers/media/rc/keymaps/rc-gotview7135.c
@@ -52,7 +52,7 @@ static struct rc_map_table gotview7135[] = {
 static struct rc_map_list gotview7135_map = {
 	.map = {
 		.scan     = gotview7135,
-		.size     = ARRAY_SIZE(gotview7135),
+		.entries  = ARRAY_SIZE(gotview7135),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_GOTVIEW7135,
 	}
diff --git a/drivers/media/rc/keymaps/rc-hauppauge.c b/drivers/media/rc/keymaps/rc-hauppauge.c
index 9e64c0b2d18e..e89931e756ab 100644
--- a/drivers/media/rc/keymaps/rc-hauppauge.c
+++ b/drivers/media/rc/keymaps/rc-hauppauge.c
@@ -308,7 +308,7 @@ static struct rc_map_table rc5_hauppauge_new[] = {
 static struct rc_map_list rc5_hauppauge_new_map = {
 	.map = {
 		.scan     = rc5_hauppauge_new,
-		.size     = ARRAY_SIZE(rc5_hauppauge_new),
+		.entries  = ARRAY_SIZE(rc5_hauppauge_new),
 		.rc_proto = RC_PROTO_RC5,
 		.name     = RC_MAP_HAUPPAUGE,
 	}
diff --git a/drivers/media/rc/keymaps/rc-hisi-poplar.c b/drivers/media/rc/keymaps/rc-hisi-poplar.c
index b10ad674c32a..3ca32efc8f7b 100644
--- a/drivers/media/rc/keymaps/rc-hisi-poplar.c
+++ b/drivers/media/rc/keymaps/rc-hisi-poplar.c
@@ -43,7 +43,7 @@ static struct rc_map_table hisi_poplar_keymap[] = {
 static struct rc_map_list hisi_poplar_map = {
 	.map = {
 		.scan	  = hisi_poplar_keymap,
-		.size	  = ARRAY_SIZE(hisi_poplar_keymap),
+		.entries  = ARRAY_SIZE(hisi_poplar_keymap),
 		.rc_proto = RC_PROTO_NEC,
 		.name	  = RC_MAP_HISI_POPLAR,
 	}
diff --git a/drivers/media/rc/keymaps/rc-hisi-tv-demo.c b/drivers/media/rc/keymaps/rc-hisi-tv-demo.c
index 24dcb38df27c..90d5c0286829 100644
--- a/drivers/media/rc/keymaps/rc-hisi-tv-demo.c
+++ b/drivers/media/rc/keymaps/rc-hisi-tv-demo.c
@@ -55,7 +55,7 @@ static struct rc_map_table hisi_tv_demo_keymap[] = {
 static struct rc_map_list hisi_tv_demo_map = {
 	.map = {
 		.scan	  = hisi_tv_demo_keymap,
-		.size	  = ARRAY_SIZE(hisi_tv_demo_keymap),
+		.entries  = ARRAY_SIZE(hisi_tv_demo_keymap),
 		.rc_proto = RC_PROTO_NEC,
 		.name	  = RC_MAP_HISI_TV_DEMO,
 	}
diff --git a/drivers/media/rc/keymaps/rc-imon-mce.c b/drivers/media/rc/keymaps/rc-imon-mce.c
index 130f685ae30e..8cf091850cae 100644
--- a/drivers/media/rc/keymaps/rc-imon-mce.c
+++ b/drivers/media/rc/keymaps/rc-imon-mce.c
@@ -115,7 +115,7 @@ static struct rc_map_table imon_mce[] = {
 static struct rc_map_list imon_mce_map = {
 	.map = {
 		.scan     = imon_mce,
-		.size     = ARRAY_SIZE(imon_mce),
+		.entries  = ARRAY_SIZE(imon_mce),
 		/* its RC6, but w/a hardware decoder */
 		.rc_proto = RC_PROTO_RC6_MCE,
 		.name     = RC_MAP_IMON_MCE,
diff --git a/drivers/media/rc/keymaps/rc-imon-pad.c b/drivers/media/rc/keymaps/rc-imon-pad.c
index cd5ba44d033c..2e571e2f8ac1 100644
--- a/drivers/media/rc/keymaps/rc-imon-pad.c
+++ b/drivers/media/rc/keymaps/rc-imon-pad.c
@@ -129,7 +129,7 @@ static struct rc_map_table imon_pad[] = {
 static struct rc_map_list imon_pad_map = {
 	.map = {
 		.scan     = imon_pad,
-		.size     = ARRAY_SIZE(imon_pad),
+		.entries  = ARRAY_SIZE(imon_pad),
 		.rc_proto = RC_PROTO_IMON,
 		.name     = RC_MAP_IMON_PAD,
 	}
diff --git a/drivers/media/rc/keymaps/rc-imon-rsc.c b/drivers/media/rc/keymaps/rc-imon-rsc.c
index e4124fadf705..337928253144 100644
--- a/drivers/media/rc/keymaps/rc-imon-rsc.c
+++ b/drivers/media/rc/keymaps/rc-imon-rsc.c
@@ -59,7 +59,7 @@ static struct rc_map_table imon_rsc[] = {
 static struct rc_map_list imon_rsc_map = {
 	.map = {
 		.scan     = imon_rsc,
-		.size     = ARRAY_SIZE(imon_rsc),
+		.entries  = ARRAY_SIZE(imon_rsc),
 		.rc_proto = RC_PROTO_NECX,
 		.name     = RC_MAP_IMON_RSC,
 	}
diff --git a/drivers/media/rc/keymaps/rc-iodata-bctv7e.c b/drivers/media/rc/keymaps/rc-iodata-bctv7e.c
index 95256e85458a..8279190b7b5f 100644
--- a/drivers/media/rc/keymaps/rc-iodata-bctv7e.c
+++ b/drivers/media/rc/keymaps/rc-iodata-bctv7e.c
@@ -61,7 +61,7 @@ static struct rc_map_table iodata_bctv7e[] = {
 static struct rc_map_list iodata_bctv7e_map = {
 	.map = {
 		.scan     = iodata_bctv7e,
-		.size     = ARRAY_SIZE(iodata_bctv7e),
+		.entries  = ARRAY_SIZE(iodata_bctv7e),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_IODATA_BCTV7E,
 	}
diff --git a/drivers/media/rc/keymaps/rc-it913x-v1.c b/drivers/media/rc/keymaps/rc-it913x-v1.c
index d80764c98f44..9a707fed9b3d 100644
--- a/drivers/media/rc/keymaps/rc-it913x-v1.c
+++ b/drivers/media/rc/keymaps/rc-it913x-v1.c
@@ -68,7 +68,7 @@ static struct rc_map_table it913x_v1_rc[] = {
 static struct rc_map_list it913x_v1_map = {
 	.map = {
 		.scan     = it913x_v1_rc,
-		.size     = ARRAY_SIZE(it913x_v1_rc),
+		.entries  = ARRAY_SIZE(it913x_v1_rc),
 		.rc_proto = RC_PROTO_NECX,
 		.name     = RC_MAP_IT913X_V1,
 	}
diff --git a/drivers/media/rc/keymaps/rc-it913x-v2.c b/drivers/media/rc/keymaps/rc-it913x-v2.c
index c37358cf8b86..a38bbfccb9ff 100644
--- a/drivers/media/rc/keymaps/rc-it913x-v2.c
+++ b/drivers/media/rc/keymaps/rc-it913x-v2.c
@@ -67,7 +67,7 @@ static struct rc_map_table it913x_v2_rc[] = {
 static struct rc_map_list it913x_v2_map = {
 	.map = {
 		.scan     = it913x_v2_rc,
-		.size     = ARRAY_SIZE(it913x_v2_rc),
+		.entries  = ARRAY_SIZE(it913x_v2_rc),
 		.rc_proto = RC_PROTO_NECX,
 		.name     = RC_MAP_IT913X_V2,
 	}
diff --git a/drivers/media/rc/keymaps/rc-kaiomy.c b/drivers/media/rc/keymaps/rc-kaiomy.c
index bea50c6f7e99..c93d19d693ce 100644
--- a/drivers/media/rc/keymaps/rc-kaiomy.c
+++ b/drivers/media/rc/keymaps/rc-kaiomy.c
@@ -60,7 +60,7 @@ static struct rc_map_table kaiomy[] = {
 static struct rc_map_list kaiomy_map = {
 	.map = {
 		.scan     = kaiomy,
-		.size     = ARRAY_SIZE(kaiomy),
+		.entries  = ARRAY_SIZE(kaiomy),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_KAIOMY,
 	}
diff --git a/drivers/media/rc/keymaps/rc-khadas.c b/drivers/media/rc/keymaps/rc-khadas.c
index 2b7161e1bc3f..94e5b076862c 100644
--- a/drivers/media/rc/keymaps/rc-khadas.c
+++ b/drivers/media/rc/keymaps/rc-khadas.c
@@ -31,7 +31,7 @@ static struct rc_map_table khadas[] = {
 static struct rc_map_list khadas_map = {
 	.map = {
 		.scan     = khadas,
-		.size     = ARRAY_SIZE(khadas),
+		.entries  = ARRAY_SIZE(khadas),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_KHADAS,
 	}
diff --git a/drivers/media/rc/keymaps/rc-khamsin.c b/drivers/media/rc/keymaps/rc-khamsin.c
index 2121cad8d3df..893fa512cf48 100644
--- a/drivers/media/rc/keymaps/rc-khamsin.c
+++ b/drivers/media/rc/keymaps/rc-khamsin.c
@@ -52,7 +52,7 @@ static struct rc_map_table khamsin[] = {
 static struct rc_map_list khamsin_map = {
 	.map = {
 		.scan     = khamsin,
-		.size     = ARRAY_SIZE(khamsin),
+		.entries  = ARRAY_SIZE(khamsin),
 		.rc_proto = RC_PROTO_NECX,
 		.name     = RC_MAP_KHAMSIN,
 	}
diff --git a/drivers/media/rc/keymaps/rc-kworld-315u.c b/drivers/media/rc/keymaps/rc-kworld-315u.c
index f849dd6b7ef2..e7aa537e65ee 100644
--- a/drivers/media/rc/keymaps/rc-kworld-315u.c
+++ b/drivers/media/rc/keymaps/rc-kworld-315u.c
@@ -56,7 +56,7 @@ static struct rc_map_table kworld_315u[] = {
 static struct rc_map_list kworld_315u_map = {
 	.map = {
 		.scan     = kworld_315u,
-		.size     = ARRAY_SIZE(kworld_315u),
+		.entries  = ARRAY_SIZE(kworld_315u),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_KWORLD_315U,
 	}
diff --git a/drivers/media/rc/keymaps/rc-kworld-pc150u.c b/drivers/media/rc/keymaps/rc-kworld-pc150u.c
index 630ef7c330d9..97eb43f69f46 100644
--- a/drivers/media/rc/keymaps/rc-kworld-pc150u.c
+++ b/drivers/media/rc/keymaps/rc-kworld-pc150u.c
@@ -75,7 +75,7 @@ static struct rc_map_table kworld_pc150u[] = {
 static struct rc_map_list kworld_pc150u_map = {
 	.map = {
 		.scan     = kworld_pc150u,
-		.size     = ARRAY_SIZE(kworld_pc150u),
+		.entries  = ARRAY_SIZE(kworld_pc150u),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_KWORLD_PC150U,
 	}
diff --git a/drivers/media/rc/keymaps/rc-kworld-plus-tv-analog.c b/drivers/media/rc/keymaps/rc-kworld-plus-tv-analog.c
index 1fb9dc434685..6f40894e9c1f 100644
--- a/drivers/media/rc/keymaps/rc-kworld-plus-tv-analog.c
+++ b/drivers/media/rc/keymaps/rc-kworld-plus-tv-analog.c
@@ -76,7 +76,7 @@ static struct rc_map_table kworld_plus_tv_analog[] = {
 static struct rc_map_list kworld_plus_tv_analog_map = {
 	.map = {
 		.scan     = kworld_plus_tv_analog,
-		.size     = ARRAY_SIZE(kworld_plus_tv_analog),
+		.entries  = ARRAY_SIZE(kworld_plus_tv_analog),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_KWORLD_PLUS_TV_ANALOG,
 	}
diff --git a/drivers/media/rc/keymaps/rc-leadtek-y04g0051.c b/drivers/media/rc/keymaps/rc-leadtek-y04g0051.c
index c637312643b7..b9402ea6a5e2 100644
--- a/drivers/media/rc/keymaps/rc-leadtek-y04g0051.c
+++ b/drivers/media/rc/keymaps/rc-leadtek-y04g0051.c
@@ -64,7 +64,7 @@ static struct rc_map_table leadtek_y04g0051[] = {
 static struct rc_map_list leadtek_y04g0051_map = {
 	.map = {
 		.scan     = leadtek_y04g0051,
-		.size     = ARRAY_SIZE(leadtek_y04g0051),
+		.entries  = ARRAY_SIZE(leadtek_y04g0051),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_LEADTEK_Y04G0051,
 	}
diff --git a/drivers/media/rc/keymaps/rc-lme2510.c b/drivers/media/rc/keymaps/rc-lme2510.c
index 575485655a85..fa83d6999efc 100644
--- a/drivers/media/rc/keymaps/rc-lme2510.c
+++ b/drivers/media/rc/keymaps/rc-lme2510.c
@@ -83,7 +83,7 @@ static struct rc_map_table lme2510_rc[] = {
 static struct rc_map_list lme2510_map = {
 	.map = {
 		.scan     = lme2510_rc,
-		.size     = ARRAY_SIZE(lme2510_rc),
+		.entries  = ARRAY_SIZE(lme2510_rc),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_LME2510,
 	}
diff --git a/drivers/media/rc/keymaps/rc-manli.c b/drivers/media/rc/keymaps/rc-manli.c
index b81149a0dfd8..5aa6043972d5 100644
--- a/drivers/media/rc/keymaps/rc-manli.c
+++ b/drivers/media/rc/keymaps/rc-manli.c
@@ -107,7 +107,7 @@ static struct rc_map_table manli[] = {
 static struct rc_map_list manli_map = {
 	.map = {
 		.scan     = manli,
-		.size     = ARRAY_SIZE(manli),
+		.entries  = ARRAY_SIZE(manli),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_MANLI,
 	}
diff --git a/drivers/media/rc/keymaps/rc-mecool-kii-pro.c b/drivers/media/rc/keymaps/rc-mecool-kii-pro.c
index 273fe1a304f0..e40e8c01dbbb 100644
--- a/drivers/media/rc/keymaps/rc-mecool-kii-pro.c
+++ b/drivers/media/rc/keymaps/rc-mecool-kii-pro.c
@@ -68,7 +68,7 @@ static struct rc_map_table mecool_kii_pro[] = {
 static struct rc_map_list mecool_kii_pro_map = {
 	.map = {
 		.scan     = mecool_kii_pro,
-		.size     = ARRAY_SIZE(mecool_kii_pro),
+		.entries  = ARRAY_SIZE(mecool_kii_pro),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_MECOOL_KII_PRO,
 	}
diff --git a/drivers/media/rc/keymaps/rc-mecool-kiii-pro.c b/drivers/media/rc/keymaps/rc-mecool-kiii-pro.c
index 53fd7c895ddc..d7234645c29d 100644
--- a/drivers/media/rc/keymaps/rc-mecool-kiii-pro.c
+++ b/drivers/media/rc/keymaps/rc-mecool-kiii-pro.c
@@ -65,7 +65,7 @@ static struct rc_map_table mecool_kiii_pro[] = {
 static struct rc_map_list mecool_kiii_pro_map = {
 	.map = {
 		.scan     = mecool_kiii_pro,
-		.size     = ARRAY_SIZE(mecool_kiii_pro),
+		.entries  = ARRAY_SIZE(mecool_kiii_pro),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_MECOOL_KIII_PRO,
 	}
diff --git a/drivers/media/rc/keymaps/rc-medion-x10-digitainer.c b/drivers/media/rc/keymaps/rc-medion-x10-digitainer.c
index bf74912859b3..2e843414710c 100644
--- a/drivers/media/rc/keymaps/rc-medion-x10-digitainer.c
+++ b/drivers/media/rc/keymaps/rc-medion-x10-digitainer.c
@@ -86,7 +86,7 @@ static struct rc_map_table medion_x10_digitainer[] = {
 static struct rc_map_list medion_x10_digitainer_map = {
 	.map = {
 		.scan     = medion_x10_digitainer,
-		.size     = ARRAY_SIZE(medion_x10_digitainer),
+		.entries  = ARRAY_SIZE(medion_x10_digitainer),
 		.rc_proto = RC_PROTO_OTHER,
 		.name     = RC_MAP_MEDION_X10_DIGITAINER,
 	}
diff --git a/drivers/media/rc/keymaps/rc-medion-x10-or2x.c b/drivers/media/rc/keymaps/rc-medion-x10-or2x.c
index 293045c9aaa5..1b3161c4813f 100644
--- a/drivers/media/rc/keymaps/rc-medion-x10-or2x.c
+++ b/drivers/media/rc/keymaps/rc-medion-x10-or2x.c
@@ -71,7 +71,7 @@ static struct rc_map_table medion_x10_or2x[] = {
 static struct rc_map_list medion_x10_or2x_map = {
 	.map = {
 		.scan     = medion_x10_or2x,
-		.size     = ARRAY_SIZE(medion_x10_or2x),
+		.entries  = ARRAY_SIZE(medion_x10_or2x),
 		.rc_proto = RC_PROTO_OTHER,
 		.name     = RC_MAP_MEDION_X10_OR2X,
 	}
diff --git a/drivers/media/rc/keymaps/rc-medion-x10.c b/drivers/media/rc/keymaps/rc-medion-x10.c
index 3ea8fdbaf18c..696335cd9c6d 100644
--- a/drivers/media/rc/keymaps/rc-medion-x10.c
+++ b/drivers/media/rc/keymaps/rc-medion-x10.c
@@ -81,7 +81,7 @@ static struct rc_map_table medion_x10[] = {
 static struct rc_map_list medion_x10_map = {
 	.map = {
 		.scan     = medion_x10,
-		.size     = ARRAY_SIZE(medion_x10),
+		.entries  = ARRAY_SIZE(medion_x10),
 		.rc_proto = RC_PROTO_OTHER,
 		.name     = RC_MAP_MEDION_X10,
 	}
diff --git a/drivers/media/rc/keymaps/rc-minix-neo.c b/drivers/media/rc/keymaps/rc-minix-neo.c
index ce16e964e72e..7979f8a45bdd 100644
--- a/drivers/media/rc/keymaps/rc-minix-neo.c
+++ b/drivers/media/rc/keymaps/rc-minix-neo.c
@@ -32,7 +32,7 @@ static struct rc_map_table minix_neo[] = {
 static struct rc_map_list minix_neo_map = {
 	.map = {
 		.scan     = minix_neo,
-		.size     = ARRAY_SIZE(minix_neo),
+		.entries  = ARRAY_SIZE(minix_neo),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_MINIX_NEO,
 	}
diff --git a/drivers/media/rc/keymaps/rc-msi-digivox-ii.c b/drivers/media/rc/keymaps/rc-msi-digivox-ii.c
index f152626fd802..988bd85ee570 100644
--- a/drivers/media/rc/keymaps/rc-msi-digivox-ii.c
+++ b/drivers/media/rc/keymaps/rc-msi-digivox-ii.c
@@ -32,7 +32,7 @@ static struct rc_map_table msi_digivox_ii[] = {
 static struct rc_map_list msi_digivox_ii_map = {
 	.map = {
 		.scan     = msi_digivox_ii,
-		.size     = ARRAY_SIZE(msi_digivox_ii),
+		.entries  = ARRAY_SIZE(msi_digivox_ii),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_MSI_DIGIVOX_II,
 	}
diff --git a/drivers/media/rc/keymaps/rc-msi-digivox-iii.c b/drivers/media/rc/keymaps/rc-msi-digivox-iii.c
index 1250cde3367d..e5a90d2d548c 100644
--- a/drivers/media/rc/keymaps/rc-msi-digivox-iii.c
+++ b/drivers/media/rc/keymaps/rc-msi-digivox-iii.c
@@ -50,7 +50,7 @@ static struct rc_map_table msi_digivox_iii[] = {
 static struct rc_map_list msi_digivox_iii_map = {
 	.map = {
 		.scan     = msi_digivox_iii,
-		.size     = ARRAY_SIZE(msi_digivox_iii),
+		.entries  = ARRAY_SIZE(msi_digivox_iii),
 		.rc_proto = RC_PROTO_NECX,
 		.name     = RC_MAP_MSI_DIGIVOX_III,
 	}
diff --git a/drivers/media/rc/keymaps/rc-msi-tvanywhere-plus.c b/drivers/media/rc/keymaps/rc-msi-tvanywhere-plus.c
index 648bac448f29..66f462c4569b 100644
--- a/drivers/media/rc/keymaps/rc-msi-tvanywhere-plus.c
+++ b/drivers/media/rc/keymaps/rc-msi-tvanywhere-plus.c
@@ -96,7 +96,7 @@ static struct rc_map_table msi_tvanywhere_plus[] = {
 static struct rc_map_list msi_tvanywhere_plus_map = {
 	.map = {
 		.scan     = msi_tvanywhere_plus,
-		.size     = ARRAY_SIZE(msi_tvanywhere_plus),
+		.entries  = ARRAY_SIZE(msi_tvanywhere_plus),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_MSI_TVANYWHERE_PLUS,
 	}
diff --git a/drivers/media/rc/keymaps/rc-msi-tvanywhere.c b/drivers/media/rc/keymaps/rc-msi-tvanywhere.c
index b59af39ba005..db609dd2e348 100644
--- a/drivers/media/rc/keymaps/rc-msi-tvanywhere.c
+++ b/drivers/media/rc/keymaps/rc-msi-tvanywhere.c
@@ -42,7 +42,7 @@ static struct rc_map_table msi_tvanywhere[] = {
 static struct rc_map_list msi_tvanywhere_map = {
 	.map = {
 		.scan     = msi_tvanywhere,
-		.size     = ARRAY_SIZE(msi_tvanywhere),
+		.entries  = ARRAY_SIZE(msi_tvanywhere),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_MSI_TVANYWHERE,
 	}
diff --git a/drivers/media/rc/keymaps/rc-mygica-utv3.c b/drivers/media/rc/keymaps/rc-mygica-utv3.c
index f32b8281459b..8dc1db9c6b8e 100644
--- a/drivers/media/rc/keymaps/rc-mygica-utv3.c
+++ b/drivers/media/rc/keymaps/rc-mygica-utv3.c
@@ -45,7 +45,7 @@ static struct rc_map_table mygica_utv3[] = {
 static struct rc_map_list mygica_utv3_map = {
 	.map = {
 		.scan     = mygica_utv3,
-		.size     = ARRAY_SIZE(mygica_utv3),
+		.entries  = ARRAY_SIZE(mygica_utv3),
 		.rc_proto = RC_PROTO_RC5,
 		.name     = RC_MAP_MYGICA_UTV3,
 	}
diff --git a/drivers/media/rc/keymaps/rc-nebula.c b/drivers/media/rc/keymaps/rc-nebula.c
index 23b75269d307..809024407f3e 100644
--- a/drivers/media/rc/keymaps/rc-nebula.c
+++ b/drivers/media/rc/keymaps/rc-nebula.c
@@ -69,7 +69,7 @@ static struct rc_map_table nebula[] = {
 static struct rc_map_list nebula_map = {
 	.map = {
 		.scan     = nebula,
-		.size     = ARRAY_SIZE(nebula),
+		.entries  = ARRAY_SIZE(nebula),
 		.rc_proto = RC_PROTO_RC5,
 		.name     = RC_MAP_NEBULA,
 	}
diff --git a/drivers/media/rc/keymaps/rc-nec-terratec-cinergy-xs.c b/drivers/media/rc/keymaps/rc-nec-terratec-cinergy-xs.c
index 94340a1864a0..b2e850ff2eea 100644
--- a/drivers/media/rc/keymaps/rc-nec-terratec-cinergy-xs.c
+++ b/drivers/media/rc/keymaps/rc-nec-terratec-cinergy-xs.c
@@ -130,7 +130,7 @@ static struct rc_map_table nec_terratec_cinergy_xs[] = {
 static struct rc_map_list nec_terratec_cinergy_xs_map = {
 	.map = {
 		.scan     = nec_terratec_cinergy_xs,
-		.size     = ARRAY_SIZE(nec_terratec_cinergy_xs),
+		.entries  = ARRAY_SIZE(nec_terratec_cinergy_xs),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_NEC_TERRATEC_CINERGY_XS,
 	}
diff --git a/drivers/media/rc/keymaps/rc-norwood.c b/drivers/media/rc/keymaps/rc-norwood.c
index da00003a5e79..f57fb87b67b5 100644
--- a/drivers/media/rc/keymaps/rc-norwood.c
+++ b/drivers/media/rc/keymaps/rc-norwood.c
@@ -58,7 +58,7 @@ static struct rc_map_table norwood[] = {
 static struct rc_map_list norwood_map = {
 	.map = {
 		.scan     = norwood,
-		.size     = ARRAY_SIZE(norwood),
+		.entries  = ARRAY_SIZE(norwood),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_NORWOOD,
 	}
diff --git a/drivers/media/rc/keymaps/rc-npgtech.c b/drivers/media/rc/keymaps/rc-npgtech.c
index 6f4412922e0c..f79f47a54a4b 100644
--- a/drivers/media/rc/keymaps/rc-npgtech.c
+++ b/drivers/media/rc/keymaps/rc-npgtech.c
@@ -53,7 +53,7 @@ static struct rc_map_table npgtech[] = {
 static struct rc_map_list npgtech_map = {
 	.map = {
 		.scan     = npgtech,
-		.size     = ARRAY_SIZE(npgtech),
+		.entries  = ARRAY_SIZE(npgtech),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_NPGTECH,
 	}
diff --git a/drivers/media/rc/keymaps/rc-odroid.c b/drivers/media/rc/keymaps/rc-odroid.c
index 0353229a4915..dd51661dbd20 100644
--- a/drivers/media/rc/keymaps/rc-odroid.c
+++ b/drivers/media/rc/keymaps/rc-odroid.c
@@ -31,7 +31,7 @@ static struct rc_map_table odroid[] = {
 static struct rc_map_list odroid_map = {
 	.map = {
 		.scan     = odroid,
-		.size     = ARRAY_SIZE(odroid),
+		.entries  = ARRAY_SIZE(odroid),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_ODROID,
 	}
diff --git a/drivers/media/rc/keymaps/rc-pctv-sedna.c b/drivers/media/rc/keymaps/rc-pctv-sedna.c
index 6583bf4fcb04..8b026b90a300 100644
--- a/drivers/media/rc/keymaps/rc-pctv-sedna.c
+++ b/drivers/media/rc/keymaps/rc-pctv-sedna.c
@@ -53,7 +53,7 @@ static struct rc_map_table pctv_sedna[] = {
 static struct rc_map_list pctv_sedna_map = {
 	.map = {
 		.scan     = pctv_sedna,
-		.size     = ARRAY_SIZE(pctv_sedna),
+		.entries  = ARRAY_SIZE(pctv_sedna),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_PCTV_SEDNA,
 	}
diff --git a/drivers/media/rc/keymaps/rc-pine64.c b/drivers/media/rc/keymaps/rc-pine64.c
index bcdb99997d4d..e9977f4a4c25 100644
--- a/drivers/media/rc/keymaps/rc-pine64.c
+++ b/drivers/media/rc/keymaps/rc-pine64.c
@@ -42,7 +42,7 @@ static struct rc_map_table pine64[] = {
 static struct rc_map_list pine64_map = {
 	.map = {
 		.scan     = pine64,
-		.size     = ARRAY_SIZE(pine64),
+		.entries  = ARRAY_SIZE(pine64),
 		.rc_proto = RC_PROTO_NECX,
 		.name     = RC_MAP_PINE64,
 	}
diff --git a/drivers/media/rc/keymaps/rc-pinnacle-color.c b/drivers/media/rc/keymaps/rc-pinnacle-color.c
index f33c38644f83..925aad59b16c 100644
--- a/drivers/media/rc/keymaps/rc-pinnacle-color.c
+++ b/drivers/media/rc/keymaps/rc-pinnacle-color.c
@@ -67,7 +67,7 @@ static struct rc_map_table pinnacle_color[] = {
 static struct rc_map_list pinnacle_color_map = {
 	.map = {
 		.scan     = pinnacle_color,
-		.size     = ARRAY_SIZE(pinnacle_color),
+		.entries  = ARRAY_SIZE(pinnacle_color),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_PINNACLE_COLOR,
 	}
diff --git a/drivers/media/rc/keymaps/rc-pinnacle-grey.c b/drivers/media/rc/keymaps/rc-pinnacle-grey.c
index 22ef3d4e2e71..56e93d153bd3 100644
--- a/drivers/media/rc/keymaps/rc-pinnacle-grey.c
+++ b/drivers/media/rc/keymaps/rc-pinnacle-grey.c
@@ -62,7 +62,7 @@ static struct rc_map_table pinnacle_grey[] = {
 static struct rc_map_list pinnacle_grey_map = {
 	.map = {
 		.scan     = pinnacle_grey,
-		.size     = ARRAY_SIZE(pinnacle_grey),
+		.entries  = ARRAY_SIZE(pinnacle_grey),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_PINNACLE_GREY,
 	}
diff --git a/drivers/media/rc/keymaps/rc-pinnacle-pctv-hd.c b/drivers/media/rc/keymaps/rc-pinnacle-pctv-hd.c
index 35f0c790cc0c..944d304df55a 100644
--- a/drivers/media/rc/keymaps/rc-pinnacle-pctv-hd.c
+++ b/drivers/media/rc/keymaps/rc-pinnacle-pctv-hd.c
@@ -43,7 +43,7 @@ static struct rc_map_table pinnacle_pctv_hd[] = {
 static struct rc_map_list pinnacle_pctv_hd_map = {
 	.map = {
 		.scan     = pinnacle_pctv_hd,
-		.size     = ARRAY_SIZE(pinnacle_pctv_hd),
+		.entries  = ARRAY_SIZE(pinnacle_pctv_hd),
 		.rc_proto = RC_PROTO_RC5,
 		.name     = RC_MAP_PINNACLE_PCTV_HD,
 	}
diff --git a/drivers/media/rc/keymaps/rc-pixelview-002t.c b/drivers/media/rc/keymaps/rc-pixelview-002t.c
index 0966ebf0903a..f31135978ab5 100644
--- a/drivers/media/rc/keymaps/rc-pixelview-002t.c
+++ b/drivers/media/rc/keymaps/rc-pixelview-002t.c
@@ -50,7 +50,7 @@ static struct rc_map_table pixelview_002t[] = {
 static struct rc_map_list pixelview_map = {
 	.map = {
 		.scan     = pixelview_002t,
-		.size     = ARRAY_SIZE(pixelview_002t),
+		.entries  = ARRAY_SIZE(pixelview_002t),
 		.rc_proto = RC_PROTO_NECX,
 		.name     = RC_MAP_PIXELVIEW_002T,
 	}
diff --git a/drivers/media/rc/keymaps/rc-pixelview-mk12.c b/drivers/media/rc/keymaps/rc-pixelview-mk12.c
index e18774473809..0a305f68dea2 100644
--- a/drivers/media/rc/keymaps/rc-pixelview-mk12.c
+++ b/drivers/media/rc/keymaps/rc-pixelview-mk12.c
@@ -56,7 +56,7 @@ static struct rc_map_table pixelview_mk12[] = {
 static struct rc_map_list pixelview_map = {
 	.map = {
 		.scan     = pixelview_mk12,
-		.size     = ARRAY_SIZE(pixelview_mk12),
+		.entries  = ARRAY_SIZE(pixelview_mk12),
 		.rc_proto = RC_PROTO_NECX,
 		.name     = RC_MAP_PIXELVIEW_MK12,
 	}
diff --git a/drivers/media/rc/keymaps/rc-pixelview-new.c b/drivers/media/rc/keymaps/rc-pixelview-new.c
index cf7f1cf8c3b5..fc324eab8450 100644
--- a/drivers/media/rc/keymaps/rc-pixelview-new.c
+++ b/drivers/media/rc/keymaps/rc-pixelview-new.c
@@ -56,7 +56,7 @@ static struct rc_map_table pixelview_new[] = {
 static struct rc_map_list pixelview_new_map = {
 	.map = {
 		.scan     = pixelview_new,
-		.size     = ARRAY_SIZE(pixelview_new),
+		.entries  = ARRAY_SIZE(pixelview_new),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_PIXELVIEW_NEW,
 	}
diff --git a/drivers/media/rc/keymaps/rc-pixelview.c b/drivers/media/rc/keymaps/rc-pixelview.c
index 567ad0a076fc..219579b92a7e 100644
--- a/drivers/media/rc/keymaps/rc-pixelview.c
+++ b/drivers/media/rc/keymaps/rc-pixelview.c
@@ -55,7 +55,7 @@ static struct rc_map_table pixelview[] = {
 static struct rc_map_list pixelview_map = {
 	.map = {
 		.scan     = pixelview,
-		.size     = ARRAY_SIZE(pixelview),
+		.entries  = ARRAY_SIZE(pixelview),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_PIXELVIEW,
 	}
diff --git a/drivers/media/rc/keymaps/rc-powercolor-real-angel.c b/drivers/media/rc/keymaps/rc-powercolor-real-angel.c
index e7a6add1df26..53bf725caec7 100644
--- a/drivers/media/rc/keymaps/rc-powercolor-real-angel.c
+++ b/drivers/media/rc/keymaps/rc-powercolor-real-angel.c
@@ -54,7 +54,7 @@ static struct rc_map_table powercolor_real_angel[] = {
 static struct rc_map_list powercolor_real_angel_map = {
 	.map = {
 		.scan     = powercolor_real_angel,
-		.size     = ARRAY_SIZE(powercolor_real_angel),
+		.entries  = ARRAY_SIZE(powercolor_real_angel),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_POWERCOLOR_REAL_ANGEL,
 	}
diff --git a/drivers/media/rc/keymaps/rc-proteus-2309.c b/drivers/media/rc/keymaps/rc-proteus-2309.c
index 1300482a6119..75b1661b933f 100644
--- a/drivers/media/rc/keymaps/rc-proteus-2309.c
+++ b/drivers/media/rc/keymaps/rc-proteus-2309.c
@@ -42,7 +42,7 @@ static struct rc_map_table proteus_2309[] = {
 static struct rc_map_list proteus_2309_map = {
 	.map = {
 		.scan     = proteus_2309,
-		.size     = ARRAY_SIZE(proteus_2309),
+		.entries  = ARRAY_SIZE(proteus_2309),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_PROTEUS_2309,
 	}
diff --git a/drivers/media/rc/keymaps/rc-purpletv.c b/drivers/media/rc/keymaps/rc-purpletv.c
index 9f6ee0be1347..87498d63f717 100644
--- a/drivers/media/rc/keymaps/rc-purpletv.c
+++ b/drivers/media/rc/keymaps/rc-purpletv.c
@@ -54,7 +54,7 @@ static struct rc_map_table purpletv[] = {
 static struct rc_map_list purpletv_map = {
 	.map = {
 		.scan     = purpletv,
-		.size     = ARRAY_SIZE(purpletv),
+		.entries  = ARRAY_SIZE(purpletv),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_PURPLETV,
 	}
diff --git a/drivers/media/rc/keymaps/rc-pv951.c b/drivers/media/rc/keymaps/rc-pv951.c
index 539e8573eb19..3a338867977f 100644
--- a/drivers/media/rc/keymaps/rc-pv951.c
+++ b/drivers/media/rc/keymaps/rc-pv951.c
@@ -51,7 +51,7 @@ static struct rc_map_table pv951[] = {
 static struct rc_map_list pv951_map = {
 	.map = {
 		.scan     = pv951,
-		.size     = ARRAY_SIZE(pv951),
+		.entries  = ARRAY_SIZE(pv951),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_PV951,
 	}
diff --git a/drivers/media/rc/keymaps/rc-rc6-mce.c b/drivers/media/rc/keymaps/rc-rc6-mce.c
index ef1c61eb99b2..3ed40dabe537 100644
--- a/drivers/media/rc/keymaps/rc-rc6-mce.c
+++ b/drivers/media/rc/keymaps/rc-rc6-mce.c
@@ -93,7 +93,7 @@ static struct rc_map_table rc6_mce[] = {
 static struct rc_map_list rc6_mce_map = {
 	.map = {
 		.scan     = rc6_mce,
-		.size     = ARRAY_SIZE(rc6_mce),
+		.entries  = ARRAY_SIZE(rc6_mce),
 		.rc_proto = RC_PROTO_RC6_MCE,
 		.name     = RC_MAP_RC6_MCE,
 	}
diff --git a/drivers/media/rc/keymaps/rc-real-audio-220-32-keys.c b/drivers/media/rc/keymaps/rc-real-audio-220-32-keys.c
index 088ead8f736b..e80eafa08912 100644
--- a/drivers/media/rc/keymaps/rc-real-audio-220-32-keys.c
+++ b/drivers/media/rc/keymaps/rc-real-audio-220-32-keys.c
@@ -51,7 +51,7 @@ static struct rc_map_table real_audio_220_32_keys[] = {
 static struct rc_map_list real_audio_220_32_keys_map = {
 	.map = {
 		.scan     = real_audio_220_32_keys,
-		.size     = ARRAY_SIZE(real_audio_220_32_keys),
+		.entries  = ARRAY_SIZE(real_audio_220_32_keys),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_REAL_AUDIO_220_32_KEYS,
 	}
diff --git a/drivers/media/rc/keymaps/rc-reddo.c b/drivers/media/rc/keymaps/rc-reddo.c
index af50d1ca4b15..7223234fae71 100644
--- a/drivers/media/rc/keymaps/rc-reddo.c
+++ b/drivers/media/rc/keymaps/rc-reddo.c
@@ -50,7 +50,7 @@ static struct rc_map_table reddo[] = {
 static struct rc_map_list reddo_map = {
 	.map = {
 		.scan     = reddo,
-		.size     = ARRAY_SIZE(reddo),
+		.entries  = ARRAY_SIZE(reddo),
 		.rc_proto = RC_PROTO_NECX,
 		.name     = RC_MAP_REDDO,
 	}
diff --git a/drivers/media/rc/keymaps/rc-siemens-gigaset-rc20.c b/drivers/media/rc/keymaps/rc-siemens-gigaset-rc20.c
index defc77932e10..1826f06efa6d 100644
--- a/drivers/media/rc/keymaps/rc-siemens-gigaset-rc20.c
+++ b/drivers/media/rc/keymaps/rc-siemens-gigaset-rc20.c
@@ -47,7 +47,7 @@ static struct rc_map_table siemens_gigaset_rc20[] = {
 static struct rc_map_list siemens_gigaset_rc20_map = {
 	.map = {
 		.scan     = siemens_gigaset_rc20,
-		.size     = ARRAY_SIZE(siemens_gigaset_rc20),
+		.entries  = ARRAY_SIZE(siemens_gigaset_rc20),
 		.rc_proto = RC_PROTO_RC5,
 		.name     = RC_MAP_SIEMENS_GIGASET_RC20,
 	}
diff --git a/drivers/media/rc/keymaps/rc-snapstream-firefly.c b/drivers/media/rc/keymaps/rc-snapstream-firefly.c
index 826f44595e70..89337d843d60 100644
--- a/drivers/media/rc/keymaps/rc-snapstream-firefly.c
+++ b/drivers/media/rc/keymaps/rc-snapstream-firefly.c
@@ -71,7 +71,7 @@ static struct rc_map_table snapstream_firefly[] = {
 static struct rc_map_list snapstream_firefly_map = {
 	.map = {
 		.scan     = snapstream_firefly,
-		.size     = ARRAY_SIZE(snapstream_firefly),
+		.entries  = ARRAY_SIZE(snapstream_firefly),
 		.rc_proto = RC_PROTO_OTHER,
 		.name     = RC_MAP_SNAPSTREAM_FIREFLY,
 	}
diff --git a/drivers/media/rc/keymaps/rc-streamzap.c b/drivers/media/rc/keymaps/rc-streamzap.c
index b82c3cdfca3b..a9c48e10c61c 100644
--- a/drivers/media/rc/keymaps/rc-streamzap.c
+++ b/drivers/media/rc/keymaps/rc-streamzap.c
@@ -54,7 +54,7 @@ static struct rc_map_table streamzap[] = {
 static struct rc_map_list streamzap_map = {
 	.map = {
 		.scan     = streamzap,
-		.size     = ARRAY_SIZE(streamzap),
+		.entries  = ARRAY_SIZE(streamzap),
 		.rc_proto = RC_PROTO_RC5_SZ,
 		.name     = RC_MAP_STREAMZAP,
 	}
diff --git a/drivers/media/rc/keymaps/rc-su3000.c b/drivers/media/rc/keymaps/rc-su3000.c
index a333ade3b1d2..d173cf29fb24 100644
--- a/drivers/media/rc/keymaps/rc-su3000.c
+++ b/drivers/media/rc/keymaps/rc-su3000.c
@@ -48,7 +48,7 @@ static struct rc_map_table su3000[] = {
 static struct rc_map_list su3000_map = {
 	.map = {
 		.scan     = su3000,
-		.size     = ARRAY_SIZE(su3000),
+		.entries  = ARRAY_SIZE(su3000),
 		.rc_proto = RC_PROTO_RC5,
 		.name     = RC_MAP_SU3000,
 	}
diff --git a/drivers/media/rc/keymaps/rc-tanix-tx3mini.c b/drivers/media/rc/keymaps/rc-tanix-tx3mini.c
index b5d77a0c94ed..999ff2e57677 100644
--- a/drivers/media/rc/keymaps/rc-tanix-tx3mini.c
+++ b/drivers/media/rc/keymaps/rc-tanix-tx3mini.c
@@ -54,7 +54,7 @@ static struct rc_map_table tanix_tx3mini[] = {
 static struct rc_map_list tanix_tx3mini_map = {
 	.map = {
 		.scan     = tanix_tx3mini,
-		.size     = ARRAY_SIZE(tanix_tx3mini),
+		.entries  = ARRAY_SIZE(tanix_tx3mini),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_TANIX_TX3MINI,
 	}
diff --git a/drivers/media/rc/keymaps/rc-tanix-tx5max.c b/drivers/media/rc/keymaps/rc-tanix-tx5max.c
index 91db9017845a..9c052dd2c212 100644
--- a/drivers/media/rc/keymaps/rc-tanix-tx5max.c
+++ b/drivers/media/rc/keymaps/rc-tanix-tx5max.c
@@ -45,7 +45,7 @@ static struct rc_map_table tanix_tx5max[] = {
 static struct rc_map_list tanix_tx5max_map = {
 	.map = {
 		.scan     = tanix_tx5max,
-		.size     = ARRAY_SIZE(tanix_tx5max),
+		.entries  = ARRAY_SIZE(tanix_tx5max),
 		.rc_proto = RC_PROTO_NECX,
 		.name     = RC_MAP_TANIX_TX5MAX,
 	}
diff --git a/drivers/media/rc/keymaps/rc-tbs-nec.c b/drivers/media/rc/keymaps/rc-tbs-nec.c
index 426c767c907f..86c7e1917adb 100644
--- a/drivers/media/rc/keymaps/rc-tbs-nec.c
+++ b/drivers/media/rc/keymaps/rc-tbs-nec.c
@@ -48,7 +48,7 @@ static struct rc_map_table tbs_nec[] = {
 static struct rc_map_list tbs_nec_map = {
 	.map = {
 		.scan     = tbs_nec,
-		.size     = ARRAY_SIZE(tbs_nec),
+		.entries  = ARRAY_SIZE(tbs_nec),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_TBS_NEC,
 	}
diff --git a/drivers/media/rc/keymaps/rc-technisat-ts35.c b/drivers/media/rc/keymaps/rc-technisat-ts35.c
index 07d5e0884eb9..07529e3ceffb 100644
--- a/drivers/media/rc/keymaps/rc-technisat-ts35.c
+++ b/drivers/media/rc/keymaps/rc-technisat-ts35.c
@@ -50,7 +50,7 @@ static struct rc_map_table technisat_ts35[] = {
 static struct rc_map_list technisat_ts35_map = {
 	.map = {
 		.scan     = technisat_ts35,
-		.size     = ARRAY_SIZE(technisat_ts35),
+		.entries  = ARRAY_SIZE(technisat_ts35),
 		.rc_proto = RC_PROTO_UNKNOWN,
 		.name     = RC_MAP_TECHNISAT_TS35,
 	}
diff --git a/drivers/media/rc/keymaps/rc-technisat-usb2.c b/drivers/media/rc/keymaps/rc-technisat-usb2.c
index 74ac89d37966..c37bc0d73e06 100644
--- a/drivers/media/rc/keymaps/rc-technisat-usb2.c
+++ b/drivers/media/rc/keymaps/rc-technisat-usb2.c
@@ -67,7 +67,7 @@ static struct rc_map_table technisat_usb2[] = {
 static struct rc_map_list technisat_usb2_map = {
 	.map = {
 		.scan     = technisat_usb2,
-		.size     = ARRAY_SIZE(technisat_usb2),
+		.entries  = ARRAY_SIZE(technisat_usb2),
 		.rc_proto = RC_PROTO_RC5,
 		.name     = RC_MAP_TECHNISAT_USB2,
 	}
diff --git a/drivers/media/rc/keymaps/rc-terratec-cinergy-c-pci.c b/drivers/media/rc/keymaps/rc-terratec-cinergy-c-pci.c
index d44891308193..ea39a7bb4312 100644
--- a/drivers/media/rc/keymaps/rc-terratec-cinergy-c-pci.c
+++ b/drivers/media/rc/keymaps/rc-terratec-cinergy-c-pci.c
@@ -62,7 +62,7 @@ static struct rc_map_table terratec_cinergy_c_pci[] = {
 static struct rc_map_list terratec_cinergy_c_pci_map = {
 	.map = {
 		.scan     = terratec_cinergy_c_pci,
-		.size     = ARRAY_SIZE(terratec_cinergy_c_pci),
+		.entries  = ARRAY_SIZE(terratec_cinergy_c_pci),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_TERRATEC_CINERGY_C_PCI,
 	}
diff --git a/drivers/media/rc/keymaps/rc-terratec-cinergy-s2-hd.c b/drivers/media/rc/keymaps/rc-terratec-cinergy-s2-hd.c
index dbbb1ba0247b..e87be431c341 100644
--- a/drivers/media/rc/keymaps/rc-terratec-cinergy-s2-hd.c
+++ b/drivers/media/rc/keymaps/rc-terratec-cinergy-s2-hd.c
@@ -60,7 +60,7 @@ static struct rc_map_table terratec_cinergy_s2_hd[] = {
 static struct rc_map_list terratec_cinergy_s2_hd_map = {
 	.map = {
 		.scan     = terratec_cinergy_s2_hd,
-		.size     = ARRAY_SIZE(terratec_cinergy_s2_hd),
+		.entries  = ARRAY_SIZE(terratec_cinergy_s2_hd),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_TERRATEC_CINERGY_S2_HD,
 	}
diff --git a/drivers/media/rc/keymaps/rc-terratec-cinergy-xs.c b/drivers/media/rc/keymaps/rc-terratec-cinergy-xs.c
index a9452d581339..b9193a7189a2 100644
--- a/drivers/media/rc/keymaps/rc-terratec-cinergy-xs.c
+++ b/drivers/media/rc/keymaps/rc-terratec-cinergy-xs.c
@@ -65,7 +65,7 @@ static struct rc_map_table terratec_cinergy_xs[] = {
 static struct rc_map_list terratec_cinergy_xs_map = {
 	.map = {
 		.scan     = terratec_cinergy_xs,
-		.size     = ARRAY_SIZE(terratec_cinergy_xs),
+		.entries  = ARRAY_SIZE(terratec_cinergy_xs),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_TERRATEC_CINERGY_XS,
 	}
diff --git a/drivers/media/rc/keymaps/rc-terratec-slim-2.c b/drivers/media/rc/keymaps/rc-terratec-slim-2.c
index ea259d88769b..47b190b9a2fb 100644
--- a/drivers/media/rc/keymaps/rc-terratec-slim-2.c
+++ b/drivers/media/rc/keymaps/rc-terratec-slim-2.c
@@ -37,7 +37,7 @@ static struct rc_map_table terratec_slim_2[] = {
 static struct rc_map_list terratec_slim_2_map = {
 	.map = {
 		.scan     = terratec_slim_2,
-		.size     = ARRAY_SIZE(terratec_slim_2),
+		.entries  = ARRAY_SIZE(terratec_slim_2),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_TERRATEC_SLIM_2,
 	}
diff --git a/drivers/media/rc/keymaps/rc-terratec-slim.c b/drivers/media/rc/keymaps/rc-terratec-slim.c
index bb40cbd58ebe..557f91676a84 100644
--- a/drivers/media/rc/keymaps/rc-terratec-slim.c
+++ b/drivers/media/rc/keymaps/rc-terratec-slim.c
@@ -44,7 +44,7 @@ static struct rc_map_table terratec_slim[] = {
 static struct rc_map_list terratec_slim_map = {
 	.map = {
 		.scan     = terratec_slim,
-		.size     = ARRAY_SIZE(terratec_slim),
+		.entries  = ARRAY_SIZE(terratec_slim),
 		.rc_proto = RC_PROTO_NECX,
 		.name     = RC_MAP_TERRATEC_SLIM,
 	}
diff --git a/drivers/media/rc/keymaps/rc-tevii-nec.c b/drivers/media/rc/keymaps/rc-tevii-nec.c
index ee7f8014742b..cbac237990a8 100644
--- a/drivers/media/rc/keymaps/rc-tevii-nec.c
+++ b/drivers/media/rc/keymaps/rc-tevii-nec.c
@@ -61,7 +61,7 @@ static struct rc_map_table tevii_nec[] = {
 static struct rc_map_list tevii_nec_map = {
 	.map = {
 		.scan     = tevii_nec,
-		.size     = ARRAY_SIZE(tevii_nec),
+		.entries  = ARRAY_SIZE(tevii_nec),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_TEVII_NEC,
 	}
diff --git a/drivers/media/rc/keymaps/rc-tivo.c b/drivers/media/rc/keymaps/rc-tivo.c
index c02b8c8abd5c..35429d5e8f7a 100644
--- a/drivers/media/rc/keymaps/rc-tivo.c
+++ b/drivers/media/rc/keymaps/rc-tivo.c
@@ -72,7 +72,7 @@ static struct rc_map_table tivo[] = {
 static struct rc_map_list tivo_map = {
 	.map = {
 		.scan     = tivo,
-		.size     = ARRAY_SIZE(tivo),
+		.entries  = ARRAY_SIZE(tivo),
 		.rc_proto = RC_PROTO_NEC32,
 		.name     = RC_MAP_TIVO,
 	}
diff --git a/drivers/media/rc/keymaps/rc-total-media-in-hand-02.c b/drivers/media/rc/keymaps/rc-total-media-in-hand-02.c
index 290d1cc8577c..2b5f8f851523 100644
--- a/drivers/media/rc/keymaps/rc-total-media-in-hand-02.c
+++ b/drivers/media/rc/keymaps/rc-total-media-in-hand-02.c
@@ -50,7 +50,7 @@ static struct rc_map_table total_media_in_hand_02[] = {
 static struct rc_map_list total_media_in_hand_02_map = {
 	.map = {
 		.scan     = total_media_in_hand_02,
-		.size     = ARRAY_SIZE(total_media_in_hand_02),
+		.entries  = ARRAY_SIZE(total_media_in_hand_02),
 		.rc_proto = RC_PROTO_RC5,
 		.name     = RC_MAP_TOTAL_MEDIA_IN_HAND_02,
 	}
diff --git a/drivers/media/rc/keymaps/rc-total-media-in-hand.c b/drivers/media/rc/keymaps/rc-total-media-in-hand.c
index 7f4b31b98f35..afd363d3ff79 100644
--- a/drivers/media/rc/keymaps/rc-total-media-in-hand.c
+++ b/drivers/media/rc/keymaps/rc-total-media-in-hand.c
@@ -50,7 +50,7 @@ static struct rc_map_table total_media_in_hand[] = {
 static struct rc_map_list total_media_in_hand_map = {
 	.map = {
 		.scan     = total_media_in_hand,
-		.size     = ARRAY_SIZE(total_media_in_hand),
+		.entries  = ARRAY_SIZE(total_media_in_hand),
 		.rc_proto = RC_PROTO_NECX,
 		.name     = RC_MAP_TOTAL_MEDIA_IN_HAND,
 	}
diff --git a/drivers/media/rc/keymaps/rc-trekstor.c b/drivers/media/rc/keymaps/rc-trekstor.c
index ff01de550904..6ae2aac049b6 100644
--- a/drivers/media/rc/keymaps/rc-trekstor.c
+++ b/drivers/media/rc/keymaps/rc-trekstor.c
@@ -45,7 +45,7 @@ static struct rc_map_table trekstor[] = {
 static struct rc_map_list trekstor_map = {
 	.map = {
 		.scan     = trekstor,
-		.size     = ARRAY_SIZE(trekstor),
+		.entries  = ARRAY_SIZE(trekstor),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_TREKSTOR,
 	}
diff --git a/drivers/media/rc/keymaps/rc-tt-1500.c b/drivers/media/rc/keymaps/rc-tt-1500.c
index eb8d7fc5061a..b8efd1cd6a8e 100644
--- a/drivers/media/rc/keymaps/rc-tt-1500.c
+++ b/drivers/media/rc/keymaps/rc-tt-1500.c
@@ -55,7 +55,7 @@ static struct rc_map_table tt_1500[] = {
 static struct rc_map_list tt_1500_map = {
 	.map = {
 		.scan     = tt_1500,
-		.size     = ARRAY_SIZE(tt_1500),
+		.entries  = ARRAY_SIZE(tt_1500),
 		.rc_proto = RC_PROTO_RC5,
 		.name     = RC_MAP_TT_1500,
 	}
diff --git a/drivers/media/rc/keymaps/rc-twinhan-dtv-cab-ci.c b/drivers/media/rc/keymaps/rc-twinhan-dtv-cab-ci.c
index 8e5cf8eb0db9..4559eb482a39 100644
--- a/drivers/media/rc/keymaps/rc-twinhan-dtv-cab-ci.c
+++ b/drivers/media/rc/keymaps/rc-twinhan-dtv-cab-ci.c
@@ -72,7 +72,7 @@ static struct rc_map_table twinhan_dtv_cab_ci[] = {
 static struct rc_map_list twinhan_dtv_cab_ci_map = {
 	.map = {
 		.scan     = twinhan_dtv_cab_ci,
-		.size     = ARRAY_SIZE(twinhan_dtv_cab_ci),
+		.entries  = ARRAY_SIZE(twinhan_dtv_cab_ci),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_TWINHAN_DTV_CAB_CI,
 	}
diff --git a/drivers/media/rc/keymaps/rc-twinhan1027.c b/drivers/media/rc/keymaps/rc-twinhan1027.c
index 411ce3c8cbd0..82933a4c7d6d 100644
--- a/drivers/media/rc/keymaps/rc-twinhan1027.c
+++ b/drivers/media/rc/keymaps/rc-twinhan1027.c
@@ -66,7 +66,7 @@ static struct rc_map_table twinhan_vp1027[] = {
 static struct rc_map_list twinhan_vp1027_map = {
 	.map = {
 		.scan     = twinhan_vp1027,
-		.size     = ARRAY_SIZE(twinhan_vp1027),
+		.entries  = ARRAY_SIZE(twinhan_vp1027),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_TWINHAN_VP1027_DVBS,
 	}
diff --git a/drivers/media/rc/keymaps/rc-vega-s9x.c b/drivers/media/rc/keymaps/rc-vega-s9x.c
index 40fbf408bf65..c9ed36a580cd 100644
--- a/drivers/media/rc/keymaps/rc-vega-s9x.c
+++ b/drivers/media/rc/keymaps/rc-vega-s9x.c
@@ -31,7 +31,7 @@ static struct rc_map_table vega_s9x[] = {
 static struct rc_map_list vega_s9x_map = {
 	.map = {
 		.scan     = vega_s9x,
-		.size     = ARRAY_SIZE(vega_s9x),
+		.entries  = ARRAY_SIZE(vega_s9x),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_VEGA_S9X,
 	}
diff --git a/drivers/media/rc/keymaps/rc-videomate-k100.c b/drivers/media/rc/keymaps/rc-videomate-k100.c
index 6664cfd0b7f3..06466be0d705 100644
--- a/drivers/media/rc/keymaps/rc-videomate-k100.c
+++ b/drivers/media/rc/keymaps/rc-videomate-k100.c
@@ -66,7 +66,7 @@ static struct rc_map_table videomate_k100[] = {
 static struct rc_map_list videomate_k100_map = {
 	.map = {
 		.scan     = videomate_k100,
-		.size     = ARRAY_SIZE(videomate_k100),
+		.entries  = ARRAY_SIZE(videomate_k100),
 		.rc_proto = RC_PROTO_UNKNOWN,     /* Legacy IR type */
 		.name     = RC_MAP_VIDEOMATE_K100,
 	}
diff --git a/drivers/media/rc/keymaps/rc-videomate-s350.c b/drivers/media/rc/keymaps/rc-videomate-s350.c
index 281cc747229f..d788252892e3 100644
--- a/drivers/media/rc/keymaps/rc-videomate-s350.c
+++ b/drivers/media/rc/keymaps/rc-videomate-s350.c
@@ -58,7 +58,7 @@ static struct rc_map_table videomate_s350[] = {
 static struct rc_map_list videomate_s350_map = {
 	.map = {
 		.scan     = videomate_s350,
-		.size     = ARRAY_SIZE(videomate_s350),
+		.entries  = ARRAY_SIZE(videomate_s350),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_VIDEOMATE_S350,
 	}
diff --git a/drivers/media/rc/keymaps/rc-videomate-tv-pvr.c b/drivers/media/rc/keymaps/rc-videomate-tv-pvr.c
index 829842425fae..ba430f469b77 100644
--- a/drivers/media/rc/keymaps/rc-videomate-tv-pvr.c
+++ b/drivers/media/rc/keymaps/rc-videomate-tv-pvr.c
@@ -60,7 +60,7 @@ static struct rc_map_table videomate_tv_pvr[] = {
 static struct rc_map_list videomate_tv_pvr_map = {
 	.map = {
 		.scan     = videomate_tv_pvr,
-		.size     = ARRAY_SIZE(videomate_tv_pvr),
+		.entries  = ARRAY_SIZE(videomate_tv_pvr),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_VIDEOMATE_TV_PVR,
 	}
diff --git a/drivers/media/rc/keymaps/rc-videostrong-kii-pro.c b/drivers/media/rc/keymaps/rc-videostrong-kii-pro.c
index 10cbc2c781d2..d797a49d0e0b 100644
--- a/drivers/media/rc/keymaps/rc-videostrong-kii-pro.c
+++ b/drivers/media/rc/keymaps/rc-videostrong-kii-pro.c
@@ -60,7 +60,7 @@ static struct rc_map_table kii_pro[] = {
 static struct rc_map_list kii_pro_map = {
 	.map = {
 		.scan     = kii_pro,
-		.size     = ARRAY_SIZE(kii_pro),
+		.entries  = ARRAY_SIZE(kii_pro),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_KII_PRO,
 	}
diff --git a/drivers/media/rc/keymaps/rc-wetek-hub.c b/drivers/media/rc/keymaps/rc-wetek-hub.c
index 591ec20399f4..c8d448cf39f2 100644
--- a/drivers/media/rc/keymaps/rc-wetek-hub.c
+++ b/drivers/media/rc/keymaps/rc-wetek-hub.c
@@ -30,7 +30,7 @@ static struct rc_map_table wetek_hub[] = {
 static struct rc_map_list wetek_hub_map = {
 	.map = {
 		.scan     = wetek_hub,
-		.size     = ARRAY_SIZE(wetek_hub),
+		.entries  = ARRAY_SIZE(wetek_hub),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_WETEK_HUB,
 	}
diff --git a/drivers/media/rc/keymaps/rc-wetek-play2.c b/drivers/media/rc/keymaps/rc-wetek-play2.c
index ce3b1029df23..198738a95c55 100644
--- a/drivers/media/rc/keymaps/rc-wetek-play2.c
+++ b/drivers/media/rc/keymaps/rc-wetek-play2.c
@@ -70,7 +70,7 @@ static struct rc_map_table wetek_play2[] = {
 static struct rc_map_list wetek_play2_map = {
 	.map = {
 		.scan     = wetek_play2,
-		.size     = ARRAY_SIZE(wetek_play2),
+		.entries  = ARRAY_SIZE(wetek_play2),
 		.rc_proto = RC_PROTO_NECX,
 		.name     = RC_MAP_WETEK_PLAY2,
 	}
diff --git a/drivers/media/rc/keymaps/rc-winfast-usbii-deluxe.c b/drivers/media/rc/keymaps/rc-winfast-usbii-deluxe.c
index edfba31f9ae6..3019bb2eaa8d 100644
--- a/drivers/media/rc/keymaps/rc-winfast-usbii-deluxe.c
+++ b/drivers/media/rc/keymaps/rc-winfast-usbii-deluxe.c
@@ -55,7 +55,7 @@ static struct rc_map_table winfast_usbii_deluxe[] = {
 static struct rc_map_list winfast_usbii_deluxe_map = {
 	.map = {
 		.scan     = winfast_usbii_deluxe,
-		.size     = ARRAY_SIZE(winfast_usbii_deluxe),
+		.entries  = ARRAY_SIZE(winfast_usbii_deluxe),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_WINFAST_USBII_DELUXE,
 	}
diff --git a/drivers/media/rc/keymaps/rc-winfast.c b/drivers/media/rc/keymaps/rc-winfast.c
index 89649c8cdee5..0cecf00b4188 100644
--- a/drivers/media/rc/keymaps/rc-winfast.c
+++ b/drivers/media/rc/keymaps/rc-winfast.c
@@ -75,7 +75,7 @@ static struct rc_map_table winfast[] = {
 static struct rc_map_list winfast_map = {
 	.map = {
 		.scan     = winfast,
-		.size     = ARRAY_SIZE(winfast),
+		.entries  = ARRAY_SIZE(winfast),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_WINFAST,
 	}
diff --git a/drivers/media/rc/keymaps/rc-x96max.c b/drivers/media/rc/keymaps/rc-x96max.c
index a22fcbbfa383..f830fbfd4d57 100644
--- a/drivers/media/rc/keymaps/rc-x96max.c
+++ b/drivers/media/rc/keymaps/rc-x96max.c
@@ -60,7 +60,7 @@ static struct rc_map_table x96max[] = {
 static struct rc_map_list x96max_map = {
 	.map = {
 		.scan     = x96max,
-		.size     = ARRAY_SIZE(x96max),
+		.entries  = ARRAY_SIZE(x96max),
 		.rc_proto = RC_PROTO_NEC,
 		.name     = RC_MAP_X96MAX,
 	}
diff --git a/drivers/media/rc/keymaps/rc-xbox-360.c b/drivers/media/rc/keymaps/rc-xbox-360.c
index 1364daf3ae6f..13e0843291fc 100644
--- a/drivers/media/rc/keymaps/rc-xbox-360.c
+++ b/drivers/media/rc/keymaps/rc-xbox-360.c
@@ -61,7 +61,7 @@ static struct rc_map_table xbox_360[] = {
 static struct rc_map_list xbox_360_map = {
 	.map = {
 		.scan     = xbox_360,
-		.size     = ARRAY_SIZE(xbox_360),
+		.entries  = ARRAY_SIZE(xbox_360),
 		.rc_proto = RC_PROTO_RC6_MCE,
 		.name     = RC_MAP_XBOX_360,
 	}
diff --git a/drivers/media/rc/keymaps/rc-xbox-dvd.c b/drivers/media/rc/keymaps/rc-xbox-dvd.c
index 11ab134b05b5..94bb444bb578 100644
--- a/drivers/media/rc/keymaps/rc-xbox-dvd.c
+++ b/drivers/media/rc/keymaps/rc-xbox-dvd.c
@@ -41,7 +41,7 @@ static struct rc_map_table xbox_dvd[] = {
 static struct rc_map_list xbox_dvd_map = {
 	.map = {
 		.scan     = xbox_dvd,
-		.size     = ARRAY_SIZE(xbox_dvd),
+		.entries  = ARRAY_SIZE(xbox_dvd),
 		.rc_proto = RC_PROTO_XBOX_DVD,
 		.name     = RC_MAP_XBOX_DVD,
 	}
diff --git a/drivers/media/rc/keymaps/rc-zx-irdec.c b/drivers/media/rc/keymaps/rc-zx-irdec.c
index e4bea7b39fd1..b2115914f3d4 100644
--- a/drivers/media/rc/keymaps/rc-zx-irdec.c
+++ b/drivers/media/rc/keymaps/rc-zx-irdec.c
@@ -53,7 +53,7 @@ static struct rc_map_table zx_irdec_table[] = {
 static struct rc_map_list zx_irdec_map = {
 	.map = {
 		.scan = zx_irdec_table,
-		.size = ARRAY_SIZE(zx_irdec_table),
+		.entries = ARRAY_SIZE(zx_irdec_table),
 		.rc_proto = RC_PROTO_NEC,
 		.name = RC_MAP_ZX_IRDEC,
 	}
diff --git a/drivers/media/rc/rc-main.c b/drivers/media/rc/rc-main.c
index c36a62992b76..e2e99ea63516 100644
--- a/drivers/media/rc/rc-main.c
+++ b/drivers/media/rc/rc-main.c
@@ -152,7 +152,7 @@ static struct rc_map_table empty[] = {
 static struct rc_map_list empty_map = {
 	.map = {
 		.scan     = empty,
-		.size     = ARRAY_SIZE(empty),
+		.entries  = ARRAY_SIZE(empty),
 		.rc_proto = RC_PROTO_UNKNOWN,	/* Legacy IR type */
 		.name     = RC_MAP_EMPTY,
 	}
@@ -199,10 +199,11 @@ static int scancode_to_u64(const struct input_keymap_entry *ke, u64 *scancode)
  * @rc_map:	the rc_map to initialize
  * @map_name:	name to assign to the table
  * @rc_proto:	ir type to assign to the new table
- * @size:	initial size of the table
+ * @size:	number of entries the table must be able to hold
  *
  * This routine will initialize the rc_map and will allocate
- * memory to hold at least the specified number of elements.
+ * memory to hold at least @size entries; the capacity is rounded up
+ * to a power of two.
  *
  * return:	zero on success or a negative error code
  */
@@ -210,15 +211,15 @@ static int ir_create_table(struct rc_dev *dev, struct rc_map *rc_map,
 			   const char *map_name, u64 rc_proto, size_t size)
 {
 	struct rc_map_table *scan;
-	unsigned int alloc;
+	unsigned int capacity;
 	char *name;
 
 	name = kstrdup(map_name, GFP_KERNEL);
 	if (!name)
 		return -ENOMEM;
 
-	alloc = roundup_pow_of_two(size);
-	scan = kmalloc_objs(struct rc_map_table, alloc, GFP_KERNEL);
+	capacity = roundup_pow_of_two(size);
+	scan = kmalloc_objs(struct rc_map_table, capacity, GFP_KERNEL);
 	if (!scan) {
 		kfree(name);
 		return -ENOMEM;
@@ -228,12 +229,12 @@ static int ir_create_table(struct rc_dev *dev, struct rc_map *rc_map,
 		rc_map->name = name;
 		rc_map->scan = scan;
 		rc_map->rc_proto = rc_proto;
-		rc_map->len = 0;
-		rc_map->size = alloc;
+		rc_map->entries = 0;
+		rc_map->capacity = capacity;
 	}
 
 	dev_dbg(&dev->dev, "Allocated space for %u keycode entries (%zu bytes)\n",
-		alloc, alloc * sizeof(struct rc_map_table));
+		capacity, capacity * sizeof(struct rc_map_table));
 	return 0;
 }
 
@@ -253,8 +254,8 @@ static void ir_free_table(struct rc_map *rc_map)
 		name = rc_map->name;
 		scan = rc_map->scan;
 
-		rc_map->size = 0;
-		rc_map->len = 0;
+		rc_map->capacity = 0;
+		rc_map->entries = 0;
 		rc_map->name = NULL;
 		rc_map->scan = NULL;
 	}
@@ -277,37 +278,38 @@ static void ir_free_table(struct rc_map *rc_map)
 static int ir_resize_table(struct rc_dev *dev, struct rc_map *rc_map,
 			   gfp_t gfp_flags)
 {
-	unsigned int newsize = rc_map->size;
+	unsigned int new_capacity = rc_map->capacity;
 	struct rc_map_table *newscan;
 
 	lockdep_assert_held(&rc_map->lock);
 
-	if (rc_map->size == rc_map->len) {
+	if (rc_map->capacity == rc_map->entries) {
 		/* All entries in use -> grow keytable */
-		if (newsize >= IR_TAB_MAX_ENTRIES)
+		if (new_capacity >= IR_TAB_MAX_ENTRIES)
 			return -ENOMEM;
 
-		newsize *= 2;
+		new_capacity *= 2;
 
-		dev_dbg(&dev->dev, "Growing table to %u entries\n", newsize);
+		dev_dbg(&dev->dev, "Growing table to %u entries\n", new_capacity);
 	}
 
-	if (rc_map->len * 3 < rc_map->size && rc_map->size > IR_TAB_MIN_ENTRIES) {
+	if (rc_map->entries * 3 < rc_map->capacity &&
+	    rc_map->capacity > IR_TAB_MIN_ENTRIES) {
 		/* Less than 1/3 of entries in use -> shrink keytable */
-		newsize /= 2;
-		dev_dbg(&dev->dev, "Shrinking table to %u entries\n", newsize);
+		new_capacity /= 2;
+		dev_dbg(&dev->dev, "Shrinking table to %u entries\n", new_capacity);
 	}
 
-	if (newsize == rc_map->size)
+	if (new_capacity == rc_map->capacity)
 		return 0;
 
-	newscan = krealloc_array(rc_map->scan, newsize,
+	newscan = krealloc_array(rc_map->scan, new_capacity,
 				 sizeof(struct rc_map_table), gfp_flags);
 	if (!newscan)
 		return -ENOMEM;
 
 	rc_map->scan = newscan;
-	rc_map->size = newsize;
+	rc_map->capacity = new_capacity;
 
 	return 0;
 }
@@ -339,9 +341,9 @@ static unsigned int ir_update_mapping(struct rc_dev *dev,
 	if (new_keycode == KEY_RESERVED || new_keycode == KEY_UNKNOWN) {
 		dev_dbg(&dev->dev, "#%d: Deleting scan 0x%04llx\n",
 			index, rc_map->scan[index].scancode);
-		rc_map->len--;
+		rc_map->entries--;
 		memmove(&rc_map->scan[index], &rc_map->scan[index+ 1],
-			(rc_map->len - index) * sizeof(struct rc_map_table));
+			(rc_map->entries - index) * sizeof(struct rc_map_table));
 	} else {
 		dev_dbg(&dev->dev, "#%d: %s scan 0x%04llx with key 0x%04x\n",
 			index,
@@ -355,7 +357,7 @@ static unsigned int ir_update_mapping(struct rc_dev *dev,
 		/* A previous mapping was updated... */
 		__clear_bit(old_keycode, dev->input_dev->keybit);
 		/* ... but another scancode might use the same keycode */
-		for (i = 0; i < rc_map->len; i++) {
+		for (i = 0; i < rc_map->entries; i++) {
 			if (rc_map->scan[i].keycode == old_keycode) {
 				__set_bit(old_keycode, dev->input_dev->keybit);
 				break;
@@ -407,7 +409,7 @@ static unsigned int ir_establish_scancode(struct rc_dev *dev,
 	 * Binary search for an existing mapping for this ir command.
 	 */
 	lo = 0;
-	hi = rc_map->len;
+	hi = rc_map->entries;
 	while (lo < hi) {
 		i = lo + (hi - lo) / 2;
 		if (rc_map->scan[i].scancode == scancode)
@@ -420,18 +422,18 @@ static unsigned int ir_establish_scancode(struct rc_dev *dev,
 	i = lo;
 
 	/* No previous mapping found, we might need to grow the table */
-	if (rc_map->size == rc_map->len) {
+	if (rc_map->capacity == rc_map->entries) {
 		if (!resize || ir_resize_table(dev, rc_map, GFP_ATOMIC))
 			return UINT_MAX;
 	}
 
 	/* i is the proper index to insert our new keycode */
-	if (i < rc_map->len)
+	if (i < rc_map->entries)
 		memmove(&rc_map->scan[i + 1], &rc_map->scan[i],
-			(rc_map->len - i) * sizeof(struct rc_map_table));
+			(rc_map->entries - i) * sizeof(struct rc_map_table));
 	rc_map->scan[i].scancode = scancode;
 	rc_map->scan[i].keycode = KEY_RESERVED;
-	rc_map->len++;
+	rc_map->entries++;
 
 	return i;
 }
@@ -461,7 +463,7 @@ static int ir_setkeycode(struct input_dev *idev,
 
 	if (ke->flags & INPUT_KEYMAP_BY_INDEX) {
 		index = ke->index;
-		if (index >= rc_map->len) {
+		if (index >= rc_map->entries) {
 			retval = -EINVAL;
 			goto out;
 		}
@@ -471,7 +473,7 @@ static int ir_setkeycode(struct input_dev *idev,
 			goto out;
 
 		index = ir_establish_scancode(rdev, rc_map, scancode, true);
-		if (index >= rc_map->len) {
+		if (index >= rc_map->entries) {
 			retval = -ENOMEM;
 			goto out;
 		}
@@ -500,15 +502,15 @@ static int ir_setkeytable(struct rc_dev *dev, const struct rc_map *from)
 	int rc;
 
 	rc = ir_create_table(dev, rc_map, from->name, from->rc_proto,
-			     from->size);
+			     from->entries);
 	if (rc)
 		return rc;
 
 	scoped_guard(spinlock_irqsave, &rc_map->lock) {
-		for (i = 0; i < from->size; i++) {
+		for (i = 0; i < from->entries; i++) {
 			index = ir_establish_scancode(dev, rc_map,
 						      from->scan[i].scancode, false);
-			if (index >= rc_map->len) {
+			if (index >= rc_map->entries) {
 				rc = -ENOMEM;
 				break;
 			}
@@ -553,7 +555,7 @@ static unsigned int ir_lookup_by_scancode(const struct rc_map *rc_map,
 
 	lockdep_assert_held(&rc_map->lock);
 
-	res = bsearch(&scancode, rc_map->scan, rc_map->len,
+	res = bsearch(&scancode, rc_map->scan, rc_map->entries,
 		      sizeof(struct rc_map_table), rc_map_cmp);
 	if (!res)
 		return -1U;
@@ -593,7 +595,7 @@ static int ir_getkeycode(struct input_dev *idev,
 		index = ir_lookup_by_scancode(rc_map, scancode);
 	}
 
-	if (index < rc_map->len) {
+	if (index < rc_map->entries) {
 		entry = &rc_map->scan[index];
 
 		ke->index = index;
@@ -641,7 +643,7 @@ u32 rc_g_keycode_from_table(struct rc_dev *dev, u64 scancode)
 	spin_lock_irqsave(&rc_map->lock, flags);
 
 	index = ir_lookup_by_scancode(rc_map, scancode);
-	keycode = index < rc_map->len ?
+	keycode = index < rc_map->entries ?
 			rc_map->scan[index].keycode : KEY_RESERVED;
 
 	spin_unlock_irqrestore(&rc_map->lock, flags);
@@ -1837,7 +1839,7 @@ static int rc_prepare_rx_device(struct rc_dev *dev)
 	rc_map = rc_map_get(dev->map_name);
 	if (!rc_map)
 		rc_map = rc_map_get(RC_MAP_EMPTY);
-	if (!rc_map || !rc_map->scan || rc_map->size == 0)
+	if (!rc_map || !rc_map->scan || rc_map->entries == 0)
 		return -EINVAL;
 
 	rc = ir_setkeytable(dev, rc_map);
diff --git a/include/media/rc-map.h b/include/media/rc-map.h
index f167c37179c8..39cc226e56af 100644
--- a/include/media/rc-map.h
+++ b/include/media/rc-map.h
@@ -146,8 +146,8 @@ struct rc_map_table {
  * struct rc_map - represents a keycode map table
  *
  * @scan: pointer to struct &rc_map_table
- * @size: Max number of entries
- * @len: Number of entries that are in use
+ * @capacity: Number of entries @scan has room for
+ * @entries: Number of entries in @scan that are in use
  * @rc_proto: type of the remote controller protocol, as defined at
  *	     enum &rc_proto
  * @name: name of the key map table
@@ -155,8 +155,8 @@ struct rc_map_table {
  */
 struct rc_map {
 	struct rc_map_table	*scan;
-	unsigned int		size;
-	unsigned int		len;
+	unsigned int		capacity;
+	unsigned int		entries;
 	enum rc_proto		rc_proto;
 	const char		*name;
 	spinlock_t		lock;
-- 
2.56.0


