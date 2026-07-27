Return-Path: <linuxppc-dev+bounces-24879-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C839FC53219
	for <linuxppc-dev@archiver.kernel.org>; Mon, 27 Jul 2026 10:43:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4h7wDx4RgWz2yj1;
	Mon, 27 Jul 2026 20:43:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=54.206.16.166
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785149025;
	cv=none; b=ooh1KoWMxBcBKnfBcOBMJrD+DxPf+W3DmMUbhaoNhskIACKeDkypwsT1Uot8mB75jdlEfU4ojXHKw40wtDMgNQo0nWLyT2IeLW0A+ncA2bQsJT/b2lvHtAQBZ5BVt8sRxLQNZ4VZYWbXqmFDq8YRwMC33L4OzymT4YxfE04OwkQWFH9TbG6UWbBhqluV7Un4V3uTTMsJ5AfghzH6M0nXde1cyjwyq4uSlorgPZTtY8/0C7CyoN99L4PH5ChWlQIQ1JVY5PO9YR/+JW7219uwZiz65I691y30msLP0T94y4P0ZwDFG/lAQCy4vMAK40vBKt0nnejlXHIKzOXqgZXksQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785149025; c=relaxed/relaxed;
	bh=ls2JxttOX9m/OH0Ji2giU8VW2A62OMMFfToSeR4oAHQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cU+hVDTkX0rPNVHiBE03BU2XchtnC+1VN/JT25wkvSnHFMzbTBEVouoA6bXUB+oz43M1izsArJKC+SuXAjUpLsZOAVUSSpNVY75vtty8GSMmTxWQmfolFhAYjbFRo2K/RoM44l9IxIk64I5URv7xGP0G2TF3KgIjOORadsmvglugDszb6ahsAXQyp5p3+Y6EKLuxwcElWgxb0gs8NXlHRGtTB7RSVsKbNBeWl2L7chekqUWBnwvFx7YY52/2wcHDMJgLkll5uwkhFLhBnZnnrByjkRZrAy1lyrQf2LGiHE0fqtZBKCQOR8hK+7KNeqFuqljl0a9msyzTnbhZ1n7pFA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=R0X/gpQF; dkim-atps=neutral; spf=pass (client-ip=54.206.16.166; helo=smtpbgau1.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org) smtp.mailfrom=uniontech.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=uniontech.com header.i=@uniontech.com header.a=rsa-sha256 header.s=onoh2408 header.b=R0X/gpQF;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=uniontech.com (client-ip=54.206.16.166; helo=smtpbgau1.qq.com; envelope-from=gouhao@uniontech.com; receiver=lists.ozlabs.org)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4h7wDw75f5z2yhb
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jul 2026 20:43:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1785148975;
	bh=ls2JxttOX9m/OH0Ji2giU8VW2A62OMMFfToSeR4oAHQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version;
	b=R0X/gpQF5HrO1GZYnK0NTgZnMWP4rn+8VuAjJGZ6NyISiUnRexpZ3Qwrn1rk4Byew
	 cBQoKj2y8ZWW5cx3I6MgZIjq1h+lAq/2UWyL3uAUnk8vHcz1lxLnJqQNTWHzp5x1kG
	 QTSuv0ULv67bRmoev1FJiphQsFAVPthSAYKa5Vcc=
X-QQ-mid: zesmtpip2t1785148963t9475962f
X-QQ-Originating-IP: ockOe7XHHARhEMveJ2Rfcx2IR/gFdsOpyasST/oAAwA=
Received: from localhost.localdomain ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 27 Jul 2026 18:42:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16030799654733497151
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
Subject: [PATCH v3 5/5] powerpc/smp: add NULL guard for cause_ipi in smp_muxed_ipi_message_pass
Date: Mon, 27 Jul 2026 18:42:15 +0800
Message-Id: <20260727104215.184786-6-gouhao@uniontech.com>
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
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz5b-2
X-QQ-XMAILINFO: MQPu5pFEJFN4oG81pN7JVHui50BiujakWoOdlLfz9aeK7vwFVZDZ6h8m
	vTrYF9H9BrOHEmauDwk5L56ec7IDT1+43oAMlcTc5NUBwHMBdeOUve5UG3ymZhu0lY/4QBD
	lk9k31OJZJSJ7IJjCggognhwD/iq73ELVPaAeH33kI403v+xeo5XQVgM7r10hpZO/i+95+W
	c0tDhFRXOG56fy0DmwU97+XhehnWVzdSeHXFlke5tcQN1XbP9e+Cds5Tx1O0vLAQa9CSgha
	WBuHT9zen4yBFwStbnAoIxH8VqB56JCvEavfu8IHUULR8+34mLN+hIi8WS5VLsZXUUeOe5M
	JUtbvBVTGlVpVVRxfzVD9rSBo6cTRMMxfxEsISIsZfG/oEnFBZEzAWkHckhytpHMnl7IO/T
	u+Arn6qKbwzkGCk7/nGO9yEQlI6Z5lrPzyGMpEQG8q5pWm4VHK+a0NSG+u8CH0ZmEIQjCO/
	OzxF6a1AR8PF6G5mA2SRDcFHRhmIvoeJvrsjoPReia7pjyspCU5j07IndXLfyHIxCNRKQ4z
	KmYZDY6UC1eT63ioW0tgZ+MWQPLF7JdBtHkveJQ3Wt/VvtatHv/vyOsY12TUKGj6cooWBZn
	5MwLQCQydpHVYw1rf3PazyjOFxgKb0D4mIX2Q97r3HtnXRx4iAIBcnV5CBURott0Bo6atIh
	+krUV8BDi6Vz0PVc3y4cISOgDk+8OIekUrN79p8DTro16t7FTyHA2FHjia1NoZOtecssdYM
	8vlCSGfoplvJS2C6IvV2bBS0CQj5M1p+Sg4cpBphlBuNOKYji9/56naNBVwV4+43oAHukxA
	jl95ypLSTSu+U/c1kbgkwgu9y6IYBti0ZzLrE8RIFDikWSYXmMGau6ill8PhAz4YAEWeJxn
	MaPofpXBl6YPpamm7Ef6gllWa1R5obgHsAvqGbzuByv84QM858IlTWGvFFxDxkxNZ17V1dg
	odTPxlNdNT9kezhDjHrIRC8BjX5Wne/BQtPJMOIsZi9TRVFCu5iL/YRimDsZHkU/r1o4cG2
	a2xvBsCuzP7Co1S3owZ45ZqzcN2EZUDxdZiXYeaQ==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
X-QQ-RECHKSPAM: 0

smp_muxed_ipi_message_pass() calls smp_ops->cause_ipi() without
checking whether it has been set.

On platforms using muxed IPI (e.g. powernv/pseries), smp_ops->cause_ipi
is initialized to NULL in the static smp_ops and only assigned during
the platform smp_probe() handler.  If the IPI subsystem fails to
initialize -- for example when xive_init_ipis() fails and
xive_smp_probe() returns an error -- the probe handler returns early
and cause_ipi is never set.  Any subsequent IPI send (e.g.
arch_smp_send_reschedule()) would dereference the NULL pointer.

Add a NULL check to avoid the crash in that situation.

Fixes: 23d72bfd8f9f ("powerpc: Consolidate ipi message mux and demux")
Signed-off-by: Gou Hao <gouhao@uniontech.com>
Reviewed-by: jiazhenyuan <jiazhenyuan@uniontech.com>
---
 arch/powerpc/kernel/smp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 3467f86fd78f..6a5a5469aaae 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -289,6 +289,9 @@ void smp_muxed_ipi_set_message(int cpu, int msg)
 
 void smp_muxed_ipi_message_pass(int cpu, int msg)
 {
+	if (!smp_ops->cause_ipi)
+		return;
+
 	smp_muxed_ipi_set_message(cpu, msg);
 
 	/*
-- 
2.20.1


