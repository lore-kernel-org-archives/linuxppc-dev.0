Return-Path: <rcjenn@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C598CDDF3A
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Aug 2008 06:21:53 +1000 (EST)
Received: from e2.ny.us.ibm.com ([192.168.1.102])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m7FJAXr8001761
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 15:10:33 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7FJAJR1001214
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 15:10:19 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7FJAIBI238820
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 15:10:18 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7FJAInK024857
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Aug 2008 15:10:18 -0400
Date: Fri, 15 Aug 2008 14:10:18 -0500
From: Robert Jennings <rcj@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 3/3] powerpc: add CMO enabled flag and paging space data to
	lparcfg
Message-ID: <20080815191017.GD20629@austin.ibm.com>
References: <20080815190230.GA20629@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080815190230.GA20629@austin.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Add a field in lparcfg output to indicate whether the kernel is running on a 
dedicated or shared memory lpar.  Added fields to show the paging space pool
IDs and the CMO page size.

Submitted-by: Robert Jennings <rcj@linux.vnet.ibm.com>

---
 arch/powerpc/kernel/lparcfg.c |    5 +++++
 1 file changed, 5 insertions(+)

Index: b/arch/powerpc/kernel/lparcfg.c
===================================================================
--- a/arch/powerpc/kernel/lparcfg.c
+++ b/arch/powerpc/kernel/lparcfg.c
@@ -416,6 +416,8 @@ static void pseries_cmo_data(struct seq_
 	unsigned long cmo_faults = 0;
 	unsigned long cmo_fault_time = 0;
 
+	seq_printf(m, "cmo_enabled=%d\n", firmware_has_feature(FW_FEATURE_CMO));
+
 	if (!firmware_has_feature(FW_FEATURE_CMO))
 		return;
 
@@ -427,6 +429,9 @@ static void pseries_cmo_data(struct seq_
 	seq_printf(m, "cmo_faults=%lu\n", cmo_faults);
 	seq_printf(m, "cmo_fault_time_usec=%lu\n",
 		   cmo_fault_time / tb_ticks_per_usec);
+	seq_printf(m, "cmo_primary_psp=%d\n", cmo_get_primary_psp());
+	seq_printf(m, "cmo_secondary_psp=%d\n", cmo_get_secondary_psp());
+	seq_printf(m, "cmo_page_size=%lu\n", cmo_get_page_size());
 }
 
 static int pseries_lparcfg_data(struct seq_file *m, void *v)
