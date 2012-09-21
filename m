Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Set paca->data_offset = 0 for boot cpu
Date: Fri, 21 Sep 2012 18:07:58 +1000
Message-Id: <1348214878-32319-1-git-send-email-michael@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In commit 407821a we assigned a poison value to the paca->data_offset.

Unfortunately with CONFIG_LOCK_STAT=y lockdep will read & write to percpu
data very early in boot, prior to us initialising the percpu areas,
leading to a crash.

We have been getting away with this because the data_offset was previously
set to zero. This causes lockdep to read & write to the initial copy of
the percpu variables, which are discarded later in boot.

Although that is "fishy", it does work, and for lock statistics it is no
big deal to discard the counts from early boot.

So set the paca->data_offset = 0 for the boot cpu paca only.

Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/kernel/setup_64.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 389bd4f..efb6a41 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -208,6 +208,8 @@ void __init early_setup(unsigned long dt_ptr)
 
 	/* Fix up paca fields required for the boot cpu */
 	get_paca()->cpu_start = 1;
+	/* Allow percpu accesses to "work" until we setup percpu data */
+	get_paca()->data_offset = 0;
 
 	/* Probe the machine type */
 	probe_machine();
-- 
1.7.9.5
