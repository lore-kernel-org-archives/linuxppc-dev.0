Return-Path: <SRS0=sHkL=Q6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 424CEC43381
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 07:06:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7A486206A3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 07:06:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SQBsUEfe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7A486206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445zlJ5Xc3zDqXd
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 18:06:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::642; helo=mail-pl1-x642.google.com;
 envelope-from=jrdr.linux@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="SQBsUEfe"; 
 dkim-atps=neutral
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20::642])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445zjS0nSpzDqLt
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 18:04:43 +1100 (AEDT)
Received: by mail-pl1-x642.google.com with SMTP id s1so2087903plp.9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 23:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:mime-version:content-disposition
 :user-agent; bh=V9oHt98crmFrdUvp7m267PBEG8+VEKI9MKfQ+oxnd90=;
 b=SQBsUEfezZFarr0BfV/nBxxA5r3Qp869wxfWnurAcuP/+FXnozR7Kqno0t8ehNRXgb
 EGVmTC6fTVcqpwz9pPQEJdRW+S/Hyut+TBN2glOZj1nevKokQHrYmEK880FOwlegIXyZ
 GAvvWGY9wiH7nL48WZjvtLgln0ewRGBe/KDkQssJ5TDbPfbp5tCcpy+/Z0j5YQbIc+c/
 NLQaQkXIiZXzG2bwCAVbpD8YOMyvJ23FApk7SVrpOFR5WZwV53n7UfQ8FDYROlzkVGGd
 FybE+5oX05L02GPA6MyVbYuNJr0iLwZqIbxnQSVvQcrdD04Z3POa/0ZS25TMBVePxXQa
 VJ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition:user-agent;
 bh=V9oHt98crmFrdUvp7m267PBEG8+VEKI9MKfQ+oxnd90=;
 b=d0BWZ6eSFwjiCRh0BXqv5KabN3JztOUpydYkuOoxit8yXHwYzUvUxUiRJO6ibIecj9
 lf4hCAI13uPMV5J7tf7TR4B0xG1Kt5FnR8P7dULtMPomMcghc4xZOlr0aVTnn9zj/SdF
 DPkVBxuO356OgcK5vYy3HiCkZTCe0j1SELvWFnmqNZOcLZkieLu8pubZvM4aXZBIUI/4
 4tSOgxB7T0/UA+jFs0PLzMmwp9J2iCYm7U1g/COijR6UGoz0H36rjOZYFp8xQh3XHP51
 oKOk84c3315dW0Sd4Owa5nS3vhtbU/N71HAxorv8BphMGR+l6ZoKvBultga1MQL0IyW9
 yAHw==
X-Gm-Message-State: AHQUAuYVqoKiw6vqgyA1HDYgx4uwyQIQOAyQYHq6v2VQ7F0Q+x2nktkp
 07UDNlGd/8Jp1LVJyT/OSc0=
X-Google-Smtp-Source: AHgI3IbfhdT+5w9bnfHnexY3r0tLTLyeGXfxwWZRPyY7PYZHTGUjuw4JJNjE9HVw5P7nLEmR2l2NMg==
X-Received: by 2002:a17:902:6f08:: with SMTP id w8mr8201728plk.5.1550905481641; 
 Fri, 22 Feb 2019 23:04:41 -0800 (PST)
Received: from jordon-HP-15-Notebook-PC ([1.39.146.163])
 by smtp.gmail.com with ESMTPSA id t12sm6634255pgq.68.2019.02.22.23.04.39
 (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 22 Feb 2019 23:04:40 -0800 (PST)
Date: Sat, 23 Feb 2019 12:39:02 +0530
From: Souptick Joarder <jrdr.linux@gmail.com>
To: bamv2005@gmail.com, shuah@kernel.org, davem@davemloft.net,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 adobriyan@gmail.com, mathieu.desnoyers@efficios.com,
 peterz@infradead.org, paulmck@linux.ibm.com, boqun.feng@gmail.com,
 john.stultz@linaro.org, tglx@linutronix.de, sboyd@kernel.org,
 akpm@linux-foundation.org
Subject: [PATCH] tools: testing: selftests: Remove duplicate headers
Message-ID: <20190223070901.GA10274@jordon-HP-15-Notebook-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
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
Cc: sabyasachi.linux@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Remove duplicate headers which are included twice.

Signed-off-by: Sabyasachi Gupta <sabyasachi.linux@gmail.com>
Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 tools/testing/selftests/gpio/gpio-mockup-chardev.c          | 1 -
 tools/testing/selftests/net/udpgso.c                        | 1 -
 tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c | 1 -
 tools/testing/selftests/proc/proc-self-syscall.c            | 1 -
 tools/testing/selftests/rseq/rseq.h                         | 1 -
 tools/testing/selftests/timers/skew_consistency.c           | 1 -
 tools/testing/selftests/x86/mpx-dig.c                       | 2 --
 7 files changed, 8 deletions(-)

diff --git a/tools/testing/selftests/gpio/gpio-mockup-chardev.c b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
index aaa1e9f..d587c81 100644
--- a/tools/testing/selftests/gpio/gpio-mockup-chardev.c
+++ b/tools/testing/selftests/gpio/gpio-mockup-chardev.c
@@ -12,7 +12,6 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <stdio.h>
 #include <errno.h>
 #include <string.h>
 #include <fcntl.h>
diff --git a/tools/testing/selftests/net/udpgso.c b/tools/testing/selftests/net/udpgso.c
index e279051..b8265ee 100644
--- a/tools/testing/selftests/net/udpgso.c
+++ b/tools/testing/selftests/net/udpgso.c
@@ -17,7 +17,6 @@
 #include <stdbool.h>
 #include <stdlib.h>
 #include <stdio.h>
-#include <stdlib.h>
 #include <string.h>
 #include <sys/ioctl.h>
 #include <sys/socket.h>
diff --git a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
index 167135b..af1b802 100644
--- a/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
+++ b/tools/testing/selftests/powerpc/pmu/ebb/fork_cleanup_test.c
@@ -11,7 +11,6 @@
 #include <sys/wait.h>
 #include <unistd.h>
 #include <setjmp.h>
-#include <signal.h>
 
 #include "ebb.h"
 
diff --git a/tools/testing/selftests/proc/proc-self-syscall.c b/tools/testing/selftests/proc/proc-self-syscall.c
index 5ab5f48..3a4fec3 100644
--- a/tools/testing/selftests/proc/proc-self-syscall.c
+++ b/tools/testing/selftests/proc/proc-self-syscall.c
@@ -20,7 +20,6 @@
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <errno.h>
-#include <unistd.h>
 #include <string.h>
 #include <stdio.h>
 
diff --git a/tools/testing/selftests/rseq/rseq.h b/tools/testing/selftests/rseq/rseq.h
index c72eb70..6c1126e7 100644
--- a/tools/testing/selftests/rseq/rseq.h
+++ b/tools/testing/selftests/rseq/rseq.h
@@ -16,7 +16,6 @@
 #include <errno.h>
 #include <stdio.h>
 #include <stdlib.h>
-#include <sched.h>
 #include <linux/rseq.h>
 
 /*
diff --git a/tools/testing/selftests/timers/skew_consistency.c b/tools/testing/selftests/timers/skew_consistency.c
index 022b711..8066be9 100644
--- a/tools/testing/selftests/timers/skew_consistency.c
+++ b/tools/testing/selftests/timers/skew_consistency.c
@@ -32,7 +32,6 @@
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
-#include <stdlib.h>
 #include <string.h>
 #include <sys/wait.h>
 #include "../kselftest.h"
diff --git a/tools/testing/selftests/x86/mpx-dig.c b/tools/testing/selftests/x86/mpx-dig.c
index c13607e..880fbf6 100644
--- a/tools/testing/selftests/x86/mpx-dig.c
+++ b/tools/testing/selftests/x86/mpx-dig.c
@@ -8,9 +8,7 @@
 #include <unistd.h>
 #include <stdio.h>
 #include <errno.h>
-#include <sys/types.h>
 #include <sys/stat.h>
-#include <unistd.h>
 #include <sys/mman.h>
 #include <string.h>
 #include <fcntl.h>
-- 
1.9.1

