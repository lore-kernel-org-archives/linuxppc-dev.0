Return-Path: <andrew.smirnov@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz4mT71sTzDqZq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 14:25:29 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id i6so13103306pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 21:25:29 -0700 (PDT)
From: Andrey Smirnov <andrew.smirnov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Scott Wood <oss@buserror.net>,
 Kumar Gala <galak@kernel.crashing.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>,
 Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] powerpc: Call chained reset handlers during reset
Date: Mon, 25 Jul 2016 21:25:13 -0700
Message-Id: <1469507114-5788-2-git-send-email-andrew.smirnov@gmail.com>
In-Reply-To: <1469507114-5788-1-git-send-email-andrew.smirnov@gmail.com>
References: <1469507114-5788-1-git-send-email-andrew.smirnov@gmail.com>
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
