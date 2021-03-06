Return-Path: <SRS0=VmVE=IE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E109C433E0
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Mar 2021 18:10:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CA9A64FE9
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Mar 2021 18:10:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CA9A64FE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DtCLc3lrjz3cm1
	for <linuxppc-dev@archiver.kernel.org>; Sun,  7 Mar 2021 05:10:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DtCLB2wNVz3cJ9
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Mar 2021 05:09:34 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4DtCKz069zz9v086;
 Sat,  6 Mar 2021 19:09:27 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id cGRZB42mNDdR; Sat,  6 Mar 2021 19:09:26 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4DtCKy5SnHz9v085;
 Sat,  6 Mar 2021 19:09:26 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id A8CAA8B768;
 Sat,  6 Mar 2021 19:09:28 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id SEiO7T7f0CNU; Sat,  6 Mar 2021 19:09:28 +0100 (CET)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 5890A8B75B;
 Sat,  6 Mar 2021 19:09:28 +0100 (CET)
Received: by localhost.localdomain (Postfix, from userid 0)
 id 186F5674E3; Sat,  6 Mar 2021 18:09:27 +0000 (UTC)
Message-Id: <cover.1615053848.git.christophe.leroy@csgroup.eu>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 0/3] Remove qe_io{read,write}* IO accessors
To: Qiang Zhao <qiang.zhao@nxp.com>, Li Yang <leoyang.li@nxp.com>,
 Rasmus Villemoes <rasmus.villemoes@prevas.dk>, Timur Tabi <timur@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jiri Slaby <jirislaby@kernel.org>
Date: Sat,  6 Mar 2021 18:09:27 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Commit 6ac9b61786cc ("soc: fsl: qe: introduce qe_io{read,write}*
wrappers") added specific I/O accessors for qe because at that
time ioread/iowrite functions were sub-optimal on powerpc/32
compared to the architecture specific in_/out_ IO accessors.

But as ioread/iowrite accessors are now equivalent since
commit 894fa235eb4c ("powerpc: inline iomap accessors"),
use them in order to allow removal of the qe specific ones.

Christophe Leroy (3):
  soc: fsl: qe: replace qe_io{read,write}* wrappers by generic
    io{read,write}*
  tty: serial: ucc_uart: replace qe_io{read,write}* wrappers by generic
    io{read,write}*
  Revert "soc: fsl: qe: introduce qe_io{read,write}* wrappers"

 drivers/soc/fsl/qe/gpio.c     |  20 +++---
 drivers/soc/fsl/qe/qe.c       |  24 +++----
 drivers/soc/fsl/qe/qe_ic.c    |   4 +-
 drivers/soc/fsl/qe/qe_io.c    |  36 +++++-----
 drivers/soc/fsl/qe/ucc_fast.c |  68 +++++++++----------
 drivers/soc/fsl/qe/ucc_slow.c |  42 ++++++------
 drivers/tty/serial/ucc_uart.c | 124 +++++++++++++++++-----------------
 include/soc/fsl/qe/qe.h       |  34 +++-------
 8 files changed, 168 insertions(+), 184 deletions(-)

-- 
2.25.0

