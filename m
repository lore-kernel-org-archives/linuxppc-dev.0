Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89E65C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 18:35:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07AC320657
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 18:35:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="nsxeekbQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07AC320657
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TxWR6dTMzDqSt
	for <linuxppc-dev@archiver.kernel.org>; Thu, 28 Mar 2019 05:35:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=kernel.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=sashal@kernel.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="nsxeekbQ"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44Twwh67k0zDqR6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Mar 2019 05:08:36 +1100 (AEDT)
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 7BF812183F;
 Wed, 27 Mar 2019 18:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553710114;
 bh=wiBNtt7w3Hcq7fxB52lMT81otl/nnJhqu4dHJTQJCSA=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=nsxeekbQdryYNBtZp031yBL48SFlDrlP7ncJND6Z9H3dwI/rjIA1NtmtYxLC4KFtZ
 ctoD3wHISodPlD65RgZUM7VXsOxNHh4mnhdbxxcJEdoIqU6I7X011SZueHAU4DB7xF
 0LlEyXCCeEs3glkGqqyf3jfkYvIpKEhoc0Q0G7ew=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.0 202/262] powerpc/64s: Clear on-stack exception
 marker upon exception return
Date: Wed, 27 Mar 2019 14:00:57 -0400
Message-Id: <20190327180158.10245-202-sashal@kernel.org>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190327180158.10245-1-sashal@kernel.org>
References: <20190327180158.10245-1-sashal@kernel.org>
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
Cc: Sasha Levin <sashal@kernel.org>, Joe Lawrence <joe.lawrence@redhat.com>,
 linuxppc-dev@lists.ozlabs.org, Nicolai Stange <nstange@suse.de>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Nicolai Stange <nstange@suse.de>

[ Upstream commit eddd0b332304d554ad6243942f87c2fcea98c56b ]

The ppc64 specific implementation of the reliable stacktracer,
save_stack_trace_tsk_reliable(), bails out and reports an "unreliable
trace" whenever it finds an exception frame on the stack. Stack frames
are classified as exception frames if the STACK_FRAME_REGS_MARKER
magic, as written by exception prologues, is found at a particular
location.

However, as observed by Joe Lawrence, it is possible in practice that
non-exception stack frames can alias with prior exception frames and
thus, that the reliable stacktracer can find a stale
STACK_FRAME_REGS_MARKER on the stack. It in turn falsely reports an
unreliable stacktrace and blocks any live patching transition to
finish. Said condition lasts until the stack frame is
overwritten/initialized by function call or other means.

In principle, we could mitigate this by making the exception frame
classification condition in save_stack_trace_tsk_reliable() stronger:
in addition to testing for STACK_FRAME_REGS_MARKER, we could also take
into account that for all exceptions executing on the kernel stack
  - their stack frames's backlink pointers always match what is saved
    in their pt_regs instance's ->gpr[1] slot and that
  - their exception frame size equals STACK_INT_FRAME_SIZE, a value
    uncommonly large for non-exception frames.

However, while these are currently true, relying on them would make
the reliable stacktrace implementation more sensitive towards future
changes in the exception entry code. Note that false negatives, i.e.
not detecting exception frames, would silently break the live patching
consistency model.

Furthermore, certain other places (diagnostic stacktraces, perf, xmon)
rely on STACK_FRAME_REGS_MARKER as well.

Make the exception exit code clear the on-stack
STACK_FRAME_REGS_MARKER for those exceptions running on the "normal"
kernel stack and returning to kernelspace: because the topmost frame
is ignored by the reliable stack tracer anyway, returns to userspace
don't need to take care of clearing the marker.

Furthermore, as I don't have the ability to test this on Book 3E or 32
bits, limit the change to Book 3S and 64 bits.

Fixes: df78d3f61480 ("powerpc/livepatch: Implement reliable stack tracing for the consistency model")
Reported-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Nicolai Stange <nstange@suse.de>
Signed-off-by: Joe Lawrence <joe.lawrence@redhat.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kernel/entry_64.S | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 435927f549c4..a2c168b395d2 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -1002,6 +1002,13 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	ld	r2,_NIP(r1)
 	mtspr	SPRN_SRR0,r2
 
+	/*
+	 * Leaving a stale exception_marker on the stack can confuse
+	 * the reliable stack unwinder later on. Clear it.
+	 */
+	li	r2,0
+	std	r2,STACK_FRAME_OVERHEAD-16(r1)
+
 	ld	r0,GPR0(r1)
 	ld	r2,GPR2(r1)
 	ld	r3,GPR3(r1)
-- 
2.19.1

