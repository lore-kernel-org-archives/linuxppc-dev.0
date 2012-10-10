Return-Path: <sshen@haliplex.com>
Received: from bne3-0003mrc.server-mail.com (bne3-0003mrc.server-mail.com
 [203.147.156.27]) by ozlabs.org (Postfix) with ESMTP id 8D9782C008A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 09:21:58 +1100 (EST)
Received: from wic001mz.server-mail.com (wic001mz.server-mail.com
 [210.247.173.1])
 by bne3-0003mrc.server-mail.com (Postfix) with ESMTP id EA7FBF80B2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Oct 2012 08:16:44 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: Re: Contents of Linuxppc-dev digest..."
Date: Thu, 11 Oct 2012 08:15:10 +1000
Message-ID: <95BF871CD8FA7E41888131382210BEF703C03580@WIC003EBCLV1.exchange.server-login.com>
From: "Sam Shen" <sshen@haliplex.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



-----Original Message-----
From: Linuxppc-dev
[mailto:linuxppc-dev-bounces+sshen=3Dhaliplex.com@lists.ozlabs.org] On
Behalf Of linuxppc-dev-request@lists.ozlabs.org
Sent: Thursday, 11 October 2012 7:57 AM
To: linuxppc-dev@lists.ozlabs.org
Subject: Linuxppc-dev Digest, Vol 98, Issue 38

Send Linuxppc-dev mailing list submissions to
	linuxppc-dev@lists.ozlabs.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://lists.ozlabs.org/listinfo/linuxppc-dev
or, via email, send a message with subject or body 'help' to
	linuxppc-dev-request@lists.ozlabs.org

You can reach the person managing the list at
	linuxppc-dev-owner@lists.ozlabs.org

When replying, please edit your Subject line so it is more specific than
"Re: Contents of Linuxppc-dev digest..."


Today's Topics:

   1. [RESEND PATCH v1 3/3] cpuidle: (POWER) Fix snooze state
      problem persistant in the current cpuidle design on pseries.
      (Deepthi Dharwar)
   2. [RESEND PATCH v1 1/3] cpuidle: (POWER) Fix target residency
      initialisation in pseries cpuidle (Deepthi Dharwar)
   3. [PATCH 3.6.0- 2/2] powerpc/sysdev: use module_platform_driver
      macro (Srinivas KANDAGATLA)
   4. [PATCH 3.6.0- 1/2] powerpc/mpc52xx: use
      module_platform_driver macro (Srinivas KANDAGATLA)
   5. [PATCH 3.6.0- 0/2] POWERPC: use module_platform_driver macro
      (Srinivas KANDAGATLA)
   6. Re: Changing TASK_UNMAPPED_BASE to a low address
      (Thomas De Schampheleire)
   7. [PATCH] powerpc: 52xx: nop out unsupported critical IRQs
      (Wolfram Sang)


----------------------------------------------------------------------

Message: 1
Date: Wed, 10 Oct 2012 12:59:23 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	benh@kernel.crashing.org
Subject: [RESEND PATCH v1 3/3] cpuidle: (POWER) Fix snooze state
	problem persistant in the current cpuidle design on pseries.
Message-ID: <20121010072921.29317.67508.stgit@deepthi.in.ibm.com>
Content-Type: text/plain; charset=3D"utf-8"

Earlier without cpuidle framework on pseries, the native arch idle
routine comprised of both snooze and nap states.  smt_snooze_delay
variable was used to delay the idle process entry to deeper idle state
like  nap.
With the coming of cpuidle, this arch specific idle was replaced by two
different idle routines, one for supporting snooze and other for nap.
This enabled addition of more low level idle states on pseries in the
future.

On adopting the generic cpuidle framework for POWER systems, the
decision of which idle state to choose from,  given a predicted idle
time is taken by the menu governor based on target_residency and
exit_latency of the idle states.
target_residency is the minimum time to be resident in that idle state.
Exit_latency is time taken to exit out of idle state.
Deeper the idle state, both the target residency and exit latency would
be higher.

In the current design, smt_snooze_delay is used as target_residency for
the  snooze state which is incorrect, as it is not the minimum but the
maximum duration to be in snooze state.
This would  result in the governor in taking bad decision, as presently
target_residency of nap < target_residency of snooze inspite of nap
being deeper idle state.

This patch aims to fix this problem by replacing the smt_snooze_delay
loop in snooze state, with the need_resched()  as the governor is aware
of entry and exit of various idle transitions based on which next idle
time prediction.

The governor is intelligent enough to determine the idle state the needs
to be transitioned to and maintains a whole of heuristics including io
load, previous idle states predictions etc for the same, based on which
idle state entry decision is taken.

With this fix, of setting target_residency of snooze to 0
					     nap to smt_snooze_delay
if the predicted idle time is less
than smt_snooze_delay (target_residency of nap) value governor would
pick snooze state, else nap. This adhers to the previous native idle
design.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---

 arch/powerpc/platforms/pseries/processor_idle.c |   36
++++++++---------------
 1 file changed, 13 insertions(+), 23 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/processor_idle.c
b/arch/powerpc/platforms/pseries/processor_idle.c
index a32d56d..45d00e5 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -59,32 +59,22 @@ static int snooze_loop(struct cpuidle_device *dev,
{
 	unsigned long in_purr;
 	ktime_t kt_before;
-	unsigned long start_snooze;
-	long snooze =3D drv->states[0].target_residency;
+	int cpu =3D dev->cpu;
=20
 	idle_loop_prolog(&in_purr, &kt_before);
+	local_irq_enable();
+	set_thread_flag(TIF_POLLING_NRFLAG);
=20
-	if (snooze) {
-		start_snooze =3D get_tb() + snooze * tb_ticks_per_usec;
-		local_irq_enable();
-		set_thread_flag(TIF_POLLING_NRFLAG);
-
-		while ((snooze < 0) || (get_tb() < start_snooze)) {
-			if (need_resched() || cpu_is_offline(dev->cpu))
-				goto out;
-			ppc64_runlatch_off();
-			HMT_low();
-			HMT_very_low();
-		}
-
-		HMT_medium();
-		clear_thread_flag(TIF_POLLING_NRFLAG);
-		smp_mb();
-		local_irq_disable();
+	while ((!need_resched()) && cpu_online(cpu)) {
+		ppc64_runlatch_off();
+		HMT_low();
+		HMT_very_low();
 	}
=20
-out:
 	HMT_medium();
+	clear_thread_flag(TIF_POLLING_NRFLAG);
+	smp_mb();
+
 	dev->last_residency =3D
 		(int)idle_loop_epilog(in_purr, kt_before);
 	return index;
@@ -165,8 +155,8 @@ static struct cpuidle_state
dedicated_states[MAX_IDLE_STATE_COUNT] =3D {
 		.name =3D "CEDE",
 		.desc =3D "CEDE",
 		.flags =3D CPUIDLE_FLAG_TIME_VALID,
-		.exit_latency =3D 1,
-		.target_residency =3D 10,
+		.exit_latency =3D 10,
+		.target_residency =3D 100,
 		.enter =3D &dedicated_cede_loop },
 };
=20
@@ -197,7 +187,7 @@ void update_smt_snooze_delay(int cpu, int residency)
 			dev->states_usage[1].disable =3D 1;
 	} else
 		if (drv)
-			drv->states[0].target_residency =3D residency;
+			drv->states[1].target_residency =3D residency;
 }
=20
 static int pseries_cpuidle_add_cpu_notifier(struct notifier_block *n,



------------------------------

Message: 2
Date: Wed, 10 Oct 2012 12:59:08 +0530
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	benh@kernel.crashing.org
Subject: [RESEND PATCH v1 1/3] cpuidle: (POWER) Fix target residency
	initialisation in pseries cpuidle
Message-ID: <20121010072906.29317.32144.stgit@deepthi.in.ibm.com>
Content-Type: text/plain; charset=3D"utf-8"

Remove the redundant target residency initialisation in
pseries_cpuidle_driver_init().
This is currently over-writing the residency time updated as part of the
static table, resulting in  all the idle states having the same target
residency of 100us which is incorrect. This may result in the menu
governor making wrong state decisions.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---

 arch/powerpc/platforms/pseries/processor_idle.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/processor_idle.c
b/arch/powerpc/platforms/pseries/processor_idle.c
index 455760b..02e425a 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -246,10 +246,6 @@ static int pseries_cpuidle_driver_init(void)
 		drv->states[drv->state_count] =3D	/* structure copy */
 			cpuidle_state_table[idle_state];
=20
-		if (cpuidle_state_table =3D=3D dedicated_states)
-			drv->states[drv->state_count].target_residency =3D
-				__get_cpu_var(smt_snooze_delay);
-
 		drv->state_count +=3D 1;
 	}
=20



------------------------------

Message: 3
Date: Wed, 10 Oct 2012 19:32:30 +0100
From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
To: grant.likely@secretlab.ca
Cc: krafft@de.ibm.com, agust@denx.de, linuxppc-dev@lists.ozlabs.org,
	srinivas.kandagatla@st.com
Subject: [PATCH 3.6.0- 2/2] powerpc/sysdev: use module_platform_driver
	macro
Message-ID:
	<1349893950-7710-1-git-send-email-srinivas.kandagatla@st.com>

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes some code duplication by using
module_platform_driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/powerpc/sysdev/pmi.c |   13 +------------
 1 files changed, 1 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/sysdev/pmi.c b/arch/powerpc/sysdev/pmi.c index
8f04654..5aaf86c 100644
--- a/arch/powerpc/sysdev/pmi.c
+++ b/arch/powerpc/sysdev/pmi.c
@@ -214,18 +214,7 @@ static struct platform_driver
pmi_of_platform_driver =3D {
 		.of_match_table =3D pmi_match,
 	},
 };
-
-static int __init pmi_module_init(void) -{
-	return platform_driver_register(&pmi_of_platform_driver);
-}
-module_init(pmi_module_init);
-
-static void __exit pmi_module_exit(void) -{
-	platform_driver_unregister(&pmi_of_platform_driver);
-}
-module_exit(pmi_module_exit);
+module_platform_driver(pmi_of_platform_driver);
=20
 int pmi_send_message(pmi_message_t msg)  {
--
1.7.0.4



------------------------------

Message: 4
Date: Wed, 10 Oct 2012 19:32:24 +0100
From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
To: grant.likely@secretlab.ca
Cc: krafft@de.ibm.com, agust@denx.de, linuxppc-dev@lists.ozlabs.org,
	srinivas.kandagatla@st.com
Subject: [PATCH 3.6.0- 1/2] powerpc/mpc52xx: use
	module_platform_driver macro
Message-ID:
	<1349893944-7675-1-git-send-email-srinivas.kandagatla@st.com>

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

This patch removes some code duplication by using
module_platform_driver.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@st.com>
---
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |   16 +---------------
 1 files changed, 1 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
index 2351f9e..16150fa 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -578,18 +578,4 @@ static struct platform_driver
mpc52xx_lpbfifo_driver =3D {
 	.probe =3D mpc52xx_lpbfifo_probe,
 	.remove =3D __devexit_p(mpc52xx_lpbfifo_remove),
 };
-
-/**********************************************************************
*
- * Module init/exit
- */
-static int __init mpc52xx_lpbfifo_init(void)
-{
-	return platform_driver_register(&mpc52xx_lpbfifo_driver);
-}
-module_init(mpc52xx_lpbfifo_init);
-
-static void __exit mpc52xx_lpbfifo_exit(void)
-{
-	platform_driver_unregister(&mpc52xx_lpbfifo_driver);
-}
-module_exit(mpc52xx_lpbfifo_exit);
+module_platform_driver(mpc52xx_lpbfifo_driver);
--=20
1.7.0.4



------------------------------

Message: 5
Date: Wed, 10 Oct 2012 19:32:17 +0100
From: Srinivas KANDAGATLA <srinivas.kandagatla@st.com>
To: grant.likely@secretlab.ca
Cc: krafft@de.ibm.com, agust@denx.de, linuxppc-dev@lists.ozlabs.org,
	srinivas.kandagatla@st.com
Subject: [PATCH 3.6.0- 0/2] POWERPC: use module_platform_driver macro
Message-ID:
	<1349893937-7642-1-git-send-email-srinivas.kandagatla@st.com>

From: Srinivas Kandagatla <srinivas.kandagatla@st.com>

Running below Coccinelle lookup pattern like below on the=20
latest kernel showed about 52 hits. This patch series is a subset=20
of those 52 patches, so that it will be easy for maintainers to review.
Hopefully these patches will get rid of some code duplication in kernel.

@  @
- initfunc(void)
- { return platform_driver_register(&dr); }

...

- module_init(initfunc);
...

- exitfunc(void)
- { platform_driver_unregister(&dr); }

...

- module_exit(exitfunc);
+ module_platform_driver(dr);=20

Srinivas Kandagatla (2):
  powerpc/mpc52xx: use module_platform_driver macro
  powerpc/sysdev: use module_platform_driver macro

 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |   16 +---------------
 arch/powerpc/sysdev/pmi.c                     |   13 +------------
 2 files changed, 2 insertions(+), 27 deletions(-)



------------------------------

Message: 6
Date: Wed, 10 Oct 2012 21:05:37 +0200
From: Thomas De Schampheleire <patrickdepinguin+linuxppc@gmail.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Cc: Ronny Meeus <Ronny.Meeus@gmail.com>,
	patrickdepinguin+linuxppc@gmail.com
Subject: Re: Changing TASK_UNMAPPED_BASE to a low address
Message-ID:
=09
<CAAXf6LUXWB_BxTO+go-CSdV+R8XYav1y7TaeMQTy-5GA=3DGXagA@mail.gmail.com>
Content-Type: text/plain; charset=3DISO-8859-1

Hi,

On Fri, Oct 5, 2012 at 11:47 AM, Thomas De Schampheleire
<patrickdepinguin+linuxppc@gmail.com> wrote:
> Hi,
>
> The current virtual address space of a 32-bit userspace process looks
> like this on powerpc:
> # cat /proc/28922/maps
> 00100000-00102000 r-xp 00000000 00:00 0          [vdso]
> 0fe70000-0ffd8000 r-xp 00000000 00:01 754        /lib/libc-2.10.1.so
> 0ffd8000-0ffe8000 ---p 00168000 00:01 754        /lib/libc-2.10.1.so
> 0ffe8000-0ffea000 r--p 00168000 00:01 754        /lib/libc-2.10.1.so
> 0ffea000-0ffed000 rwxp 0016a000 00:01 754        /lib/libc-2.10.1.so
> 0ffed000-0fff0000 rwxp 00000000 00:00 0
> 10000000-10001000 r-xp 00000000 00:12 73         /tmp/memory_alloc
> 10010000-10011000 rwxp 00000000 00:12 73         /tmp/memory_alloc
> 10011000-47a32000 rwxp 00000000 00:00 0          [heap]
> 48000000-4801d000 r-xp 00000000 00:01 793        /lib/ld-2.10.1.so
> 4801d000-4801f000 rw-p 00000000 00:00 0
> 4801f000-48021000 rw-p 00000000 00:00 0
> 4802d000-4802e000 r--p 0001d000 00:01 793        /lib/ld-2.10.1.so
> 4802e000-4802f000 rwxp 0001e000 00:01 793        /lib/ld-2.10.1.so
> 4802f000-bf6ee000 rw-p 00000000 00:00 0
> bfa18000-bfa39000 rw-p 00000000 00:00 0          [stack]
>
> The process text and data area are at 0x10000000 (fixed), the
> mmap_base is at 0x48000000 (TASK_UNMAPPED_BASE =3D 3/8*0xc0000000), =
and
> shared libraries are put directly above 0x10000000.
>
> When your application starts allocating memory, the first blocks are
> taken starting from mmap_base (0x48000000) until you reached the stack
> area (0xbfa18000 in this example). Then, a 'heap' region is created
> after the process text/data area (0x10011000 in this example) and the
> mmap_base (0x48000000). When this is also filled, any further
> allocation fails.
> However, between 0x0 and the first shared library, there is still
> plenty of space. Without any shared library, there would be approx.
> 256 MB free. Even with a few shared libraries, this typically is >200
> MB, at least in the type of applications I'm envisioning.
>
> Because of the 3GB/1GB userspace/kernelspace virtual address split,
> one expects an application to be able to allocate close to 3GB =3D =
3072
> MB. Due to the 256MB 'unused' area mentioned, you can only allocate
> something like 2800 MB. If your application needs more than that, and
> you're bound to 32-bit processors, this is a problem.
>
> I've been looking at two ways to use the extra memory:
> 1. do an anonymous mmap with an address hint in that range, e.g. at
> address 0x00110000. This does return memory, and if you know how much
> is free there, you can take all of it.
>
> 2. change the TASK_UNMAPPED_BASE setting in the kernel
> (arch/powerpc/include/asm/processor.h) to a low address, e.g. 0x40000.
> The advantage of this is that applications need no change.
>
> The second approach seems to work fine. The memory map changes to:
>
> # cat /proc/6954/maps
> 00040000-0005d000 r-xp 00000000 00:01 787        /lib/ld-2.10.1.so
> 0005d000-0005f000 rw-p 00000000 00:00 0
> 0005f000-00061000 rw-p 00000000 00:00 0
> 0006d000-0006e000 r--p 0001d000 00:01 787        /lib/ld-2.10.1.so
> 0006e000-0006f000 rwxp 0001e000 00:01 787        /lib/ld-2.10.1.so
> 00100000-00102000 r-xp 00000000 00:00 0          [vdso]
> 00102000-0c904000 rw-p 00000000 00:00 0
> 0ca00000-0ca21000 rw-p 00000000 00:00 0
> 0ca21000-0cb00000 ---p 00000000 00:00 0
> 0fe70000-0ffd8000 r-xp 00000000 00:01 750        /lib/libc-2.10.1.so
> 0ffd8000-0ffe8000 ---p 00168000 00:01 750        /lib/libc-2.10.1.so
> 0ffe8000-0ffea000 r--p 00168000 00:01 750        /lib/libc-2.10.1.so
> 0ffea000-0ffed000 rwxp 0016a000 00:01 750        /lib/libc-2.10.1.so
> 0ffed000-0fff0000 rwxp 00000000 00:00 0
> 10000000-10001000 r-xp 00000000 00:12 119
> /mnt/repo/tdescham/reborn/isam-linux-target-apps/memory_alloc
> 10010000-10011000 rwxp 00000000 00:12 119
> /mnt/repo/tdescham/reborn/isam-linux-target-apps/memory_alloc
> 10011000-cb82f000 rw-p 00000000 00:00 0          [heap]
> bffaf000-bffd0000 rw-p 00000000 00:00 0          [stack]
>
>
> I have not seen anything 'weird' about this change.
> I found the following thread that also discusses such a change:
>
https://lists.ozlabs.org/pipermail/linuxppc-dev/2004-February/016513.htm
l
> The thread talks about a few problems, but later concludes that these
> have been fixed. Since the thread dates from 2004, I assume that
> indeed this has been fixed.
>
> Is there any reason why this change is not OK? I'm not necessarily
> talking about mainlining the change. I first would like to know if it
> is 'dangerous' or if there are other reasons not to do it.
>
> This post is using linux-2.6.36.4 as base, but I looked at more recent
> kernels and the settings seem the same.


Any feedback on this topic?

Thanks,
Thomas


------------------------------

Message: 7
Date: Wed, 10 Oct 2012 22:56:33 +0200
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Cc: John Bonesio <bones@secretlab.ca>, Anatolij Gustschin
	<agust@denx.de>, Wolfram Sang <w.sang@pengutronix.de>
Subject: [PATCH] powerpc: 52xx: nop out unsupported critical IRQs
Message-ID: <1349902593-16431-1-git-send-email-w.sang@pengutronix.de>

Currently, when booting MPC52xx based platforms, we get:

        mpc52xx_irqhost_map: invalid irq: virq=3D16, l1=3D0, l2=3D3
        irq: irq-16=3D=3D>hwirq-0x3 mapping failed: -22
        [WARNing skipped]

The warning is wrong since the mapping itself is valid. However, there
is no
support for that type of IRQ currently. Print a proper warning and bind
the irq
to a no_irq chip.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: John Bonesio <bones@secretlab.ca>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
---
 arch/powerpc/platforms/52xx/mpc52xx_pic.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 8520b58..703ad42 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -372,6 +372,11 @@ static int mpc52xx_irqhost_map(struct irq_domain
*h, unsigned int virq,
 	case MPC52xx_IRQ_L1_MAIN: irqchip =3D &mpc52xx_main_irqchip;
break;
 	case MPC52xx_IRQ_L1_PERP: irqchip =3D &mpc52xx_periph_irqchip;
break;
 	case MPC52xx_IRQ_L1_SDMA: irqchip =3D &mpc52xx_sdma_irqchip;
break;
+	case MPC52xx_IRQ_L1_CRIT:
+		pr_warn("%s: Critical IRQ #%d is unsupported! Nopping
it.\n",
+			__func__, l2irq);
+		irq_set_chip(virq, &no_irq_chip);
+		return 0;
 	default:
 		pr_err("%s: invalid irq: virq=3D%i, l1=3D%i, l2=3D%i\n",
 		       __func__, virq, l1irq, l2irq);
--=20
1.7.10.4



------------------------------

Subject: Digest Footer

_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org
https://lists.ozlabs.org/listinfo/linuxppc-dev

------------------------------

End of Linuxppc-dev Digest, Vol 98, Issue 38
********************************************
