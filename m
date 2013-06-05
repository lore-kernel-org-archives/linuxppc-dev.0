Return-Path: <B44306@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe002.messaging.microsoft.com [213.199.154.205])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 364BE2C0095
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Jun 2013 06:22:19 +1000 (EST)
Received: from mail99-am1 (localhost [127.0.0.1])	by mail99-am1-R.bigfish.com
 (Postfix) with ESMTP id 69486200A5	for <linuxppc-dev@ozlabs.org>;
 Wed,  5 Jun 2013 20:22:14 +0000 (UTC)
Received: from AM1EHSMHS019.bigfish.com (unknown [10.3.201.226])	by
 mail99-am1.bigfish.com (Postfix) with ESMTP id 607F23A0057	for
 <linuxppc-dev@ozlabs.org>; Wed,  5 Jun 2013 20:22:12 +0000 (UTC)
From: Lijun Pan <Lijun.Pan@freescale.com>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 3/4] powerpc/perf: add 2 additional performance monitor
 counters for e6500 core
Date: Wed, 5 Jun 2013 15:22:09 -0500
Message-ID: <1370463730-23733-3-git-send-email-Lijun.Pan@freescale.com>
In-Reply-To: <1370463730-23733-1-git-send-email-Lijun.Pan@freescale.com>
References: <1370463730-23733-1-git-send-email-Lijun.Pan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Lijun.Pan@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

There are 6 counters in e6500 core instead of 4 in e500 core.

Signed-off-by: Lijun Pan <Lijun.Pan@freescale.com>
---
 arch/powerpc/include/asm/reg_fsl_emb.h   |   12 ++++++++++++
 arch/powerpc/kernel/cputable.c           |    2 +-
 arch/powerpc/oprofile/op_model_fsl_emb.c |   30 ++++++++++++++++++++++++++++++
 arch/powerpc/perf/core-fsl-emb.c         |   24 ++++++++++++++++++++++++
 4 files changed, 67 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/reg_fsl_emb.h b/arch/powerpc/include/asm/reg_fsl_emb.h
index 1cf8ab0..c51d52e 100644
--- a/arch/powerpc/include/asm/reg_fsl_emb.h
+++ b/arch/powerpc/include/asm/reg_fsl_emb.h
@@ -19,10 +19,14 @@
 #define PMRN_PMC1	0x011	/* Performance Monitor Counter 1 */
 #define PMRN_PMC2	0x012	/* Performance Monitor Counter 2 */
 #define PMRN_PMC3	0x013	/* Performance Monitor Counter 3 */
+#define PMRN_PMC4	0x014	/* Performance Monitor Counter 4 */
+#define PMRN_PMC5	0x015	/* Performance Monitor Counter 5 */
 #define PMRN_PMLCA0	0x090	/* PM Local Control A0 */
 #define PMRN_PMLCA1	0x091	/* PM Local Control A1 */
 #define PMRN_PMLCA2	0x092	/* PM Local Control A2 */
 #define PMRN_PMLCA3	0x093	/* PM Local Control A3 */
+#define PMRN_PMLCA4	0x094	/* PM Local Control A4 */
+#define PMRN_PMLCA5	0x095	/* PM Local Control A5 */
 
 #define PMLCA_FC	0x80000000	/* Freeze Counter */
 #define PMLCA_FCS	0x40000000	/* Freeze in Supervisor */
@@ -38,6 +42,8 @@
 #define PMRN_PMLCB1	0x111	/* PM Local Control B1 */
 #define PMRN_PMLCB2	0x112	/* PM Local Control B2 */
 #define PMRN_PMLCB3	0x113	/* PM Local Control B3 */
+#define PMRN_PMLCB4	0x114	/* PM Local Control B4 */
+#define PMRN_PMLCB5	0x115	/* PM Local Control B5 */
 
 #define PMLCB_THRESHMUL_MASK	0x0700	/* Threshold Multiple Field */
 #define PMLCB_THRESHMUL_SHIFT	8
@@ -57,14 +63,20 @@
 #define PMRN_UPMC1	0x001	/* User Performance Monitor Counter 1 */
 #define PMRN_UPMC2	0x002	/* User Performance Monitor Counter 2 */
 #define PMRN_UPMC3	0x003	/* User Performance Monitor Counter 3 */
+#define PMRN_UPMC4	0x004	/* User Performance Monitor Counter 4 */
+#define PMRN_UPMC5	0x005	/* User Performance Monitor Counter 5 */
 #define PMRN_UPMLCA0	0x080	/* User PM Local Control A0 */
 #define PMRN_UPMLCA1	0x081	/* User PM Local Control A1 */
 #define PMRN_UPMLCA2	0x082	/* User PM Local Control A2 */
 #define PMRN_UPMLCA3	0x083	/* User PM Local Control A3 */
+#define PMRN_UPMLCA4	0x084	/* User PM Local Control A4 */
+#define PMRN_UPMLCA5	0x085	/* User PM Local Control A5 */
 #define PMRN_UPMLCB0	0x100	/* User PM Local Control B0 */
 #define PMRN_UPMLCB1	0x101	/* User PM Local Control B1 */
 #define PMRN_UPMLCB2	0x102	/* User PM Local Control B2 */
 #define PMRN_UPMLCB3	0x103	/* User PM Local Control B3 */
+#define PMRN_UPMLCB4	0x104	/* User PM Local Control B4 */
+#define PMRN_UPMLCB5	0x105	/* User PM Local Control B5 */
 #define PMRN_UPMGC0	0x180	/* User PM Global Control 0 */
 
 
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index cc39139..2d4eee2 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -2073,7 +2073,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 			MMU_FTR_USE_TLBILX,
 		.icache_bsize		= 64,
 		.dcache_bsize		= 64,
-		.num_pmcs		= 4,
+		.num_pmcs		= 6,
 		.oprofile_cpu_type	= "ppc/e6500",
 		.oprofile_type		= PPC_OPROFILE_FSL_EMB,
 		.cpu_setup		= __setup_cpu_e6500,
diff --git a/arch/powerpc/oprofile/op_model_fsl_emb.c b/arch/powerpc/oprofile/op_model_fsl_emb.c
index ccc1daa..2a82d3e 100644
--- a/arch/powerpc/oprofile/op_model_fsl_emb.c
+++ b/arch/powerpc/oprofile/op_model_fsl_emb.c
@@ -46,6 +46,12 @@ static inline u32 get_pmlca(int ctr)
 		case 3:
 			pmlca = mfpmr(PMRN_PMLCA3);
 			break;
+		case 4:
+			pmlca = mfpmr(PMRN_PMLCA4);
+			break;
+		case 5:
+			pmlca = mfpmr(PMRN_PMLCA5);
+			break;
 		default:
 			panic("Bad ctr number\n");
 	}
@@ -68,6 +74,12 @@ static inline void set_pmlca(int ctr, u32 pmlca)
 		case 3:
 			mtpmr(PMRN_PMLCA3, pmlca);
 			break;
+		case 4:
+			mtpmr(PMRN_PMLCA4, pmlca);
+			break;
+		case 5:
+			mtpmr(PMRN_PMLCA5, pmlca);
+			break;
 		default:
 			panic("Bad ctr number\n");
 	}
@@ -84,6 +96,10 @@ static inline unsigned int ctr_read(unsigned int i)
 			return mfpmr(PMRN_PMC2);
 		case 3:
 			return mfpmr(PMRN_PMC3);
+		case 4:
+			return mfpmr(PMRN_PMC4);
+		case 5:
+			return mfpmr(PMRN_PMC5);
 		default:
 			return 0;
 	}
@@ -104,6 +120,12 @@ static inline void ctr_write(unsigned int i, unsigned int val)
 		case 3:
 			mtpmr(PMRN_PMC3, val);
 			break;
+		case 4:
+			mtpmr(PMRN_PMC4, val);
+			break;
+		case 5:
+			mtpmr(PMRN_PMC5, val);
+			break;
 		default:
 			break;
 	}
@@ -133,6 +155,14 @@ static void init_pmc_stop(int ctr)
 			mtpmr(PMRN_PMLCA3, pmlca);
 			mtpmr(PMRN_PMLCB3, pmlcb);
 			break;
+		case 4:
+			mtpmr(PMRN_PMLCA4, pmlca);
+			mtpmr(PMRN_PMLCB4, pmlcb);
+			break;
+		case 5:
+			mtpmr(PMRN_PMLCA5, pmlca);
+			mtpmr(PMRN_PMLCB5, pmlcb);
+			break;
 		default:
 			panic("Bad ctr number!\n");
 	}
diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
index 0b13f74..d35ae52 100644
--- a/arch/powerpc/perf/core-fsl-emb.c
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -70,6 +70,12 @@ static unsigned long read_pmc(int idx)
 	case 3:
 		val = mfpmr(PMRN_PMC3);
 		break;
+	case 4:
+		val = mfpmr(PMRN_PMC4);
+		break;
+	case 5:
+		val = mfpmr(PMRN_PMC5);
+		break;
 	default:
 		printk(KERN_ERR "oops trying to read PMC%d\n", idx);
 		val = 0;
@@ -95,6 +101,12 @@ static void write_pmc(int idx, unsigned long val)
 	case 3:
 		mtpmr(PMRN_PMC3, val);
 		break;
+	case 4:
+		mtpmr(PMRN_PMC4, val);
+		break;
+	case 5:
+		mtpmr(PMRN_PMC5, val);
+		break;
 	default:
 		printk(KERN_ERR "oops trying to write PMC%d\n", idx);
 	}
@@ -120,6 +132,12 @@ static void write_pmlca(int idx, unsigned long val)
 	case 3:
 		mtpmr(PMRN_PMLCA3, val);
 		break;
+	case 4:
+		mtpmr(PMRN_PMLCA4, val);
+		break;
+	case 5:
+		mtpmr(PMRN_PMLCA5, val);
+		break;
 	default:
 		printk(KERN_ERR "oops trying to write PMLCA%d\n", idx);
 	}
@@ -145,6 +163,12 @@ static void write_pmlcb(int idx, unsigned long val)
 	case 3:
 		mtpmr(PMRN_PMLCB3, val);
 		break;
+	case 4:
+		mtpmr(PMRN_PMLCB4, val);
+		break;
+	case 5:
+		mtpmr(PMRN_PMLCB5, val);
+		break;
 	default:
 		printk(KERN_ERR "oops trying to write PMLCB%d\n", idx);
 	}
-- 
1.7.9.7
