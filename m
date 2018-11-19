Return-Path: <SRS0=K8Qv=N6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1578C43441
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 21:12:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C93C20851
	for <linuxppc-dev@archiver.kernel.org>; Mon, 19 Nov 2018 21:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C93C20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42zM4D1GDHzF3Tf
	for <linuxppc-dev@archiver.kernel.org>; Tue, 20 Nov 2018 08:12:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=altlinux.org
 (client-ip=194.107.17.57; helo=vmicros1.altlinux.org;
 envelope-from=ldv@altlinux.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=altlinux.org
X-Greylist: delayed 556 seconds by postgrey-1.36 at bilbo;
 Tue, 20 Nov 2018 08:11:02 AEDT
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 42zM2G4LBczF3C0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Nov 2018 08:11:02 +1100 (AEDT)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
 by vmicros1.altlinux.org (Postfix) with ESMTP id A348372CA5E;
 Tue, 20 Nov 2018 00:01:39 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
 id 956EB7CD1FF; Tue, 20 Nov 2018 00:01:39 +0300 (MSK)
Date: Tue, 20 Nov 2018 00:01:39 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3] powerpc/ptrace: replace ptrace_report_syscall() with a
 tracehook call
Message-ID: <20181119210139.GA8360@altlinux.org>
References: <20181116121701.14359da0@akathisia>
 <87ftw12nyn.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftw12nyn.fsf@concordia.ellerman.id.au>
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
Cc: linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 Eugene Syromyatnikov <esyr@redhat.com>,
 Elvira Khabirova <lineprinter@altlinux.org>, Andy Lutomirski <luto@kernel.org>,
 Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

From: Elvira Khabirova <lineprinter@altlinux.org>

Arch code should use tracehook_*() helpers as documented
in include/linux/tracehook.h,
ptrace_report_syscall() is not expected to be used outside that file.

Co-authored-by: Dmitry V. Levin <ldv@altlinux.org>
Fixes: 5521eb4bca2d ("powerpc/ptrace: Add support for PTRACE_SYSEMU")
Signed-off-by: Elvira Khabirova <lineprinter@altlinux.org>
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

v3: add a descriptive comment
v2: explicitly ignore tracehook_report_syscall_entry() return code

 arch/powerpc/kernel/ptrace.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index afb819f4ca68..e84220d91bbd 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -3266,7 +3266,12 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 	user_exit();
 
 	if (test_thread_flag(TIF_SYSCALL_EMU)) {
-		ptrace_report_syscall(regs);
+		/*
+		 * A nonzero return code from tracehook_report_syscall_entry()
+		 * tells us to prevent the syscall execution, but we are not
+		 * going to execute it anyway.
+		 */
+		(void) tracehook_report_syscall_entry(regs);
 		/*
 		 * Returning -1 will skip the syscall execution. We want to
 		 * avoid clobbering any register also, thus, not 'gotoing'
-- 
ldv
