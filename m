Return-Path: <SRS0=Rj2I=VR=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E648CC7618F
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Jul 2019 01:33:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9FC0920873
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Jul 2019 01:33:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9FC0920873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45r9PM3WYLzDqyx
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Jul 2019 11:33:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=ozlabs.ru
 (client-ip=107.173.13.209; helo=ozlabs.ru; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=ozlabs.ru
Received: from ozlabs.ru (ozlabs.ru [107.173.13.209])
 by lists.ozlabs.org (Postfix) with ESMTP id 45r9KM2bMNzDqwT
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Jul 2019 11:29:59 +1000 (AEST)
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 921C0AE807F5;
 Fri, 19 Jul 2019 21:29:20 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel RFC 0/2] powerpc/pseries: Kexec style boot
Date: Sat, 20 Jul 2019 11:29:17 +1000
Message-Id: <20190720012919.14417-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, kvm-ppc@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

There is a funny excercise to run a guest under QEMU without
the SLOF firmware and boot into a kernel directly to use petitboot as
a boot loader (a more power boot loader than grub and yum),
the patchset is posted as "spapr: Kexec style boot".

Since there is no SLOF, i.e. no client interface and no RTAS blob,
we need to avoid the former and call the latter directly. Also,
this implements "client-architecture-support" substiitute for
the new environment.

This is based on sha1
a2b6f26c264e Christophe Leroy "powerpc/module64: Use symbolic instructions names.".

Please comment. Thanks.



Alexey Kardashevskiy (2):
  powerpc/pseries: Call RTAS directly
  powerpc/pseries: Kexec style ibm,client-architecture-support support

 arch/powerpc/include/asm/rtas.h |  1 +
 arch/powerpc/kernel/prom_init.c | 12 ++++++---
 arch/powerpc/kernel/rtas.c      | 47 +++++++++++++++------------------
 arch/powerpc/kernel/setup_64.c  | 41 ++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+), 30 deletions(-)

-- 
2.17.1

