Return-Path: <SRS0=P3hO=RE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20237C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 20:01:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8DDD120848
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Mar 2019 20:01:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="JaydcnMu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8DDD120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=cisco.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44B0fx5S2WzDqJ8
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Mar 2019 07:01:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=cisco.com
 (client-ip=173.37.86.78; helo=rcdn-iport-7.cisco.com;
 envelope-from=danielwa@cisco.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none)
 header.from=cisco.com
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=cisco.com header.i=@cisco.com header.b="JaydcnMu"; 
 dkim-atps=neutral
Received: from rcdn-iport-7.cisco.com (rcdn-iport-7.cisco.com [173.37.86.78])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44B0Xy4QL3zDqVj
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Mar 2019 06:56:18 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=cisco.com; i=@cisco.com; l=1852; q=dns/txt; s=iport;
 t=1551470178; x=1552679778;
 h=from:to:cc:subject:date:message-id;
 bh=CSGgkLU0GtxBXZ4f0m30bkOxXaKsKnckSnhZfY3p/kw=;
 b=JaydcnMuCMG8igYM8bR5k7aij1ZFBwYkDJq71nZZ3ppiWPnag+34ivF1
 Z3O3BFhs/q6l6eINQ9M+USpm0bRn0r12Q8cL+I9tPKEVORnvXpk8mRFSC
 G7380Znka+jU6LDmrGakfa9P/jqYaD2xgD/5pEWzvUOWDtmNSbfRdH6N+ Q=;
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A0AmAAC/inlc/5NdJa1kHAEBAQQBAQc?=
 =?us-ascii?q?EAQGBUQcBAQsBggRogQMnjCKld4F7DSOESYQjIjQJDQEDAQEDAQMCbRwMhko?=
 =?us-ascii?q?pgQkMgzUBgXQBD6xvii+ICIRDF4FAP4VLGQGBXAKHQgKKESCNM4wWCYJAhQO?=
 =?us-ascii?q?LLAIXgXSFYYtLAZA6jGxvWDiBVjMaCBsVgycJgiuDVopTPzOQSgEB?=
X-IronPort-AV: E=Sophos;i="5.58,428,1544486400"; d="scan'208";a="523879473"
Received: from rcdn-core-11.cisco.com ([173.37.93.147])
 by rcdn-iport-7.cisco.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 01 Mar 2019 19:44:32 +0000
Received: from sjc-ads-2388.cisco.com (sjc-ads-2388.cisco.com [171.70.63.76])
 by rcdn-core-11.cisco.com (8.15.2/8.15.2) with ESMTP id
 x21JiWLi018182; Fri, 1 Mar 2019 19:44:32 GMT
From: Daniel Walker <danielwa@cisco.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [PULL REQUEST] powerpc generic command line
Date: Fri,  1 Mar 2019 19:44:28 +0000
Message-Id: <1551469472-53043-1-git-send-email-danielwa@cisco.com>
X-Mailer: git-send-email 2.7.4
X-Outbound-SMTP-Client: 171.70.63.76, sjc-ads-2388.cisco.com
X-Outbound-Node: rcdn-core-11.cisco.com
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Here are the generic command line changes for powerpc. 

These changes have been in linux-next for two cycles, with few problems reported.
It's also been used at Cisco Systems, Inc. in production products for many many
years with no problems.

Please pull these changes.


The following changes since commit ccda4af0f4b92f7b4c308d3acc262f4a7e3affad:

  Linux 4.20-rc2 (2018-11-11 17:12:31 -0600)

are available in the git repository at:

  https://github.com/daniel-walker/cisco-linux.git for-powerpc

for you to fetch changes up to 5d4514a9c291ecf19b0626695161673d35e5d549:

  powerpc: convert config files to generic cmdline (2018-11-16 07:32:26 -0800)

----------------------------------------------------------------
Daniel Walker (3):
      add generic builtin command line
      powerpc: convert to generic builtin command line
      powerpc: convert config files to generic cmdline

 arch/powerpc/Kconfig                          | 23 +--------
 arch/powerpc/configs/44x/fsp2_defconfig       | 29 ++++++-----
 arch/powerpc/configs/44x/iss476-smp_defconfig | 24 ++++-----
 arch/powerpc/configs/44x/warp_defconfig       | 12 ++---
 arch/powerpc/configs/holly_defconfig          | 12 ++---
 arch/powerpc/configs/mvme5100_defconfig       | 25 +++++-----
 arch/powerpc/configs/skiroot_defconfig        | 48 +++++++++---------
 arch/powerpc/configs/storcenter_defconfig     | 15 +++---
 arch/powerpc/kernel/prom.c                    |  4 ++
 arch/powerpc/kernel/prom_init.c               |  8 +--
 arch/powerpc/kernel/prom_init_check.sh        |  2 +-
 include/linux/cmdline.h                       | 72 +++++++++++++++++++++++++++
 init/Kconfig                                  | 69 +++++++++++++++++++++++++
 13 files changed, 231 insertions(+), 112 deletions(-)
 create mode 100644 include/linux/cmdline.h
