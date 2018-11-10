Return-Path: <SRS0=qVND=NW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACB00C43441
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Nov 2018 11:03:58 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EDF8C20862
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Nov 2018 11:03:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EDF8C20862
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42t9xR5SFTzF3YD
	for <linuxppc-dev@archiver.kernel.org>; Sun, 11 Nov 2018 22:03:55 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=altlinux.org
 (client-ip=194.107.17.39; helo=air.basealt.ru;
 envelope-from=lineprinter@altlinux.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=altlinux.org
X-Greylist: delayed 475 seconds by postgrey-1.36 at bilbo;
 Sat, 10 Nov 2018 14:28:51 AEDT
Received: from air.basealt.ru (air.basealt.ru [194.107.17.39])
 by lists.ozlabs.org (Postfix) with ESMTP id 42sMtq183vzF3gW
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 10 Nov 2018 14:28:51 +1100 (AEDT)
Received: by air.basealt.ru (Postfix, from userid 490)
 id 357AF589A99; Sat, 10 Nov 2018 03:20:45 +0000 (UTC)
Received: from akathisia (ip4-83-240-49-150.cust.nbox.cz [83.240.49.150])
 by air.basealt.ru (Postfix) with ESMTPSA id 23AB2589A97;
 Sat, 10 Nov 2018 03:20:42 +0000 (UTC)
Date: Sat, 10 Nov 2018 04:20:40 +0100
From: Elvira Khabirova <lineprinter@altlinux.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Subject: [PATCH] powerpc/ptrace: replace ptrace_report_syscall() with a
 tracehook call
Message-ID: <20181110042040.68ed3ac8@akathisia>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Sun, 11 Nov 2018 22:02:05 +1100
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
Cc: linux-kernel@vger.kernel.org, ldv@altlinux.org, luto@kernel.org,
 oleg@redhat.com, leitao@debian.org, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Arch code should use tracehook_*() helpers, as documented
in include/linux/tracehook.h.

Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
---
 arch/powerpc/kernel/ptrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index afb819f4ca68..f73f8ea402e9 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3266,7 +3266,7 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 	user_exit();
 
 	if (test_thread_flag(TIF_SYSCALL_EMU)) {
-		ptrace_report_syscall(regs);
+		tracehook_report_syscall_entry(regs);
 		/*
 		 * Returning -1 will skip the syscall execution. We want to
 		 * avoid clobbering any register also, thus, not 'gotoing'
-- 
2.19.1

