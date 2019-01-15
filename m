Return-Path: <SRS0=xHiI=PX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19B17C43387
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 06:40:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1EDE20656
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 06:40:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1EDE20656
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43f11S0K9yzDqdg
	for <linuxppc-dev@archiver.kernel.org>; Tue, 15 Jan 2019 17:40:28 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43f0yC52M4zDqdc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jan 2019 17:37:39 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43f0yC4KTGz9s3q; Tue, 15 Jan 2019 17:37:39 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43f0yC3mxMz9sBQ; Tue, 15 Jan 2019 17:37:39 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/64: Make sys_switch_endian() traceable
Date: Tue, 15 Jan 2019 17:37:36 +1100
Message-Id: <20190115063736.3679-1-mpe@ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

We weren't using SYSCALL_DEFINE for sys_switch_endian(), which means
it wasn't able to be traced by CONFIG_FTRACE_SYSCALLS.

By using the macro we create the right metadata and the syscall is
visible. eg:

  # cd /sys/kernel/debug/tracing
  # echo 1 | tee events/syscalls/sys_*_switch_endian/enable
  # ~/switch_endian_test
  # cat trace
  ...
  switch_endian_t-3604  [009] ....   315.175164: sys_switch_endian()
  switch_endian_t-3604  [009] ....   315.175167: sys_switch_endian -> 0x5555aaaa5555aaaa
  switch_endian_t-3604  [009] ....   315.175169: sys_switch_endian()
  switch_endian_t-3604  [009] ....   315.175169: sys_switch_endian -> 0x5555aaaa5555aaaa

Fixes: 529d235a0e19 ("powerpc: Add a proper syscall for switching endianness")
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/syscalls.c b/arch/powerpc/kernel/syscalls.c
index e6982ab21816..e52a8878c2fb 100644
--- a/arch/powerpc/kernel/syscalls.c
+++ b/arch/powerpc/kernel/syscalls.c
@@ -123,7 +123,7 @@ long ppc_fadvise64_64(int fd, int advice, u32 offset_high, u32 offset_low,
 				 (u64)len_high << 32 | len_low, advice);
 }
 
-long sys_switch_endian(void)
+SYSCALL_DEFINE0(switch_endian)
 {
 	struct thread_info *ti;
 
-- 
2.20.1

