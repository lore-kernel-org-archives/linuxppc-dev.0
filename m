Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 0C5B8DDEFD
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Jun 2007 18:17:28 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <4666233F.1080103@am.sony.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <aedf9b62aefb7f14cb71ba5bba9c5e38@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [patch 08/18] PS3: Kexec support (and a tutoral on the kexec flow
	for 64 bit powerpc)
Date: Sat, 9 Jun 2007 03:17:27 -0500
To: Geoff Levand <geoffrey.levand@am.sony.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed Jun 6 13:00:15 EST 2007, Geoff Levand wrote:

> Fixup the core platform parts needed for kexec to work on the PS3.
>  - Setup ps3_hpte_clear correctly.
>  - Mask interrupts on irq removal.
>  - Release all hypervisor resources.
>
> Signed-off-by: Geoff Levand <geoffrey.levand at am.sony.com>
> ---
>  arch/powerpc/platforms/ps3/htab.c      |   14 +-
>  arch/powerpc/platforms/ps3/interrupt.c |  199 
> ++++++++++++++++++++-------------
>  arch/powerpc/platforms/ps3/setup.c     |   29 ++--
>  3 files changed, 147 insertions(+), 95 deletions(-)
>
> --- a/arch/powerpc/platforms/ps3/htab.c
> +++ b/arch/powerpc/platforms/ps3/htab.c
> @@ -234,10 +234,18 @@ static void ps3_hpte_invalidate(unsigned
>
>  static void ps3_hpte_clear(void)
>  {
> -       /* Make sure to clean up the frame buffer device first */
> -       ps3fb_cleanup();

I'm glad to see this go.  Which patch added the call to the driver?

> +       int result;
>
> -       lv1_unmap_htab(htab_addr);
> +       DBG(" -> %s:%d\n", __func__, __LINE__);
> +
> +       result = lv1_unmap_htab(htab_addr);
> +       BUG_ON(result);
> +
> +       ps3_mm_shutdown();
> +
> +       ps3_mm_vas_destroy();
>
I tried to look at these to check that nothing dynamically allocated 
was being touched.   I didn't find anything if the memory had been 
hot-unplugged, but it also looked like they skipped the last one.

> +
> +       DBG(" <- %s:%d\n", __func__, __LINE__);
>  }
>
>  void __init ps3_hpte_init(unsigned long htab_size)
>
[skipped interrupt.c changes]

> --- a/arch/powerpc/platforms/ps3/setup.c
> +++ b/arch/powerpc/platforms/ps3/setup.c
> @@ -209,31 +209,28 @@ static int __init ps3_probe(void)
>  #if defined(CONFIG_KEXEC)
>  static void ps3_kexec_cpu_down(int crash_shutdown, int secondary)
>  {
> -       DBG(" -> %s:%d\n", __func__, __LINE__);
> +       int result;
> +       u64 ppe_id;
> +       u64 thread_id = secondary ? 1 : 0;

This is wrong.   This is not what secondary means.  To get the 
thread_id you must use smp_processor_id for logical or 
hard_smp_processor_id() for the hardware thread id.

> +
> +       DBG(" -> %s:%d: (%d)\n", __func__, __LINE__, secondary);
> +       ps3_smp_cleanup_cpu(thread_id);
> +
> +       lv1_get_logical_ppe_id(&ppe_id);
> +       result = lv1_configure_irq_state_bitmap(ppe_id, secondary ? 0 
> : 1, 0);

As the second argument is thread id, again this is wrong.

>
> -       if (secondary) {
> -               int cpu;
> -               for_each_online_cpu(cpu)
> -                       if (cpu)
> -                               ps3_smp_cleanup_cpu(cpu);
> -       } else
> -               ps3_smp_cleanup_cpu(0);
> +       /* seems to fail on second call */
> +       DBG("%s:%d: lv1_configure_irq_state_bitmap (%d) %s\n", 
> __func__,
> +               __LINE__, secondary, ps3_result(result));
>
>         DBG(" <- %s:%d\n", __func__, __LINE__);
>  }

Once linux is running, all processors are identical.  That is the S in 
SMP.   However, during kernel boot, we need one cpu to be running and 
the others to wait until the path is prepared.  Since kexec effectively 
leads to a boot, one cpu becomes known as the boot cpu and the rest 
become secondary cpus.

There are two paths to enter the kexec code: the panic code, and the 
shutdown/reboot syscall.  For normal kexec, whatever cpu thread is 
running the user process when it makes the reboot system call will be 
the master.  For crash kexec, its whichever thread called panic.

The secondary flag to cpu_down exists because the secondary cpus will 
call it in ipi context but will not return to the irq layer to eoi the 
ipi.  The call to cpu_down is made from kexec_smp_down initiated via 
the smp_call_function ipi context but instead of returning, 
kexec_smp_down calls kexec_smp_wait which will mark the paca, switch to 
real mode and spin with the hardware thread in r3 until the master 
tells them its done copying the kernel, when it will jump to address 
0x60.

The code in default_machine_kexec calls kexec_prepare_cpus which uses 
smp_call_function to ipi the other cpus and have them call 
kexec_cpu_down.  After the secondaries have marked their paca, cpu_down 
will be called on the master with the secondary arg 0.  During this 
call all other cpus are spinning.  After this call, the cpu will switch 
to a statically allocated stack and copy the new image pages into 
place, destroying any dynamically allocated and per-cpu data.  It then 
calls switches to real mode and calls the htab_clear hook to tear down 
the page tables, leaving a clean state for the new kernel.  When 
finished it copies 256 bytes from the entry point to address 0 and 
tells any slaves to branch to 0x60.  It then branches to the entry 
point (not address 0) with r3 containing its hardware cpu id, r4 
containing the entry address, and r5 containing 0.

When using kexec-tools, the entry point in v2wrap.S stores the master 
cpu id, calls the generic C code to checksum the image, then stores the 
master cpu id as the boot cpu in the device tree header, loads r3 with 
the device tree, and enters the new kernel.  (This adjusts for the 
difference between leaving the kernel, where cpu id is in r3, and 
entering the kernel, which expects a pointer to the device tree.   The 
kexec_load syscall just supplies memory contents and the entry point; 
the design is that any registers needed by the new code are to be set 
by a trampoline added to the list of image segments by user space.  The 
master cpu is not known until kexec is initiated and therefore is 
passed in the r3 (the very existence of the device-tree structure is 
only known to user space, not passed to the system call); the 
specification of r4 and r5 for the master thread is for convenience)

Since there is no handoff to say the slave noticed that the master was 
done copying the image, I have submitted a kernel patch to release the 
slaves to the new kernel's wait code entry point at 0x60 before calling 
the htab_clear routine, giving them the time that the htab_clear 
function executes in addition to the time for the code in purgatory.  
The patch \to copy the payload kernel's spin loop instead of creating 
another loop and sync gate is in kexec-testing.

Note that the order describe above is for the 64 bit PowerPC port; most 
architectures switch to real mode, flash invalidate the mmu and copy 
the new kernel in real mode using an relocatable assembly routine 
running at a location chosen by the kernel (a page that is neither an 
image source or destination page).   The LPAR real mode limitations 
deem this impractical; instead we reserve the kernel text, data, and 
bss space, the mmu hash table (in non-lpar mode), and any tce tables.  
If the execed image was a kernel, it will copy itself to its linked 
location as it must when started from open firmware.

>
>  static void ps3_machine_kexec(struct kimage *image)
>  {
> -       unsigned long ppe_id;
> -
>         DBG(" -> %s:%d\n", __func__, __LINE__);
>
> -       lv1_get_logical_ppe_id(&ppe_id);
> -       lv1_configure_irq_state_bitmap(ppe_id, 0, 0);
> -       ps3_mm_shutdown();
> -       ps3_mm_vas_destroy();
> -
> -       default_machine_kexec(image);
> +       default_machine_kexec(image); // needs ipi, never returns.
>
>         DBG(" <- %s:%d\n", __func__, __LINE__);
>  }
>

Others noted this now passthough function can be eliminated.

milton
