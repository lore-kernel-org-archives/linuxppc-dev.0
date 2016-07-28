Return-Path: <andrew.smirnov@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s0nZN49G5zDrQS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2016 09:07:40 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id h186so4362681pfg.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 16:07:40 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Scott Wood <oss@buserror.net>,
 Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] powerpc: Call chained reset handlers during reset
Date: Thu, 28 Jul 2016 16:07:17 -0700
Message-Id: <1469747238-17432-2-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1469747238-17432-1-git-send-email-andrew.smirnov@gmail.com>
References: <1469747238-17432-1-git-send-email-andrew.smirnov@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Call out to all restart handlers that were added via
register_restart_handler() API when restarting the machine.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---

No changes compared to v1

 arch/powerpc/kernel/setup-common.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 5cd3283..205d073 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -145,6 +145,10 @@ void machine_restart(char *cmd)
 		ppc_md.restart(cmd);
 
 	smp_send_stop();
+
+	do_kernel_restart(cmd);
+	mdelay(1000);
+
 	machine_hang();
 }
 
-- 
2.5.5
