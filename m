Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AEA251007D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Apr 2011 06:29:22 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e35.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p3FKDDbA021046
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2011 14:13:13 -0600
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p3FKTHWY094456
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2011 14:29:17 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p3FKTHIM015554
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Apr 2011 14:29:17 -0600
Date: Fri, 15 Apr 2011 13:29:16 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Fix kexec-related UP build error
Message-ID: <20110415202916.GA6758@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: ebiederm@xmission.com, paulus@samba.org, linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org
Reply-To: paulmck@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello!

The following patch fixes a UP build problem for kexec() on powerpc.
When the crash_kexec_wait_realmode() function was added, it was
placed in only two of the three required locations.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

The function crash_kexec_wait_realmode() is defined only if SMP, but is
called in UP builds.  Create an empty function to keep the compiler happy
in UP builds.

Signed-off-by: Paul E. McKenney <paul.mckenney@linaro.org>
Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

diff --git a/arch/powerpc/kernel/crash.c b/arch/powerpc/kernel/crash.c
index 3d3d416..6f964ef 100644
--- a/arch/powerpc/kernel/crash.c
+++ b/arch/powerpc/kernel/crash.c
@@ -251,6 +251,10 @@ static void crash_kexec_prepare_cpus(int cpu)
 #endif
 }
 
+static void crash_kexec_wait_realmode(int cpu)
+{
+}
+
 void crash_kexec_secondary(struct pt_regs *regs)
 {
 	cpus_in_sr = CPU_MASK_NONE;
