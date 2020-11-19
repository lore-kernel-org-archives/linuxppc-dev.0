Return-Path: <SRS0=HG9l=EZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61E05C56201
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2020 21:12:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8F7C122255
	for <linuxppc-dev@archiver.kernel.org>; Thu, 19 Nov 2020 21:12:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F7C122255
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=csgroup.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CcXSk515tzDqD7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Nov 2020 08:12:38 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=csgroup.eu (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@csgroup.eu; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=csgroup.eu
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CcXMB0M8dzDqYY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2020 08:07:47 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4CcXM14zGlz9v4nj;
 Thu, 19 Nov 2020 22:07:41 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id F-4BTdxGLIpJ; Thu, 19 Nov 2020 22:07:41 +0100 (CET)
Received: from vm-hermes.si.c-s.fr (vm-hermes.si.c-s.fr [192.168.25.253])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4CcXM13sgdz9v4nh;
 Thu, 19 Nov 2020 22:07:41 +0100 (CET)
Received: by vm-hermes.si.c-s.fr (Postfix, from userid 33)
 id 5D1733AF; Thu, 19 Nov 2020 22:10:33 +0100 (CET)
Received: from 192.168.4.90 ([192.168.4.90]) by messagerie.c-s.fr (Horde
 Framework) with HTTP; Thu, 19 Nov 2020 22:10:33 +0100
Date: Thu, 19 Nov 2020 22:10:33 +0100
Message-ID: <20201119221033.Horde.be-msjDTeIW4XeXARjUu7g1@messagerie.c-s.fr>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
To: Oleg Nesterov <oleg@redhat.com>
Subject: Re: [PATCH v3 2/2] powerpc/ptrace: Hard wire PT_SOFTE value to 1 in
 gpr_get() too
References: <20201119160154.GA5183@redhat.com>
 <20201119160247.GB5188@redhat.com>
In-Reply-To: <20201119160247.GB5188@redhat.com>
User-Agent: Internet Messaging Program (IMP) H5 (6.2.3)
Content-Type: text/plain; charset=UTF-8; format=flowed; DelSp=Yes
MIME-Version: 1.0
Content-Disposition: inline
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
Cc: Christophe Leroy <christophe.leroy@c-s.fr>,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Nicholas Piggin <npiggin@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Al Viro <viro@zeniv.linux.org.uk>, "Aneesh
 Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Jan Kratochvil <jan.kratochvil@redhat.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


Quoting Oleg Nesterov <oleg@redhat.com>:

> The commit a8a4b03ab95f ("powerpc: Hard wire PT_SOFTE value to 1 in
> ptrace & signals") changed ptrace_get_reg(PT_SOFTE) to report 0x1,
> but PTRACE_GETREGS still copies pt_regs->softe as is.
>
> This is not consistent and this breaks the user-regs-peekpoke test
> from https://sourceware.org/systemtap/wiki/utrace/tests/
>
> Reported-by: Jan Kratochvil <jan.kratochvil@redhat.com>
> Signed-off-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  arch/powerpc/kernel/ptrace/ptrace-tm.c   | 8 +++++++-
>  arch/powerpc/kernel/ptrace/ptrace-view.c | 8 +++++++-
>  2 files changed, 14 insertions(+), 2 deletions(-)
>

I think the following should work, and not require the first patch  
(compile tested only).

diff --git a/arch/powerpc/kernel/ptrace/ptrace-tm.c  
b/arch/powerpc/kernel/ptrace/ptrace-tm.c
index 54f2d076206f..f779b3bc0279 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-tm.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-tm.c
@@ -104,8 +104,14 @@ int tm_cgpr_get(struct task_struct *target, const  
struct user_regset *regset,
  		     offsetof(struct pt_regs, msr) + sizeof(long));

  	membuf_write(&to, &target->thread.ckpt_regs.orig_gpr3,
-			sizeof(struct user_pt_regs) -
-			offsetof(struct pt_regs, orig_gpr3));
+		     offsetof(struct pt_regs, softe) - offsetof(struct pt_regs,  
orig_gpr3));
+	membuf_store(&to, 1UL);
+
+	BUILD_BUG_ON(offsetof(struct pt_regs, trap) !=
+		     offsetof(struct pt_regs, softe) + sizeof(long));
+
+	membuf_write(&to, &target->thread.ckpt_regs.trap,
+		     sizeof(struct user_pt_regs) - offsetof(struct pt_regs, trap));
  	return membuf_zero(&to, ELF_NGREG * sizeof(unsigned long) -
  			sizeof(struct user_pt_regs));
  }
diff --git a/arch/powerpc/kernel/ptrace/ptrace-view.c  
b/arch/powerpc/kernel/ptrace/ptrace-view.c
index 7e6478e7ed07..736bfbf33890 100644
--- a/arch/powerpc/kernel/ptrace/ptrace-view.c
+++ b/arch/powerpc/kernel/ptrace/ptrace-view.c
@@ -234,9 +234,21 @@ static int gpr_get(struct task_struct *target,  
const struct user_regset *regset,
  	BUILD_BUG_ON(offsetof(struct pt_regs, orig_gpr3) !=
  		     offsetof(struct pt_regs, msr) + sizeof(long));

+#ifdef CONFIG_PPC64
+	membuf_write(&to, &target->thread.regs->orig_gpr3,
+		     offsetof(struct pt_regs, softe) - offsetof(struct pt_regs,  
orig_gpr3));
+	membuf_store(&to, 1UL);
+
+	BUILD_BUG_ON(offsetof(struct pt_regs, trap) !=
+		     offsetof(struct pt_regs, softe) + sizeof(long));
+
+	membuf_write(&to, &target->thread.regs->trap,
+		     sizeof(struct user_pt_regs) - offsetof(struct pt_regs, trap));
+#else
  	membuf_write(&to, &target->thread.regs->orig_gpr3,
  			sizeof(struct user_pt_regs) -
  			offsetof(struct pt_regs, orig_gpr3));
+#endif
  	return membuf_zero(&to, ELF_NGREG * sizeof(unsigned long) -
  				 sizeof(struct user_pt_regs));
  }
---
Christophe
