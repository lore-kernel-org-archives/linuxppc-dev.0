Return-Path: <SRS0=1YdR=PK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 562F6C433EF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Oct 2021 06:49:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BE28960EE3
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Oct 2021 06:49:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org BE28960EE3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HbFMb3DvRz3cTM
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Oct 2021 17:49:47 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=PMNO7u+J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=suse.com (client-ip=195.135.220.28; helo=smtp-out1.suse.de;
 envelope-from=jgross@suse.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256
 header.s=susede1 header.b=PMNO7u+J; dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HbFLt2X46z2yPh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Oct 2021 17:49:09 +1100 (AEDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8D2452197F;
 Fri, 22 Oct 2021 06:49:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1634885344; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=vdb5nLtyp5tIbT7/OLrVEaSBnq6naUGZA07AQT86v2c=;
 b=PMNO7u+JK4lsjHIAmHQ/NYSH6PSDWxW5oi4qSzEsVw9p0v6RgIf1dw5L1M0yxZnnPmUE42
 bEdzMHkjaPHjMsStRKaaW/VG+AFY5hngJA838Yw55Zrc0gCY9ILGst8rEWSnr+azo7IRtQ
 wVKKkBy8OqPGObfHmn8PuQkefgkgXAA=
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1A09513AAD;
 Fri, 22 Oct 2021 06:49:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id jpEMBeBecmEIEwAAMHmgww
 (envelope-from <jgross@suse.com>); Fri, 22 Oct 2021 06:49:04 +0000
From: Juergen Gross <jgross@suse.com>
To: xen-devel@lists.xenproject.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 0/5] xen: cleanup detection of non-essential pv devices
Date: Fri, 22 Oct 2021 08:47:55 +0200
Message-Id: <20211022064800.14978-1-jgross@suse.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
Cc: Juergen Gross <jgross@suse.com>, alsa-devel@alsa-project.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 Oleksandr Andrushchenko <oleksandr_andrushchenko@epam.com>,
 David Airlie <airlied@linux.ie>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Jaroslav Kysela <perex@perex.cz>, Daniel Vetter <daniel@ffwll.ch>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Jiri Slaby <jirislaby@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Today the non-essential pv devices are hard coded in the xenbus driver
and this list is lacking multiple entries.

This series reworks the detection logic of non-essential devices by
adding a flag for that purpose to struct xenbus_driver.

Juergen Gross (5):
  xen: add "not_essential" flag to struct xenbus_driver
  xen: flag xen_drm_front to be not essential for system boot
  xen: flag hvc_xen to be not essential for system boot
  xen: flag pvcalls-front to be not essential for system boot
  xen: flag xen_snd_front to be not essential for system boot

 drivers/gpu/drm/xen/xen_drm_front.c        |  1 +
 drivers/input/misc/xen-kbdfront.c          |  1 +
 drivers/tty/hvc/hvc_xen.c                  |  1 +
 drivers/video/fbdev/xen-fbfront.c          |  1 +
 drivers/xen/pvcalls-front.c                |  1 +
 drivers/xen/xenbus/xenbus_probe_frontend.c | 14 +++-----------
 include/xen/xenbus.h                       |  1 +
 sound/xen/xen_snd_front.c                  |  1 +
 8 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.26.2

