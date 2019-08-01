Return-Path: <SRS0=4G4N=V5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E178FC19759
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Aug 2019 08:33:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DC9C2087E
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Aug 2019 08:33:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DC9C2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45zk8s5bP4zDqtk
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Aug 2019 18:33:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=wanadoo.fr
 (client-ip=80.12.242.126; helo=smtp.smtpout.orange.fr;
 envelope-from=christophe.jaillet@wanadoo.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=wanadoo.fr
Received: from smtp.smtpout.orange.fr (smtp04.smtpout.orange.fr
 [80.12.242.126])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45zk6n47VvzDqpg
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2019 18:31:53 +1000 (AEST)
Received: from localhost.localdomain ([176.167.121.156]) by mwinf5d80 with ME
 id jkXg2000Y3NZnML03kXgAC; Thu, 01 Aug 2019 10:31:48 +0200
X-ME-Helo: localhost.localdomain
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 01 Aug 2019 10:31:48 +0200
X-ME-IP: 176.167.121.156
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 allison@lohutok.net, tglx@linutronix.de, clg@kaod.org, groug@kaod.org
Subject: [PATCH 0/2] powerpc/xive: 2 small tweaks in 'xive_irq_bitmap_add()'
Date: Thu,  1 Aug 2019 10:31:44 +0200
Message-Id: <cover.1564647619.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.20.1
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
Cc: kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The first patch uses GFP_KERNEL instead of GFP_ATOMIC.
The 2nd adds a check for memory allocation failure.

Christophe JAILLET (2):
  powerpc/xive: Use GFP_KERNEL instead of GFP_ATOMIC in
    'xive_irq_bitmap_add()'
  powerpc/xive: Add a check for memory allocation failure

 arch/powerpc/sysdev/xive/spapr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

-- 
2.20.1

