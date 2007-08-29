Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1236DDD07
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 08:27:44 +1000 (EST)
Date: Wed, 29 Aug 2007 17:27:38 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'for-2.6.23'
Message-ID: <Pine.LNX.4.64.0708291727240.26956@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'for-2.6.23' branch of

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for-2.6.23

to receive the following updates:

 arch/powerpc/configs/linkstation_defconfig   |  219 ++----
 arch/powerpc/configs/lite5200_defconfig      |  191 +----
 arch/powerpc/configs/mpc7448_hpc2_defconfig  |  202 +-----
 arch/powerpc/configs/mpc8272_ads_defconfig   |  193 +----
 arch/powerpc/configs/mpc8313_rdb_defconfig   |  224 ++----
 arch/powerpc/configs/mpc832x_mds_defconfig   |  209 +-----
 arch/powerpc/configs/mpc832x_rdb_defconfig   |  211 +-----
 arch/powerpc/configs/mpc834x_itx_defconfig   |  206 +-----
 arch/powerpc/configs/mpc834x_itxgp_defconfig |  203 +-----
 arch/powerpc/configs/mpc834x_mds_defconfig   |  205 +-----
 arch/powerpc/configs/mpc836x_mds_defconfig   |  209 +-----
 arch/powerpc/configs/mpc8540_ads_defconfig   |  183 +----
 arch/powerpc/configs/mpc8544_ds_defconfig    |  459 ++++++++++++--
 arch/powerpc/configs/mpc8560_ads_defconfig   |  196 +-----
 arch/powerpc/configs/mpc8568mds_defconfig    |   43 -
 arch/powerpc/configs/mpc85xx_cds_defconfig   |  198 +-----
 arch/powerpc/configs/mpc8641_hpcn_defconfig  |  880 +++++++++++++++++++++------
 arch/powerpc/configs/mpc866_ads_defconfig    |  174 +----
 arch/powerpc/configs/mpc885_ads_defconfig    |  174 +----
 arch/powerpc/configs/prpmc2800_defconfig     |  213 +-----
 arch/powerpc/kernel/process.c                |    6
 21 files changed, 2134 insertions(+), 2664 deletions(-)

Kumar Gala (2):
      [POWERPC] Flush registers to proper task context
      [POWERPC] Update defconfigs

commit 5cc44e086d7a4e20035997ec612678ca91f426e7
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Tue Aug 28 21:46:53 2007 -0500

    [POWERPC] Update defconfigs

    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

commit 0ee6c15e7ba7b36a217cdadb292eeaf32a057a59
Author: Kumar Gala <galak@kernel.crashing.org>
Date:   Tue Aug 28 21:15:53 2007 -0500

    [POWERPC] Flush registers to proper task context

    When we flush register state for FP, Altivec, or SPE in flush_*_to_thread
    we need to respect the task_struct that the caller has passed to us.

    Most cases we are called with current, however sometimes (ptrace) we may
    be passed a different task_struct.

    This showed up when using gdbserver debugging a simple program that used
    floating point. When gdb tried to show the FP regs they all showed up as
    0, because the child's FP registers were never properly flushed to memory.

    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index a83727b..e477c9d 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -83,7 +83,7 @@ void flush_fp_to_thread(struct task_struct *tsk)
 			 */
 			BUG_ON(tsk != current);
 #endif
-			giveup_fpu(current);
+			giveup_fpu(tsk);
 		}
 		preempt_enable();
 	}
@@ -143,7 +143,7 @@ void flush_altivec_to_thread(struct task_struct *tsk)
 #ifdef CONFIG_SMP
 			BUG_ON(tsk != current);
 #endif
-			giveup_altivec(current);
+			giveup_altivec(tsk);
 		}
 		preempt_enable();
 	}
@@ -182,7 +182,7 @@ void flush_spe_to_thread(struct task_struct *tsk)
 #ifdef CONFIG_SMP
 			BUG_ON(tsk != current);
 #endif
-			giveup_spe(current);
+			giveup_spe(tsk);
 		}
 		preempt_enable();
 	}
