Return-Path: <rashmicy@gmail.com>
Received: from mail-pa0-x22e.google.com (mail-pa0-x22e.google.com
 [IPv6:2607:f8b0:400e:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D5FED1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Nov 2015 17:08:38 +1100 (AEDT)
Received: by pacdm15 with SMTP id dm15so137460966pac.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Nov 2015 22:08:35 -0800 (PST)
Received: from circle.ozlabs.ibm.com ([122.99.82.10])
 by smtp.gmail.com with ESMTPSA id by6sm1994935pab.25.2015.11.20.22.08.33
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Fri, 20 Nov 2015 22:08:34 -0800 (PST)
From: Rashmica Gupta <rashmicy@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Add rN aliases to the pt_regs_offset table.
Date: Sat, 21 Nov 2015 17:08:16 +1100
Message-Id: <1448086096-3117-1-git-send-email-rashmicy@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

It is common practice with powerpc to use 'rN' to refer to register 'N'. However
when using the pt_regs_offset table we have to use 'gprN'.

So add aliases such that both 'rN' and 'gprN' can be used.

For example, we can currently do:
$ su -
$ echo "p:probe/sys_fchownat .sys_fchownat %gpr3:s32 +0(%gpr4):string %gpr5:s32
%gpr6:s32 %gpr7:s32" > /sys/kernel/debug/tracing/kprobe_events
$ echo 1 > /sys/kernel/debug/tracing/events/probe/sys_fchownat/enable
$ touch /tmp/foo
$ chown root /tmp/foo
$ echo 0 > /sys/kernel/debug/tracing/events/enable
$ cat /sys/kernel/debug/tracing/trace
           chown-5040  [001] d... 24800.047211: sys_fchownat:
(.SyS_fchownat+0x0/0x190) arg1=-100 arg2="foo" arg3=0 arg4=-1 arg5=0

Instead we'd like to be able to use:
$ echo "p:probe/sys_fchownat sys_fchownat %r3:s32 +0(%r4):string %r5:s32
%r6:s32 %r7:s32" > /sys/kernel/debug/tracing/kprobe_events

Signed-off-by: Rashmica Gupta <rashmicy@gmail.com>
---
 arch/powerpc/kernel/ptrace.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index 737c0d0b53ac..30a03c03fe73 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -60,6 +60,7 @@ struct pt_regs_offset {
 #define STR(s)	#s			/* convert to string */
 #define REG_OFFSET_NAME(r) {.name = #r, .offset = offsetof(struct pt_regs, r)}
 #define GPR_OFFSET_NAME(num)	\
+	{.name = STR(r##num), .offset = offsetof(struct pt_regs, gpr[num])}, \
 	{.name = STR(gpr##num), .offset = offsetof(struct pt_regs, gpr[num])}
 #define REG_OFFSET_END {.name = NULL, .offset = 0}
 
-- 
2.5.0
