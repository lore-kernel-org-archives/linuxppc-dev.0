Return-Path: <SRS0=nZGU=SK=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F5BC10F13
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 17:44:00 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD2E620879
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Apr 2019 17:43:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD2E620879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44dHpk0hfJzDqC4
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2019 03:43:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=altlinux.org
 (client-ip=194.107.17.57; helo=vmicros1.altlinux.org;
 envelope-from=ldv@altlinux.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=altlinux.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
 by lists.ozlabs.org (Postfix) with ESMTP id 44dHmp0fYZzDqHn
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2019 03:42:17 +1000 (AEST)
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
 by vmicros1.altlinux.org (Postfix) with ESMTP id 4614872CCAC;
 Mon,  8 Apr 2019 20:42:16 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
 id 374737CCE4F; Mon,  8 Apr 2019 20:42:16 +0300 (MSK)
Date: Mon, 8 Apr 2019 20:42:16 +0300
From: "Dmitry V. Levin" <ldv@altlinux.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: [PATCH linux-next v9 5/7] powerpc: define syscall_get_error()
Message-ID: <20190408174216.GF11889@altlinux.org>
References: <20190408174036.GA11889@altlinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190408174036.GA11889@altlinux.org>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Eugene Syromyatnikov <esyr@redhat.com>, Oleg Nesterov <oleg@redhat.com>,
 Elvira Khabirova <lineprinter@altlinux.org>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

syscall_get_error() is required to be implemented on this
architecture in addition to already implemented syscall_get_nr(),
syscall_get_arguments(), syscall_get_return_value(), and
syscall_get_arch() functions in order to extend the generic
ptrace API with PTRACE_GET_SYSCALL_INFO request.

Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Elvira Khabirova <lineprinter@altlinux.org>
Cc: Eugene Syromyatnikov <esyr@redhat.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
---

Michael, this patch is waiting for ACK since early December.

Notes:
    v9: unchanged
    v8: unchanged
    v7: unchanged
    v6: unchanged
    v5: initial revision
    
    This change has been tested with
    tools/testing/selftests/ptrace/get_syscall_info.c and strace,
    so it's correct from PTRACE_GET_SYSCALL_INFO point of view.
    
    This cast doubts on commit v4.3-rc1~86^2~81 that changed
    syscall_set_return_value() in a way that doesn't quite match
    syscall_get_error(), but syscall_set_return_value() is out
    of scope of this series, so I'll just let you know my concerns.

 arch/powerpc/include/asm/syscall.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index a048fed0722f..bd9663137d57 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -38,6 +38,16 @@ static inline void syscall_rollback(struct task_struct *task,
 	regs->gpr[3] = regs->orig_gpr3;
 }
 
+static inline long syscall_get_error(struct task_struct *task,
+				     struct pt_regs *regs)
+{
+	/*
+	 * If the system call failed,
+	 * regs->gpr[3] contains a positive ERRORCODE.
+	 */
+	return (regs->ccr & 0x10000000UL) ? -regs->gpr[3] : 0;
+}
+
 static inline long syscall_get_return_value(struct task_struct *task,
 					    struct pt_regs *regs)
 {
-- 
ldv
