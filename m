Return-Path: <rcjenn@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5CBBADDF7F
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jun 2008 08:16:05 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m5CMG21d013948
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 18:16:02 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m5CMG2cp174882
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 16:16:02 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m5CMG16P018298
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 16:16:02 -0600
Date: Thu, 12 Jun 2008 17:14:31 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: paulus@samba.org
Subject: [PATCH 09/19] powerpc: Add CMO paging statistics
Message-ID: <20080612221431.GP30916@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080612215312.GF30916@linux.vnet.ibm.com>
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
@@ -410,6 +410,25 @@ static int lparcfg_count_active_processo
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
@@ -435,6 +454,7 @@ static int pseries_lparcfg_data(struct s
 		parse_system_parameter_string(m);
 		parse_ppp_data(m);
 		parse_mpp_data(m);
+		pseries_cmo_data(m);
=20
 		seq_printf(m, "purr=3D%ld\n", get_purr());
=20
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
