Return-Path: <mrmeissn@us.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A0B522C0260
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 09:26:14 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrmeissn@us.ibm.com>;
 Fri, 3 May 2013 19:26:11 -0400
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 0B16FC9001D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 19:26:08 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r43NQ8dX64880736
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 19:26:08 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r43NQ7KY029112
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 May 2013 20:26:07 -0300
In-Reply-To: <20130503231933.GA29436@linux.vnet.ibm.com>
References: <20130503231933.GA29436@linux.vnet.ibm.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
MIME-Version: 1.0
Subject: Re: [PATCH] arch/powerpc: advertise ISA2.07, HTM, DSCR,
 EBB and ISEL bits in HWCAP2
Message-ID: <OFFA9C9591.71B67D7B-ON85257B60.00808C43-85257B60.0080BB77@us.ibm.com>
From: Michael R Meissner <mrmeissn@us.ibm.com>
Date: Fri, 3 May 2013 19:26:06 -0400
Content-Type: multipart/alternative;
 boundary="=_alternative 0080BB7285257B60_="
Cc: linuxppc-dev@lists.ozlabs.org, Steve Munroe <sjmunroe@us.ibm.com>,
 Peter Bergner <bergner@us.ibm.com>, Ryan Arnold <ryanarn@us.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 0080BB7285257B60_=
Content-Type: text/plain; charset="US-ASCII"

According to the GCC sources, ISEL is enabled by default for the 8540, 
8548, e500mc, e500mc64, e6500 processors.



From:
Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To:
benh@kernel.crashing.org, 
Cc:
Steve Munroe/Rochester/IBM@IBMUS, Peter Bergner/Rochester/IBM@IBMUS, 
Michael R Meissner/Cambridge/IBM@IBMUS, Michael Neuling 
<michael.neuling@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org, Ryan 
Arnold/Rochester/IBM@IBMUS
Date:
05/03/2013 07:19 PM
Subject:
[PATCH] arch/powerpc: advertise ISA2.07, HTM, DSCR, EBB and ISEL bits in 
HWCAP2



Now that we have AT_HWCAP2 support, start exposing some of the new
POWER8 features via it.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

---
Note: there are, I think, some Freescale processors that also should be
updated to indicate they support ISEL, but I don't know which ones.
Since this is a new feature bit (and vector), it seems like we can fix
that up in a follow-on patch. Also, this is my first patch trying to
manipulate these bits, so please let me know if I'm doing something
wrong (for instance, I don't see any particular order to the bits in
PPC_FEATURE_*)

diff --git a/arch/powerpc/include/uapi/asm/cputable.h 
b/arch/powerpc/include/uapi/asm/cputable.h
index ed9dd81..78db4e2 100644
--- a/arch/powerpc/include/uapi/asm/cputable.h
+++ b/arch/powerpc/include/uapi/asm/cputable.h
@@ -1,6 +1,7 @@
 #ifndef _UAPI__ASM_POWERPC_CPUTABLE_H
 #define _UAPI__ASM_POWERPC_CPUTABLE_H
 
+/* in AT_HWCAP */
 #define PPC_FEATURE_32 0x80000000
 #define PPC_FEATURE_64 0x40000000
 #define PPC_FEATURE_601_INSTR                           0x20000000
@@ -33,4 +34,11 @@
 #define PPC_FEATURE_TRUE_LE                             0x00000002
 #define PPC_FEATURE_PPC_LE                              0x00000001
 
+/* in AT_HWCAP2 */
+#define PPC_FEATURE2_ARCH_2_07                          0x80000000
+#define PPC_FEATURE2_HTM                                0x40000000
+#define PPC_FEATURE2_DSCR                               0x20000000
+#define PPC_FEATURE2_EBB                                0x10000000
+#define PPC_FEATURE2_ISEL                               0x08000000
+
 #endif /* _UAPI__ASM_POWERPC_CPUTABLE_H */
diff --git a/arch/powerpc/kernel/cputable.c 
b/arch/powerpc/kernel/cputable.c
index ae9f433..871c741 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -102,6 +102,9 @@ extern void __restore_cpu_e6500(void);
 PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \
 PPC_FEATURE_TRUE_LE | \
 PPC_FEATURE_PSERIES_PERFMON_COMPAT)
+#define COMMON_USER2_POWER8             (PPC_FEATURE2_ARCH_2_07 | 
PPC_FEATURE2_HTM | \
+ PPC_FEATURE2_DSCR | PPC_FEATURE2_EBB | \
+ PPC_FEATURE2_ISEL)
 #define COMMON_USER_PA6T                (COMMON_USER_PPC64 | 
PPC_FEATURE_PA6T |\
 PPC_FEATURE_TRUE_LE | \
 PPC_FEATURE_HAS_ALTIVEC_COMP)
@@ -443,6 +446,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
                                 .cpu_name                               = 
"POWER8 (architected)",
                                 .cpu_features                           = 
CPU_FTRS_POWER8,
                                 .cpu_user_features              = 
COMMON_USER_POWER8,
+                                .cpu_user_features2             = 
COMMON_USER2_POWER8,
                                 .mmu_features                           = 
MMU_FTRS_POWER8,
                                 .icache_bsize                           = 
128,
                                 .dcache_bsize                           = 
128,
@@ -492,6 +496,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
                                 .cpu_name                               = 
"POWER8 (raw)",
                                 .cpu_features                           = 
CPU_FTRS_POWER8,
                                 .cpu_user_features              = 
COMMON_USER_POWER8,
+                                .cpu_user_features2             = 
COMMON_USER2_POWER8,
                                 .mmu_features                           = 
MMU_FTRS_POWER8,
                                 .icache_bsize                           = 
128,
                                 .dcache_bsize                           = 
128,



--=_alternative 0080BB7285257B60_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">According to the GCC sources, ISEL is enabled
by default for the 8540, 8548, e500mc, e500mc64, e6500 processors.</font>
<br>
<br>
<br>
<table width=100%>
<tr valign=top>
<td><font size=1 color=#5f5f5f face="sans-serif">From:</font>
<td><font size=1 face="sans-serif">Nishanth Aravamudan &lt;nacc@linux.vnet.ibm.com&gt;</font>
<tr valign=top>
<td><font size=1 color=#5f5f5f face="sans-serif">To:</font>
<td><font size=1 face="sans-serif">benh@kernel.crashing.org, </font>
<tr>
<td valign=top><font size=1 color=#5f5f5f face="sans-serif">Cc:</font>
<td><font size=1 face="sans-serif">Steve Munroe/Rochester/IBM@IBMUS, Peter
Bergner/Rochester/IBM@IBMUS, Michael R Meissner/Cambridge/IBM@IBMUS, Michael
Neuling &lt;michael.neuling@au1.ibm.com&gt;, linuxppc-dev@lists.ozlabs.org,
Ryan Arnold/Rochester/IBM@IBMUS</font>
<tr valign=top>
<td><font size=1 color=#5f5f5f face="sans-serif">Date:</font>
<td><font size=1 face="sans-serif">05/03/2013 07:19 PM</font>
<tr valign=top>
<td><font size=1 color=#5f5f5f face="sans-serif">Subject:</font>
<td><font size=1 face="sans-serif">[PATCH] arch/powerpc: advertise ISA2.07,
HTM, DSCR, EBB and ISEL bits in HWCAP2</font></table>
<br>
<hr noshade>
<br>
<br>
<br><tt><font size=2>Now that we have AT_HWCAP2 support, start exposing
some of the new<br>
POWER8 features via it.<br>
<br>
Signed-off-by: Nishanth Aravamudan &lt;nacc@us.ibm.com&gt;<br>
<br>
---<br>
Note: there are, I think, some Freescale processors that also should be<br>
updated to indicate they support ISEL, but I don't know which ones.<br>
Since this is a new feature bit (and vector), it seems like we can fix<br>
that up in a follow-on patch. Also, this is my first patch trying to<br>
manipulate these bits, so please let me know if I'm doing something<br>
wrong (for instance, I don't see any particular order to the bits in<br>
PPC_FEATURE_*)<br>
<br>
diff --git a/arch/powerpc/include/uapi/asm/cputable.h b/arch/powerpc/include/uapi/asm/cputable.h<br>
index ed9dd81..78db4e2 100644<br>
--- a/arch/powerpc/include/uapi/asm/cputable.h<br>
+++ b/arch/powerpc/include/uapi/asm/cputable.h<br>
@@ -1,6 +1,7 @@<br>
 #ifndef _UAPI__ASM_POWERPC_CPUTABLE_H<br>
 #define _UAPI__ASM_POWERPC_CPUTABLE_H<br>
 <br>
+/* in AT_HWCAP */<br>
 #define PPC_FEATURE_32 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; 0x80000000<br>
 #define PPC_FEATURE_64 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; 0x40000000<br>
 #define PPC_FEATURE_601_INSTR &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;0x20000000<br>
@@ -33,4 +34,11 @@<br>
 #define PPC_FEATURE_TRUE_LE &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;0x00000002<br>
 #define PPC_FEATURE_PPC_LE &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;0x00000001<br>
 <br>
+/* in AT_HWCAP2 */<br>
+#define PPC_FEATURE2_ARCH_2_07 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;0x80000000<br>
+#define PPC_FEATURE2_HTM &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;0x40000000<br>
+#define PPC_FEATURE2_DSCR &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;0x20000000<br>
+#define PPC_FEATURE2_EBB &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;0x10000000<br>
+#define PPC_FEATURE2_ISEL &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp;0x08000000<br>
+<br>
 #endif /* _UAPI__ASM_POWERPC_CPUTABLE_H */<br>
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c<br>
index ae9f433..871c741 100644<br>
--- a/arch/powerpc/kernel/cputable.c<br>
+++ b/arch/powerpc/kernel/cputable.c<br>
@@ -102,6 +102,9 @@ extern void __restore_cpu_e6500(void);<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;PPC_FEATURE_SMT | PPC_FEATURE_ICACHE_SNOOP | \<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;PPC_FEATURE_TRUE_LE | \<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;PPC_FEATURE_PSERIES_PERFMON_COMPAT)<br>
+#define COMMON_USER2_POWER8 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; (PPC_FEATURE2_ARCH_2_07 | PPC_FEATURE2_HTM
| \<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
PPC_FEATURE2_DSCR | PPC_FEATURE2_EBB | \<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
PPC_FEATURE2_ISEL)<br>
 #define COMMON_USER_PA6T &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; (COMMON_USER_PPC64 | PPC_FEATURE_PA6T |\<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;PPC_FEATURE_TRUE_LE | \<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp;PPC_FEATURE_HAS_ALTIVEC_COMP)<br>
@@ -443,6 +446,7 @@ static struct cpu_spec __initdata cpu_specs[] = {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
.cpu_name &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
&quot;POWER8 (architected)&quot;,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
.cpu_features &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;= CPU_FTRS_POWER8,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
.cpu_user_features &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; = COMMON_USER_POWER8,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.cpu_user_features2
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
= COMMON_USER2_POWER8,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
.mmu_features &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;= MMU_FTRS_POWER8,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
.icache_bsize &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;= 128,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
.dcache_bsize &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;= 128,<br>
@@ -492,6 +496,7 @@ static struct cpu_spec __initdata cpu_specs[] = {<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
.cpu_name &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;=
&quot;POWER8 (raw)&quot;,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
.cpu_features &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;= CPU_FTRS_POWER8,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
.cpu_user_features &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; = COMMON_USER_POWER8,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;.cpu_user_features2
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
= COMMON_USER2_POWER8,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
.mmu_features &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;= MMU_FTRS_POWER8,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
.icache_bsize &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;= 128,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
.dcache_bsize &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp;= 128,<br>
</font></tt>
<br>
<br>
--=_alternative 0080BB7285257B60_=--
