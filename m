Return-Path: <linuxppc-dev+bounces-21551-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FEBCD5BDE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 May 2026 03:27:11 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gQFRL52Thz2yTH;
	Wed, 27 May 2026 13:27:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=202.36.163.20
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779852430;
	cv=none; b=OI1eAUpWD3zmCOweXarj25xB8k+sYO97jFzFUkFAtdFF/D9dpvufsq0KW5QwqAoYocZuoyWm9VthakYvQOWqsnRTHNFgShbhZIlrU/e/0P2F9cCJZVrL4EsBL7I33l5b/KxoRPYo+EMWg0dTl4DFxmHw3cr4M1S7KhWKdBvYBpLpk0elSzQWQvuerAZ9a2RpLb48BYSKh2Z8D+hoHADPb9YTqCktsiKx8pt7FRJD691oWijs1QdciS0V/fFFw2R3PtTn4kDGl9d36h2SUAAMexLlFCRcxMEKDJXKAy6f3tq6wxN0fezkZ3+GSQj8w+VHmAiA4gyoCEf0hFsoFbTQTw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779852430; c=relaxed/relaxed;
	bh=MhqdYPGYS8b9T6wCn1CL5QB2FD4/fXd6hMuIvJxe5qo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ky+RaFi+8oeKAREfBzaBDAfoAlXUiydc242yZ2PwUKTHfx0QweDpPa1WWeF5+9tqcpiB3OL/pwFVld6DaZ9R6Cfi+Mxs66EVoQGRCxfOUsWVIYb3R61M+oz6BngyfhsP7C2WPaSYsJTMdhgvK5oek81ieJOK/85KD6t+UOrDseoT5A+4cr6BQEdwyngU23jY7gxqZhiq2mE8sdN2N15JShbKpBjmUTt2nR4mJCFoGtHGtKJPUp3rNKlxVxbIwmXXR5KDF8zzK2AGcsMOAPxb+zUxt579tpoOvL5U39fTqIaI39AnswrmZn7kDCOSeyF38dlNEIlaaXjDwAkubaSypg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz; dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=jDR2hL2b; dkim-atps=neutral; spf=pass (client-ip=202.36.163.20; helo=gate2.alliedtelesis.co.nz; envelope-from=markto@alliedtelesis.co.nz; receiver=lists.ozlabs.org) smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=jDR2hL2b;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alliedtelesis.co.nz (client-ip=202.36.163.20; helo=gate2.alliedtelesis.co.nz; envelope-from=markto@alliedtelesis.co.nz; receiver=lists.ozlabs.org)
X-Greylist: delayed 557 seconds by postgrey-1.37 at boromir; Wed, 27 May 2026 13:27:09 AEST
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gQFRK411kz2xtC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 May 2026 13:27:09 +1000 (AEST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id B06C62C0241;
	Wed, 27 May 2026 15:17:50 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1779851870;
	bh=MhqdYPGYS8b9T6wCn1CL5QB2FD4/fXd6hMuIvJxe5qo=;
	h=From:To:Cc:Subject:Date:From;
	b=jDR2hL2b6IPUT76zUF8c7vcuXB80GEa9ESKD6VJlhSmObMLBrXMI+Elk3ZJU6nEIV
	 reshOZlUXO92+UMoHYb2s5FyRhvMEUtw5AdLTHPMxWlO1yGthBejQ4dErdrS9+X1RM
	 yddwlkeDkfDUR0qURDb+h2NdW8gLCUd2JKN5VO9wj5HKafR+REGdY2V9RiaY/U0GsH
	 Qr2W/RzUHg7yOAn7OY1onkW+amOn0NCAetKiiv7sd3wPCdFVxQX2ifW3IY/GzmYnYZ
	 51MZdT1PWL4WApjGVvIoZCR/5o1FHLyJgfkD73f98cM42ILKL2IS6O6xIEO9fUz33q
	 vuIk8tgsOPKuQ==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6a16625e0000>; Wed, 27 May 2026 15:17:50 +1200
Received: from markto-dl.ws.atlnz.lc (markto-dl.ws.atlnz.lc [10.33.23.30])
	by pat.atlnz.lc (Postfix) with ESMTP id 829D713EDE9;
	Wed, 27 May 2026 15:17:50 +1200 (NZST)
Received: by markto-dl.ws.atlnz.lc (Postfix, from userid 1155)
	id 7B6F3406AE; Wed, 27 May 2026 15:17:50 +1200 (NZST)
From: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
To: Madhavan Srinivasan <maddy@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
Subject: [PATCH] smp: prevent soft lockup in smp_call_function_many_cond
Date: Wed, 27 May 2026 15:16:18 +1200
Message-ID: <20260527031618.2940365-1-mark.tomlinson@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.54.0
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
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=Es1xrjcA c=1 sm=1 tr=0 ts=6a16625e a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=NGcC8JguVDcA:10 a=2LgRR1xebQ5gNK1IvtAA:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

Using the PowerPC P2040 (e500mc) CPU, soft lockups can occasionally be
seen in smp_call_function_many_cond(). The conclusion is that this CPU
does not process the doorbell interrupt while in a data-storage (MMU)
exception. If more than one CPU in a multi core environment is calling
this function at the same time, it is possible for a deadlock to occur.

The fix for this is to call flush_smp_call_function_queue() before
waiting for responses from other CPUs. If there is something in the
queue, this is a good time to process it before busy-waiting on other
CPUs. On other architectures this call will quickly do nothing, as the
queue will be empty.

Signed-off-by: Mark Tomlinson <mark.tomlinson@alliedtelesis.co.nz>
---
 kernel/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/smp.c b/kernel/smp.c
index a0bb56bd8dda..3c4467654ab0 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -884,6 +884,8 @@ static void smp_call_function_many_cond(const struct =
cpumask *mask,
 		local_irq_restore(flags);
 	}
=20
+	flush_smp_call_function_queue();
+
 	if (run_remote && wait) {
 		for_each_cpu(cpu, cfd->cpumask) {
 			call_single_data_t *csd;
--=20
2.54.0


