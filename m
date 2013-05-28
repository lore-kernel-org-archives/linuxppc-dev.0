Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e39.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8D3712C032E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 May 2013 06:40:01 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 28 May 2013 14:39:58 -0600
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 4379938C804D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2013 16:39:55 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4SKds0K52101198
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2013 16:39:54 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4SKdrpm028112
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 May 2013 16:39:54 -0400
Date: Tue, 28 May 2013 13:39:50 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH] powerpc/cputable: fix oprofile_cpu_type on power8
Message-ID: <20130528203950.GA30172@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Maynard Johnson <mpjohn@us.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Maynard informed me that neither the oprofile kernel module nor oprofile
userspace has been updated to support that "legacy" oprofile module
interface for power8, which is indicated by "ppc64/power8." This results
in no samples. The solution is to default to the "timer" type, instead.
The raw entry also should be updated, as "ppc64/ibm-compat-v1" indicates
to oprofile userspace to use "compatibility events" which are obsolete
in ISA 2.07.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---
Ben, if this seems reasonable to you, it would be great to get this into
3.10.

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index c60bbec..b8808bc 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -453,7 +453,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.oprofile_type		= PPC_OPROFILE_POWER4,
-		.oprofile_cpu_type	= "ppc64/ibm-compat-v1",
+		.oprofile_cpu_type	= 0,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
 		.platform		= "power8",
@@ -506,7 +506,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.dcache_bsize		= 128,
 		.num_pmcs		= 6,
 		.pmc_type		= PPC_PMC_IBM,
-		.oprofile_cpu_type	= "ppc64/power8",
+		.oprofile_cpu_type	= 0,
 		.oprofile_type		= PPC_OPROFILE_POWER4,
 		.cpu_setup		= __setup_cpu_power8,
 		.cpu_restore		= __restore_cpu_power8,
