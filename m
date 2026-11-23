Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57651606A31A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 23 Nov 2026 03:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=DScxZSda
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXrxT4lm1z2xyj;
	Mon, 23 Nov 2026 14:28:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=111.22.67.139
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1795404493;
	cv=none; b=Etnr/QSHmM4cZAsNitv5KWlU5lYLDC1vLbHePf9znWiz9XSByQE6/VaNSjnybFmWL+B97ZDjUqQ/NWdzMnsWCIsgOPYhPH7ZO0672lWKfLKp77XFwAGcDAPHNe7A9vqT5nx28OmqwrWbk2f8o3vMgX5PuY7HvQtaGPTbmGGNbz6CmRL1ukZ4j8TMV9rW4P3WLIzVp/X/HGU8KDxPJDU2CBOaoIcP9YhzwX4EJfL29SgHHSXe1N2/X1YZCZEjTBJNV4oQ8EBj5X6TEWAb5qGKwJ5VNvVadPsdh5Ta2D1bSZwc7sYKU9nEB4UUhgfT+v7tfV6qiQYqoOP+JTg/4Dat8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1795404493; c=relaxed/relaxed;
	bh=TGfp7P5OBJUKiThiruIwJr4YVVahruavoJqGO1SNK8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eteJnvBraOBQvPPGdu4lNIkTTg1CjTJlsE90M9CPAvLvMEiPN0772mg/WdyXesn4DA0k9zqPhtZjq//j/WVZfqvkcCMrZP9h22e57RjO/r+QlJ0rC6/bxy/X0IVyNA+Dk1yTVdeyL+nCcr67895kbXxVLelz7/s7U9iJYDLPuUpay66aks4R5Rgg+YlRA29NK+OfrV/hatZk1Upz73acJoRj0oAlIslqqFcEgEZ5sUi2NRWBObgltZakKIEym1oOQhiXgA1oSifYrSAaodIxxzlsK8OvkKJjAr8I4E5886hegStYnE0Xw/ozELSZb0Lq+vjHA5hBNiBTbYrZ8XHwMA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com; dkim=pass (1024-bit key; unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=DScxZSda; dkim-atps=neutral; spf=pass (client-ip=111.22.67.139; helo=cmccmta6.chinamobile.com; envelope-from=chenaibing@cmss.chinamobile.com; receiver=lists.ozlabs.org) smtp.mailfrom=cmss.chinamobile.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=cmss.chinamobile.com header.i=@cmss.chinamobile.com header.a=rsa-sha256 header.s=default header.b=DScxZSda;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cmss.chinamobile.com (client-ip=111.22.67.139; helo=cmccmta6.chinamobile.com; envelope-from=chenaibing@cmss.chinamobile.com; receiver=lists.ozlabs.org)
Received: from cmccmta6.chinamobile.com (cmccmta6.chinamobile.com [111.22.67.139])
	by lists.ozlabs.org (Postfix) with ESMTP id 4jXrxP570Mz2xdR
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Nov 2026 14:28:07 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=cmss.chinamobile.com; s=default; l=0;
	h=from:subject:message-id:to:cc:mime-version;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	b=DScxZSdazFS7PwahgzQqGpB/4MD+YYIL03yNpJ1gAV+xzkymx4hQjavd+KC8VOLi/RWtcWRWlOvSc
	 Xoa7BJDuW49VKKoj2dkMAzsxjyYNb0rkvi9QJ3/cRCQN9ewXTuAEXVvJG0e2xcUa8zjQHQ2mfHllDn
	 r90KuvjBEVnLqerw=
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app05-12005 (RichMail) with SMTP id 2ee56b03b2c007e-35e20;
	Mon, 23 Nov 2026 11:28:00 +0800 (CST)
X-RM-TRANSID:2ee56b03b2c007e-35e20
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from FHD-W7400297 (unknown[10.55.1.70])
	by rmsmtp-syy-appsvr02-12002 (RichMail) with SMTP id 2ee26b03b2be876-84f5d;
	Mon, 23 Nov 2026 11:28:00 +0800 (CST)
X-RM-TRANSID:2ee26b03b2be876-84f5d
From: Aibing Chen <chenaibing@cmss.chinamobile.com>
To: Takashi Iwai <tiwai@suse.de>
Cc: Johannes Berg <johannes@sipsolutions.net>,
	Jaroslav Kysela <perex@perex.cz>,
	linuxppc-dev@lists.ozlabs.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: aoa: size the codec reference property name buffer
Date: Mon, 23 Nov 2026 11:27:58 +0800
Message-ID: <20261123032758.855-1-chenaibing@cmss.chinamobile.com>
X-Mailer: git-send-email 2.50.1.windows.1
In-Reply-To: <87cxs5ypv9.wl-tiwai@suse.de>
References: <87cxs5ypv9.wl-tiwai@suse.de>
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
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Takashi,

You are right, there is no truncation with the codecs that exist in the
tree.  codec->name is only ever set from a fixed string:

  sound/aoa/codecs/onyx.c:1005     strscpy(onyx->codec.name, "onyx");
  sound/aoa/codecs/tas.c:860       strscpy(tas->codec.name, "tas");
  sound/aoa/codecs/toonie.c:129    strscpy(toonie->codec.name, "toonie");

so the longest property name built by check_codec() is
"platform-toonie-codec-ref", 25 bytes including the terminator, which
fits in the existing 32 byte array.  The W=1 warning is a false positive:
the compiler cannot bound the length of codec->name.

I will drop the patch.

Thanks,
Aibing Chen



