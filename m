Return-Path: <SRS0=WC9B=B3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03700C433DF
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 12:08:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90ED22072E
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 12:08:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LtWAzvRH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90ED22072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BVXrL3fYQzDqV9
	for <linuxppc-dev@archiver.kernel.org>; Mon, 17 Aug 2020 22:08:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::544;
 helo=mail-pg1-x544.google.com; envelope-from=allen.cryptic@gmail.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20161025 header.b=LtWAzvRH; dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BVSjX3pmZzDqTw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 19:02:23 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id i10so2268062pgk.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Aug 2020 02:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=ZC0KgckbobKMVj5LNskgiWBvLB99vw6xXyp7G4nHwHs=;
 b=LtWAzvRHRo/hDVkht4VwT9on5IaPKV6420lBfPnZOTHiGZkzNZbwY7MOrf34k0vLZj
 CUJPCkbSKAgOTAy0inWwOrrPkUwXbFem9JRMgQyDbKVc5akH+Rw1vRE70gdDQdozDpuX
 d+US6nIjO7b88t9dfb4JimOv7nj6R1oJ1Y8dAc/zXUl0dEhT9CgGujDNXReqnJKt87ab
 caIoCpfJOpafH+Bbw5LpRB+rtMW8Ymfq6w0AUHTrWUJcJNBUi/V0FZRirPY066djDKTV
 9aXCo13AgbnDmu+oy1jijiDv3yUFKW4VI+vjtwJ13gZwX5/iQiPn1BVihJSLLEA5lXuP
 WhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=ZC0KgckbobKMVj5LNskgiWBvLB99vw6xXyp7G4nHwHs=;
 b=VqlpC4Zsd9x+l0VD4qT58nOAFtPkEM8+uOC0XRzyW6iw48s1ARlujlBiSLMZZgtAvg
 BqKpoFlvG5njO+SVyio27TBCCjnB3yj8y4PpFgpWwyds4B+aSQ+fFMlQxuKnjxaSerKA
 MBPqC9o0SRVzpvtSlfkwrq/gF9T4ggv+I0x3QhDtNkmIA1gxMokq9lzQTGoQdU7FTTbz
 lX0+EwnUPM3QA57GIdpHpCXHkSvtpaKMIzlL/9O8jHWoafwwf6E7mBMWxZrusL+L6nk6
 8TW4bftFTyMEacSCuQ4bkqHJ4pm9nboQm3lZbaQBNti6FF4MQZ6krWqvsVg46xMm3YO9
 JQAw==
X-Gm-Message-State: AOAM533/LkGddz6AD9G1CkBhFtf9qOYLU5uauomPwtE8HGVKbwPMuAZa
 SAAetWYkNex17RbODFdpvuI=
X-Google-Smtp-Source: ABdhPJwTF2ujS4X+LZ29MIz5ofATMmQi3CNS6pxXN5INk7X1POpIv7TjyTdUGld9toMU2mDPaJ+atw==
X-Received: by 2002:a62:9246:: with SMTP id o67mr10339722pfd.249.1597654941674; 
 Mon, 17 Aug 2020 02:02:21 -0700 (PDT)
Received: from localhost.localdomain ([49.207.202.98])
 by smtp.gmail.com with ESMTPSA id f3sm19488238pfj.206.2020.08.17.02.02.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2020 02:02:21 -0700 (PDT)
From: Allen Pais <allen.cryptic@gmail.com>
To: duncan.sands@free.fr, gregkh@linuxfoundation.org, jacmet@sunsite.dk,
 balbi@kernel.org, leoyang.li@nxp.com, johan@kernel.org
Subject: [PATCH 0/7] usb: convert tasklets to use new tasklet_setup()
Date: Mon, 17 Aug 2020 14:32:02 +0530
Message-Id: <20200817090209.26351-1-allen.cryptic@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Mailman-Approved-At: Mon, 17 Aug 2020 21:23:58 +1000
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
Cc: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 keescook@chromium.org, Allen Pais <allen.lkml@gmail.com>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Allen Pais <allen.lkml@gmail.com>

Commit 12cc923f1ccc ("tasklet: Introduce new initialization API")'
introduced a new tasklet initialization API. This series converts 
all the usb drivers to use the new tasklet_setup() API

Allen Pais (7):
  usb: atm: convert tasklets to use new tasklet_setup() API
  usb: c67x00: convert tasklets to use new tasklet_setup() API
  usb: hcd: convert tasklets to use new tasklet_setup() API
  usb/gadget: f_midi: convert tasklets to use new tasklet_setup() API
  usb/gadget: fsl_qe_udc: convert tasklets to use new tasklet_setup()
    API
  usb: xhci: convert tasklets to use new tasklet_setup() API
  usb: mos7720: convert tasklets to use new tasklet_setup() API

 drivers/usb/atm/usbatm.c             | 14 ++++++++------
 drivers/usb/c67x00/c67x00-sched.c    |  7 +++----
 drivers/usb/core/hcd.c               |  6 +++---
 drivers/usb/gadget/function/f_midi.c |  6 +++---
 drivers/usb/gadget/udc/fsl_qe_udc.c  |  7 +++----
 drivers/usb/host/xhci-dbgtty.c       |  6 +++---
 drivers/usb/serial/mos7720.c         |  8 ++++----
 7 files changed, 27 insertions(+), 27 deletions(-)

-- 
2.17.1

