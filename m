Return-Path: <SRS0=hsDs=PQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A746C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 19:54:03 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D559B206BB
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Jan 2019 19:54:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="D1jbdf3+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D559B206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43Z2yJ5GkPzDqJh
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Jan 2019 06:54:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="D1jbdf3+"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43Z2Rg42G6zDqXM
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Jan 2019 06:30:55 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DF88A20645;
 Tue,  8 Jan 2019 19:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1546975853;
 bh=AOKM9aP3K91DApiEOhrPC6XBXVCx80u9YSho/Ff4azY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=D1jbdf3+TcW8+oMJ1PljiguP+NJa4Ksm5NfskJMYASeTQlgTu0i/9KCuHzP2fGZ1F
 whpgOPtXy0AHQNA8tt1yMe14LNAWxmZ8Lf3jHyz61JkdOCEsuFZuI+lfKrGuynalY/
 NcZxvkTVEH8H1XNV1wnyF2sfwaxZHOBQcGApe8PU=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 4.19 38/97] powerpc/pseries/cpuidle: Fix preempt
 warning
Date: Tue,  8 Jan 2019 14:28:47 -0500
Message-Id: <20190108192949.122407-38-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190108192949.122407-1-sashal@kernel.org>
References: <20190108192949.122407-1-sashal@kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: Ignore
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
Cc: Breno Leitao <leitao@debian.org>, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Sasha Levin <sashal@kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Breno Leitao <leitao@debian.org>

[ Upstream commit 2b038cbc5fcf12a7ee1cc9bfd5da1e46dacdee87 ]

When booting a pseries kernel with PREEMPT enabled, it dumps the
following warning:

   BUG: using smp_processor_id() in preemptible [00000000] code: swapper/0/1
   caller is pseries_processor_idle_init+0x5c/0x22c
   CPU: 13 PID: 1 Comm: swapper/0 Not tainted 4.20.0-rc3-00090-g12201a0128bc-dirty #828
   Call Trace:
   [c000000429437ab0] [c0000000009c8878] dump_stack+0xec/0x164 (unreliable)
   [c000000429437b00] [c0000000005f2f24] check_preemption_disabled+0x154/0x160
   [c000000429437b90] [c000000000cab8e8] pseries_processor_idle_init+0x5c/0x22c
   [c000000429437c10] [c000000000010ed4] do_one_initcall+0x64/0x300
   [c000000429437ce0] [c000000000c54500] kernel_init_freeable+0x3f0/0x500
   [c000000429437db0] [c0000000000112dc] kernel_init+0x2c/0x160
   [c000000429437e20] [c00000000000c1d0] ret_from_kernel_thread+0x5c/0x6c

This happens because the code calls get_lppaca() which calls
get_paca() and it checks if preemption is disabled through
check_preemption_disabled().

Preemption should be disabled because the per CPU variable may make no
sense if there is a preemption (and a CPU switch) after it reads the
per CPU data and when it is used.

In this device driver specifically, it is not a problem, because this
code just needs to have access to one lppaca struct, and it does not
matter if it is the current per CPU lppaca struct or not (i.e. when
there is a preemption and a CPU migration).

That said, the most appropriate fix seems to be related to avoiding
the debug_smp_processor_id() call at get_paca(), instead of calling
preempt_disable() before get_paca().

Signed-off-by: Breno Leitao <leitao@debian.org>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/cpuidle/cpuidle-pseries.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 9e56bc411061..74c247972bb3 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -247,7 +247,13 @@ static int pseries_idle_probe(void)
 		return -ENODEV;
 
 	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
-		if (lppaca_shared_proc(get_lppaca())) {
+		/*
+		 * Use local_paca instead of get_lppaca() since
+		 * preemption is not disabled, and it is not required in
+		 * fact, since lppaca_ptr does not need to be the value
+		 * associated to the current CPU, it can be from any CPU.
+		 */
+		if (lppaca_shared_proc(local_paca->lppaca_ptr)) {
 			cpuidle_state_table = shared_states;
 			max_idle_state = ARRAY_SIZE(shared_states);
 		} else {
-- 
2.19.1

