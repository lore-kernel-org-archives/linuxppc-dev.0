Return-Path: <SRS0=ynH/=IA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90385C433E0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 17:26:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B503764F34
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Mar 2021 17:26:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B503764F34
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DqkYj2hBFz3d9p
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Mar 2021 04:26:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DqkY00tY6z30N7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Mar 2021 04:25:21 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DqkXq2Y55z9v1By;
 Tue,  2 Mar 2021 18:25:15 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 3XK1Ji_IwYa7; Tue,  2 Mar 2021 18:25:15 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DqkXq139Yz9v1Bx;
 Tue,  2 Mar 2021 18:25:15 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id D6D058B7B5;
 Tue,  2 Mar 2021 18:25:16 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id fhn6Nsk8d_7h; Tue,  2 Mar 2021 18:25:16 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 81F848B75F;
 Tue,  2 Mar 2021 18:25:16 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 41160674A2; Tue,  2 Mar 2021 17:25:16 +0000 (UTC)
Message-Id: <cover.1614705851.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v2 0/7] Improve boot command line handling
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, 
 danielwa@cisco.com, robh@kernel.org, daniel@gimpelevich.san-francisco.ca.us
Date: Tue,  2 Mar 2021 17:25:16 +0000 (UTC)
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
Cc: linux-arch@vger.kernel.org, devicetree@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The purpose of this series is to improve and enhance the
handling of kernel boot arguments.

It is first focussed on powerpc but also extends the capability
for other arches.

This is based on suggestion from Daniel Walker <danielwa@cisco.com>

Christophe Leroy (7):
  cmdline: Add generic function to build command line.
  drivers: of: use cmdline building function
  powerpc: convert to generic builtin command line
  cmdline: Add capability to prepend the command line
  powerpc: add capability to prepend default command line
  cmdline: Gives architectures opportunity to use generically defined
    boot cmdline manipulation
  powerpc: use generic CMDLINE manipulations

 arch/powerpc/Kconfig            | 37 ++-----------------
 arch/powerpc/kernel/prom_init.c | 35 +++---------------
 drivers/of/fdt.c                | 23 ++----------
 include/linux/cmdline.h         | 65 +++++++++++++++++++++++++++++++++
 init/Kconfig                    | 56 ++++++++++++++++++++++++++++
 5 files changed, 133 insertions(+), 83 deletions(-)
 create mode 100644 include/linux/cmdline.h

-- 
2.25.0

