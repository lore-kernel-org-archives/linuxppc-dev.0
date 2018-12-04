Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D814C04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 21:32:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FE7D20850
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 21:32:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FE7D20850
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438Znf1kLWzDqXG
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 08:32:06 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=arndb.de
 (client-ip=212.227.126.135; helo=mout.kundenserver.de;
 envelope-from=arnd@arndb.de; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=arndb.de
X-Greylist: delayed 345 seconds by postgrey-1.36 at bilbo;
 Wed, 05 Dec 2018 08:30:00 AEDT
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.135])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438ZlD0bFVzDqSg
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 08:29:59 +1100 (AEDT)
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1N1g3U-1hVr8c2Txw-011z3G; Tue, 04 Dec 2018 22:23:54 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: firoz.khan@linaro.org
Subject: [PATCH] powerpc: split compat syscall table out from native table
Date: Tue,  4 Dec 2018 22:23:07 +0100
Message-Id: <20181204212340.3915309-1-arnd@arndb.de>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <CAK8P3a2SP0eX50NoFKaM2N85mgSejToQkD9ZOE_7V_RT__BCvg@mail.gmail.com>
References: <CAK8P3a2SP0eX50NoFKaM2N85mgSejToQkD9ZOE_7V_RT__BCvg@mail.gmail.com>
X-Provags-ID: V03:K1:ZivU5sOtOGpvDROJTPzC3cFFUPED1oKW1AZPSkRrG/FCNsI6ycM
 jjrNujJjd2p+OwP+pG02TnUfEYAH601nUI6m9yt/MeolUQHcCflniE4TV7DsknVpDSHunLG
 vifhgRA6fUkcl4BnthmsZ3nU8dgUqUsYLviHorZkE5cVSmm897Jp9xzVNZyOHpWdji3Duim
 An7RuQOsAXMwxohY2CtBA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:h90Zwfc29RQ=:Utg+pf9JDg39tN1CNfDzvJ
 kHBea40gGhdEWdogifobxMW7zdxnX9b67b4Z7Gv9DLnAED0JDuHR7Ox4F2AZ4tz6F8spWgzhY
 0/JGRjxYRnzIZ9QbCmK2vB/Tp7xZKKIURDcD8Mx/TRjHD5Zy//i6WLmjNHZZtnh/sF0ayKsST
 CtLElfRAComDvaSoJezHh4ZOP2kad/FCp2o4/OvAAjovMdyXiaQipbOjL65Fz8hJ4ZUDrRcT5
 Sa78PJKV0dFCkqLrt/UAMY/zVXEVbMZXPKO+cBy2TEDV1geUMc0/v6SYfe3g5jVUuTxO23O9N
 9Piva4j51FtjDwQIzq0/CHVfIjLVvVLJrGr6k04B3Kf67jgMQjevqbQEcfYEIfb+dBiQjWZUR
 5fHxv3alVMP9Ozuhp3EpamoZGMC2F7Ko3I88DxYzuhmSyu/hg3tei6TOch9oT6TkqW02BQsuY
 Jh8alF7r4W6kAWHxZYT72XaD3M1pVnYxPolXNHIIOppF+iUfRfHM5jZEz1bz61kFgIn4stzgL
 3jZp3ZVhYwVj6JUVICvVrH82PCirIoET9FENbFiAh8my1r62Bsm1JP9oAPw4wxRbOtckRcm95
 h/U2hqG5XKxU5+s4mWgve4w4o2uJvIjAAV1+6lnlAat58NGeLfOqQygQWuSZXHdX/twTAdYds
 Y6NdTcJtDbKJfbSg7OuKScDwOb9YMzQyhf/UXpF4B6bN0LEdlHb4Z8h+0xP4Gi8sA77zcfx30
 +P5yS26LClP+2kduwJRdSEm0EII1u/wdtqc0eHwENYgw6J12gTAMdWPpyMiMNKDksjEhd+nm6
 XWhHf4l2/ukQjcC2cp9vguMksHrSA9Zi2xawgrEjolNWLeDIzlOdCWyT85USLx0acMgkTj3sf
 jNwGQhXxU5V6jdDLqCEGO758AoU8jjZRsY5lPsPyeq4G2leZAXlPmZm3qQaedV
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
Cc: linux-arch@vger.kernel.org, Madhavan Srinivasan <maddy@linux.vnet.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>, y2038@lists.linaro.org,
 linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@samba.org>, deepa.kernel@gmail.com,
 linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

PowerPC uses a syscall table with native and compat calls interleaved,
which is a slightly simpler way to define two matching tables.

As we move to having the tables generated, that advantage is no longer
important, but the interleaved table gets in the way of using the
same scripts as on the other architectures.

Split out a new compat_sys_call_table symbol that contains all the
compat calls, and leave the main table for the native calls, to more
closely match the method we use everywhere else.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
This is completely untested, it's just for illustration and to
get comments about whether this is a good idea.

Firoz, can you try to get this working?
---
 arch/powerpc/include/asm/syscall.h |  3 +--
 arch/powerpc/kernel/entry_64.S     |  7 ++++--
 arch/powerpc/kernel/systbl.S       | 37 ++++++++++++++++++++++++------
 arch/powerpc/kernel/vdso.c         |  7 ++++--
 4 files changed, 41 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/include/asm/syscall.h b/arch/powerpc/include/asm/syscall.h
index ab9f3f0a8637..1a0e7a8b1c81 100644
--- a/arch/powerpc/include/asm/syscall.h
+++ b/arch/powerpc/include/asm/syscall.h
@@ -18,9 +18,8 @@
 #include <linux/thread_info.h>
 
 /* ftrace syscalls requires exporting the sys_call_table */
-#ifdef CONFIG_FTRACE_SYSCALLS
 extern const unsigned long sys_call_table[];
-#endif /* CONFIG_FTRACE_SYSCALLS */
+extern const unsigned long compat_sys_call_table[];
 
 static inline int syscall_get_nr(struct task_struct *task, struct pt_regs *regs)
 {
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 7b1693adff2a..5574d92646f1 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -54,6 +54,9 @@
 SYS_CALL_TABLE:
 	.tc sys_call_table[TC],sys_call_table
 
+COMPAT_SYS_CALL_TABLE:
+	.tc compat_sys_call_table[TC],compat_sys_call_table
+
 /* This value is used to mark exception frames on the stack. */
 exception_marker:
 	.tc	ID_EXC_MARKER[TC],STACK_FRAME_REGS_MARKER
@@ -173,7 +176,7 @@ system_call:			/* label this so stack traces look sane */
 	ld	r11,SYS_CALL_TABLE@toc(2)
 	andis.	r10,r10,_TIF_32BIT@h
 	beq	15f
-	addi	r11,r11,8	/* use 32-bit syscall entries */
+	ld	r11,COMPAT_SYS_CALL_TABLE@toc(2)
 	clrldi	r3,r3,32
 	clrldi	r4,r4,32
 	clrldi	r5,r5,32
@@ -181,7 +184,7 @@ system_call:			/* label this so stack traces look sane */
 	clrldi	r7,r7,32
 	clrldi	r8,r8,32
 15:
-	slwi	r0,r0,4
+	slwi	r0,r0,3
 
 	barrier_nospec_asm
 	/*
diff --git a/arch/powerpc/kernel/systbl.S b/arch/powerpc/kernel/systbl.S
index 919a32746ede..883b8e36964c 100644
--- a/arch/powerpc/kernel/systbl.S
+++ b/arch/powerpc/kernel/systbl.S
@@ -17,13 +17,13 @@
 #include <asm/ppc_asm.h>
 
 #ifdef CONFIG_PPC64
-#define SYSCALL(func)		.8byte	DOTSYM(sys_##func),DOTSYM(sys_##func)
-#define COMPAT_SYS(func)	.8byte	DOTSYM(sys_##func),DOTSYM(compat_sys_##func)
-#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func),DOTSYM(ppc_##func)
-#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall),DOTSYM(sys_ni_syscall)
-#define SYS32ONLY(func)		.8byte	DOTSYM(sys_ni_syscall),DOTSYM(compat_sys_##func)
-#define PPC64ONLY(func)		.8byte	DOTSYM(ppc_##func),DOTSYM(sys_ni_syscall)
-#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f),DOTSYM(f3264)
+#define SYSCALL(func)		.8byte	DOTSYM(sys_##func)
+#define COMPAT_SYS(func)	.8byte	DOTSYM(sys_##func)
+#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func)
+#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall)
+#define SYS32ONLY(func)		.8byte	DOTSYM(sys_ni_syscall)
+#define PPC64ONLY(func)		.8byte	DOTSYM(ppc_##func)
+#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f)
 #else
 #define SYSCALL(func)		.long	sys_##func
 #define COMPAT_SYS(func)	.long	sys_##func
@@ -48,3 +48,26 @@
 sys_call_table:
 
 #include <asm/systbl.h>
+
+#undef SYSCALL
+#undef COMPAT_SYS
+#undef PPC_SYS
+#undef OLDSYS
+#undef SYS32ONLY
+#undef PPC64ONLY
+#undef SYSX
+
+#ifdef CONFIG_COMPAT
+#define SYSCALL(func)		.8byte	DOTSYM(sys_##func)
+#define COMPAT_SYS(func)	.8byte	DOTSYM(compat_sys_##func)
+#define PPC_SYS(func)		.8byte	DOTSYM(ppc_##func)
+#define OLDSYS(func)		.8byte	DOTSYM(sys_ni_syscall)
+#define SYS32ONLY(func)		.8byte	DOTSYM(compat_sys_##func)
+#define PPC64ONLY(func)		.8byte	DOTSYM(sys_ni_syscall)
+#define SYSX(f, f3264, f32)	.8byte	DOTSYM(f3264)
+
+.globl compat_sys_call_table
+compat_sys_call_table:
+
+#include <asm/systbl.h>
+#endif
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 65b3bdb99f0b..7725a9714736 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -671,15 +671,18 @@ static void __init vdso_setup_syscall_map(void)
 {
 	unsigned int i;
 	extern unsigned long *sys_call_table;
+#ifdef CONFIG_PPC64
+	extern unsigned long *compat_sys_call_table;
+#endif
 	extern unsigned long sys_ni_syscall;
 
 
 	for (i = 0; i < NR_syscalls; i++) {
 #ifdef CONFIG_PPC64
-		if (sys_call_table[i*2] != sys_ni_syscall)
+		if (sys_call_table[i] != sys_ni_syscall)
 			vdso_data->syscall_map_64[i >> 5] |=
 				0x80000000UL >> (i & 0x1f);
-		if (sys_call_table[i*2+1] != sys_ni_syscall)
+		if (compat_sys_call_table[i] != sys_ni_syscall)
 			vdso_data->syscall_map_32[i >> 5] |=
 				0x80000000UL >> (i & 0x1f);
 #else /* CONFIG_PPC64 */
-- 
2.18.0

