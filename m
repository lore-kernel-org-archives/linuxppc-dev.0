Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C3F731007D3
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Jul 2010 12:43:52 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e37.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6N2fsCZ025041
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 20:41:54 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6N2hjvB158600
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 20:43:45 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6N2hi7k019208
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 20:43:45 -0600
Date: Thu, 22 Jul 2010 21:43:44 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@austin.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>, Gautham R Shenoy <ego@in.ibm.com>,
	Julia Lawall <julia@diku.dk>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: ONLINE to OFFLINE CPU state transition during removal
Message-ID: <20100723024343.GC32534@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If a CPU remove is attempted using the 'release' interface on hardware
which supports extended cede, the CPU will be put in the INACTIVE state
rather than the OFFLINE state due to the default preferred_offline_state
in that situation.  In the INACTIVE state it will fail to be removed.

This patch changes the preferred offline state to OFFLINE when an CPU is
in the ONLINE state.  After cpu_down() is called in dlpar_offline_cpu()
the CPU will be OFFLINE and CPU removal can continue.

Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---

diff --git a/arch/powerpc/platforms/pseries/dlpar.c b/arch/powerpc/platforms/pseries/dlpar.c
index d71e585..227c1c3 100644
--- a/arch/powerpc/platforms/pseries/dlpar.c
+++ b/arch/powerpc/platforms/pseries/dlpar.c
@@ -463,6 +463,7 @@ static int dlpar_offline_cpu(struct device_node *dn)
 				break;
 
 			if (get_cpu_current_state(cpu) == CPU_STATE_ONLINE) {
+				set_preferred_offline_state(cpu, CPU_STATE_OFFLINE);
 				cpu_maps_update_done();
 				rc = cpu_down(cpu);
 				if (rc)
