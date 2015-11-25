Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x235.google.com (mail-pa0-x235.google.com
 [IPv6:2607:f8b0:400e:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C56861A032F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 13:46:39 +1100 (AEDT)
Received: by pacej9 with SMTP id ej9so41540213pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Nov 2015 18:46:37 -0800 (PST)
Received: from circle.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id 132sm16920629pfc.63.2015.11.24.18.46.35
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Tue, 24 Nov 2015 18:46:36 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc: Append linux_banner to exception information in
 xmon.
Date: Wed, 25 Nov 2015 13:46:25 +1100
Message-Id: <1448419585-5181-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently if you are in xmon without an oops etc. to view the kernel
version you have to type "d $linux_banner" - not necessarily obvious. As
this is useful information, append to the output of "e" command.

Example output:
$mon> e
cpu 0x1: Vector: 0  at [c0000000f879ba80]
    pc: c000000000081718: sysrq_handle_xmon+0x68/0x80
    lr: c000000000081718: sysrq_handle_xmon+0x68/0x80
    sp: c0000000f879bbe0
   msr: 8000000000009033
  current = 0xc0000000f604d5c0
  paca    = 0xc00000000fdc0480	 softe: 0	 irq_happened: 0x01
    pid   = 2467, comm = bash
Linux version 4.4.0-rc2-00008-gc51af91c3ab3-dirty (rashmica@circle) (gcc
version 5.1.1 20150629 (GCC) ) #45 SMP Wed Nov 25 10:25:12 AEDT 2015

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
Added example output and word wrapping.

 arch/powerpc/xmon/xmon.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index df05bd2fca07..6d3d9d031aea 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1528,6 +1528,8 @@ static void excprint(struct pt_regs *fp)
 
 	if (trap == 0x700)
 		print_bug_trap(fp);
+
+	printf(linux_banner);
 }
 
 static void prregs(struct pt_regs *fp)
-- 
2.5.0
