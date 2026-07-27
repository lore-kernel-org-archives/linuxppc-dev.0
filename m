Return-Path: <linuxppc-dev+bounces-24881-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECC7C53219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 10:49:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7wN21bRmz2yl2;
	Mon, 27 Jul 2026 20:49:54 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=54.254.200.128
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785149394;
	cv=none; b=jgin7+ai8igShIv9i3pv+R9zwIOjoXW2UdTilDYYVwrvpUBkzaujWXiehhQm70CFhZJ/zQSqKfo3rfP3395lL5CoHYTwdiX0IfPeC4f6jP1ORO6pTNMDJ3Sek1WpJjtDQ5yQo9FBGVr+Kg/7ZlNqbRLFkmkJx0VsBRmxwbtnyydP0YCiu4iJRSZqwso0vMH66fp7hv/84IaBakqtBCgyaTdqDaBQoqmsZXfyJ8LgAWUB2R+DqOH7ywDRUnj6q/U4CEhdVVzqLXPQwzz7o2fcHM8WCON9pA9DBxKlJQ4J55S4mb7urJZa/fIr7XPbVhfWt4IY6SKSbWtyBlg/Bo7n7g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785149394; c=relaxed/relaxed;
	bh=TXa6iFdMkvlwp3XxdegWSZVS0vNsS7U8uR7PamDNfBc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=opteK/z9VDpODTpqq/r9UaaM0yy+iPK/p9EXsgA9NFF6e+OTcaJQ4Q9mgP4BYhPbqSZCqLrCtpgJBxtWq4ijNUzsCf+MSWV7X/JBcgphnkzydWsXV0ugygY9nffNQOVMoemMZyi9vYkacCIwFGSH7oT2qa5AmYfEelf0oCoXhRUfo1yeJgdJu+PUjVeuqP3tlvgTQMIrb4NgA5Wyy2dLwjIv0SJ/vcGSPiQRu7U5PULDgqfKGRSvQrzCljZTqqQINriI1wi1yd44jRG6mhLCnEmXOOXjdovFDLixW4oq0DYzWnDSH83J73XIjw9FOsq8KAdY+QXmN2o91NeIbzK+kg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=TVtbDHEq; dkim-atps=neutral; spf=pass (client-ip=54.254.200.128; helo=smtpbgsg2.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=TVtbDHEq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=54.254.200.128; helo=smtpbgsg2.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
Received: from smtpbgsg2.qq.com (smtpbgsg2.qq.com [54.254.200.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7wN13nsyz2yhY
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 20:49:53 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785149382;
	bh=TXa6iFdMkvlwp3XxdegWSZVS0vNsS7U8uR7PamDNfBc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=TVtbDHEqcXX6w0JtHjMM3ot4nQCEvwcy/8DMP/zjLmz8gwQYtBBJ7lHrUrRMx5cB/
	 r2bcrCEBcdqzQUadf8LEEVXgWAc5XoPxTb9CeoQ4KV1oKsHbMUL+EotuQapTEsWkGZ
	 /QRM941EBjpY7pjerq+gj9yc/P8DlrVOUL+QubNA=
X-QQ-mid: zesmtpip2t1785148958t77f18cea
X-QQ-Originating-IP: DKnJpBwcQH+bUEQJ3OJTc88fsyuu7uMlWVo5/kgJZf4=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Jul 2026 18:42:36 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 13927317821740604240
EX-QQ-RecipientCnt: 21
From: Gou Hao <gouhao@uniontech.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	namcao@linutronix.de,
	peterz@infradead.org,
	sshegde@linux.ibm.com,
	kees@kernel.org,
	lgs201920130244@gmail.com,
	srikar@linux.ibm.com,
	ynorov@nvidia.com,
	nilay@linux.ibm.com,
	clg@kaod.org,
	benh@kernel.crashing.org,
	miltonm@bga.com,
	mkchauras@gmail.com,
	akpm@linux-foundation.org
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	gouhaojake@163.com,
	kernel@uniontech.com
Subject: [PATCH v3 4/5] powerpc/xive: defer setting cause_ipi until IPI init succeeds
Date: Mon, 27 Jul 2026 18:42:14 +0800
Message-Id: <20260727104215.184786-5-gouhao@uniontech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260727104215.184786-1-gouhao@uniontech.com>
References: <20260727104215.184786-1-gouhao@uniontech.com>
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
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: MQ+wLuVvI2LQeaTiZ+mMYcU+M/usnWj7t5FSioKdvCzdQX2kADSz8s3+
	sd98UFbjRUFX+G7bg6GukdVGW/ZmwJu6tywErrXx9bnc6j3zaLfk7SNj93HY2Vff9akV00+
	y5MoQix+y1ejSaQglEAyisH2Hd08bbt//cuDKJ7L3rvIuHQ7ylHmiizhr2JBnIQdmUU5MAB
	mILsGyzK+wFmIrCIWGjuP1BpaC53T268lhzN5X0QyToUv315RWgLkB5TGQPhpcVE8vrpekJ
	lfhuSbytIqJkxQMKxAK9ytqJbIZPJr0EEdJUKvO95KrpiDM36yIc1qrQatgaRE+PBwCi9qC
	rpyQyr3zuA640UWyEwSLGlMPrQYaYFo9Ml0c0zVrB2tkkyt7NiZKNQf3ZJFKhoTVBqD+LAk
	VIoscLR3ow6BGcWOE8NVoOQ8CsaXfv1NXkABMXm8+9gjLwXKmBrqryonSciU/FKmt+FFTUQ
	3KuklKWyxGYW13T3J0sYMO57xMqWLOEhc+sKR9utZoo4LXXNzskJS7AeBTboRerUqS4RHSX
	k7PtvhjcI29qapcvPqB7lfzaGwZE0rt554eiarXjAlxCd/ni+M9MB0lQi1bPMybCypY3bXM
	am64aCLNBi+3jDUq5H+KNh835UjZkVEmP87Ah0hum1hGAxkJvnrKLuvY35CwxE3fTWHgZdw
	z1wQeZvtKbzAlI9bhAB1OIcLM1w7na2yzcZp39VJfpjRrbTQH5SCE8ZUWwzRZ/dLm+cwXTL
	VOk7oH93obdVphtHj82NkAualeR/0EzJkisjjFCFxYNRk037pepRxRui80E7vxV1XJ5pGvX
	O4SZ9UOyCGXjkZ1F5pMESVnHEjH4FzkeF0W6+j48htfGXZdU+FCHf6INYsXxDfWh5UJuHBX
	2sl/2UclIz/Om/pNOgs5cD30xTWAxMkCRJqj8SO6HvjZvobr25RDcOcmftQGyyHt2odPhed
	aLjgHw30uCzQ2YrhA55bUdj/YjhGIbj5xgaa/8jkjwOogIYu82Cdv5abMLoZQ0t2DLbdNA6
	sAIRsHg8W2R+m4gl6gafrjUYC0hrOTMFp9WHi6MESUR/0M5CJ7
X-QQ-XMRINFO: OD9hHCdaPRBwH5bRRRw8tsiH4UAatJqXfg==
X-QQ-RECHKSPAM: 0

xive_smp_probe() currently assigns smp_ops->cause_ipi = xive_cause_ipi
before calling xive_init_ipis() and xive_setup_cpu_ipi().  If either
call fails, the platform probe handler returns early but cause_ipi
remains pointing to xive_cause_ipi -- which accesses per-cpu IPI data
(xc->ipi_data) that was never properly initialized, leading to
a WARN and a crash.

Move the cause_ipi assignment to after both calls succeed, so that
smp_ops->cause_ipi is only set when the IPI subsystem is fully
initialized.

Signed-off-by: Gou Hao <gouhao@uniontech.com>
Suggested-by: Cédric Le Goater <clg@kaod.org>
Reviewed-by: jiazhenyuan <jiazhenyuan@uniontech.com>
---
 arch/powerpc/sysdev/xive/common.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index bbe7c85274ea..8ae088632337 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1269,15 +1269,19 @@ int __init xive_smp_probe(void)
 {
 	int ret;
 
-	smp_ops->cause_ipi = xive_cause_ipi;
-
 	/* Register the IPI */
 	ret = xive_init_ipis();
 	if (ret < 0)
 		return ret;
 
 	/* Allocate and setup IPI for the boot CPU */
-	return xive_setup_cpu_ipi(smp_processor_id());
+	ret = xive_setup_cpu_ipi(smp_processor_id());
+	if (ret < 0)
+		return ret;
+
+	smp_ops->cause_ipi = xive_cause_ipi;
+
+	return 0;
 }
 
 #endif /* CONFIG_SMP */
-- 
2.20.1


