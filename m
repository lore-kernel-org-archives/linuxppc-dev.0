Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-wm0-x244.google.com (mail-wm0-x244.google.com
 [IPv6:2a00:1450:400c:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41C7r60zVQzF152
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Jun 2018 05:27:34 +1000 (AEST)
Received: by mail-wm0-x244.google.com with SMTP id r15-v6so3224100wmc.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jun 2018 12:27:33 -0700 (PDT)
Sender: Mathieu Malaterre <mathieu.malaterre@gmail.com>
From: Mathieu Malaterre <malat@debian.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Mathieu Malaterre <malat@debian.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Balbir Singh <bsingharora@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Vaibhav Jain <vaibhav@linux.vnet.ibm.com>,
 Breno Leitao <leitao@debian.org>, Yisheng Xie <xieyisheng1@huawei.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] =?UTF-8?q?powerpc/xmon:=20avoid=20warnings=20about=20vari?=
 =?UTF-8?q?ables=20that=20might=20be=20clobbered=20by=20=E2=80=98longjmp?=
 =?UTF-8?q?=E2=80=99?=
Date: Fri, 22 Jun 2018 21:27:17 +0200
Message-Id: <20180622192718.24242-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move initialization of variables after data definitions. This silence
warnings treated as error with W=1:

  arch/powerpc/xmon/xmon.c:3389:14: error: variable ‘name’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]
  arch/powerpc/xmon/xmon.c:3100:22: error: variable ‘tsk’ might be clobbered by ‘longjmp’ or ‘vfork’ [-Werror=clobbered]

Signed-off-by: Mathieu Malaterre <malat@debian.org>
---
 arch/powerpc/xmon/xmon.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 47166ad2a669..982848c784ff 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -3097,10 +3097,11 @@ static void show_pte(unsigned long addr)
 static void show_tasks(void)
 {
 	unsigned long tskv;
-	struct task_struct *tsk = NULL;
+	struct task_struct *tsk;
 
 	printf("     task_struct     ->thread.ksp    PID   PPID S  P CMD\n");
 
+	tsk = NULL;
 	if (scanhex(&tskv))
 		tsk = (struct task_struct *)tskv;
 
@@ -3386,10 +3387,11 @@ static void xmon_print_symbol(unsigned long address, const char *mid,
 			      const char *after)
 {
 	char *modname;
-	const char *name = NULL;
+	const char *name;
 	unsigned long offset, size;
 
 	printf(REG, address);
+	name = NULL;
 	if (setjmp(bus_error_jmp) == 0) {
 		catch_memory_errors = 1;
 		sync();
-- 
2.11.0
