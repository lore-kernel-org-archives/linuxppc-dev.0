Return-Path: <lennox.wu@gmail.com>
Received: from mail-qg0-x236.google.com (mail-qg0-x236.google.com
 [IPv6:2607:f8b0:400d:c04::236])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 77A711A009F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Oct 2014 21:02:12 +1100 (AEDT)
Received: by mail-qg0-f54.google.com with SMTP id f51so638153qge.27
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Oct 2014 03:02:09 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1413864783-3271-9-git-send-email-linux@roeck-us.net>
References: <1413864783-3271-1-git-send-email-linux@roeck-us.net>
 <1413864783-3271-9-git-send-email-linux@roeck-us.net>
Date: Fri, 24 Oct 2014 18:02:09 +0800
Message-ID: <CAF0htA5SybjQdn-UtN+PeQyWcGsJQOsisUSqwFNLAJXSxxViBw@mail.gmail.com>
Subject: Re: [PATCH v2 08/47] kernel: Move pm_power_off to common code
From: Lennox Wu <lennox.wu@gmail.com>
Content-Type: multipart/alternative; boundary=001a113a86702f37da0506284674
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
 "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
 linux-sh@vger.kernel.org,
 "linux@lists.openrisc.net" <linux@lists.openrisc.net>,
 "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
 "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
 "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>,
 "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>,
 "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
 "x86@kernel.org" <x86@kernel.org>, xen-devel@lists.xenproject.org,
 "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
 "user-mode-linux-devel@lists.sourceforge.net"
 <user-mode-linux-devel@lists.sourceforge.net>, linux-pm@vger.kernel.org,
 "adi-buildroot-devel@lists.sourceforge.net"
 <adi-buildroot-devel@lists.sourceforge.net>,
 "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
 "user-mode-linux-user@lists.sourceforge.net"
 <user-mode-linux-user@lists.sourceforge.net>,
 "linux-metag@vger.kernel.org" <linux-metag@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
 "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
 open list <linux-kernel@vger.kernel.org>,
 "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
 "linux390@de.ibm.com" <linux390@de.ibm.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a113a86702f37da0506284674
Content-Type: text/plain; charset=UTF-8

Acked-by: Lennox Wu <lennox.wu@gmail.com>

2014-10-21 12:12 GMT+08:00 Guenter Roeck <linux@roeck-us.net>:

> pm_power_off is defined for all architectures. Move it to common code.
>
> Have all architectures call do_kernel_power_off instead of pm_power_off.
> Some architectures point pm_power_off to machine_power_off. For those,
> call do_kernel_power_off from machine_power_off instead.
>
> Acked-by: David Vrabel <david.vrabel@citrix.com>
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
> Acked-by: Hirokazu Takata <takata@linux-m32r.org>
> Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>
> Acked-by: Max Filippov <jcmvbkbc@gmail.com>
> Acked-by: Rafael J. Wysocki <rjw@rjwysocki.net>
> Acked-by: Richard Weinberger <richard@nod.at>
> Acked-by: Xuetao Guan <gxt@mprc.pku.edu.cn>
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> v2:
> - do_kernel_poweroff -> do_kernel_power_off
> - have_kernel_poweroff -> have_kernel_power_off
>
>  arch/alpha/kernel/process.c        |  9 +++------
>  arch/arc/kernel/reset.c            |  5 +----
>  arch/arm/kernel/process.c          |  5 +----
>  arch/arm64/kernel/process.c        |  5 +----
>  arch/avr32/kernel/process.c        |  6 +-----
>  arch/blackfin/kernel/process.c     |  3 ---
>  arch/blackfin/kernel/reboot.c      |  2 ++
>  arch/c6x/kernel/process.c          |  9 +--------
>  arch/cris/kernel/process.c         |  4 +---
>  arch/frv/kernel/process.c          |  5 ++---
>  arch/hexagon/kernel/reset.c        |  5 ++---
>  arch/ia64/kernel/process.c         |  5 +----
>  arch/m32r/kernel/process.c         |  8 ++++----
>  arch/m68k/kernel/process.c         |  6 +-----
>  arch/metag/kernel/process.c        |  6 +-----
>  arch/microblaze/kernel/process.c   |  3 ---
>  arch/microblaze/kernel/reset.c     |  1 +
>  arch/mips/kernel/reset.c           |  6 +-----
>  arch/mn10300/kernel/process.c      |  8 ++------
>  arch/openrisc/kernel/process.c     |  8 +++++---
>  arch/parisc/kernel/process.c       |  8 ++++----
>  arch/powerpc/kernel/setup-common.c |  6 +++---
>  arch/s390/kernel/setup.c           |  8 ++------
>  arch/score/kernel/process.c        |  8 ++++----
>  arch/sh/kernel/reboot.c            |  6 +-----
>  arch/sparc/kernel/process_32.c     | 10 ++--------
>  arch/sparc/kernel/reboot.c         |  8 ++------
>  arch/tile/kernel/reboot.c          |  7 +++----
>  arch/um/kernel/reboot.c            |  2 --
>  arch/unicore32/kernel/process.c    |  9 +--------
>  arch/x86/kernel/reboot.c           | 11 +++--------
>  arch/x86/xen/enlighten.c           |  3 +--
>  arch/xtensa/kernel/process.c       |  4 ----
>  drivers/parisc/power.c             |  3 +--
>  kernel/power/poweroff_handler.c    |  8 ++++++++
>  kernel/reboot.c                    |  4 ++--
>  36 files changed, 68 insertions(+), 146 deletions(-)
>
> diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c
> index 1941a07..81c43f8 100644
> --- a/arch/alpha/kernel/process.c
> +++ b/arch/alpha/kernel/process.c
> @@ -24,6 +24,7 @@
>  #include <linux/vt.h>
>  #include <linux/mman.h>
>  #include <linux/elfcore.h>
> +#include <linux/pm.h>
>  #include <linux/reboot.h>
>  #include <linux/tty.h>
>  #include <linux/console.h>
> @@ -40,12 +41,6 @@
>  #include "proto.h"
>  #include "pci_impl.h"
>
> -/*
> - * Power off function, if any
> - */
> -void (*pm_power_off)(void) = machine_power_off;
> -EXPORT_SYMBOL(pm_power_off);
> -
>  #ifdef CONFIG_ALPHA_WTINT
>  /*
>   * Sleep the CPU.
> @@ -184,6 +179,8 @@ machine_halt(void)
>  void
>  machine_power_off(void)
>  {
> +       do_kernel_power_off();
> +
>         common_shutdown(LINUX_REBOOT_CMD_POWER_OFF, NULL);
>  }
>
> diff --git a/arch/arc/kernel/reset.c b/arch/arc/kernel/reset.c
> index 2768fa1..0758d9d 100644
> --- a/arch/arc/kernel/reset.c
> +++ b/arch/arc/kernel/reset.c
> @@ -26,9 +26,6 @@ void machine_restart(char *__unused)
>
>  void machine_power_off(void)
>  {
> -       /* FIXME ::  power off ??? */
> +       do_kernel_power_off();
>         machine_halt();
>  }
> -
> -void (*pm_power_off) (void) = NULL;
> -EXPORT_SYMBOL(pm_power_off);
> diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c
> index fe972a2..aa3f656 100644
> --- a/arch/arm/kernel/process.c
> +++ b/arch/arm/kernel/process.c
> @@ -117,8 +117,6 @@ void soft_restart(unsigned long addr)
>  /*
>   * Function pointers to optional machine specific functions
>   */
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL(pm_power_off);
>
>  void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
>
> @@ -205,8 +203,7 @@ void machine_power_off(void)
>         local_irq_disable();
>         smp_send_stop();
>
> -       if (pm_power_off)
> -               pm_power_off();
> +       do_kernel_power_off();
>  }
>
>  /*
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index c3065db..46a483a 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -68,8 +68,6 @@ void soft_restart(unsigned long addr)
>  /*
>   * Function pointers to optional machine specific functions
>   */
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL_GPL(pm_power_off);
>
>  void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd);
>
> @@ -129,8 +127,7 @@ void machine_power_off(void)
>  {
>         local_irq_disable();
>         smp_send_stop();
> -       if (pm_power_off)
> -               pm_power_off();
> +       do_kernel_power_off();
>  }
>
>  /*
> diff --git a/arch/avr32/kernel/process.c b/arch/avr32/kernel/process.c
> index 42a53e74..529c1f6 100644
> --- a/arch/avr32/kernel/process.c
> +++ b/arch/avr32/kernel/process.c
> @@ -23,9 +23,6 @@
>
>  #include <mach/pm.h>
>
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL(pm_power_off);
> -
>  /*
>   * This file handles the architecture-dependent parts of process
> handling..
>   */
> @@ -48,8 +45,7 @@ void machine_halt(void)
>
>  void machine_power_off(void)
>  {
> -       if (pm_power_off)
> -               pm_power_off();
> +       do_kernel_power_off();
>  }
>
>  void machine_restart(char *cmd)
> diff --git a/arch/blackfin/kernel/process.c
> b/arch/blackfin/kernel/process.c
> index 4aa5545..812dd83 100644
> --- a/arch/blackfin/kernel/process.c
> +++ b/arch/blackfin/kernel/process.c
> @@ -39,9 +39,6 @@ int nr_l1stack_tasks;
>  void *l1_stack_base;
>  unsigned long l1_stack_len;
>
> -void (*pm_power_off)(void) = NULL;
> -EXPORT_SYMBOL(pm_power_off);
> -
>  /*
>   * The idle loop on BFIN
>   */
> diff --git a/arch/blackfin/kernel/reboot.c b/arch/blackfin/kernel/reboot.c
> index c4f50a3..387d610 100644
> --- a/arch/blackfin/kernel/reboot.c
> +++ b/arch/blackfin/kernel/reboot.c
> @@ -7,6 +7,7 @@
>   */
>
>  #include <linux/interrupt.h>
> +#include <linux/pm.h>
>  #include <asm/bfin-global.h>
>  #include <asm/reboot.h>
>  #include <asm/bfrom.h>
> @@ -106,6 +107,7 @@ void machine_halt(void)
>  __attribute__((weak))
>  void native_machine_power_off(void)
>  {
> +       do_kernel_power_off();
>         idle_with_irq_disabled();
>  }
>
> diff --git a/arch/c6x/kernel/process.c b/arch/c6x/kernel/process.c
> index 57d2ea8..edf7e5a 100644
> --- a/arch/c6x/kernel/process.c
> +++ b/arch/c6x/kernel/process.c
> @@ -27,12 +27,6 @@ void (*c6x_halt)(void);
>  extern asmlinkage void ret_from_fork(void);
>  extern asmlinkage void ret_from_kernel_thread(void);
>
> -/*
> - * power off function, if any
> - */
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL(pm_power_off);
> -
>  void arch_cpu_idle(void)
>  {
>         unsigned long tmp;
> @@ -73,8 +67,7 @@ void machine_halt(void)
>
>  void machine_power_off(void)
>  {
> -       if (pm_power_off)
> -               pm_power_off();
> +       do_kernel_power_off();
>         halt_loop();
>  }
>
> diff --git a/arch/cris/kernel/process.c b/arch/cris/kernel/process.c
> index b78498e..9ebd76b 100644
> --- a/arch/cris/kernel/process.c
> +++ b/arch/cris/kernel/process.c
> @@ -31,9 +31,6 @@
>
>  extern void default_idle(void);
>
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL(pm_power_off);
> -
>  void arch_cpu_idle(void)
>  {
>         default_idle();
> @@ -60,6 +57,7 @@ void machine_halt(void)
>
>  void machine_power_off(void)
>  {
> +       do_kernel_power_off();
>  }
>
>  /*
> diff --git a/arch/frv/kernel/process.c b/arch/frv/kernel/process.c
> index 5d40aeb77..502dabb 100644
> --- a/arch/frv/kernel/process.c
> +++ b/arch/frv/kernel/process.c
> @@ -42,9 +42,6 @@ asmlinkage void ret_from_kernel_thread(void);
>
>  #include <asm/pgalloc.h>
>
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL(pm_power_off);
> -
>  static void core_sleep_idle(void)
>  {
>  #ifdef LED_DEBUG_SLEEP
> @@ -107,6 +104,8 @@ void machine_power_off(void)
>         gdbstub_exit(0);
>  #endif
>
> +       do_kernel_power_off();
> +
>         for (;;);
>  }
>
> diff --git a/arch/hexagon/kernel/reset.c b/arch/hexagon/kernel/reset.c
> index 76483c1..6f607b6 100644
> --- a/arch/hexagon/kernel/reset.c
> +++ b/arch/hexagon/kernel/reset.c
> @@ -16,11 +16,13 @@
>   * 02110-1301, USA.
>   */
>
> +#include <linux/pm.h>
>  #include <linux/smp.h>
>  #include <asm/hexagon_vm.h>
>
>  void machine_power_off(void)
>  {
> +       do_kernel_power_off();
>         smp_send_stop();
>         __vmstop();
>  }
> @@ -32,6 +34,3 @@ void machine_halt(void)
>  void machine_restart(char *cmd)
>  {
>  }
> -
> -void (*pm_power_off)(void) = NULL;
> -EXPORT_SYMBOL(pm_power_off);
> diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c
> index b515149..88121a2 100644
> --- a/arch/ia64/kernel/process.c
> +++ b/arch/ia64/kernel/process.c
> @@ -57,8 +57,6 @@ void (*ia64_mark_idle)(int);
>
>  unsigned long boot_option_idle_override = IDLE_NO_OVERRIDE;
>  EXPORT_SYMBOL(boot_option_idle_override);
> -void (*pm_power_off) (void);
> -EXPORT_SYMBOL(pm_power_off);
>
>  void
>  ia64_do_show_stack (struct unw_frame_info *info, void *arg)
> @@ -675,8 +673,7 @@ machine_halt (void)
>  void
>  machine_power_off (void)
>  {
> -       if (pm_power_off)
> -               pm_power_off();
> +       do_kernel_power_off();
>         machine_halt();
>  }
>
> diff --git a/arch/m32r/kernel/process.c b/arch/m32r/kernel/process.c
> index e69221d..65a037e 100644
> --- a/arch/m32r/kernel/process.c
> +++ b/arch/m32r/kernel/process.c
> @@ -23,6 +23,7 @@
>  #include <linux/fs.h>
>  #include <linux/slab.h>
>  #include <linux/module.h>
> +#include <linux/pm.h>
>  #include <linux/ptrace.h>
>  #include <linux/unistd.h>
>  #include <linux/hardirq.h>
> @@ -44,9 +45,6 @@ unsigned long thread_saved_pc(struct task_struct *tsk)
>         return tsk->thread.lr;
>  }
>
> -void (*pm_power_off)(void) = NULL;
> -EXPORT_SYMBOL(pm_power_off);
> -
>  void machine_restart(char *__unused)
>  {
>  #if defined(CONFIG_PLAT_MAPPI3)
> @@ -67,7 +65,9 @@ void machine_halt(void)
>
>  void machine_power_off(void)
>  {
> -       /* M32R_FIXME */
> +       do_kernel_power_off();
> +       for (;;)
> +               ;
>  }
>
>  void show_regs(struct pt_regs * regs)
> diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c
> index afe3d6e..bbc0a63 100644
> --- a/arch/m68k/kernel/process.c
> +++ b/arch/m68k/kernel/process.c
> @@ -78,14 +78,10 @@ void machine_halt(void)
>
>  void machine_power_off(void)
>  {
> -       if (pm_power_off)
> -               pm_power_off();
> +       do_kernel_power_off();
>         for (;;);
>  }
>
> -void (*pm_power_off)(void) = machine_power_off;
> -EXPORT_SYMBOL(pm_power_off);
> -
>  void show_regs(struct pt_regs * regs)
>  {
>         printk("\n");
> diff --git a/arch/metag/kernel/process.c b/arch/metag/kernel/process.c
> index 483dff9..8d95773 100644
> --- a/arch/metag/kernel/process.c
> +++ b/arch/metag/kernel/process.c
> @@ -67,9 +67,6 @@ void arch_cpu_idle_dead(void)
>  }
>  #endif
>
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL(pm_power_off);
> -
>  void (*soc_restart)(char *cmd);
>  void (*soc_halt)(void);
>
> @@ -90,8 +87,7 @@ void machine_halt(void)
>
>  void machine_power_off(void)
>  {
> -       if (pm_power_off)
> -               pm_power_off();
> +       do_kernel_power_off();
>         smp_send_stop();
>         hard_processor_halt(HALT_OK);
>  }
> diff --git a/arch/microblaze/kernel/process.c
> b/arch/microblaze/kernel/process.c
> index b2dd371..0ebca36 100644
> --- a/arch/microblaze/kernel/process.c
> +++ b/arch/microblaze/kernel/process.c
> @@ -44,9 +44,6 @@ void show_regs(struct pt_regs *regs)
>                                 regs->msr, regs->ear, regs->esr,
> regs->fsr);
>  }
>
> -void (*pm_power_off)(void) = NULL;
> -EXPORT_SYMBOL(pm_power_off);
> -
>  void flush_thread(void)
>  {
>  }
> diff --git a/arch/microblaze/kernel/reset.c
> b/arch/microblaze/kernel/reset.c
> index fbe58c6..2c6b32c 100644
> --- a/arch/microblaze/kernel/reset.c
> +++ b/arch/microblaze/kernel/reset.c
> @@ -103,6 +103,7 @@ void machine_halt(void)
>  void machine_power_off(void)
>  {
>         pr_notice("Machine power off...\n");
> +       do_kernel_power_off();
>         while (1)
>                 ;
>  }
> diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
> index 07fc524..09e74d2 100644
> --- a/arch/mips/kernel/reset.c
> +++ b/arch/mips/kernel/reset.c
> @@ -21,9 +21,6 @@
>   */
>  void (*_machine_restart)(char *command);
>  void (*_machine_halt)(void);
> -void (*pm_power_off)(void);
> -
> -EXPORT_SYMBOL(pm_power_off);
>
>  void machine_restart(char *command)
>  {
> @@ -39,6 +36,5 @@ void machine_halt(void)
>
>  void machine_power_off(void)
>  {
> -       if (pm_power_off)
> -               pm_power_off();
> +       do_kernel_power_off();
>  }
> diff --git a/arch/mn10300/kernel/process.c b/arch/mn10300/kernel/process.c
> index 3707da5..c78b2eb 100644
> --- a/arch/mn10300/kernel/process.c
> +++ b/arch/mn10300/kernel/process.c
> @@ -20,6 +20,7 @@
>  #include <linux/user.h>
>  #include <linux/interrupt.h>
>  #include <linux/delay.h>
> +#include <linux/pm.h>
>  #include <linux/reboot.h>
>  #include <linux/percpu.h>
>  #include <linux/err.h>
> @@ -45,12 +46,6 @@ unsigned long thread_saved_pc(struct task_struct *tsk)
>  }
>
>  /*
> - * power off function, if any
> - */
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL(pm_power_off);
> -
> -/*
>   * On SMP it's slightly faster (but much more power-consuming!)
>   * to poll the ->work.need_resched flag instead of waiting for the
>   * cross-CPU IPI to arrive. Use this option with caution.
> @@ -93,6 +88,7 @@ void machine_power_off(void)
>  #ifdef CONFIG_KERNEL_DEBUGGER
>         gdbstub_exit(0);
>  #endif
> +       do_kernel_power_off();
>  }
>
>  void show_regs(struct pt_regs *regs)
> diff --git a/arch/openrisc/kernel/process.c
> b/arch/openrisc/kernel/process.c
> index 386af25..494afd2 100644
> --- a/arch/openrisc/kernel/process.c
> +++ b/arch/openrisc/kernel/process.c
> @@ -25,6 +25,7 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/mm.h>
> +#include <linux/pm.h>
>  #include <linux/stddef.h>
>  #include <linux/unistd.h>
>  #include <linux/ptrace.h>
> @@ -51,7 +52,7 @@
>   */
>  struct thread_info *current_thread_info_set[NR_CPUS] = {
> &init_thread_info, };
>
> -void machine_restart(void)
> +void machine_restart(char *cmd)
>  {
>         printk(KERN_INFO "*** MACHINE RESTART ***\n");
>         __asm__("l.nop 1");
> @@ -72,11 +73,12 @@ void machine_halt(void)
>  void machine_power_off(void)
>  {
>         printk(KERN_INFO "*** MACHINE POWER OFF ***\n");
> +
> +       do_kernel_power_off();
> +
>         __asm__("l.nop 1");
>  }
>
> -void (*pm_power_off) (void) = machine_power_off;
> -
>  /*
>   * When a process does an "exec", machine state like FPU and debug
>   * registers need to be reset.  This is a hook function for that.
> diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c
> index 0bbbf0d..3f5d14a 100644
> --- a/arch/parisc/kernel/process.c
> +++ b/arch/parisc/kernel/process.c
> @@ -41,6 +41,7 @@
>  #include <linux/fs.h>
>  #include <linux/module.h>
>  #include <linux/personality.h>
> +#include <linux/pm.h>
>  #include <linux/ptrace.h>
>  #include <linux/sched.h>
>  #include <linux/slab.h>
> @@ -133,7 +134,9 @@ void machine_power_off(void)
>         pdc_soft_power_button(0);
>
>         pdc_chassis_send_status(PDC_CHASSIS_DIRECT_SHUTDOWN);
> -
> +
> +       do_kernel_power_off();
> +
>         /* It seems we have no way to power the system off via
>          * software. The user has to press the button himself. */
>
> @@ -141,9 +144,6 @@ void machine_power_off(void)
>                "Please power this system off now.");
>  }
>
> -void (*pm_power_off)(void) = machine_power_off;
> -EXPORT_SYMBOL(pm_power_off);
> -
>  /*
>   * Free current thread data structures etc..
>   */
> diff --git a/arch/powerpc/kernel/setup-common.c
> b/arch/powerpc/kernel/setup-common.c
> index 1362cd6..5b7a851 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -141,6 +141,9 @@ void machine_power_off(void)
>         machine_shutdown();
>         if (ppc_md.power_off)
>                 ppc_md.power_off();
> +
> +       do_kernel_power_off();
> +
>  #ifdef CONFIG_SMP
>         smp_send_stop();
>  #endif
> @@ -151,9 +154,6 @@ void machine_power_off(void)
>  /* Used by the G5 thermal driver */
>  EXPORT_SYMBOL_GPL(machine_power_off);
>
> -void (*pm_power_off)(void) = machine_power_off;
> -EXPORT_SYMBOL_GPL(pm_power_off);
> -
>  void machine_halt(void)
>  {
>         machine_shutdown();
> diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
> index e80d9ff..267e025 100644
> --- a/arch/s390/kernel/setup.c
> +++ b/arch/s390/kernel/setup.c
> @@ -263,13 +263,9 @@ void machine_power_off(void)
>                  */
>                 console_unblank();
>         _machine_power_off();
> -}
>
> -/*
> - * Dummy power off function.
> - */
> -void (*pm_power_off)(void) = machine_power_off;
> -EXPORT_SYMBOL_GPL(pm_power_off);
> +       do_kernel_power_off();
> +}
>
>  static int __init early_parse_mem(char *p)
>  {
> diff --git a/arch/score/kernel/process.c b/arch/score/kernel/process.c
> index a1519ad3..b76ea67 100644
> --- a/arch/score/kernel/process.c
> +++ b/arch/score/kernel/process.c
> @@ -29,9 +29,6 @@
>  #include <linux/pm.h>
>  #include <linux/rcupdate.h>
>
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL(pm_power_off);
> -
>  /* If or when software machine-restart is implemented, add code here. */
>  void machine_restart(char *command) {}
>
> @@ -39,7 +36,10 @@ void machine_restart(char *command) {}
>  void machine_halt(void) {}
>
>  /* If or when software machine-power-off is implemented, add code here. */
> -void machine_power_off(void) {}
> +void machine_power_off(void)
> +{
> +       do_kernel_power_off();
> +}
>
>  void ret_from_fork(void);
>  void ret_from_kernel_thread(void);
> diff --git a/arch/sh/kernel/reboot.c b/arch/sh/kernel/reboot.c
> index 04afe5b..065de12 100644
> --- a/arch/sh/kernel/reboot.c
> +++ b/arch/sh/kernel/reboot.c
> @@ -11,9 +11,6 @@
>  #include <asm/tlbflush.h>
>  #include <asm/traps.h>
>
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL(pm_power_off);
> -
>  #ifdef CONFIG_SUPERH32
>  static void watchdog_trigger_immediate(void)
>  {
> @@ -51,8 +48,7 @@ static void native_machine_shutdown(void)
>
>  static void native_machine_power_off(void)
>  {
> -       if (pm_power_off)
> -               pm_power_off();
> +       do_kernel_power_off();
>  }
>
>  static void native_machine_halt(void)
> diff --git a/arch/sparc/kernel/process_32.c
> b/arch/sparc/kernel/process_32.c
> index 50e7b62..cb8148a 100644
> --- a/arch/sparc/kernel/process_32.c
> +++ b/arch/sparc/kernel/process_32.c
> @@ -48,14 +48,6 @@
>   */
>  void (*sparc_idle)(void);
>
> -/*
> - * Power-off handler instantiation for pm.h compliance
> - * This is done via auxio, but could be used as a fallback
> - * handler when auxio is not present-- unused for now...
> - */
> -void (*pm_power_off)(void) = machine_power_off;
> -EXPORT_SYMBOL(pm_power_off);
> -
>  /*
>   * sysctl - toggle power-off restriction for serial console
>   * systems in machine_power_off()
> @@ -112,6 +104,8 @@ void machine_power_off(void)
>                 sbus_writeb(power_register, auxio_power_register);
>         }
>
> +       do_kernel_power_off();
> +
>         machine_halt();
>  }
>
> diff --git a/arch/sparc/kernel/reboot.c b/arch/sparc/kernel/reboot.c
> index eba7d91..3c0bb03 100644
> --- a/arch/sparc/kernel/reboot.c
> +++ b/arch/sparc/kernel/reboot.c
> @@ -16,17 +16,13 @@
>   */
>  int scons_pwroff = 1;
>
> -/* This isn't actually used, it exists merely to satisfy the
> - * reference in kernel/sys.c
> - */
> -void (*pm_power_off)(void) = machine_power_off;
> -EXPORT_SYMBOL(pm_power_off);
> -
>  void machine_power_off(void)
>  {
>         if (strcmp(of_console_device->type, "serial") || scons_pwroff)
>                 prom_halt_power_off();
>
> +       do_kernel_power_off();
> +
>         prom_halt();
>  }
>
> diff --git a/arch/tile/kernel/reboot.c b/arch/tile/kernel/reboot.c
> index 6c5d2c0..8ff4a7f 100644
> --- a/arch/tile/kernel/reboot.c
> +++ b/arch/tile/kernel/reboot.c
> @@ -36,6 +36,9 @@ void machine_power_off(void)
>  {
>         arch_local_irq_disable_all();
>         smp_send_stop();
> +
> +       do_kernel_power_off();
> +
>         hv_power_off();
>  }
>
> @@ -45,7 +48,3 @@ void machine_restart(char *cmd)
>         smp_send_stop();
>         hv_restart((HV_VirtAddr) "vmlinux", (HV_VirtAddr) cmd);
>  }
> -
> -/* No interesting distinction to be made here. */
> -void (*pm_power_off)(void) = NULL;
> -EXPORT_SYMBOL(pm_power_off);
> diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
> index ced8903..a82ef28 100644
> --- a/arch/um/kernel/reboot.c
> +++ b/arch/um/kernel/reboot.c
> @@ -11,8 +11,6 @@
>  #include <os.h>
>  #include <skas.h>
>
> -void (*pm_power_off)(void);
> -
>  static void kill_off_processes(void)
>  {
>         if (proc_mm)
> diff --git a/arch/unicore32/kernel/process.c
> b/arch/unicore32/kernel/process.c
> index b008e99..9490dd5 100644
> --- a/arch/unicore32/kernel/process.c
> +++ b/arch/unicore32/kernel/process.c
> @@ -56,16 +56,9 @@ void machine_halt(void)
>         gpio_set_value(GPO_SOFT_OFF, 0);
>  }
>
> -/*
> - * Function pointers to optional machine specific functions
> - */
> -void (*pm_power_off)(void) = NULL;
> -EXPORT_SYMBOL(pm_power_off);
> -
>  void machine_power_off(void)
>  {
> -       if (pm_power_off)
> -               pm_power_off();
> +       do_kernel_power_off();
>         machine_halt();
>  }
>
> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
> index 17962e6..5c09e28 100644
> --- a/arch/x86/kernel/reboot.c
> +++ b/arch/x86/kernel/reboot.c
> @@ -30,12 +30,6 @@
>  #include <asm/x86_init.h>
>  #include <asm/efi.h>
>
> -/*
> - * Power off function, if any
> - */
> -void (*pm_power_off)(void);
> -EXPORT_SYMBOL(pm_power_off);
> -
>  static const struct desc_ptr no_idt = {};
>
>  /*
> @@ -647,11 +641,12 @@ static void native_machine_halt(void)
>
>  static void native_machine_power_off(void)
>  {
> -       if (pm_power_off) {
> +       if (have_kernel_power_off()) {
>                 if (!reboot_force)
>                         machine_shutdown();
> -               pm_power_off();
> +               do_kernel_power_off();
>         }
> +
>         /* A fallback in case there is no PM info available */
>         tboot_shutdown(TB_SHUTDOWN_HALT);
>  }
> diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c
> index 1a3f044..c2c1d74 100644
> --- a/arch/x86/xen/enlighten.c
> +++ b/arch/x86/xen/enlighten.c
> @@ -1320,8 +1320,7 @@ static void xen_machine_halt(void)
>
>  static void xen_machine_power_off(void)
>  {
> -       if (pm_power_off)
> -               pm_power_off();
> +       do_kernel_power_off();
>         xen_reboot(SHUTDOWN_poweroff);
>  }
>
> diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c
> index 1c85323..c487296 100644
> --- a/arch/xtensa/kernel/process.c
> +++ b/arch/xtensa/kernel/process.c
> @@ -49,10 +49,6 @@ extern void ret_from_kernel_thread(void);
>
>  struct task_struct *current_set[NR_CPUS] = {&init_task, };
>
> -void (*pm_power_off)(void) = NULL;
> -EXPORT_SYMBOL(pm_power_off);
> -
> -
>  #if XTENSA_HAVE_COPROCESSORS
>
>  void coprocessor_release_all(struct thread_info *ti)
> diff --git a/drivers/parisc/power.c b/drivers/parisc/power.c
> index ef31b77..f10cf92 100644
> --- a/drivers/parisc/power.c
> +++ b/drivers/parisc/power.c
> @@ -95,8 +95,7 @@ static void process_shutdown(void)
>                 /* send kill signal */
>                 if (kill_cad_pid(SIGINT, 1)) {
>                         /* just in case killing init process failed */
> -                       if (pm_power_off)
> -                               pm_power_off();
> +                       kernel_power_off();
>                 }
>         }
>  }
> diff --git a/kernel/power/poweroff_handler.c
> b/kernel/power/poweroff_handler.c
> index aeb4736..37f0b88 100644
> --- a/kernel/power/poweroff_handler.c
> +++ b/kernel/power/poweroff_handler.c
> @@ -22,6 +22,12 @@
>  #include <linux/types.h>
>
>  /*
> + * If set, calling this function will power off the system immediately.
> + */
> +void (*pm_power_off)(void);
> +EXPORT_SYMBOL(pm_power_off);
> +
> +/*
>   *     Notifier list for kernel code which wants to be called
>   *     to power off the system.
>   */
> @@ -236,6 +242,8 @@ EXPORT_SYMBOL(devm_register_power_off_handler);
>  void do_kernel_power_off(void)
>  {
>         spin_lock(&power_off_handler_lock);
> +       if (pm_power_off)
> +               pm_power_off();
>         raw_notifier_call_chain(&power_off_handler_list, 0, NULL);
>         spin_unlock(&power_off_handler_lock);
>  }
> diff --git a/kernel/reboot.c b/kernel/reboot.c
> index 5925f5a..0930851 100644
> --- a/kernel/reboot.c
> +++ b/kernel/reboot.c
> @@ -306,9 +306,9 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2,
> unsigned int, cmd,
>                 return ret;
>
>         /* Instead of trying to make the power_off code look like
> -        * halt when pm_power_off is not set do it the easy way.
> +        * halt when no poweroff handler exists do it the easy way.
>          */
> -       if ((cmd == LINUX_REBOOT_CMD_POWER_OFF) && !pm_power_off)
> +       if (cmd == LINUX_REBOOT_CMD_POWER_OFF && !have_kernel_power_off())
>                 cmd = LINUX_REBOOT_CMD_HALT;
>
>         mutex_lock(&reboot_mutex);
> --
> 1.9.1
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

--001a113a86702f37da0506284674
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Acked-by: Lennox Wu &lt;<a href=3D"mailto:lennox.wu@gmail.=
com">lennox.wu@gmail.com</a>&gt;<br></div><div class=3D"gmail_extra"><br><d=
iv class=3D"gmail_quote">2014-10-21 12:12 GMT+08:00 Guenter Roeck <span dir=
=3D"ltr">&lt;<a href=3D"mailto:linux@roeck-us.net" target=3D"_blank">linux@=
roeck-us.net</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"=
margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">pm_power_off=
 is defined for all architectures. Move it to common code.<br>
<br>
Have all architectures call do_kernel_power_off instead of pm_power_off.<br=
>
Some architectures point pm_power_off to machine_power_off. For those,<br>
call do_kernel_power_off from machine_power_off instead.<br>
<br>
Acked-by: David Vrabel &lt;<a href=3D"mailto:david.vrabel@citrix.com">david=
.vrabel@citrix.com</a>&gt;<br>
Acked-by: Geert Uytterhoeven &lt;<a href=3D"mailto:geert@linux-m68k.org">ge=
ert@linux-m68k.org</a>&gt;<br>
Acked-by: Hirokazu Takata &lt;<a href=3D"mailto:takata@linux-m32r.org">taka=
ta@linux-m32r.org</a>&gt;<br>
Acked-by: Jesper Nilsson &lt;<a href=3D"mailto:jesper.nilsson@axis.com">jes=
per.nilsson@axis.com</a>&gt;<br>
Acked-by: Max Filippov &lt;<a href=3D"mailto:jcmvbkbc@gmail.com">jcmvbkbc@g=
mail.com</a>&gt;<br>
Acked-by: Rafael J. Wysocki &lt;<a href=3D"mailto:rjw@rjwysocki.net">rjw@rj=
wysocki.net</a>&gt;<br>
Acked-by: Richard Weinberger &lt;<a href=3D"mailto:richard@nod.at">richard@=
nod.at</a>&gt;<br>
Acked-by: Xuetao Guan &lt;<a href=3D"mailto:gxt@mprc.pku.edu.cn">gxt@mprc.p=
ku.edu.cn</a>&gt;<br>
Signed-off-by: Guenter Roeck &lt;<a href=3D"mailto:linux@roeck-us.net">linu=
x@roeck-us.net</a>&gt;<br>
---<br>
v2:<br>
- do_kernel_poweroff -&gt; do_kernel_power_off<br>
- have_kernel_poweroff -&gt; have_kernel_power_off<br>
<br>
=C2=A0arch/alpha/kernel/process.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9 +++-=
-----<br>
=C2=A0arch/arc/kernel/reset.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 5 +----<br>
=C2=A0arch/arm/kernel/process.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5=
 +----<br>
=C2=A0arch/arm64/kernel/process.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 +---=
-<br>
=C2=A0arch/avr32/kernel/process.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 +---=
--<br>
=C2=A0arch/blackfin/kernel/process.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 3 ---<br>
=C2=A0arch/blackfin/kernel/reboot.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 2 ++<br>
=C2=A0arch/c6x/kernel/process.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 9=
 +--------<br>
=C2=A0arch/cris/kernel/process.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4=
 +---<br>
=C2=A0arch/frv/kernel/process.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5=
 ++---<br>
=C2=A0arch/hexagon/kernel/reset.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 5 ++--=
-<br>
=C2=A0arch/ia64/kernel/process.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 5=
 +----<br>
=C2=A0arch/m32r/kernel/process.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8=
 ++++----<br>
=C2=A0arch/m68k/kernel/process.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 6=
 +-----<br>
=C2=A0arch/metag/kernel/process.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 6 +---=
--<br>
=C2=A0arch/microblaze/kernel/process.c=C2=A0 =C2=A0|=C2=A0 3 ---<br>
=C2=A0arch/microblaze/kernel/reset.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 1 +<br>
=C2=A0arch/mips/kernel/reset.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 6 +-----<br>
=C2=A0arch/mn10300/kernel/process.c=C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ++------<=
br>
=C2=A0arch/openrisc/kernel/process.c=C2=A0 =C2=A0 =C2=A0|=C2=A0 8 +++++---<=
br>
=C2=A0arch/parisc/kernel/process.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8 ++++=
----<br>
=C2=A0arch/powerpc/kernel/setup-common.c |=C2=A0 6 +++---<br>
=C2=A0arch/s390/kernel/setup.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 8 ++------<br>
=C2=A0arch/score/kernel/process.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 8 ++++=
----<br>
=C2=A0arch/sh/kernel/reboot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 6 +-----<br>
=C2=A0arch/sparc/kernel/process_32.c=C2=A0 =C2=A0 =C2=A0| 10 ++--------<br>
=C2=A0arch/sparc/kernel/reboot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 8=
 ++------<br>
=C2=A0arch/tile/kernel/reboot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 7=
 +++----<br>
=C2=A0arch/um/kernel/reboot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 2 --<br>
=C2=A0arch/unicore32/kernel/process.c=C2=A0 =C2=A0 |=C2=A0 9 +--------<br>
=C2=A0arch/x86/kernel/reboot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 11=
 +++--------<br>
=C2=A0arch/x86/xen/enlighten.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 3 +--<br>
=C2=A0arch/xtensa/kernel/process.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 4 ----=
<br>
=C2=A0drivers/parisc/power.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 3 +--<br>
=C2=A0kernel/power/poweroff_handler.c=C2=A0 =C2=A0 |=C2=A0 8 ++++++++<br>
=C2=A0kernel/reboot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A036 files changed, 68 insertions(+), 146 deletions(-)<br>
<br>
diff --git a/arch/alpha/kernel/process.c b/arch/alpha/kernel/process.c<br>
index 1941a07..81c43f8 100644<br>
--- a/arch/alpha/kernel/process.c<br>
+++ b/arch/alpha/kernel/process.c<br>
@@ -24,6 +24,7 @@<br>
=C2=A0#include &lt;linux/vt.h&gt;<br>
=C2=A0#include &lt;linux/mman.h&gt;<br>
=C2=A0#include &lt;linux/elfcore.h&gt;<br>
+#include &lt;linux/pm.h&gt;<br>
=C2=A0#include &lt;linux/reboot.h&gt;<br>
=C2=A0#include &lt;linux/tty.h&gt;<br>
=C2=A0#include &lt;linux/console.h&gt;<br>
@@ -40,12 +41,6 @@<br>
=C2=A0#include &quot;proto.h&quot;<br>
=C2=A0#include &quot;pci_impl.h&quot;<br>
<br>
-/*<br>
- * Power off function, if any<br>
- */<br>
-void (*pm_power_off)(void) =3D machine_power_off;<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
=C2=A0#ifdef CONFIG_ALPHA_WTINT<br>
=C2=A0/*<br>
=C2=A0 * Sleep the CPU.<br>
@@ -184,6 +179,8 @@ machine_halt(void)<br>
=C2=A0void<br>
=C2=A0machine_power_off(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 common_shutdown(LINUX_REBOOT_CMD_POWER_OFF, NUL=
L);<br>
=C2=A0}<br>
<br>
diff --git a/arch/arc/kernel/reset.c b/arch/arc/kernel/reset.c<br>
index 2768fa1..0758d9d 100644<br>
--- a/arch/arc/kernel/reset.c<br>
+++ b/arch/arc/kernel/reset.c<br>
@@ -26,9 +26,6 @@ void machine_restart(char *__unused)<br>
<br>
=C2=A0void machine_power_off(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* FIXME ::=C2=A0 power off ??? */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 machine_halt();<br>
=C2=A0}<br>
-<br>
-void (*pm_power_off) (void) =3D NULL;<br>
-EXPORT_SYMBOL(pm_power_off);<br>
diff --git a/arch/arm/kernel/process.c b/arch/arm/kernel/process.c<br>
index fe972a2..aa3f656 100644<br>
--- a/arch/arm/kernel/process.c<br>
+++ b/arch/arm/kernel/process.c<br>
@@ -117,8 +117,6 @@ void soft_restart(unsigned long addr)<br>
=C2=A0/*<br>
=C2=A0 * Function pointers to optional machine specific functions<br>
=C2=A0 */<br>
-void (*pm_power_off)(void);<br>
-EXPORT_SYMBOL(pm_power_off);<br>
<br>
=C2=A0void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd)=
;<br>
<br>
@@ -205,8 +203,7 @@ void machine_power_off(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local_irq_disable();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_send_stop();<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pm_power_off)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_power_off();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c<br>
index c3065db..46a483a 100644<br>
--- a/arch/arm64/kernel/process.c<br>
+++ b/arch/arm64/kernel/process.c<br>
@@ -68,8 +68,6 @@ void soft_restart(unsigned long addr)<br>
=C2=A0/*<br>
=C2=A0 * Function pointers to optional machine specific functions<br>
=C2=A0 */<br>
-void (*pm_power_off)(void);<br>
-EXPORT_SYMBOL_GPL(pm_power_off);<br>
<br>
=C2=A0void (*arm_pm_restart)(enum reboot_mode reboot_mode, const char *cmd)=
;<br>
<br>
@@ -129,8 +127,7 @@ void machine_power_off(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 local_irq_disable();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_send_stop();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pm_power_off)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_power_off();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
diff --git a/arch/avr32/kernel/process.c b/arch/avr32/kernel/process.c<br>
index 42a53e74..529c1f6 100644<br>
--- a/arch/avr32/kernel/process.c<br>
+++ b/arch/avr32/kernel/process.c<br>
@@ -23,9 +23,6 @@<br>
<br>
=C2=A0#include &lt;mach/pm.h&gt;<br>
<br>
-void (*pm_power_off)(void);<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
=C2=A0/*<br>
=C2=A0 * This file handles the architecture-dependent parts of process hand=
ling..<br>
=C2=A0 */<br>
@@ -48,8 +45,7 @@ void machine_halt(void)<br>
<br>
=C2=A0void machine_power_off(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pm_power_off)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_power_off();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
=C2=A0}<br>
<br>
=C2=A0void machine_restart(char *cmd)<br>
diff --git a/arch/blackfin/kernel/process.c b/arch/blackfin/kernel/process.=
c<br>
index 4aa5545..812dd83 100644<br>
--- a/arch/blackfin/kernel/process.c<br>
+++ b/arch/blackfin/kernel/process.c<br>
@@ -39,9 +39,6 @@ int nr_l1stack_tasks;<br>
=C2=A0void *l1_stack_base;<br>
=C2=A0unsigned long l1_stack_len;<br>
<br>
-void (*pm_power_off)(void) =3D NULL;<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
=C2=A0/*<br>
=C2=A0 * The idle loop on BFIN<br>
=C2=A0 */<br>
diff --git a/arch/blackfin/kernel/reboot.c b/arch/blackfin/kernel/reboot.c<=
br>
index c4f50a3..387d610 100644<br>
--- a/arch/blackfin/kernel/reboot.c<br>
+++ b/arch/blackfin/kernel/reboot.c<br>
@@ -7,6 +7,7 @@<br>
=C2=A0 */<br>
<br>
=C2=A0#include &lt;linux/interrupt.h&gt;<br>
+#include &lt;linux/pm.h&gt;<br>
=C2=A0#include &lt;asm/bfin-global.h&gt;<br>
=C2=A0#include &lt;asm/reboot.h&gt;<br>
=C2=A0#include &lt;asm/bfrom.h&gt;<br>
@@ -106,6 +107,7 @@ void machine_halt(void)<br>
=C2=A0__attribute__((weak))<br>
=C2=A0void native_machine_power_off(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 idle_with_irq_disabled();<br>
=C2=A0}<br>
<br>
diff --git a/arch/c6x/kernel/process.c b/arch/c6x/kernel/process.c<br>
index 57d2ea8..edf7e5a 100644<br>
--- a/arch/c6x/kernel/process.c<br>
+++ b/arch/c6x/kernel/process.c<br>
@@ -27,12 +27,6 @@ void (*c6x_halt)(void);<br>
=C2=A0extern asmlinkage void ret_from_fork(void);<br>
=C2=A0extern asmlinkage void ret_from_kernel_thread(void);<br>
<br>
-/*<br>
- * power off function, if any<br>
- */<br>
-void (*pm_power_off)(void);<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
=C2=A0void arch_cpu_idle(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 unsigned long tmp;<br>
@@ -73,8 +67,7 @@ void machine_halt(void)<br>
<br>
=C2=A0void machine_power_off(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pm_power_off)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_power_off();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 halt_loop();<br>
=C2=A0}<br>
<br>
diff --git a/arch/cris/kernel/process.c b/arch/cris/kernel/process.c<br>
index b78498e..9ebd76b 100644<br>
--- a/arch/cris/kernel/process.c<br>
+++ b/arch/cris/kernel/process.c<br>
@@ -31,9 +31,6 @@<br>
<br>
=C2=A0extern void default_idle(void);<br>
<br>
-void (*pm_power_off)(void);<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
=C2=A0void arch_cpu_idle(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 default_idle();<br>
@@ -60,6 +57,7 @@ void machine_halt(void)<br>
<br>
=C2=A0void machine_power_off(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
=C2=A0}<br>
<br>
=C2=A0/*<br>
diff --git a/arch/frv/kernel/process.c b/arch/frv/kernel/process.c<br>
index 5d40aeb77..502dabb 100644<br>
--- a/arch/frv/kernel/process.c<br>
+++ b/arch/frv/kernel/process.c<br>
@@ -42,9 +42,6 @@ asmlinkage void ret_from_kernel_thread(void);<br>
<br>
=C2=A0#include &lt;asm/pgalloc.h&gt;<br>
<br>
-void (*pm_power_off)(void);<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
=C2=A0static void core_sleep_idle(void)<br>
=C2=A0{<br>
=C2=A0#ifdef LED_DEBUG_SLEEP<br>
@@ -107,6 +104,8 @@ void machine_power_off(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gdbstub_exit(0);<br>
=C2=A0#endif<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (;;);<br>
=C2=A0}<br>
<br>
diff --git a/arch/hexagon/kernel/reset.c b/arch/hexagon/kernel/reset.c<br>
index 76483c1..6f607b6 100644<br>
--- a/arch/hexagon/kernel/reset.c<br>
+++ b/arch/hexagon/kernel/reset.c<br>
@@ -16,11 +16,13 @@<br>
=C2=A0 * 02110-1301, USA.<br>
=C2=A0 */<br>
<br>
+#include &lt;linux/pm.h&gt;<br>
=C2=A0#include &lt;linux/smp.h&gt;<br>
=C2=A0#include &lt;asm/hexagon_vm.h&gt;<br>
<br>
=C2=A0void machine_power_off(void)<br>
=C2=A0{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_send_stop();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __vmstop();<br>
=C2=A0}<br>
@@ -32,6 +34,3 @@ void machine_halt(void)<br>
=C2=A0void machine_restart(char *cmd)<br>
=C2=A0{<br>
=C2=A0}<br>
-<br>
-void (*pm_power_off)(void) =3D NULL;<br>
-EXPORT_SYMBOL(pm_power_off);<br>
diff --git a/arch/ia64/kernel/process.c b/arch/ia64/kernel/process.c<br>
index b515149..88121a2 100644<br>
--- a/arch/ia64/kernel/process.c<br>
+++ b/arch/ia64/kernel/process.c<br>
@@ -57,8 +57,6 @@ void (*ia64_mark_idle)(int);<br>
<br>
=C2=A0unsigned long boot_option_idle_override =3D IDLE_NO_OVERRIDE;<br>
=C2=A0EXPORT_SYMBOL(boot_option_idle_override);<br>
-void (*pm_power_off) (void);<br>
-EXPORT_SYMBOL(pm_power_off);<br>
<br>
=C2=A0void<br>
=C2=A0ia64_do_show_stack (struct unw_frame_info *info, void *arg)<br>
@@ -675,8 +673,7 @@ machine_halt (void)<br>
=C2=A0void<br>
=C2=A0machine_power_off (void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pm_power_off)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_power_off();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 machine_halt();<br>
=C2=A0}<br>
<br>
diff --git a/arch/m32r/kernel/process.c b/arch/m32r/kernel/process.c<br>
index e69221d..65a037e 100644<br>
--- a/arch/m32r/kernel/process.c<br>
+++ b/arch/m32r/kernel/process.c<br>
@@ -23,6 +23,7 @@<br>
=C2=A0#include &lt;linux/fs.h&gt;<br>
=C2=A0#include &lt;linux/slab.h&gt;<br>
=C2=A0#include &lt;linux/module.h&gt;<br>
+#include &lt;linux/pm.h&gt;<br>
=C2=A0#include &lt;linux/ptrace.h&gt;<br>
=C2=A0#include &lt;linux/unistd.h&gt;<br>
=C2=A0#include &lt;linux/hardirq.h&gt;<br>
@@ -44,9 +45,6 @@ unsigned long thread_saved_pc(struct task_struct *tsk)<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return tsk-&gt;<a href=3D"http://thread.lr" tar=
get=3D"_blank">thread.lr</a>;<br>
=C2=A0}<br>
<br>
-void (*pm_power_off)(void) =3D NULL;<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
=C2=A0void machine_restart(char *__unused)<br>
=C2=A0{<br>
=C2=A0#if defined(CONFIG_PLAT_MAPPI3)<br>
@@ -67,7 +65,9 @@ void machine_halt(void)<br>
<br>
=C2=A0void machine_power_off(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0/* M32R_FIXME */<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0for (;;)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0;<br>
=C2=A0}<br>
<br>
=C2=A0void show_regs(struct pt_regs * regs)<br>
diff --git a/arch/m68k/kernel/process.c b/arch/m68k/kernel/process.c<br>
index afe3d6e..bbc0a63 100644<br>
--- a/arch/m68k/kernel/process.c<br>
+++ b/arch/m68k/kernel/process.c<br>
@@ -78,14 +78,10 @@ void machine_halt(void)<br>
<br>
=C2=A0void machine_power_off(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pm_power_off)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_power_off();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 for (;;);<br>
=C2=A0}<br>
<br>
-void (*pm_power_off)(void) =3D machine_power_off;<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
=C2=A0void show_regs(struct pt_regs * regs)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(&quot;\n&quot;);<br>
diff --git a/arch/metag/kernel/process.c b/arch/metag/kernel/process.c<br>
index 483dff9..8d95773 100644<br>
--- a/arch/metag/kernel/process.c<br>
+++ b/arch/metag/kernel/process.c<br>
@@ -67,9 +67,6 @@ void arch_cpu_idle_dead(void)<br>
=C2=A0}<br>
=C2=A0#endif<br>
<br>
-void (*pm_power_off)(void);<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
=C2=A0void (*soc_restart)(char *cmd);<br>
=C2=A0void (*soc_halt)(void);<br>
<br>
@@ -90,8 +87,7 @@ void machine_halt(void)<br>
<br>
=C2=A0void machine_power_off(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pm_power_off)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_power_off();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_send_stop();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hard_processor_halt(HALT_OK);<br>
=C2=A0}<br>
diff --git a/arch/microblaze/kernel/process.c b/arch/microblaze/kernel/proc=
ess.c<br>
index b2dd371..0ebca36 100644<br>
--- a/arch/microblaze/kernel/process.c<br>
+++ b/arch/microblaze/kernel/process.c<br>
@@ -44,9 +44,6 @@ void show_regs(struct pt_regs *regs)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 regs-&gt;msr, regs-&gt;ear, regs-&gt=
;esr, regs-&gt;fsr);<br>
=C2=A0}<br>
<br>
-void (*pm_power_off)(void) =3D NULL;<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
=C2=A0void flush_thread(void)<br>
=C2=A0{<br>
=C2=A0}<br>
diff --git a/arch/microblaze/kernel/reset.c b/arch/microblaze/kernel/reset.=
c<br>
index fbe58c6..2c6b32c 100644<br>
--- a/arch/microblaze/kernel/reset.c<br>
+++ b/arch/microblaze/kernel/reset.c<br>
@@ -103,6 +103,7 @@ void machine_halt(void)<br>
=C2=A0void machine_power_off(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pr_notice(&quot;Machine power off...\n&quot;);<=
br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (1)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ;<br>
=C2=A0}<br>
diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c<br>
index 07fc524..09e74d2 100644<br>
--- a/arch/mips/kernel/reset.c<br>
+++ b/arch/mips/kernel/reset.c<br>
@@ -21,9 +21,6 @@<br>
=C2=A0 */<br>
=C2=A0void (*_machine_restart)(char *command);<br>
=C2=A0void (*_machine_halt)(void);<br>
-void (*pm_power_off)(void);<br>
-<br>
-EXPORT_SYMBOL(pm_power_off);<br>
<br>
=C2=A0void machine_restart(char *command)<br>
=C2=A0{<br>
@@ -39,6 +36,5 @@ void machine_halt(void)<br>
<br>
=C2=A0void machine_power_off(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pm_power_off)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_power_off();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
=C2=A0}<br>
diff --git a/arch/mn10300/kernel/process.c b/arch/mn10300/kernel/process.c<=
br>
index 3707da5..c78b2eb 100644<br>
--- a/arch/mn10300/kernel/process.c<br>
+++ b/arch/mn10300/kernel/process.c<br>
@@ -20,6 +20,7 @@<br>
=C2=A0#include &lt;linux/user.h&gt;<br>
=C2=A0#include &lt;linux/interrupt.h&gt;<br>
=C2=A0#include &lt;linux/delay.h&gt;<br>
+#include &lt;linux/pm.h&gt;<br>
=C2=A0#include &lt;linux/reboot.h&gt;<br>
=C2=A0#include &lt;linux/percpu.h&gt;<br>
=C2=A0#include &lt;linux/err.h&gt;<br>
@@ -45,12 +46,6 @@ unsigned long thread_saved_pc(struct task_struct *tsk)<b=
r>
=C2=A0}<br>
<br>
=C2=A0/*<br>
- * power off function, if any<br>
- */<br>
-void (*pm_power_off)(void);<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
-/*<br>
=C2=A0 * On SMP it&#39;s slightly faster (but much more power-consuming!)<b=
r>
=C2=A0 * to poll the -&gt;work.need_resched flag instead of waiting for the=
<br>
=C2=A0 * cross-CPU IPI to arrive. Use this option with caution.<br>
@@ -93,6 +88,7 @@ void machine_power_off(void)<br>
=C2=A0#ifdef CONFIG_KERNEL_DEBUGGER<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gdbstub_exit(0);<br>
=C2=A0#endif<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
=C2=A0}<br>
<br>
=C2=A0void show_regs(struct pt_regs *regs)<br>
diff --git a/arch/openrisc/kernel/process.c b/arch/openrisc/kernel/process.=
c<br>
index 386af25..494afd2 100644<br>
--- a/arch/openrisc/kernel/process.c<br>
+++ b/arch/openrisc/kernel/process.c<br>
@@ -25,6 +25,7 @@<br>
=C2=A0#include &lt;linux/kernel.h&gt;<br>
=C2=A0#include &lt;linux/module.h&gt;<br>
=C2=A0#include &lt;linux/mm.h&gt;<br>
+#include &lt;linux/pm.h&gt;<br>
=C2=A0#include &lt;linux/stddef.h&gt;<br>
=C2=A0#include &lt;linux/unistd.h&gt;<br>
=C2=A0#include &lt;linux/ptrace.h&gt;<br>
@@ -51,7 +52,7 @@<br>
=C2=A0 */<br>
=C2=A0struct thread_info *current_thread_info_set[NR_CPUS] =3D { &amp;init_=
thread_info, };<br>
<br>
-void machine_restart(void)<br>
+void machine_restart(char *cmd)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_INFO &quot;*** MACHINE RESTART ***\=
n&quot;);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __asm__(&quot;l.nop 1&quot;);<br>
@@ -72,11 +73,12 @@ void machine_halt(void)<br>
=C2=A0void machine_power_off(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 printk(KERN_INFO &quot;*** MACHINE POWER OFF **=
*\n&quot;);<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 __asm__(&quot;l.nop 1&quot;);<br>
=C2=A0}<br>
<br>
-void (*pm_power_off) (void) =3D machine_power_off;<br>
-<br>
=C2=A0/*<br>
=C2=A0 * When a process does an &quot;exec&quot;, machine state like FPU an=
d debug<br>
=C2=A0 * registers need to be reset.=C2=A0 This is a hook function for that=
.<br>
diff --git a/arch/parisc/kernel/process.c b/arch/parisc/kernel/process.c<br=
>
index 0bbbf0d..3f5d14a 100644<br>
--- a/arch/parisc/kernel/process.c<br>
+++ b/arch/parisc/kernel/process.c<br>
@@ -41,6 +41,7 @@<br>
=C2=A0#include &lt;linux/fs.h&gt;<br>
=C2=A0#include &lt;linux/module.h&gt;<br>
=C2=A0#include &lt;linux/personality.h&gt;<br>
+#include &lt;linux/pm.h&gt;<br>
=C2=A0#include &lt;linux/ptrace.h&gt;<br>
=C2=A0#include &lt;linux/sched.h&gt;<br>
=C2=A0#include &lt;linux/slab.h&gt;<br>
@@ -133,7 +134,9 @@ void machine_power_off(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pdc_soft_power_button(0);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 pdc_chassis_send_status(PDC_CHASSIS_DIRECT_SHUT=
DOWN);<br>
-<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* It seems we have no way to power the system =
off via<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* software. The user has to press the but=
ton himself. */<br>
<br>
@@ -141,9 +144,6 @@ void machine_power_off(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;Please power t=
his system off now.&quot;);<br>
=C2=A0}<br>
<br>
-void (*pm_power_off)(void) =3D machine_power_off;<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
=C2=A0/*<br>
=C2=A0 * Free current thread data structures etc..<br>
=C2=A0 */<br>
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup=
-common.c<br>
index 1362cd6..5b7a851 100644<br>
--- a/arch/powerpc/kernel/setup-common.c<br>
+++ b/arch/powerpc/kernel/setup-common.c<br>
@@ -141,6 +141,9 @@ void machine_power_off(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 machine_shutdown();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (ppc_md.power_off)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ppc_md.power_off();=
<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
+<br>
=C2=A0#ifdef CONFIG_SMP<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_send_stop();<br>
=C2=A0#endif<br>
@@ -151,9 +154,6 @@ void machine_power_off(void)<br>
=C2=A0/* Used by the G5 thermal driver */<br>
=C2=A0EXPORT_SYMBOL_GPL(machine_power_off);<br>
<br>
-void (*pm_power_off)(void) =3D machine_power_off;<br>
-EXPORT_SYMBOL_GPL(pm_power_off);<br>
-<br>
=C2=A0void machine_halt(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 machine_shutdown();<br>
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c<br>
index e80d9ff..267e025 100644<br>
--- a/arch/s390/kernel/setup.c<br>
+++ b/arch/s390/kernel/setup.c<br>
@@ -263,13 +263,9 @@ void machine_power_off(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 console_unblank();<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 _machine_power_off();<br>
-}<br>
<br>
-/*<br>
- * Dummy power off function.<br>
- */<br>
-void (*pm_power_off)(void) =3D machine_power_off;<br>
-EXPORT_SYMBOL_GPL(pm_power_off);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
+}<br>
<br>
=C2=A0static int __init early_parse_mem(char *p)<br>
=C2=A0{<br>
diff --git a/arch/score/kernel/process.c b/arch/score/kernel/process.c<br>
index a1519ad3..b76ea67 100644<br>
--- a/arch/score/kernel/process.c<br>
+++ b/arch/score/kernel/process.c<br>
@@ -29,9 +29,6 @@<br>
=C2=A0#include &lt;linux/pm.h&gt;<br>
=C2=A0#include &lt;linux/rcupdate.h&gt;<br>
<br>
-void (*pm_power_off)(void);<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
=C2=A0/* If or when software machine-restart is implemented, add code here.=
 */<br>
=C2=A0void machine_restart(char *command) {}<br>
<br>
@@ -39,7 +36,10 @@ void machine_restart(char *command) {}<br>
=C2=A0void machine_halt(void) {}<br>
<br>
=C2=A0/* If or when software machine-power-off is implemented, add code her=
e. */<br>
-void machine_power_off(void) {}<br>
+void machine_power_off(void)<br>
+{<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
+}<br>
<br>
=C2=A0void ret_from_fork(void);<br>
=C2=A0void ret_from_kernel_thread(void);<br>
diff --git a/arch/sh/kernel/reboot.c b/arch/sh/kernel/reboot.c<br>
index 04afe5b..065de12 100644<br>
--- a/arch/sh/kernel/reboot.c<br>
+++ b/arch/sh/kernel/reboot.c<br>
@@ -11,9 +11,6 @@<br>
=C2=A0#include &lt;asm/tlbflush.h&gt;<br>
=C2=A0#include &lt;asm/traps.h&gt;<br>
<br>
-void (*pm_power_off)(void);<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
=C2=A0#ifdef CONFIG_SUPERH32<br>
=C2=A0static void watchdog_trigger_immediate(void)<br>
=C2=A0{<br>
@@ -51,8 +48,7 @@ static void native_machine_shutdown(void)<br>
<br>
=C2=A0static void native_machine_power_off(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pm_power_off)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_power_off();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
=C2=A0}<br>
<br>
=C2=A0static void native_machine_halt(void)<br>
diff --git a/arch/sparc/kernel/process_32.c b/arch/sparc/kernel/process_32.=
c<br>
index 50e7b62..cb8148a 100644<br>
--- a/arch/sparc/kernel/process_32.c<br>
+++ b/arch/sparc/kernel/process_32.c<br>
@@ -48,14 +48,6 @@<br>
=C2=A0 */<br>
=C2=A0void (*sparc_idle)(void);<br>
<br>
-/*<br>
- * Power-off handler instantiation for pm.h compliance<br>
- * This is done via auxio, but could be used as a fallback<br>
- * handler when auxio is not present-- unused for now...<br>
- */<br>
-void (*pm_power_off)(void) =3D machine_power_off;<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
=C2=A0/*<br>
=C2=A0 * sysctl - toggle power-off restriction for serial console<br>
=C2=A0 * systems in machine_power_off()<br>
@@ -112,6 +104,8 @@ void machine_power_off(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 sbus_writeb(power_r=
egister, auxio_power_register);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 machine_halt();<br>
=C2=A0}<br>
<br>
diff --git a/arch/sparc/kernel/reboot.c b/arch/sparc/kernel/reboot.c<br>
index eba7d91..3c0bb03 100644<br>
--- a/arch/sparc/kernel/reboot.c<br>
+++ b/arch/sparc/kernel/reboot.c<br>
@@ -16,17 +16,13 @@<br>
=C2=A0 */<br>
=C2=A0int scons_pwroff =3D 1;<br>
<br>
-/* This isn&#39;t actually used, it exists merely to satisfy the<br>
- * reference in kernel/sys.c<br>
- */<br>
-void (*pm_power_off)(void) =3D machine_power_off;<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
=C2=A0void machine_power_off(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (strcmp(of_console_device-&gt;type, &quot;se=
rial&quot;) || scons_pwroff)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 prom_halt_power_off=
();<br>
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 prom_halt();<br>
=C2=A0}<br>
<br>
diff --git a/arch/tile/kernel/reboot.c b/arch/tile/kernel/reboot.c<br>
index 6c5d2c0..8ff4a7f 100644<br>
--- a/arch/tile/kernel/reboot.c<br>
+++ b/arch/tile/kernel/reboot.c<br>
@@ -36,6 +36,9 @@ void machine_power_off(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 arch_local_irq_disable_all();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_send_stop();<br>
+<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hv_power_off();<br>
=C2=A0}<br>
<br>
@@ -45,7 +48,3 @@ void machine_restart(char *cmd)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 smp_send_stop();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 hv_restart((HV_VirtAddr) &quot;vmlinux&quot;, (=
HV_VirtAddr) cmd);<br>
=C2=A0}<br>
-<br>
-/* No interesting distinction to be made here. */<br>
-void (*pm_power_off)(void) =3D NULL;<br>
-EXPORT_SYMBOL(pm_power_off);<br>
diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c<br>
index ced8903..a82ef28 100644<br>
--- a/arch/um/kernel/reboot.c<br>
+++ b/arch/um/kernel/reboot.c<br>
@@ -11,8 +11,6 @@<br>
=C2=A0#include &lt;os.h&gt;<br>
=C2=A0#include &lt;skas.h&gt;<br>
<br>
-void (*pm_power_off)(void);<br>
-<br>
=C2=A0static void kill_off_processes(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 if (proc_mm)<br>
diff --git a/arch/unicore32/kernel/process.c b/arch/unicore32/kernel/proces=
s.c<br>
index b008e99..9490dd5 100644<br>
--- a/arch/unicore32/kernel/process.c<br>
+++ b/arch/unicore32/kernel/process.c<br>
@@ -56,16 +56,9 @@ void machine_halt(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 gpio_set_value(GPO_SOFT_OFF, 0);<br>
=C2=A0}<br>
<br>
-/*<br>
- * Function pointers to optional machine specific functions<br>
- */<br>
-void (*pm_power_off)(void) =3D NULL;<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
=C2=A0void machine_power_off(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pm_power_off)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_power_off();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 machine_halt();<br>
=C2=A0}<br>
<br>
diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c<br>
index 17962e6..5c09e28 100644<br>
--- a/arch/x86/kernel/reboot.c<br>
+++ b/arch/x86/kernel/reboot.c<br>
@@ -30,12 +30,6 @@<br>
=C2=A0#include &lt;asm/x86_init.h&gt;<br>
=C2=A0#include &lt;asm/efi.h&gt;<br>
<br>
-/*<br>
- * Power off function, if any<br>
- */<br>
-void (*pm_power_off)(void);<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
=C2=A0static const struct desc_ptr no_idt =3D {};<br>
<br>
=C2=A0/*<br>
@@ -647,11 +641,12 @@ static void native_machine_halt(void)<br>
<br>
=C2=A0static void native_machine_power_off(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pm_power_off) {<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (have_kernel_power_off()) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (!reboot_force)<=
br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 machine_shutdown();<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_power_off();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off=
();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
+<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* A fallback in case there is no PM info avail=
able */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 tboot_shutdown(TB_SHUTDOWN_HALT);<br>
=C2=A0}<br>
diff --git a/arch/x86/xen/enlighten.c b/arch/x86/xen/enlighten.c<br>
index 1a3f044..c2c1d74 100644<br>
--- a/arch/x86/xen/enlighten.c<br>
+++ b/arch/x86/xen/enlighten.c<br>
@@ -1320,8 +1320,7 @@ static void xen_machine_halt(void)<br>
<br>
=C2=A0static void xen_machine_power_off(void)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pm_power_off)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_power_off();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0do_kernel_power_off();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 xen_reboot(SHUTDOWN_poweroff);<br>
=C2=A0}<br>
<br>
diff --git a/arch/xtensa/kernel/process.c b/arch/xtensa/kernel/process.c<br=
>
index 1c85323..c487296 100644<br>
--- a/arch/xtensa/kernel/process.c<br>
+++ b/arch/xtensa/kernel/process.c<br>
@@ -49,10 +49,6 @@ extern void ret_from_kernel_thread(void);<br>
<br>
=C2=A0struct task_struct *current_set[NR_CPUS] =3D {&amp;init_task, };<br>
<br>
-void (*pm_power_off)(void) =3D NULL;<br>
-EXPORT_SYMBOL(pm_power_off);<br>
-<br>
-<br>
=C2=A0#if XTENSA_HAVE_COPROCESSORS<br>
<br>
=C2=A0void coprocessor_release_all(struct thread_info *ti)<br>
diff --git a/drivers/parisc/power.c b/drivers/parisc/power.c<br>
index ef31b77..f10cf92 100644<br>
--- a/drivers/parisc/power.c<br>
+++ b/drivers/parisc/power.c<br>
@@ -95,8 +95,7 @@ static void process_shutdown(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 /* send kill signal=
 */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (kill_cad_pid(SI=
GINT, 1)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 /* just in case killing init process failed */<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (pm_power_off)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_power_off();<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0kernel_power_off();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
=C2=A0}<br>
diff --git a/kernel/power/poweroff_handler.c b/kernel/power/poweroff_handle=
r.c<br>
index aeb4736..37f0b88 100644<br>
--- a/kernel/power/poweroff_handler.c<br>
+++ b/kernel/power/poweroff_handler.c<br>
@@ -22,6 +22,12 @@<br>
=C2=A0#include &lt;linux/types.h&gt;<br>
<br>
=C2=A0/*<br>
+ * If set, calling this function will power off the system immediately.<br=
>
+ */<br>
+void (*pm_power_off)(void);<br>
+EXPORT_SYMBOL(pm_power_off);<br>
+<br>
+/*<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0Notifier list for kernel code which wants to be=
 called<br>
=C2=A0 *=C2=A0 =C2=A0 =C2=A0to power off the system.<br>
=C2=A0 */<br>
@@ -236,6 +242,8 @@ EXPORT_SYMBOL(devm_register_power_off_handler);<br>
=C2=A0void do_kernel_power_off(void)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_lock(&amp;power_off_handler_lock);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (pm_power_off)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pm_power_off();<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 raw_notifier_call_chain(&amp;power_off_handler_=
list, 0, NULL);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 spin_unlock(&amp;power_off_handler_lock);<br>
=C2=A0}<br>
diff --git a/kernel/reboot.c b/kernel/reboot.c<br>
index 5925f5a..0930851 100644<br>
--- a/kernel/reboot.c<br>
+++ b/kernel/reboot.c<br>
@@ -306,9 +306,9 @@ SYSCALL_DEFINE4(reboot, int, magic1, int, magic2, unsig=
ned int, cmd,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 return ret;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 /* Instead of trying to make the power_off code=
 look like<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 * halt when pm_power_off is not set do it the =
easy way.<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 * halt when no poweroff handler exists do it t=
he easy way.<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0*/<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0if ((cmd =3D=3D LINUX_REBOOT_CMD_POWER_OFF) &am=
p;&amp; !pm_power_off)<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0if (cmd =3D=3D LINUX_REBOOT_CMD_POWER_OFF &amp;=
&amp; !have_kernel_power_off())<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 cmd =3D LINUX_REBOO=
T_CMD_HALT;<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 mutex_lock(&amp;reboot_mutex);<br>
<span class=3D"HOEnZb"><font color=3D"#888888">--<br>
1.9.1<br>
<br>
--<br>
To unsubscribe from this list: send the line &quot;unsubscribe linux-kernel=
&quot; in<br>
the body of a message to <a href=3D"mailto:majordomo@vger.kernel.org">major=
domo@vger.kernel.org</a><br>
More majordomo info at=C2=A0 <a href=3D"http://vger.kernel.org/majordomo-in=
fo.html" target=3D"_blank">http://vger.kernel.org/majordomo-info.html</a><b=
r>
Please read the FAQ at=C2=A0 <a href=3D"http://www.tux.org/lkml/" target=3D=
"_blank">http://www.tux.org/lkml/</a><br>
</font></span></blockquote></div><br></div>

--001a113a86702f37da0506284674--
