Return-Path: <paulmck@paulmck-laptop.linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 67CE1DDDFD
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Sep 2008 03:31:34 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7VHVTAB024801
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Aug 2008 13:31:29 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7VHVT57188878
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Aug 2008 11:31:29 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7VHVSNI028936
	for <linuxppc-dev@ozlabs.org>; Sun, 31 Aug 2008 11:31:29 -0600
Date: Sun, 31 Aug 2008 10:31:27 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] prevent powerpc from invoking irq handlers on offline CPUs
Message-ID: <20080831173127.GA15296@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tnt@246tNt.com, manfred@colorfullife.com, linuxppc-dev@ozlabs.org,
	paulus@samba.org, akpm@linux-foundation.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Make powerpc refrain from clearing a given to-be-offlined CPU's bit in the
cpu_online_mask until it has processed pending irqs.  This change
prevents other CPUs from being blindsided by an apparently offline CPU
nevertheless changing globally visible state.

Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
---

 smp.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5337ca7..1fedd7d 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -250,11 +250,11 @@ int generic_cpu_disable(void)
 	if (cpu == boot_cpuid)
 		return -EBUSY;
 
-	cpu_clear(cpu, cpu_online_map);
 #ifdef CONFIG_PPC64
 	vdso_data->processorCount--;
 	fixup_irqs(cpu_online_map);
 #endif
+	cpu_clear(cpu, cpu_online_map);
 	return 0;
 }
 
