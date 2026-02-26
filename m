Return-Path: <linuxppc-dev+bounces-17325-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3091FD9E0A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Feb 2026 21:18:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fMPSl6F5Fz2xN8;
	Fri, 27 Feb 2026 08:18:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=80.12.242.82
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772140695;
	cv=none; b=jFe/oP0ORhuyk7wTkVyFNegpvYBKH6yyG5Ge2tUI7eVPsb8bsrBnX0/bp4sTGUyS0Dn6Amcffvo/w9gf3MHYn0hCClYYBiGpw25Nf/sqsmo2sQ46ifwWv/cD0S6SWj1S3N8s/OW5REvXIOeEteOpaVM95LCEHgsUkXLbx6g2ddH4NPs3gzyBXYDd7LJb0KIB8scdSpXHBvJ3PFtuie3Ep0dA1a9rIsORhQY5q6w7f2ubJkDIWpORjuBNBgXypBoDCyrzuf2F9/B6lmK5jxtHKy78lUe6NKkB44llgr+WVYYPOE816LtooO1uCTAf5+x/9TffjjQ1qUgConZ1r7WjYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772140695; c=relaxed/relaxed;
	bh=DacmWtirnDJ8c5FfO60izxCVDBNId/jIFsPzSSFKxMk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D1logHxyAGKpAYyVoUrWDW0YPCB0EPf0BlpyPRzKryw9sZdtvDhWWJIERKXEQFtHx1O2knuWx3BqXLPrM4fsY90oEiO3oHWg/RZxU+NaweJBgqDkzJF4ocTmE2/qpM2RiI6/TB7EJ/ootkaPsSxWbYo5QeuYS1DIwFHwbar4O4zIvpJm+J4xGvonMgMVSxdaXfagA3Ir3JVBx74O24kUaVM5J+aB0/GkJjIgGs5TqktabTrnZx1xm8609dVxG+sdTkRXq9fKEjsLDjk3Kmc8CriB/XJ9sxJlUixwxD/VgJ6ZI2zJlnhZQx2HPEf6d6lov/rOS+0dmlRUZAQZQs+HeA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=sWNx3deX; dkim-atps=neutral; spf=pass (client-ip=80.12.242.82; helo=smtp.smtpout.orange.fr; envelope-from=christophe.jaillet@wanadoo.fr; receiver=lists.ozlabs.org) smtp.mailfrom=wanadoo.fr
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=wanadoo.fr header.i=@wanadoo.fr header.a=rsa-sha256 header.s=t20230301 header.b=sWNx3deX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=wanadoo.fr (client-ip=80.12.242.82; helo=smtp.smtpout.orange.fr; envelope-from=christophe.jaillet@wanadoo.fr; receiver=lists.ozlabs.org)
Received: from smtp.smtpout.orange.fr (smtp-82.smtpout.orange.fr [80.12.242.82])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fMPSl18GTz2xKh
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Feb 2026 08:18:15 +1100 (AEDT)
Received: from fedora.home ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPSA
	id viDZvEqUkbni4viDavq6iC; Thu, 26 Feb 2026 21:44:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1772138661;
	bh=DacmWtirnDJ8c5FfO60izxCVDBNId/jIFsPzSSFKxMk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=sWNx3deX74wZ1sLmbYlB94WwaAvsbzZjnr/HqeBUWAOhun7bKOCvQbAnp1elKkvzt
	 ef6PBgecHm1z/Ua/2PhYmMnHJzfwb0C3KNbIuPhRPcZiLM1ZuPS7E5X9T8t56MLJcs
	 wn7ngmD4UfdxYcVwXMKGJuHQL9er9gH4vZMBlZsmZJPus1/UJ3ySU5VVbZM0q6eUjJ
	 E3GcXHEwuv8Vup9GCxUFH5tcK1US0W+l7IYFd2W56mKh03e81/REuI8ZfgenpFXs+Z
	 jqq/hPeb1DL0biKYbHI2BhIOh/ZVmM8w1UV59jlUvdas2tRkKexZud3w+qcnFiruL/
	 bjxcsLkEKKxKQ==
X-ME-Helo: fedora.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 26 Feb 2026 21:44:21 +0100
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Johannes Berg <johannes@sipsolutions.net>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org
Subject: [PATCH v1] ALSA: aoa: Constify struct codec_connection
Date: Thu, 26 Feb 2026 21:44:10 +0100
Message-ID: <4009c337cc1a1a57795562279270c03687973b3b.1772138640.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.53.0
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

'struct codec_connection' are not modified in this driver.

Constifying these structures moves some data to a read-only section, so
increases overall security.

On a x86_64, with allmodconfig:
Before:
======
   text	   data	    bss	    dec	    hex	filename
  10034	   3392	     12	  13438	   347e	sound/aoa/fabrics/layout.o

After:
=====
   text	   data	    bss	    dec	    hex	filename
  10370	   3040	     12	  13422	   346e	sound/aoa/fabrics/layout.o

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Compile tested only.

The fabric_data field in struct aoa_codecis is only used in
sound/aoa/fabrics/layout.c, so there should be no side effect for other
files that include sound/aoa/aoa.h
---
 sound/aoa/aoa.h            |  2 +-
 sound/aoa/fabrics/layout.c | 28 ++++++++++++++--------------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/sound/aoa/aoa.h b/sound/aoa/aoa.h
index badff9f7cd54..b92593f170ca 100644
--- a/sound/aoa/aoa.h
+++ b/sound/aoa/aoa.h
@@ -48,7 +48,7 @@ struct aoa_codec {
 	u32 connected;
 
 	/* data the fabric can associate with this structure */
-	void *fabric_data;
+	const void *fabric_data;
 
 	/* private! */
 	struct list_head list;
diff --git a/sound/aoa/fabrics/layout.c b/sound/aoa/fabrics/layout.c
index c18b55305294..c3ebb6de4789 100644
--- a/sound/aoa/fabrics/layout.c
+++ b/sound/aoa/fabrics/layout.c
@@ -55,7 +55,7 @@ struct codec_connection {
 
 struct codec_connect_info {
 	char *name;
-	struct codec_connection *connections;
+	const struct codec_connection *connections;
 };
 
 #define LAYOUT_FLAG_COMBO_LINEOUT_SPDIF	(1<<0)
@@ -116,7 +116,7 @@ MODULE_ALIAS("aoa-device-id-35");
 MODULE_ALIAS("aoa-device-id-44");
 
 /* onyx with all but microphone connected */
-static struct codec_connection onyx_connections_nomic[] = {
+static const struct codec_connection onyx_connections_nomic[] = {
 	{
 		.connected = CC_SPEAKERS | CC_HEADPHONE | CC_LINEOUT,
 		.codec_bit = 0,
@@ -133,7 +133,7 @@ static struct codec_connection onyx_connections_nomic[] = {
 };
 
 /* onyx on machines without headphone */
-static struct codec_connection onyx_connections_noheadphones[] = {
+static const struct codec_connection onyx_connections_noheadphones[] = {
 	{
 		.connected = CC_SPEAKERS | CC_LINEOUT |
 			     CC_LINEOUT_LABELLED_HEADPHONE,
@@ -157,7 +157,7 @@ static struct codec_connection onyx_connections_noheadphones[] = {
 };
 
 /* onyx on machines with real line-out */
-static struct codec_connection onyx_connections_reallineout[] = {
+static const struct codec_connection onyx_connections_reallineout[] = {
 	{
 		.connected = CC_SPEAKERS | CC_LINEOUT | CC_HEADPHONE,
 		.codec_bit = 0,
@@ -174,7 +174,7 @@ static struct codec_connection onyx_connections_reallineout[] = {
 };
 
 /* tas on machines without line out */
-static struct codec_connection tas_connections_nolineout[] = {
+static const struct codec_connection tas_connections_nolineout[] = {
 	{
 		.connected = CC_SPEAKERS | CC_HEADPHONE,
 		.codec_bit = 0,
@@ -191,7 +191,7 @@ static struct codec_connection tas_connections_nolineout[] = {
 };
 
 /* tas on machines with neither line out nor line in */
-static struct codec_connection tas_connections_noline[] = {
+static const struct codec_connection tas_connections_noline[] = {
 	{
 		.connected = CC_SPEAKERS | CC_HEADPHONE,
 		.codec_bit = 0,
@@ -204,7 +204,7 @@ static struct codec_connection tas_connections_noline[] = {
 };
 
 /* tas on machines without microphone */
-static struct codec_connection tas_connections_nomic[] = {
+static const struct codec_connection tas_connections_nomic[] = {
 	{
 		.connected = CC_SPEAKERS | CC_HEADPHONE | CC_LINEOUT,
 		.codec_bit = 0,
@@ -217,7 +217,7 @@ static struct codec_connection tas_connections_nomic[] = {
 };
 
 /* tas on machines with everything connected */
-static struct codec_connection tas_connections_all[] = {
+static const struct codec_connection tas_connections_all[] = {
 	{
 		.connected = CC_SPEAKERS | CC_HEADPHONE | CC_LINEOUT,
 		.codec_bit = 0,
@@ -233,7 +233,7 @@ static struct codec_connection tas_connections_all[] = {
 	{} /* terminate array by .connected == 0 */
 };
 
-static struct codec_connection toonie_connections[] = {
+static const struct codec_connection toonie_connections[] = {
 	{
 		.connected = CC_SPEAKERS | CC_HEADPHONE,
 		.codec_bit = 0,
@@ -241,7 +241,7 @@ static struct codec_connection toonie_connections[] = {
 	{} /* terminate array by .connected == 0 */
 };
 
-static struct codec_connection topaz_input[] = {
+static const struct codec_connection topaz_input[] = {
 	{
 		.connected = CC_DIGITALIN,
 		.codec_bit = 0,
@@ -249,7 +249,7 @@ static struct codec_connection topaz_input[] = {
 	{} /* terminate array by .connected == 0 */
 };
 
-static struct codec_connection topaz_output[] = {
+static const struct codec_connection topaz_output[] = {
 	{
 		.connected = CC_DIGITALOUT,
 		.codec_bit = 1,
@@ -257,7 +257,7 @@ static struct codec_connection topaz_output[] = {
 	{} /* terminate array by .connected == 0 */
 };
 
-static struct codec_connection topaz_inout[] = {
+static const struct codec_connection topaz_inout[] = {
 	{
 		.connected = CC_DIGITALIN,
 		.codec_bit = 0,
@@ -772,7 +772,7 @@ static int check_codec(struct aoa_codec *codec,
 {
 	const u32 *ref;
 	char propname[32];
-	struct codec_connection *cc;
+	const struct codec_connection *cc;
 
 	/* if the codec has a 'codec' node, we require a reference */
 	if (of_node_name_eq(codec->node, "codec")) {
@@ -895,7 +895,7 @@ static void layout_notify(void *data)
 
 static void layout_attached_codec(struct aoa_codec *codec)
 {
-	struct codec_connection *cc;
+	const struct codec_connection *cc;
 	struct snd_kcontrol *ctl;
 	int headphones, lineout;
 	struct layout_dev *ldev = layout_device;
-- 
2.53.0


