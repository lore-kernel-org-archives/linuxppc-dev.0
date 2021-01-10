Return-Path: <SRS0=Om5s=GN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D33C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Jan 2021 23:22:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D2726227C3
	for <linuxppc-dev@archiver.kernel.org>; Sun, 10 Jan 2021 23:22:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D2726227C3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DDXtj4FLHzDqM0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Jan 2021 10:22:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=bootlin.com (client-ip=217.70.183.197;
 helo=relay5-d.mail.gandi.net; envelope-from=alexandre.belloni@bootlin.com;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=bootlin.com
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net
 [217.70.183.197])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DDXng3vJdzDqLq
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2021 10:18:10 +1100 (AEDT)
X-Originating-IP: 86.202.109.140
Received: from localhost (lfbn-lyo-1-13-140.w86-202.abo.wanadoo.fr
 [86.202.109.140])
 (Authenticated sender: alexandre.belloni@bootlin.com)
 by relay5-d.mail.gandi.net (Postfix) with ESMTPSA id 1CBA71C0008;
 Sun, 10 Jan 2021 23:17:59 +0000 (UTC)
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: linux-rtc@vger.kernel.org
Subject: [PATCH 00/17] rtc: constify all rtc_class_ops
Date: Mon, 11 Jan 2021 00:17:35 +0100
Message-Id: <20210110231752.1418816-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.29.2
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
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hello,

This first introduces a features bitfield that is used to handle the
presence or absence of alarms instead of relying only on the presence of
the alarm callbacks.

The drivers modifying a struct rtc_class_ops or using two different
structures are then converted.

Alexandre Belloni (17):
  rtc: introduce features bitfield
  rtc: pl031: use RTC_FEATURE_ALARM
  rtc: armada38x: remove armada38x_rtc_ops_noirq
  rtc: cmos: remove cmos_rtc_ops_no_alarm
  rtc: mv: remove mv_rtc_alarm_ops
  rtc: m48t59: remove m48t02_rtc_ops
  rtc: pcf2127: remove pcf2127_rtc_alrm_ops
  rtc: pcf85063: remove pcf85063_rtc_ops_alarm
  rtc: rx8010: drop a struct rtc_class_ops
  rtc: pcf85363: drop a struct rtc_class_ops
  rtc: m41t80: constify m41t80_rtc_ops
  rtc: opal: constify opal_rtc_ops
  rtc: rv3028: constify rv3028_rtc_ops
  rtc: rv3029: constify rv3029_rtc_ops
  rtc: rv3032: constify rv3032_rtc_ops
  rtc: rv8803: constify rv8803_rtc_ops
  rtc: tps65910: remove tps65910_rtc_ops_noirq

 drivers/rtc/class.c         |  5 +++++
 drivers/rtc/interface.c     | 12 ++++++------
 drivers/rtc/rtc-armada38x.c | 21 ++++-----------------
 drivers/rtc/rtc-cmos.c      | 12 +++---------
 drivers/rtc/rtc-m41t80.c    | 14 +++++++-------
 drivers/rtc/rtc-m48t59.c    | 22 ++++++++--------------
 drivers/rtc/rtc-mv.c        | 14 ++++----------
 drivers/rtc/rtc-opal.c      | 13 +++++++------
 drivers/rtc/rtc-pcf2127.c   | 11 +++--------
 drivers/rtc/rtc-pcf85063.c  | 11 ++---------
 drivers/rtc/rtc-pcf85363.c  |  8 ++------
 drivers/rtc/rtc-pl031.c     |  8 ++------
 drivers/rtc/rtc-rv3028.c    | 11 ++++++-----
 drivers/rtc/rtc-rv3029c2.c  | 11 ++++++-----
 drivers/rtc/rtc-rv3032.c    | 11 ++++++-----
 drivers/rtc/rtc-rv8803.c    | 11 ++++++-----
 drivers/rtc/rtc-rx8010.c    | 13 +++----------
 drivers/rtc/rtc-tps65910.c  | 15 ++++-----------
 include/linux/rtc.h         |  2 ++
 include/uapi/linux/rtc.h    |  5 +++++
 20 files changed, 91 insertions(+), 139 deletions(-)

-- 
2.29.2

