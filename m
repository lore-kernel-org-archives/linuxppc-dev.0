Return-Path: <adam@os.inf.tu-dresden.de>
Received: from os.inf.tu-dresden.de (os.inf.tu-dresden.de [141.76.48.99])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B774EB7D8B
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Feb 2010 04:46:53 +1100 (EST)
Received: from erwin.inf.tu-dresden.de ([141.76.48.80]
	helo=os.inf.tu-dresden.de)
	by os.inf.tu-dresden.de with esmtps (TLSv1:AES128-SHA:128) (Exim 4.71)
	id 1NlQ94-0007PQ-6l
	for linuxppc-dev@ozlabs.org; Sat, 27 Feb 2010 18:08:02 +0100
Date: Sat, 27 Feb 2010 18:07:59 +0100
From: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix SMP build with disabled CPU hotplugging.
Message-ID: <20100227170759.GB15985@os.inf.tu-dresden.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Compiling 2.6.33 with SMP enabled and HOTPLUG_CPU disabled gives me the
following link errors:

  LD      init/built-in.o
  LD      .tmp_vmlinux1
arch/powerpc/platforms/built-in.o: In function `.smp_xics_setup_cpu':
smp.c:(.devinit.text+0x88): undefined reference to `.set_cpu_current_state'
smp.c:(.devinit.text+0x94): undefined reference to `.set_default_offline_state'
arch/powerpc/platforms/built-in.o: In function `.smp_pSeries_kick_cpu':
smp.c:(.devinit.text+0x13c): undefined reference to `.set_preferred_offline_state'
smp.c:(.devinit.text+0x148): undefined reference to `.get_cpu_current_state'
smp.c:(.devinit.text+0x1a8): undefined reference to `.get_cpu_current_state'
make: *** [.tmp_vmlinux1] Error 1

The following change fixes that for me and seems to work as expected.


Signed-off-by: Adam Lackorzynski <adam@os.inf.tu-dresden.de>
---
 arch/powerpc/platforms/pseries/offline_states.h |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/offline_states.h b/arch/powerpc/platforms/pseries/offline_states.h
index 22574e0..202d869 100644
--- a/arch/powerpc/platforms/pseries/offline_states.h
+++ b/arch/powerpc/platforms/pseries/offline_states.h
@@ -9,10 +9,30 @@ enum cpu_state_vals {
 	CPU_MAX_OFFLINE_STATES
 };
 
+#ifdef CONFIG_HOTPLUG_CPU
 extern enum cpu_state_vals get_cpu_current_state(int cpu);
 extern void set_cpu_current_state(int cpu, enum cpu_state_vals state);
-extern enum cpu_state_vals get_preferred_offline_state(int cpu);
 extern void set_preferred_offline_state(int cpu, enum cpu_state_vals state);
 extern void set_default_offline_state(int cpu);
+#else
+static inline enum cpu_state_vals get_cpu_current_state(int cpu)
+{
+	return CPU_STATE_ONLINE;
+}
+
+static inline void set_cpu_current_state(int cpu, enum cpu_state_vals state)
+{
+}
+
+static inline void set_preferred_offline_state(int cpu, enum cpu_state_vals state)
+{
+}
+
+static inline void set_default_offline_state(int cpu)
+{
+}
+#endif
+
+extern enum cpu_state_vals get_preferred_offline_state(int cpu);
 extern int start_secondary(void);
 #endif
-- 
1.5.6.5

Adam
-- 
Adam                 adam@os.inf.tu-dresden.de
  Lackorzynski         http://os.inf.tu-dresden.de/~adam/
