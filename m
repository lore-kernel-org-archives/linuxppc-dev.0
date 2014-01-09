Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0152.outbound.protection.outlook.com [207.46.163.152])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A352F2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jan 2014 10:51:49 +1100 (EST)
Date: Thu, 9 Jan 2014 17:51:34 -0600
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Subject: Re: [v6,4/4] powerpc/85xx: add sysfs for pw20 state and altivec idle
Message-ID: <20140109235134.GA24262@home.buserror.net>
References: <1387268222-9703-4-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1387268222-9703-4-git-send-email-dongsheng.wang@freescale.com>
Cc: Bharat.Bhushan@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 17, 2013 at 04:17:02PM +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Add a sys interface to enable/diable pw20 state or altivec idle, and
> control the wait entry time.
> 
> Enable/Disable interface:
>     0, disable. 1, enable.
>     /sys/devices/system/cpu/cpuX/pw20_state
>     /sys/devices/system/cpu/cpuX/altivec_idle
> 
> Set wait time interface:(Nanosecond)
>     /sys/devices/system/cpu/cpuX/pw20_wait_time
>     /sys/devices/system/cpu/cpuX/altivec_idle_wait_time
> Example: Base on TBfreq is 41MHZ.
>     1~48(ns): TB[63]
>     49~97(ns): TB[62]
>     98~195(ns): TB[61]
>     196~390(ns): TB[60]
>     391~780(ns): TB[59]
>     781~1560(ns): TB[58]
>     ...
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

This causes ppc6xx_defconfig to fail to build:

  CC      arch/powerpc/kernel/sysfs.o
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c: In function 'show_pw20_state':
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c:125:11: error: 'PWRMGTCR0_PW20_WAIT' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c:125:11: note: each undeclared identifier is reported only once for each function it appears in
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c: In function 'do_store_pw20_state':
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c:138:17: error: 'PWRMGTCR0_PW20_WAIT' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c: In function 'show_pw20_wait_time':
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c:174:20: error: 'PWRMGTCR0_PW20_ENT' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c:175:6: error: 'PWRMGTCR0_PW20_ENT_SHIFT' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c: In function 'set_pw20_wait_entry_bit':
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c:204:16: error: 'PWRMGTCR0_PW20_ENT' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c:207:33: error: 'PWRMGTCR0_PW20_ENT_SHIFT' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c: In function 'show_altivec_idle':
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c:247:11: error: 'PWRMGTCR0_AV_IDLE_PD_EN' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c: In function 'do_store_altivec_idle':
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c:260:19: error: 'PWRMGTCR0_AV_IDLE_PD_EN' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c: In function 'show_altivec_idle_wait_time':
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c:296:20: error: 'PWRMGTCR0_AV_IDLE_CNT' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c:297:6: error: 'PWRMGTCR0_AV_IDLE_CNT_SHIFT' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c: In function 'set_altivec_idle_wait_entry_bit':
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c:326:19: error: 'PWRMGTCR0_AV_IDLE_CNT' undeclared (first use in this function)
/home/scott/fsl/git/linux/upstream/arch/powerpc/kernel/sysfs.c:329:36: error: 'PWRMGTCR0_AV_IDLE_CNT_SHIFT' undeclared (first use in this function)
make[2]: *** [arch/powerpc/kernel/sysfs.o] Error 1
make[1]: *** [arch/powerpc/kernel] Error 2
make[1]: *** Waiting for unfinished jobs....
make: *** [sub-make] Error 2

I'll fix when applying with this:

diff --git a/arch/powerpc/kernel/sysfs.c b/arch/powerpc/kernel/sysfs.c
index 9af9e37..d4a43e6 100644
--- a/arch/powerpc/kernel/sysfs.c
+++ b/arch/powerpc/kernel/sysfs.c
@@ -86,7 +86,7 @@ __setup("smt-snooze-delay=", setup_smt_snooze_delay);
 
 #endif /* CONFIG_PPC64 */
 
-#ifdef CONFIG_FSL_SOC
+#ifdef CONFIG_PPC_FSL_BOOK3E
 #define MAX_BIT				63
 
 static u64 pw20_wt;
@@ -723,7 +723,7 @@ static void register_cpu_online(unsigned int cpu)
 		device_create_file(s, &dev_attr_pir);
 #endif /* CONFIG_PPC64 */
 
-#ifdef CONFIG_FSL_SOC
+#ifdef CONFIG_PPC_FSL_BOOK3E
 	if (PVR_VER(cur_cpu_spec->pvr_value) == PVR_VER_E6500) {
 		device_create_file(s, &dev_attr_pw20_state);
 		device_create_file(s, &dev_attr_pw20_wait_time);
@@ -804,7 +804,7 @@ static void unregister_cpu_online(unsigned int cpu)
 		device_remove_file(s, &dev_attr_pir);
 #endif /* CONFIG_PPC64 */
 
-#ifdef CONFIG_FSL_SOC
+#ifdef CONFIG_PPC_FSL_BOOK3E
 	if (PVR_VER(cur_cpu_spec->pvr_value) == PVR_VER_E6500) {
 		device_remove_file(s, &dev_attr_pw20_state);
 		device_remove_file(s, &dev_attr_pw20_wait_time);

-Scott
