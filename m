Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 21EE6DEF53
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 04:31:01 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m6NIUwip012285
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:30:58 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6NIUwo3160812
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:30:58 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6NIUws6006451
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jul 2008 14:30:58 -0400
Date: Wed, 23 Jul 2008 13:30:58 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org, benh@kernel.crashing.org
Subject: [PATCH 08/16 v4] powerpc: Add CMO paging statistics
Message-ID: <20080723183058.GK12905@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080723181932.GC12905@linux.vnet.ibm.com>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

=46rom: Brian King <brking@linux.vnet.ibm.com>

With the addition of Cooperative Memory Overcommitment (CMO) support
for IBM Power Systems, two fields have been added to the VPA to report
paging statistics. Add support in lparcfg to report them to userspace.

Signed-off-by: Brian King <brking@linux.vnet.ibm.com>
Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---

 arch/powerpc/kernel/lparcfg.c |   20 ++++++++++++++++++++
 include/asm-powerpc/lppaca.h  |    5 ++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

Index: b/arch/powerpc/kernel/lparcfg.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -409,6 +409,25 @@ static int lparcfg_count_active_processo
 	return count;
 }
=20
+static void pseries_cmo_data(struct seq_file *m)
+{
+	int cpu;
+	unsigned long cmo_faults =3D 0;
+	unsigned long cmo_fault_time =3D 0;
+
+	if (!firmware_has_feature(FW_FEATURE_CMO))
+		return;
+
+	for_each_possible_cpu(cpu) {
+		cmo_faults +=3D lppaca[cpu].cmo_faults;
+		cmo_fault_time +=3D lppaca[cpu].cmo_fault_time;
+	}
+
+	seq_printf(m, "cmo_faults=3D%lu\n", cmo_faults);
+	seq_printf(m, "cmo_fault_time_usec=3D%lu\n",
+		   cmo_fault_time / tb_ticks_per_usec);
+}
+
 static int pseries_lparcfg_data(struct seq_file *m, void *v)
 {
 	int partition_potential_processors;
@@ -434,6 +453,7 @@ static int pseries_lparcfg_data(struct s
 		parse_system_parameter_string(m);
 		parse_ppp_data(m);
 		parse_mpp_data(m);
+		pseries_cmo_data(m);
=20
 		seq_printf(m, "purr=3D%ld\n", get_purr());
 	} else {		/* non SPLPAR case */
Index: b/include/asm-powerpc/lppaca.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/asm-powerpc/lppaca.h
+++ b/include/asm-powerpc/lppaca.h
@@ -125,7 +125,10 @@ struct lppaca {
 	// NOTE: This value will ALWAYS be zero for dedicated processors and
 	// will NEVER be zero for shared processors (ie, initialized to a 1).
 	volatile u32 yield_count;	// PLIC increments each dispatchx00-x03
-	u8	reserved6[124];		// Reserved                     x04-x7F
+	u32 reserved6;
+	volatile u64 cmo_faults;	// CMO page fault count         x08-x0F
+	volatile u64 cmo_fault_time;	// CMO page fault time          x10-x17
+	u8	reserved7[104];		// Reserved                     x18-x7F
=20
 //=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D
 // CACHE_LINE_4-5 0x0180 - 0x027F Contains PMC interrupt data
