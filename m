Return-Path: <SRS0=NWA6=ON=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D73DC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 17:54:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC69A2082B
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Dec 2018 17:54:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC69A2082B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 438Txz3zBHzDqZW
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Dec 2018 04:53:59 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.160.195; helo=mail-qt1-f195.google.com;
 envelope-from=breno.debian@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=debian.org
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com
 [209.85.160.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 438TvZ5Hh4zDqKQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Dec 2018 04:51:54 +1100 (AEDT)
Received: by mail-qt1-f195.google.com with SMTP id d19so19043410qtq.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Dec 2018 09:51:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=hev+hwWKPq/vjNeQOXN1+XagjVSlKIZls96djhFjLxo=;
 b=pDrCjoEp7V8yt24IZGeQ7wwbsOvhWk4hO8MwCHnCNawhZQjpCSLjGnxlqhjvWu33FM
 +1rQ4aFa4eHnF3E2y7hDKun7vpEMbJr5Ma9MwWsCI+aZiwmq4q6Ph9y2EJO4DSfEIQDZ
 139aFvFH1OqFPJ9XZg+S2Hs88vmVZW/HBhTnTRSjtjVLZccbFODMS8kd5pQDW91YiXgl
 5IGAxHAMARR/oNwMmiqjQT0u4pERUUlkRuLkm971TOghJlE4P/iKGWmav4WRXMGbgxwD
 tcZ5J77F6vi/hxV5K9KOo2rCkr6FO9w2m2TG5/TC0XLWqErkCNpfvujz5a9i9bIwXQdB
 6Vmg==
X-Gm-Message-State: AA+aEWa+ZJcssiIkwsXXIEGDPktMoYf1GNxvTIET0x+Tdi0ieyDTyxIu
 oiiLQeRpgo9Wll9wJy9M2sk=
X-Google-Smtp-Source: AFSGD/UGRYXOhuZMdUTmSNbTEXRmuEde5DEQaEeldmwGACD91Sm/grJFiuvcNb2CVU1wRYssAm/w5Q==
X-Received: by 2002:aed:36c1:: with SMTP id f59mr20201334qtb.250.1543945911770; 
 Tue, 04 Dec 2018 09:51:51 -0800 (PST)
Received: from [9.18.239.97] ([32.104.18.243])
 by smtp.gmail.com with ESMTPSA id c77sm16737982qkh.82.2018.12.04.09.51.49
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 04 Dec 2018 09:51:51 -0800 (PST)
Subject: Re: [PATCH] selftests/powerpc: New TM signal self test
To: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org
References: <1542828069-29100-1-git-send-email-leitao@debian.org>
 <1543411413-23863-1-git-send-email-leitao@debian.org>
 <25051cb7a66f59beca598cbbef6f7eb92d654772.camel@neuling.org>
From: Breno Leitao <leitao@debian.org>
Message-ID: <c6ada86e-6abd-b11c-d8cb-75c5eebdcdaf@debian.org>
Date: Tue, 4 Dec 2018 15:51:47 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.2
MIME-Version: 1.0
In-Reply-To: <25051cb7a66f59beca598cbbef6f7eb92d654772.camel@neuling.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: gromero@linux.vnet.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Hi Mikey,

On 11/29/18 12:11 AM, Michael Neuling wrote:
> On Wed, 2018-11-28 at 11:23 -0200, Breno Leitao wrote:
>> A new self test that forces MSR[TS] to be set without calling any TM
>> instruction. This test also tries to cause a page fault at a signal
>> handler, exactly between MSR[TS] set and tm_recheckpoint(), forcing
>> thread->texasr to be rewritten with TEXASR[FS] = 0, which will cause a BUG
>> when tm_recheckpoint() is called.
>>
>> This test is not deterministic since it is hard to guarantee that the page
>> access will cause a page fault. Tests have shown that the bug could be
>> exposed with few interactions in a buggy kernel. This test is configured to
>> loop 5000x, having a good chance to hit the kernel issue in just one run.
>> This self test takes less than two seconds to run.
> 
> You could try using sigaltstack() to put the ucontext somewhere else. Then you
> could play tricks with that memory to try to force a fault.
> madvise()+MADV_DONTNEED or fadvise()+POSIX_FADV_DONTNEED might do the trick.

Yes, it sounded interesting and I implemented the test using madvice(). Thanks
for the suggestion!

The current approach didn't seem to improve the amount of page faults at it
seems that MADV_DONTNEED makes no difference when using a Lazy page loading.
This is the test I did, where 'original' is my current patch and 'madvice` is
the patch below:

  Performance counter stats for './original':

                 0      major-faults                                                
           125,100      minor-faults                                                

       2.575479619 seconds time elapsed


  Performance counter stats for './madvice':

                 0      major-faults                                                
           125,099      minor-faults         



Other than that, I didn't see any improvements in the reproduction rate also, although
it is a bit challenging to measure, since it crashes the machine and I can't run a
full statistical model.

This is the current patch I compared to the original one

---

commit 082a9fe29412943adfa2d6a363f44bac8e81d0ce
Author: Breno Leitao <leitao@debian.org>
Date:   Tue Nov 13 18:02:57 2018 -0500

    selftests/powerpc: New TM signal self test
    
    A new self test that forces MSR[TS] to be set without calling any TM
    instruction. This test also tries to cause a page fault at a signal
    handler, exactly between MSR[TS] set and tm_recheckpoint(), forcing
    thread->texasr to be rewritten with TEXASR[FS] = 0, which will cause a BUG
    when tm_recheckpoint() is called.
    
    This test is not deterministic, since it is hard to guarantee that the page
    access will cause a page fault. In order to force more page faults at
    signal context, the signal handler and the ucontext are being mapped into a
    MADV_DONTNEED memory chunks.
    
    Tests have shown that the bug could be exposed with few interactions in a
    buggy kernel. This test is configured to loop 5000x, having a good chance
    to hit the kernel issue in just one run.  This self test takes less than
    two seconds to run.
    
    This test uses set/getcontext because the kernel will recheckpoint
    zeroed structures, causing the test to segfault, which is undesired because
    the test needs to rerun, so, there is a signal handler for SIGSEGV which
    will restart the test.
    
    Signed-off-by: Breno Leitao <leitao@debian.org>

diff --git a/tools/testing/selftests/powerpc/tm/.gitignore b/tools/testing/selftests/powerpc/tm/.gitignore
index c3ee8393dae8..89679822ebc9 100644
--- a/tools/testing/selftests/powerpc/tm/.gitignore
+++ b/tools/testing/selftests/powerpc/tm/.gitignore
@@ -11,6 +11,7 @@ tm-signal-context-chk-fpu
 tm-signal-context-chk-gpr
 tm-signal-context-chk-vmx
 tm-signal-context-chk-vsx
+tm-signal-force-msr
 tm-vmx-unavail
 tm-unavailable
 tm-trap
diff --git a/tools/testing/selftests/powerpc/tm/Makefile b/tools/testing/selftests/powerpc/tm/Makefile
index 9fc2cf6fbc92..58a2ebd13958 100644
--- a/tools/testing/selftests/powerpc/tm/Makefile
+++ b/tools/testing/selftests/powerpc/tm/Makefile
@@ -4,7 +4,7 @@ SIGNAL_CONTEXT_CHK_TESTS := tm-signal-context-chk-gpr tm-signal-context-chk-fpu
 
 TEST_GEN_PROGS := tm-resched-dscr tm-syscall tm-signal-msr-resv tm-signal-stack \
 	tm-vmxcopy tm-fork tm-tar tm-tmspr tm-vmx-unavail tm-unavailable tm-trap \
-	$(SIGNAL_CONTEXT_CHK_TESTS) tm-sigreturn
+	$(SIGNAL_CONTEXT_CHK_TESTS) tm-sigreturn tm-signal-force-msr
 
 top_srcdir = ../../../../..
 include ../../lib.mk
@@ -20,6 +20,7 @@ $(OUTPUT)/tm-vmx-unavail: CFLAGS += -pthread -m64
 $(OUTPUT)/tm-resched-dscr: ../pmu/lib.c
 $(OUTPUT)/tm-unavailable: CFLAGS += -O0 -pthread -m64 -Wno-error=uninitialized -mvsx
 $(OUTPUT)/tm-trap: CFLAGS += -O0 -pthread -m64
+$(OUTPUT)/tm-signal-force-msr: CFLAGS += -pthread
 
 SIGNAL_CONTEXT_CHK_TESTS := $(patsubst %,$(OUTPUT)/%,$(SIGNAL_CONTEXT_CHK_TESTS))
 $(SIGNAL_CONTEXT_CHK_TESTS): tm-signal.S
diff --git a/tools/testing/selftests/powerpc/tm/tm-signal-force-msr.c b/tools/testing/selftests/powerpc/tm/tm-signal-force-msr.c
new file mode 100644
index 000000000000..496596f3c1bf
--- /dev/null
+++ b/tools/testing/selftests/powerpc/tm/tm-signal-force-msr.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright 2018, Breno Leitao, Gustavo Romero, IBM Corp.
+ *
+ * This test raises a SIGUSR1 signal, and toggle the MSR[TS]
+ * fields at the signal handler. With MSR[TS] being set, the kernel will
+ * force a recheckpoint, which may cause a segfault when returning to
+ * user space. Since the kernel needs to re-run, the segfault needs to be
+ * caught and handled.
+ *
+ * In order to continue the test even after a segfault, the context is
+ * saved prior to the signal being raised, and it is restored when there is
+ * a segmentation fault. This happens for COUNT_MAX times.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <string.h>
+#include <ucontext.h>
+#include <unistd.h>
+#include <sys/mman.h>
+
+#include "tm.h"
+#include "utils.h"
+#include "reg.h"
+
+#define COUNT_MAX       5000		/* Number of interactions */
+
+/* Setting contexts because the test will crash and we want to recover */
+ucontext_t init_context, main_context;
+
+static int count, first_time;
+
+void usr_signal_handler(int signo, siginfo_t *si, void *uc)
+{
+	ucontext_t *ucp = uc;
+	int ret;
+
+	/*
+	 * Allocating memory in a signal handler, and never freeing it on
+	 * purpose, forcing the heap increase, so, the memory leak is what
+	 * we want here.
+	 */
+	ucp->uc_link = mmap(NULL, sizeof(ucontext_t),
+			    PROT_READ | PROT_WRITE,
+			    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	if (ucp->uc_link == (void *)-1) {
+		perror("Mmap failed");
+		exit(-1);
+	}
+
+	/* Forcing the page to be allocated in a page fault */
+	ret = madvise(ucp->uc_link, sizeof(ucontext_t), MADV_DONTNEED);
+	if (ret) {
+		perror("madvise failed");
+		exit(-1);
+	}
+
+	memcpy(&ucp->uc_link, &ucp->uc_mcontext, sizeof(ucp->uc_mcontext));
+
+	/* Forcing to enable MSR[TM] */
+	ucp->uc_mcontext.gp_regs[PT_MSR] |= MSR_TS_S;
+
+	/*
+	 * A fork inside a signal handler seems to be more efficient than a
+	 * fork() prior to the signal being raised.
+	 */
+	if (fork() == 0) {
+		/*
+		 * Both child and parent will return, but, child returns
+		 * with count set so it will exit in the next segfault.
+		 * Parent will continue to loop.
+		 */
+		count = COUNT_MAX;
+	}
+
+	/*
+	 * If the change above does not hit the bug, it will cause a
+	 * segmentation fault, since the ck structures are NULL.
+	 */
+}
+
+void seg_signal_handler(int signo, siginfo_t *si, void *uc)
+{
+	if (count == COUNT_MAX) {
+		/* Return to tm_signal_force_msr() and exit */
+		setcontext(&main_context);
+	}
+
+	count++;
+
+	/* Reexecute the test */
+	setcontext(&init_context);
+}
+
+void tm_trap_test(void)
+{
+	struct sigaction usr_sa, seg_sa;
+	stack_t ss;
+
+	usr_sa.sa_flags = SA_SIGINFO | SA_ONSTACK;
+	usr_sa.sa_sigaction = usr_signal_handler;
+
+	seg_sa.sa_flags = SA_SIGINFO;
+	seg_sa.sa_sigaction = seg_signal_handler;
+
+	/*
+	 * Set initial context. Will get back here from
+	 * seg_signal_handler()
+	 */
+	getcontext(&init_context);
+
+	/* Allocated am alternative signal stack area */
+	ss.ss_sp = mmap(NULL, SIGSTKSZ, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	ss.ss_size = SIGSTKSZ;
+	ss.ss_flags = 0;
+
+	if (ss.ss_sp == (void *)-1) {
+		perror("mmap error\n");
+		exit(-1);
+	}
+
+	/* Force the allocation through a page fault */
+	if (madvise(ss.ss_sp, SIGSTKSZ, MADV_DONTNEED)) {
+		perror("madvise\n");
+		exit(-1);
+	}
+
+	/* Setting a alternative stack to generate a page fault when
+	 * the signal is raised.
+	 */
+	if (sigaltstack(&ss, NULL)) {
+		perror("sigaltstack\n");
+		exit(-1);
+	}
+
+	/* The signal handler will enable MSR_TS */
+	sigaction(SIGUSR1, &usr_sa, NULL);
+	/* If it does not crash, it will segfault, avoid it to retest */
+	sigaction(SIGSEGV, &seg_sa, NULL);
+
+	raise(SIGUSR1);
+}
+
+int tm_signal_force_msr(void)
+{
+	SKIP_IF(!have_htm());
+
+	/* Will get back here after COUNT_MAX interactions */
+	getcontext(&main_context);
+
+	if (!first_time++)
+		tm_trap_test();
+
+	return EXIT_SUCCESS;
+}
+
+int main(int argc, char **argv)
+{
+	test_harness(tm_signal_force_msr, "tm_signal_force_msr");
+}
