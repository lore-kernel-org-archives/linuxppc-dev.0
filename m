Return-Path: <SRS0=Ef5B=VC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E69AC0650E
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jul 2019 00:00:06 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAA3A21738
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jul 2019 00:00:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAA3A21738
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=perches.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45fw2V6WyFzDqdW
	for <linuxppc-dev@archiver.kernel.org>; Fri,  5 Jul 2019 10:00:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=perches.com
 (client-ip=216.40.44.55; helo=smtprelay.hostedemail.com;
 envelope-from=joe@perches.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=perches.com
Received: from smtprelay.hostedemail.com (smtprelay0055.hostedemail.com
 [216.40.44.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45fw083vWkzDqcV
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jul 2019 09:57:58 +1000 (AEST)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net
 [216.40.38.60])
 by smtprelay01.hostedemail.com (Postfix) with ESMTP id 1896C100E86C0;
 Thu,  4 Jul 2019 23:57:53 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: girl52_61bbf4fecba19
X-Filterd-Recvd-Size: 1739
Received: from joe-laptop.perches.com (cpe-23-242-196-136.socal.res.rr.com
 [23.242.196.136]) (Authenticated sender: joe@perches.com)
 by omf14.hostedemail.com (Postfix) with ESMTPA;
 Thu,  4 Jul 2019 23:57:51 +0000 (UTC)
From: Joe Perches <joe@perches.com>
To: Dan Murphy <dmurphy@ti.com>, linux-leds@vger.kernel.org,
 linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-nfs@vger.kernel.org
Subject: [PATCH 0/8] treewide: correct misuses of strscpy/strlcpy
Date: Thu,  4 Jul 2019 16:57:40 -0700
Message-Id: <cover.1562283944.git.joe@perches.com>
X-Mailer: git-send-email 2.15.0
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-input@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

These are all likely copy/paste defects where the field size of the
'copied to' array is incorrect.

Each patch in this series is independent.

Joe Perches (8):
  Input: synaptics: Fix misuse of strlcpy
  leds: as3645a: Fix misuse of strlcpy
  media: m2m-deinterlace: Fix misuse of strscpy
  media: go7007: Fix misuse of strscpy
  net: ethernet: sun4i-emac: Fix misuse of strlcpy
  net: nixge: Fix misuse of strlcpy
  tty: hvcs: Fix odd use of strlcpy
  nfsd: Fix misuse of strlcpy

 drivers/input/mouse/synaptics.c             | 2 +-
 drivers/leds/leds-as3645a.c                 | 2 +-
 drivers/media/platform/m2m-deinterlace.c    | 2 +-
 drivers/media/usb/go7007/snd-go7007.c       | 2 +-
 drivers/net/ethernet/allwinner/sun4i-emac.c | 4 ++--
 drivers/net/ethernet/ni/nixge.c             | 2 +-
 drivers/tty/hvc/hvcs.c                      | 4 ++--
 fs/nfsd/nfs4idmap.c                         | 2 +-
 8 files changed, 10 insertions(+), 10 deletions(-)

-- 
2.15.0

