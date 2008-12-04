Return-Path: <glikely@secretlab.ca>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.233])
	by ozlabs.org (Postfix) with ESMTP id 036F2DDDF6
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 02:39:59 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so4167185rvb.9
	for <linuxppc-dev@ozlabs.org>; Thu, 04 Dec 2008 07:39:58 -0800 (PST)
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [PATCH] powerpc/virtex5: Fix Virtex5 machine check handling
To: john.linn@xilinx.com, jwboyer@linux.vnet.ibm.com, benh@kernel.crashing.org,
	linuxppc-dev@ozlabs.org
Date: Thu, 04 Dec 2008 08:39:55 -0700
Message-ID: <20081204153955.16903.55398.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>

The 440x5 core in the Virtex5 uses the 440A type machine check
(ie, they have MCSRR0/MCSRR1). They thus need to call the
appropriate fixup function to hook the right variant of the
exception.

Without this, all machine checks become fatal due to loss
of context when entering the exception handler.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---

 arch/powerpc/kernel/cpu_setup_44x.S |    1 +
 arch/powerpc/kernel/cputable.c      |    3 +++
 2 files changed, 4 insertions(+), 0 deletions(-)


diff --git a/arch/powerpc/kernel/cpu_setup_44x.S b/arch/powerpc/kernel/cpu_setup_44x.S
index 31c18b5..10b4ab1 100644
--- a/arch/powerpc/kernel/cpu_setup_44x.S
+++ b/arch/powerpc/kernel/cpu_setup_44x.S
@@ -40,6 +40,7 @@ _GLOBAL(__setup_cpu_460gt)
 	mtlr	r4
 	blr
 
+_GLOBAL(__setup_cpu_440x5)
 _GLOBAL(__setup_cpu_440gx)
 _GLOBAL(__setup_cpu_440spe)
 	b	__fixup_440A_mcheck
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index b1eb834..7e87195 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -39,6 +39,7 @@ extern void __setup_cpu_440epx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_440gx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_440grx(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_440spe(unsigned long offset, struct cpu_spec* spec);
+extern void __setup_cpu_440x5(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_460ex(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_460gt(unsigned long offset, struct cpu_spec* spec);
 extern void __setup_cpu_603(unsigned long offset, struct cpu_spec* spec);
@@ -1500,6 +1501,8 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_user_features	= COMMON_USER_BOOKE,
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
+		.cpu_setup		= __setup_cpu_440x5,
+		.machine_check		= machine_check_440A,
 		.platform		= "ppc440",
 	},
 	{ /* 460EX */
