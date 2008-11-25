Return-Path: <neko@genesi-usa.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 71DF9DDDFB
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Nov 2008 05:53:13 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so61010yxb.13
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Nov 2008 10:53:12 -0800 (PST)
Message-ID: <b5e2fc790811251053w507792a1r3673ee2dc7581379@mail.gmail.com>
Date: Tue, 25 Nov 2008 12:53:12 -0600
From: "Matt Sealey" <matt@genesi-usa.com>
To: "Grant Erickson" <gerickson@nuovations.com>
Subject: Re: [PATCH/RFC] Add Alternative Log Buffer Support for printk Messages
In-Reply-To: <1227638045-12862-1-git-send-email-gerickson@nuovations.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_9828_10569136.1227639192528"
References: <1227638045-12862-1-git-send-email-gerickson@nuovations.com>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Wolfgang Denx <wd@denx.de>, linux-embedded@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_9828_10569136.1227639192528
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Nitpick, really.. shouldn't the logbuffer location(s) be some device tree
property(ies), perhaps something in the
/chosen node that U-Boot etc. can then fill out?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

On Tue, Nov 25, 2008 at 12:34 PM, Grant Erickson
<gerickson@nuovations.com>wrote:

> This merges support for the previously DENX-only kernel feature of
> specifying an alternative, "external" buffer for kernel printk
> messages and their associated metadata. In addition, this ports
> architecture support for this feature from arch/ppc to arch/powerpc.
>
> Signed-off-by: Grant Erickson <gerickson@nuovations.com>
> ---
>
> When this option is enabled, an architecture- or machine-specific log
> buffer is used for all printk messages. This allows entities such as
> boot loaders (e.g. U-Boot) to place printk-compatible messages into
> this buffer and for the kernel to coalesce them with its normal
> messages.
>
> The code has historically been used and proven to work on the LWMON5
> platform under arch/ppc and is now used (by me) successfully on the
> AMCC Haleakala and Kilauea platforms.
>
> As implemented for arch/powerpc, two suboptions for the alternative
> log buffer are supported. The buffer may be contiguous with the
> metadata and message data colocated or the metadata and message
> storage may be in discontiguous regions of memory (e.g. a set of
> scratch registers and an SRAM buffer). On Kilauea and Haleakala, I
> have used the former; whereas LWMON5 has traditionally used the latter.
>
> The code here is, more or less, as-is from the DENX GIT tree. Comments
> welcome.
>
>  arch/powerpc/kernel/prom.c |   93 +++++++++++++++++++++++++++
>  include/linux/logbuff.h    |   56 ++++++++++++++++
>  init/Kconfig               |   25 +++++++
>  init/main.c                |    4 +
>  kernel/printk.c            |  149
> +++++++++++++++++++++++++++++++++++++++++++-
>  5 files changed, 324 insertions(+), 3 deletions(-)
>  create mode 100644 include/linux/logbuff.h
>
> diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> index 3a2dc7e..60282f1 100644
> --- a/arch/powerpc/kernel/prom.c
> +++ b/arch/powerpc/kernel/prom.c
> @@ -32,6 +32,7 @@
>  #include <linux/debugfs.h>
>  #include <linux/irq.h>
>  #include <linux/lmb.h>
> +#include <linux/logbuff.h>
>
>  #include <asm/prom.h>
>  #include <asm/rtas.h>
> @@ -61,6 +62,15 @@
>  #define DBG(fmt...)
>  #endif
>
> +#ifdef CONFIG_LOGBUFFER
> +#ifdef CONFIG_ALT_LB_LOCATION
> +# if !defined(BOARD_ALT_LH_ADDR) || !defined(BOARD_ALT_LB_ADDR)
> +#  error "Please specify BOARD_ALT_LH_ADDR & BOARD_ALT_LB_ADDR."
> +# endif
> +#else /* !CONFIG_ALT_LB_LOCATION */
> +static phys_addr_t ext_logbuff;
> +#endif /* CONFIG_ALT_LB_LOCATION */
> +#endif /* CONFIG_LOGBUFFER */
>
>  static int __initdata dt_root_addr_cells;
>  static int __initdata dt_root_size_cells;
> @@ -1018,6 +1028,85 @@ static int __init early_init_dt_scan_memory(unsigned
> long node,
>        return 0;
>  }
>
> +#ifdef CONFIG_LOGBUFFER
> +#ifdef CONFIG_ALT_LB_LOCATION
> +/* Alternative external log buffer mapping: log metadata header & the
> + * character buffer are separated and allocated not in RAM but in some
> + * other memory-mapped I/O region (e.g. log head in unused registers,
> + * and log buffer in OCM memory)
> + */
> +int __init setup_ext_logbuff_mem(volatile logbuff_t **lhead, char **lbuf)
> +{
> +       void *h, *b;
> +
> +       if (unlikely(!lhead) || unlikely(!lbuf))
> +               return -EINVAL;
> +
> +       /* map log head */
> +       h = ioremap(BOARD_ALT_LH_ADDR, sizeof(logbuff_t));
> +       if (unlikely(!h))
> +               return -EFAULT;
> +
> +       /* map log buffer */
> +       b = ioremap(BOARD_ALT_LB_ADDR, LOGBUFF_LEN);
> +       if (unlikely(!b)) {
> +               iounmap(h);
> +               return -EFAULT;
> +       }
> +
> +       *lhead = h;
> +       *lbuf = b;
> +
> +       return 0;
> +}
> +#else /* !CONFIG_ALT_LB_LOCATION */
> +/* Usual external log-buffer mapping: log metadata header & the character
> + * buffer are both contiguous in system RAM.
> + */
> +int __init setup_ext_logbuff_mem(logbuff_t **lhead, char **lbuf)
> +{
> +       void *p;
> +
> +       if (unlikely(!lhead) || unlikely(!lbuf))
> +               return -EINVAL;
> +
> +       if (unlikely(!ext_logbuff) || !lmb_is_reserved(ext_logbuff))
> +               return -EFAULT;
> +
> +       p = ioremap(ext_logbuff, LOGBUFF_RESERVE);
> +
> +       if (unlikely(!p))
> +               return -EFAULT;
> +
> +       *lhead = (logbuff_t *)(p + LOGBUFF_OVERHEAD -
> +                              sizeof(logbuff_t) +
> +                              sizeof(((logbuff_t *)0)->buf));
> +       *lbuf = (*lhead)->buf;
> +
> +       return 0;
> +}
> +
> +/* When the external log buffer configuration is used with the
> + * non-alternate location, the log head metadata and character buffer
> + * lie in the LOGBUFF_RESERVE bytes at the end of system RAM. Add this
> + * block of memory to the reserved memory pool so that it is not
> + * allocated for other purposes.
> + */
> +static void __init reserve_ext_logbuff_mem(void)
> +{
> +       phys_addr_t top = lmb_end_of_DRAM();
> +       phys_addr_t size = LOGBUFF_RESERVE;
> +       phys_addr_t base = top - size;
> +
> +       if (top > base) {
> +               ext_logbuff = base;
> +               DBG("reserving: %x -> %x\n", base, size);
> +               lmb_reserve(base, size);
> +       }
> +}
> +#endif /* CONFIG_ALT_LB_LOCATION */
> +#endif /* CONFIG_LOGBUFFER */
> +
>  static void __init early_reserve_mem(void)
>  {
>        u64 base, size;
> @@ -1033,6 +1122,10 @@ static void __init early_reserve_mem(void)
>        self_size = initial_boot_params->totalsize;
>        lmb_reserve(self_base, self_size);
>
> +#if defined(CONFIG_LOGBUFFER) && !defined(CONFIG_ALT_LB_LOCATION)
> +       reserve_ext_logbuff_mem();
> +#endif /* defined(CONFIG_LOGBUFFER) && !defined(CONFIG_ALT_LB_LOCATION) */
> +
>  #ifdef CONFIG_BLK_DEV_INITRD
>        /* then reserve the initrd, if any */
>        if (initrd_start && (initrd_end > initrd_start))
> diff --git a/include/linux/logbuff.h b/include/linux/logbuff.h
> new file mode 100644
> index 0000000..22a51c0
> --- /dev/null
> +++ b/include/linux/logbuff.h
> @@ -0,0 +1,56 @@
> +/*
> + * (C) Copyright 2007
> + * Wolfgang Denk, DENX Software Engineering, wd@denx.de.
> + *
> + * See file CREDITS for list of people who contributed to this
> + * project.
> + *
> + * This program is free software; you can redistribute it and/or
> + * modify it under the terms of the GNU General Public License as
> + * published by the Free Software Foundation; either version 2 of
> + * the License, or (at your option) any later version.
> + *
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program; if not, write to the Free Software
> + * Foundation, Inc., 59 Temple Place, Suite 330, Boston,
> + * MA 02111-1307 USA
> + */
> +#ifndef _LOGBUFF_H_
> +#define _LOGBUFF_H_
> +
> +#ifdef CONFIG_LOGBUFFER
> +
> +#define LOGBUFF_MAGIC          0xc0de4ced
> +#define LOGBUFF_LEN            16384
> +#define LOGBUFF_OVERHEAD       4096
> +#define LOGBUFF_RESERVE                (LOGBUFF_LEN + LOGBUFF_OVERHEAD)
> +
> +/* The mapping used here has to be the same as in logbuff_init_ptrs ()
> +   in u-boot/common/cmd_log.c */
> +
> +typedef struct {
> +       unsigned long   tag;
> +       unsigned long   start;
> +       unsigned long   con;    /* next char to be sent to consoles     */
> +       unsigned long   end;
> +       unsigned long   chars;
> +       unsigned char   buf[0];
> +} logbuff_t;
> +
> +#ifdef CONFIG_ALT_LB_LOCATION
> +# define LOGBUFF_VOLATILE      volatile
> +#else
> +# define LOGBUFF_VOLATILE
> +#endif /* defined(CONFIG_ALT_LB_LOCATION) */
> +
> +extern void setup_ext_logbuff(void);
> +/* arch specific */
> +extern int setup_ext_logbuff_mem(LOGBUFF_VOLATILE logbuff_t **lhead, char
> **lbuf);
> +
> +#endif /* CONFIG_LOGBUFFER */
> +#endif /* _LOGBUFF_H_ */
> diff --git a/init/Kconfig b/init/Kconfig
> index f763762..e1a1b59 100644
> --- a/init/Kconfig
> +++ b/init/Kconfig
> @@ -619,6 +619,31 @@ config PRINTK
>          very difficult to diagnose system problems, saying N here is
>          strongly discouraged.
>
> +config LOGBUFFER
> +       bool "External logbuffer" if PRINTK
> +       default n
> +       help
> +         This option enables support for an alternative, "external"
> +         printk log buffer. When enabled, an architecture- or machine-
> +         specific log buffer is used for all printk messages. This
> +         allows entities such as boot loaders to place printk-compatible
> +         messages into this buffer and for the kernel to coalesce them
> +         with its normal messages.
> +
> +config ALT_LB_LOCATION
> +       bool "Alternative logbuffer" if LOGBUFFER
> +       default n
> +       help
> +         When using an alternative, "external" printk log buffer, an
> +         architecture- or machine-specific log buffer with contiguous
> +         metadata and message storage is used. This option enables
> +         support for discontiguous metadata and message storage
> +         memory (e.g. a set of scratch registers and an SRAM
> +         buffer). By saying Y here, you must also ensure your
> +         architecture- or machine-code specify BOARD_ALT_LH_ADDR and
> +         BOARD_ALT_LB_ADDR, for the metadata and message memory,
> +         respectively.
> +
>  config BUG
>        bool "BUG() support" if EMBEDDED
>        default y
> diff --git a/init/main.c b/init/main.c
> index 7e117a2..5687b98 100644
> --- a/init/main.c
> +++ b/init/main.c
> @@ -61,6 +61,7 @@
>  #include <linux/kthread.h>
>  #include <linux/sched.h>
>  #include <linux/signal.h>
> +#include <linux/logbuff.h>
>  #include <linux/idr.h>
>  #include <linux/ftrace.h>
>
> @@ -563,6 +564,9 @@ asmlinkage void __init start_kernel(void)
>  * Interrupts are still disabled. Do necessary setups, then
>  * enable them
>  */
> +#ifdef CONFIG_LOGBUFFER
> +       setup_ext_logbuff();
> +#endif
>        lock_kernel();
>        tick_init();
>        boot_cpu_init();
> diff --git a/kernel/printk.c b/kernel/printk.c
> index f492f15..59884e2 100644
> --- a/kernel/printk.c
> +++ b/kernel/printk.c
> @@ -32,6 +32,7 @@
>  #include <linux/security.h>
>  #include <linux/bootmem.h>
>  #include <linux/syscalls.h>
> +#include <linux/logbuff.h>
>
>  #include <asm/uaccess.h>
>
> @@ -101,9 +102,39 @@ static DEFINE_SPINLOCK(logbuf_lock);
>  * The indices into log_buf are not constrained to log_buf_len - they
>  * must be masked before subscripting
>  */
> +#ifdef CONFIG_LOGBUFFER
> +/* Indexes to the local log buffer */
> +static unsigned long _log_start;
> +static unsigned long _con_start;
> +static unsigned long _log_end;
> +static unsigned long _logged_chars;
> +/* These will be switched to the external log buffer */
> +#ifndef CONFIG_ALT_LB_LOCATION
> +/* usual logbuffer location */
> +static unsigned long *ext_log_start = &_log_start;
> +static unsigned long *ext_con_start = &_con_start;
> +static unsigned long *ext_log_end = &_log_end;
> +static unsigned long *ext_logged_chars = &_logged_chars;
> +#define log_start      (*ext_log_start)
> +#define con_start      (*ext_con_start)
> +#define log_end                (*ext_log_end)
> +#define logged_chars   (*ext_logged_chars)
> +#else /* defined(CONFIG_ALT_LB_LOCATION) */
> +/* alternative logbuffer location */
> +static volatile unsigned long *ext_log_start = &_log_start;
> +static volatile unsigned long *ext_con_start = &_con_start;
> +static volatile unsigned long *ext_log_end = &_log_end;
> +static volatile unsigned long *ext_logged_chars = &_logged_chars;
> +#define log_start       (*((volatile u32 *)ext_log_start))
> +#define con_start       (*((volatile u32 *)ext_con_start))
> +#define log_end         (*((volatile u32 *)ext_log_end))
> +#define logged_chars    (*((volatile u32 *)ext_logged_chars))
> +#endif /* !defined(CONFIG_ALT_LB_LOCATION) */
> +#else /* !defined(CONFIG_LOGBUFFER) */
>  static unsigned log_start;     /* Index into log_buf: next char to be read
> by syslog() */
>  static unsigned con_start;     /* Index into log_buf: next char to be sent
> to consoles */
>  static unsigned log_end;       /* Index into log_buf:
> most-recently-written-char + 1 */
> +#endif /* CONFIG_LOGBUFFER */
>
>  /*
>  *     Array of consoles built from command line options (console=)
> @@ -134,10 +165,121 @@ static int console_may_schedule;
>  static char __log_buf[__LOG_BUF_LEN];
>  static char *log_buf = __log_buf;
>  static int log_buf_len = __LOG_BUF_LEN;
> +#ifndef CONFIG_LOGBUFFER
>  static unsigned logged_chars; /* Number of chars produced since last
> read+clear operation */
> +#endif /* !defined(CONFIG_LOGBUFFER) */
> +#ifdef CONFIG_LOGBUFFER
> +/* Sanity check the external log buffer metadata. When an the external
> + * log buffer is enabled, the log metadata is effectively non-volatile
> + * in that the values are preserved from reboot to reboot (until/unless
> + * the system loses power).
> + */
> +static void __init logbuff_check_metadata(LOGBUFF_VOLATILE logbuff_t *log)
> +{
> +       unsigned long chars;
> +
> +       /* Sanity check the producer and consumer indices. */
> +
> +       if (log->end - log->start > LOGBUFF_LEN)
> +               log->start = log->end - LOGBUFF_LEN;
> +
> +       if (log->end - log->con > LOGBUFF_LEN)
> +               log->con = log->end - LOGBUFF_LEN;
> +
> +       /* Occasionally, particularly following a reboot, the start
> +        * consumer index is not properly caught up to the console
> +        * consumer index. If this is the case, catch it up so that
> +        * the log buffer doesn't start with, for example,
> +        * "<0>Restarting system.\n" followed by the 'real' start of
> +        * the log.
> +        */
> +
> +       if (log->con > log->start)
> +               log->start = log->con;
> +
> +       /* Ensure that the number of characters logged reflects the
> +        * characters actually logged based on the producer and
> +        * consumer indices rather than all characters cumulatively
> +        * logged across all reboots since a power-loss event.
> +        */
> +
> +       chars = log->end - log->start;
> +
> +       if (log->chars > chars)
> +               log->chars = chars;
> +}
> +
> +/* Coalesce the current log bounded buffer and the external log
> + * bounded buffer by appending the former to the latter. Precedence is
> + * given to the external log buffer when there is more data to be
> + * appended than space exists, so the current log buffer is truncated
> + * instead of overwritting the external buffer.
> + */
> +static void __init logbuff_coalesce_buffers(LOGBUFF_VOLATILE logbuff_t
> *log)
> +{
> +       unsigned long dspace, ssize, len;
> +
> +       dspace = LOGBUFF_LEN - (log->end - log->start);
> +       ssize = log_end - log_start;
> +       len = min(dspace, ssize);
> +
> +       while (len-- > 0) {
> +               log->buf[log->end++ & (LOGBUFF_LEN-1)] =
> LOG_BUF(log_start++);
> +               log->chars++;
> +       }
> +}
>
> +void __init setup_ext_logbuff(void)
> +{
> +       LOGBUFF_VOLATILE logbuff_t *log;
> +       char *ext_log_buf = NULL;
> +       unsigned long flags;
> +
> +       if (setup_ext_logbuff_mem(&log, &ext_log_buf) < 0) {
> +               printk(KERN_WARNING
> +                      "Failed to setup external logbuffer - ignoring
> it\n");
> +               return;
> +       }
> +
> +       /* When no properly setup buffer is found, reset pointers */
> +       if (log->tag != LOGBUFF_MAGIC) {
> +               printk(KERN_WARNING
> +                      "Unexpected external log buffer magic number. "
> +                      "Got %08lx, expected %08x. Resetting pointers and
> using "
> +                      "the buffer anyway.\n",
> +                      log->tag, LOGBUFF_MAGIC);
> +               log->tag = LOGBUFF_MAGIC;
> +               log->start = log->end = log->con = log->chars = 0;
> +       }
> +
> +       spin_lock_irqsave(&logbuf_lock, flags);
> +
> +       logbuff_check_metadata(log);
> +       logbuff_coalesce_buffers(log);
> +
> +       /* Switch to the external log buffer */
> +       ext_log_start           = &log->start;
> +       ext_con_start           = &log->con;
> +       ext_log_end             = &log->end;
> +       ext_logged_chars        = &log->chars;
> +
> +       log_buf                 = ext_log_buf;
> +       log_buf_len             = LOGBUFF_LEN;
> +
> +       spin_unlock_irqrestore(&logbuf_lock, flags);
> +
> +       printk(KERN_NOTICE "log_buf=%p\n", log_buf);
> +}
> +#endif /* CONFIG_LOGBUFFER */
>  static int __init log_buf_len_setup(char *str)
>  {
> +#ifdef CONFIG_LOGBUFFER
> +       /* Log buffer size is LOGBUFF_LEN bytes */
> +       printk(KERN_NOTICE
> +              "External log buffer configured; "
> +              "ignoring log_buf_len param.\n");
> +       return 1;
> +#else
>        unsigned size = memparse(str, &str);
>        unsigned long flags;
>
> @@ -173,6 +315,7 @@ static int __init log_buf_len_setup(char *str)
>        }
>  out:
>        return 1;
> +#endif /* CONFIG_LOGBUFFER */
>  }
>
>  __setup("log_buf_len=", log_buf_len_setup);
> @@ -230,7 +373,7 @@ static void boot_delay_msec(void)
>  static inline void boot_delay_msec(void)
>  {
>  }
> -#endif
> +#endif /* CONFIG_BOOT_PRINTK_DELAY */
>
>  /*
>  * Commands to do_syslog:
> @@ -740,7 +883,7 @@ out_restore_irqs:
>  EXPORT_SYMBOL(printk);
>  EXPORT_SYMBOL(vprintk);
>
> -#else
> +#else /* !CONFIG_PRINTK */
>
>  asmlinkage long sys_syslog(int type, char __user *buf, int len)
>  {
> @@ -751,7 +894,7 @@ static void call_console_drivers(unsigned start,
> unsigned end)
>  {
>  }
>
> -#endif
> +#endif /* CONFIG_PRINTK */
>
>  static int __add_preferred_console(char *name, int idx, char *options,
>                                   char *brl_options)
> --
> 1.6.0.4
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>

------=_Part_9828_10569136.1227639192528
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Nitpick, really.. shouldn&#39;t the logbuffer location(s) be some device tree property(ies), perhaps something in the<br>/chosen node that U-Boot etc. can then fill out?<br><br>-- <br>Matt Sealey &lt;<a href="mailto:matt@genesi-usa.com">matt@genesi-usa.com</a>&gt;<br>
Genesi, Manager, Developer Relations<br><br><div class="gmail_quote">On Tue, Nov 25, 2008 at 12:34 PM, Grant Erickson <span dir="ltr">&lt;<a href="mailto:gerickson@nuovations.com">gerickson@nuovations.com</a>&gt;</span> wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">This merges support for the previously DENX-only kernel feature of<br>
specifying an alternative, &quot;external&quot; buffer for kernel printk<br>
messages and their associated metadata. In addition, this ports<br>
architecture support for this feature from arch/ppc to arch/powerpc.<br>
<br>
Signed-off-by: Grant Erickson &lt;<a href="mailto:gerickson@nuovations.com">gerickson@nuovations.com</a>&gt;<br>
---<br>
<br>
When this option is enabled, an architecture- or machine-specific log<br>
buffer is used for all printk messages. This allows entities such as<br>
boot loaders (e.g. U-Boot) to place printk-compatible messages into<br>
this buffer and for the kernel to coalesce them with its normal<br>
messages.<br>
<br>
The code has historically been used and proven to work on the LWMON5<br>
platform under arch/ppc and is now used (by me) successfully on the<br>
AMCC Haleakala and Kilauea platforms.<br>
<br>
As implemented for arch/powerpc, two suboptions for the alternative<br>
log buffer are supported. The buffer may be contiguous with the<br>
metadata and message data colocated or the metadata and message<br>
storage may be in discontiguous regions of memory (e.g. a set of<br>
scratch registers and an SRAM buffer). On Kilauea and Haleakala, I<br>
have used the former; whereas LWMON5 has traditionally used the latter.<br>
<br>
The code here is, more or less, as-is from the DENX GIT tree. Comments<br>
welcome.<br>
<br>
&nbsp;arch/powerpc/kernel/prom.c | &nbsp; 93 +++++++++++++++++++++++++++<br>
&nbsp;include/linux/logbuff.h &nbsp; &nbsp;| &nbsp; 56 ++++++++++++++++<br>
&nbsp;init/Kconfig &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; | &nbsp; 25 +++++++<br>
&nbsp;init/main.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp; &nbsp;4 +<br>
&nbsp;kernel/printk.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;| &nbsp;149 +++++++++++++++++++++++++++++++++++++++++++-<br>
&nbsp;5 files changed, 324 insertions(+), 3 deletions(-)<br>
&nbsp;create mode 100644 include/linux/logbuff.h<br>
<br>
diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c<br>
index 3a2dc7e..60282f1 100644<br>
--- a/arch/powerpc/kernel/prom.c<br>
+++ b/arch/powerpc/kernel/prom.c<br>
@@ -32,6 +32,7 @@<br>
&nbsp;#include &lt;linux/debugfs.h&gt;<br>
&nbsp;#include &lt;linux/irq.h&gt;<br>
&nbsp;#include &lt;linux/lmb.h&gt;<br>
+#include &lt;linux/logbuff.h&gt;<br>
<br>
&nbsp;#include &lt;asm/prom.h&gt;<br>
&nbsp;#include &lt;asm/rtas.h&gt;<br>
@@ -61,6 +62,15 @@<br>
&nbsp;#define DBG(fmt...)<br>
&nbsp;#endif<br>
<br>
+#ifdef CONFIG_LOGBUFFER<br>
+#ifdef CONFIG_ALT_LB_LOCATION<br>
+# if !defined(BOARD_ALT_LH_ADDR) || !defined(BOARD_ALT_LB_ADDR)<br>
+# &nbsp;error &quot;Please specify BOARD_ALT_LH_ADDR &amp; BOARD_ALT_LB_ADDR.&quot;<br>
+# endif<br>
+#else /* !CONFIG_ALT_LB_LOCATION */<br>
+static phys_addr_t ext_logbuff;<br>
+#endif /* CONFIG_ALT_LB_LOCATION */<br>
+#endif /* CONFIG_LOGBUFFER */<br>
<br>
&nbsp;static int __initdata dt_root_addr_cells;<br>
&nbsp;static int __initdata dt_root_size_cells;<br>
@@ -1018,6 +1028,85 @@ static int __init early_init_dt_scan_memory(unsigned long node,<br>
 &nbsp; &nbsp; &nbsp; &nbsp;return 0;<br>
&nbsp;}<br>
<br>
+#ifdef CONFIG_LOGBUFFER<br>
+#ifdef CONFIG_ALT_LB_LOCATION<br>
+/* Alternative external log buffer mapping: log metadata header &amp; the<br>
+ * character buffer are separated and allocated not in RAM but in some<br>
+ * other memory-mapped I/O region (e.g. log head in unused registers,<br>
+ * and log buffer in OCM memory)<br>
+ */<br>
+int __init setup_ext_logbuff_mem(volatile logbuff_t **lhead, char **lbuf)<br>
+{<br>
+ &nbsp; &nbsp; &nbsp; void *h, *b;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; if (unlikely(!lhead) || unlikely(!lbuf))<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EINVAL;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; /* map log head */<br>
+ &nbsp; &nbsp; &nbsp; h = ioremap(BOARD_ALT_LH_ADDR, sizeof(logbuff_t));<br>
+ &nbsp; &nbsp; &nbsp; if (unlikely(!h))<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EFAULT;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; /* map log buffer */<br>
+ &nbsp; &nbsp; &nbsp; b = ioremap(BOARD_ALT_LB_ADDR, LOGBUFF_LEN);<br>
+ &nbsp; &nbsp; &nbsp; if (unlikely(!b)) {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; iounmap(h);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EFAULT;<br>
+ &nbsp; &nbsp; &nbsp; }<br>
+<br>
+ &nbsp; &nbsp; &nbsp; *lhead = h;<br>
+ &nbsp; &nbsp; &nbsp; *lbuf = b;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; return 0;<br>
+}<br>
+#else /* !CONFIG_ALT_LB_LOCATION */<br>
+/* Usual external log-buffer mapping: log metadata header &amp; the character<br>
+ * buffer are both contiguous in system RAM.<br>
+ */<br>
+int __init setup_ext_logbuff_mem(logbuff_t **lhead, char **lbuf)<br>
+{<br>
+ &nbsp; &nbsp; &nbsp; void *p;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; if (unlikely(!lhead) || unlikely(!lbuf))<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EINVAL;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; if (unlikely(!ext_logbuff) || !lmb_is_reserved(ext_logbuff))<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EFAULT;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; p = ioremap(ext_logbuff, LOGBUFF_RESERVE);<br>
+<br>
+ &nbsp; &nbsp; &nbsp; if (unlikely(!p))<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return -EFAULT;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; *lhead = (logbuff_t *)(p + LOGBUFF_OVERHEAD -<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;sizeof(logbuff_t) +<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;sizeof(((logbuff_t *)0)-&gt;buf));<br>
+ &nbsp; &nbsp; &nbsp; *lbuf = (*lhead)-&gt;buf;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; return 0;<br>
+}<br>
+<br>
+/* When the external log buffer configuration is used with the<br>
+ * non-alternate location, the log head metadata and character buffer<br>
+ * lie in the LOGBUFF_RESERVE bytes at the end of system RAM. Add this<br>
+ * block of memory to the reserved memory pool so that it is not<br>
+ * allocated for other purposes.<br>
+ */<br>
+static void __init reserve_ext_logbuff_mem(void)<br>
+{<br>
+ &nbsp; &nbsp; &nbsp; phys_addr_t top = lmb_end_of_DRAM();<br>
+ &nbsp; &nbsp; &nbsp; phys_addr_t size = LOGBUFF_RESERVE;<br>
+ &nbsp; &nbsp; &nbsp; phys_addr_t base = top - size;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; if (top &gt; base) {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; ext_logbuff = base;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; DBG(&quot;reserving: %x -&gt; %x\n&quot;, base, size);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; lmb_reserve(base, size);<br>
+ &nbsp; &nbsp; &nbsp; }<br>
+}<br>
+#endif /* CONFIG_ALT_LB_LOCATION */<br>
+#endif /* CONFIG_LOGBUFFER */<br>
+<br>
&nbsp;static void __init early_reserve_mem(void)<br>
&nbsp;{<br>
 &nbsp; &nbsp; &nbsp; &nbsp;u64 base, size;<br>
@@ -1033,6 +1122,10 @@ static void __init early_reserve_mem(void)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;self_size = initial_boot_params-&gt;totalsize;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;lmb_reserve(self_base, self_size);<br>
<br>
+#if defined(CONFIG_LOGBUFFER) &amp;&amp; !defined(CONFIG_ALT_LB_LOCATION)<br>
+ &nbsp; &nbsp; &nbsp; reserve_ext_logbuff_mem();<br>
+#endif /* defined(CONFIG_LOGBUFFER) &amp;&amp; !defined(CONFIG_ALT_LB_LOCATION) */<br>
+<br>
&nbsp;#ifdef CONFIG_BLK_DEV_INITRD<br>
 &nbsp; &nbsp; &nbsp; &nbsp;/* then reserve the initrd, if any */<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (initrd_start &amp;&amp; (initrd_end &gt; initrd_start))<br>
diff --git a/include/linux/logbuff.h b/include/linux/logbuff.h<br>
new file mode 100644<br>
index 0000000..22a51c0<br>
--- /dev/null<br>
+++ b/include/linux/logbuff.h<br>
@@ -0,0 +1,56 @@<br>
+/*<br>
+ * (C) Copyright 2007<br>
+ * Wolfgang Denk, DENX Software Engineering, <a href="mailto:wd@denx.de">wd@denx.de</a>.<br>
+ *<br>
+ * See file CREDITS for list of people who contributed to this<br>
+ * project.<br>
+ *<br>
+ * This program is free software; you can redistribute it and/or<br>
+ * modify it under the terms of the GNU General Public License as<br>
+ * published by the Free Software Foundation; either version 2 of<br>
+ * the License, or (at your option) any later version.<br>
+ *<br>
+ * This program is distributed in the hope that it will be useful,<br>
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of<br>
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. &nbsp;See the<br>
+ * GNU General Public License for more details.<br>
+ *<br>
+ * You should have received a copy of the GNU General Public License<br>
+ * along with this program; if not, write to the Free Software<br>
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston,<br>
+ * MA 02111-1307 USA<br>
+ */<br>
+#ifndef _LOGBUFF_H_<br>
+#define _LOGBUFF_H_<br>
+<br>
+#ifdef CONFIG_LOGBUFFER<br>
+<br>
+#define LOGBUFF_MAGIC &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0xc0de4ced<br>
+#define LOGBUFF_LEN &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;16384<br>
+#define LOGBUFF_OVERHEAD &nbsp; &nbsp; &nbsp; 4096<br>
+#define LOGBUFF_RESERVE &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(LOGBUFF_LEN + LOGBUFF_OVERHEAD)<br>
+<br>
+/* The mapping used here has to be the same as in logbuff_init_ptrs ()<br>
+ &nbsp; in u-boot/common/cmd_log.c */<br>
+<br>
+typedef struct {<br>
+ &nbsp; &nbsp; &nbsp; unsigned long &nbsp; tag;<br>
+ &nbsp; &nbsp; &nbsp; unsigned long &nbsp; start;<br>
+ &nbsp; &nbsp; &nbsp; unsigned long &nbsp; con; &nbsp; &nbsp;/* next char to be sent to consoles &nbsp; &nbsp; */<br>
+ &nbsp; &nbsp; &nbsp; unsigned long &nbsp; end;<br>
+ &nbsp; &nbsp; &nbsp; unsigned long &nbsp; chars;<br>
+ &nbsp; &nbsp; &nbsp; unsigned char &nbsp; buf[0];<br>
+} logbuff_t;<br>
+<br>
+#ifdef CONFIG_ALT_LB_LOCATION<br>
+# define LOGBUFF_VOLATILE &nbsp; &nbsp; &nbsp;volatile<br>
+#else<br>
+# define LOGBUFF_VOLATILE<br>
+#endif /* defined(CONFIG_ALT_LB_LOCATION) */<br>
+<br>
+extern void setup_ext_logbuff(void);<br>
+/* arch specific */<br>
+extern int setup_ext_logbuff_mem(LOGBUFF_VOLATILE logbuff_t **lhead, char **lbuf);<br>
+<br>
+#endif /* CONFIG_LOGBUFFER */<br>
+#endif /* _LOGBUFF_H_ */<br>
diff --git a/init/Kconfig b/init/Kconfig<br>
index f763762..e1a1b59 100644<br>
--- a/init/Kconfig<br>
+++ b/init/Kconfig<br>
@@ -619,6 +619,31 @@ config PRINTK<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;very difficult to diagnose system problems, saying N here is<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;strongly discouraged.<br>
<br>
+config LOGBUFFER<br>
+ &nbsp; &nbsp; &nbsp; bool &quot;External logbuffer&quot; if PRINTK<br>
+ &nbsp; &nbsp; &nbsp; default n<br>
+ &nbsp; &nbsp; &nbsp; help<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; This option enables support for an alternative, &quot;external&quot;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; printk log buffer. When enabled, an architecture- or machine-<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; specific log buffer is used for all printk messages. This<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; allows entities such as boot loaders to place printk-compatible<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; messages into this buffer and for the kernel to coalesce them<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; with its normal messages.<br>
+<br>
+config ALT_LB_LOCATION<br>
+ &nbsp; &nbsp; &nbsp; bool &quot;Alternative logbuffer&quot; if LOGBUFFER<br>
+ &nbsp; &nbsp; &nbsp; default n<br>
+ &nbsp; &nbsp; &nbsp; help<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; When using an alternative, &quot;external&quot; printk log buffer, an<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; architecture- or machine-specific log buffer with contiguous<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; metadata and message storage is used. This option enables<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; support for discontiguous metadata and message storage<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; memory (e.g. a set of scratch registers and an SRAM<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; buffer). By saying Y here, you must also ensure your<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; architecture- or machine-code specify BOARD_ALT_LH_ADDR and<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; BOARD_ALT_LB_ADDR, for the metadata and message memory,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; respectively.<br>
+<br>
&nbsp;config BUG<br>
 &nbsp; &nbsp; &nbsp; &nbsp;bool &quot;BUG() support&quot; if EMBEDDED<br>
 &nbsp; &nbsp; &nbsp; &nbsp;default y<br>
diff --git a/init/main.c b/init/main.c<br>
index 7e117a2..5687b98 100644<br>
--- a/init/main.c<br>
+++ b/init/main.c<br>
@@ -61,6 +61,7 @@<br>
&nbsp;#include &lt;linux/kthread.h&gt;<br>
&nbsp;#include &lt;linux/sched.h&gt;<br>
&nbsp;#include &lt;linux/signal.h&gt;<br>
+#include &lt;linux/logbuff.h&gt;<br>
&nbsp;#include &lt;linux/idr.h&gt;<br>
&nbsp;#include &lt;linux/ftrace.h&gt;<br>
<br>
@@ -563,6 +564,9 @@ asmlinkage void __init start_kernel(void)<br>
 &nbsp;* Interrupts are still disabled. Do necessary setups, then<br>
 &nbsp;* enable them<br>
 &nbsp;*/<br>
+#ifdef CONFIG_LOGBUFFER<br>
+ &nbsp; &nbsp; &nbsp; setup_ext_logbuff();<br>
+#endif<br>
 &nbsp; &nbsp; &nbsp; &nbsp;lock_kernel();<br>
 &nbsp; &nbsp; &nbsp; &nbsp;tick_init();<br>
 &nbsp; &nbsp; &nbsp; &nbsp;boot_cpu_init();<br>
diff --git a/kernel/printk.c b/kernel/printk.c<br>
index f492f15..59884e2 100644<br>
--- a/kernel/printk.c<br>
+++ b/kernel/printk.c<br>
@@ -32,6 +32,7 @@<br>
&nbsp;#include &lt;linux/security.h&gt;<br>
&nbsp;#include &lt;linux/bootmem.h&gt;<br>
&nbsp;#include &lt;linux/syscalls.h&gt;<br>
+#include &lt;linux/logbuff.h&gt;<br>
<br>
&nbsp;#include &lt;asm/uaccess.h&gt;<br>
<br>
@@ -101,9 +102,39 @@ static DEFINE_SPINLOCK(logbuf_lock);<br>
 &nbsp;* The indices into log_buf are not constrained to log_buf_len - they<br>
 &nbsp;* must be masked before subscripting<br>
 &nbsp;*/<br>
+#ifdef CONFIG_LOGBUFFER<br>
+/* Indexes to the local log buffer */<br>
+static unsigned long _log_start;<br>
+static unsigned long _con_start;<br>
+static unsigned long _log_end;<br>
+static unsigned long _logged_chars;<br>
+/* These will be switched to the external log buffer */<br>
+#ifndef CONFIG_ALT_LB_LOCATION<br>
+/* usual logbuffer location */<br>
+static unsigned long *ext_log_start = &amp;_log_start;<br>
+static unsigned long *ext_con_start = &amp;_con_start;<br>
+static unsigned long *ext_log_end = &amp;_log_end;<br>
+static unsigned long *ext_logged_chars = &amp;_logged_chars;<br>
+#define log_start &nbsp; &nbsp; &nbsp;(*ext_log_start)<br>
+#define con_start &nbsp; &nbsp; &nbsp;(*ext_con_start)<br>
+#define log_end &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;(*ext_log_end)<br>
+#define logged_chars &nbsp; (*ext_logged_chars)<br>
+#else /* defined(CONFIG_ALT_LB_LOCATION) */<br>
+/* alternative logbuffer location */<br>
+static volatile unsigned long *ext_log_start = &amp;_log_start;<br>
+static volatile unsigned long *ext_con_start = &amp;_con_start;<br>
+static volatile unsigned long *ext_log_end = &amp;_log_end;<br>
+static volatile unsigned long *ext_logged_chars = &amp;_logged_chars;<br>
+#define log_start &nbsp; &nbsp; &nbsp; (*((volatile u32 *)ext_log_start))<br>
+#define con_start &nbsp; &nbsp; &nbsp; (*((volatile u32 *)ext_con_start))<br>
+#define log_end &nbsp; &nbsp; &nbsp; &nbsp; (*((volatile u32 *)ext_log_end))<br>
+#define logged_chars &nbsp; &nbsp;(*((volatile u32 *)ext_logged_chars))<br>
+#endif /* !defined(CONFIG_ALT_LB_LOCATION) */<br>
+#else /* !defined(CONFIG_LOGBUFFER) */<br>
&nbsp;static unsigned log_start; &nbsp; &nbsp; /* Index into log_buf: next char to be read by syslog() */<br>
&nbsp;static unsigned con_start; &nbsp; &nbsp; /* Index into log_buf: next char to be sent to consoles */<br>
&nbsp;static unsigned log_end; &nbsp; &nbsp; &nbsp; /* Index into log_buf: most-recently-written-char + 1 */<br>
+#endif /* CONFIG_LOGBUFFER */<br>
<br>
&nbsp;/*<br>
 &nbsp;* &nbsp; &nbsp; Array of consoles built from command line options (console=)<br>
@@ -134,10 +165,121 @@ static int console_may_schedule;<br>
&nbsp;static char __log_buf[__LOG_BUF_LEN];<br>
&nbsp;static char *log_buf = __log_buf;<br>
&nbsp;static int log_buf_len = __LOG_BUF_LEN;<br>
+#ifndef CONFIG_LOGBUFFER<br>
&nbsp;static unsigned logged_chars; /* Number of chars produced since last read+clear operation */<br>
+#endif /* !defined(CONFIG_LOGBUFFER) */<br>
+#ifdef CONFIG_LOGBUFFER<br>
+/* Sanity check the external log buffer metadata. When an the external<br>
+ * log buffer is enabled, the log metadata is effectively non-volatile<br>
+ * in that the values are preserved from reboot to reboot (until/unless<br>
+ * the system loses power).<br>
+ */<br>
+static void __init logbuff_check_metadata(LOGBUFF_VOLATILE logbuff_t *log)<br>
+{<br>
+ &nbsp; &nbsp; &nbsp; unsigned long chars;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; /* Sanity check the producer and consumer indices. */<br>
+<br>
+ &nbsp; &nbsp; &nbsp; if (log-&gt;end - log-&gt;start &gt; LOGBUFF_LEN)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; log-&gt;start = log-&gt;end - LOGBUFF_LEN;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; if (log-&gt;end - log-&gt;con &gt; LOGBUFF_LEN)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; log-&gt;con = log-&gt;end - LOGBUFF_LEN;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; /* Occasionally, particularly following a reboot, the start<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;* consumer index is not properly caught up to the console<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;* consumer index. If this is the case, catch it up so that<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;* the log buffer doesn&#39;t start with, for example,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;* &quot;&lt;0&gt;Restarting system.\n&quot; followed by the &#39;real&#39; start of<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;* the log.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+<br>
+ &nbsp; &nbsp; &nbsp; if (log-&gt;con &gt; log-&gt;start)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; log-&gt;start = log-&gt;con;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; /* Ensure that the number of characters logged reflects the<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;* characters actually logged based on the producer and<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;* consumer indices rather than all characters cumulatively<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;* logged across all reboots since a power-loss event.<br>
+ &nbsp; &nbsp; &nbsp; &nbsp;*/<br>
+<br>
+ &nbsp; &nbsp; &nbsp; chars = log-&gt;end - log-&gt;start;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; if (log-&gt;chars &gt; chars)<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; log-&gt;chars = chars;<br>
+}<br>
+<br>
+/* Coalesce the current log bounded buffer and the external log<br>
+ * bounded buffer by appending the former to the latter. Precedence is<br>
+ * given to the external log buffer when there is more data to be<br>
+ * appended than space exists, so the current log buffer is truncated<br>
+ * instead of overwritting the external buffer.<br>
+ */<br>
+static void __init logbuff_coalesce_buffers(LOGBUFF_VOLATILE logbuff_t *log)<br>
+{<br>
+ &nbsp; &nbsp; &nbsp; unsigned long dspace, ssize, len;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; dspace = LOGBUFF_LEN - (log-&gt;end - log-&gt;start);<br>
+ &nbsp; &nbsp; &nbsp; ssize = log_end - log_start;<br>
+ &nbsp; &nbsp; &nbsp; len = min(dspace, ssize);<br>
+<br>
+ &nbsp; &nbsp; &nbsp; while (len-- &gt; 0) {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; log-&gt;buf[log-&gt;end++ &amp; (LOGBUFF_LEN-1)] = LOG_BUF(log_start++);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; log-&gt;chars++;<br>
+ &nbsp; &nbsp; &nbsp; }<br>
+}<br>
<br>
+void __init setup_ext_logbuff(void)<br>
+{<br>
+ &nbsp; &nbsp; &nbsp; LOGBUFF_VOLATILE logbuff_t *log;<br>
+ &nbsp; &nbsp; &nbsp; char *ext_log_buf = NULL;<br>
+ &nbsp; &nbsp; &nbsp; unsigned long flags;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; if (setup_ext_logbuff_mem(&amp;log, &amp;ext_log_buf) &lt; 0) {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; printk(KERN_WARNING<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;Failed to setup external logbuffer - ignoring it\n&quot;);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; return;<br>
+ &nbsp; &nbsp; &nbsp; }<br>
+<br>
+ &nbsp; &nbsp; &nbsp; /* When no properly setup buffer is found, reset pointers */<br>
+ &nbsp; &nbsp; &nbsp; if (log-&gt;tag != LOGBUFF_MAGIC) {<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; printk(KERN_WARNING<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;Unexpected external log buffer magic number. &quot;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;Got %08lx, expected %08x. Resetting pointers and using &quot;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;the buffer anyway.\n&quot;,<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;log-&gt;tag, LOGBUFF_MAGIC);<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; log-&gt;tag = LOGBUFF_MAGIC;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; log-&gt;start = log-&gt;end = log-&gt;con = log-&gt;chars = 0;<br>
+ &nbsp; &nbsp; &nbsp; }<br>
+<br>
+ &nbsp; &nbsp; &nbsp; spin_lock_irqsave(&amp;logbuf_lock, flags);<br>
+<br>
+ &nbsp; &nbsp; &nbsp; logbuff_check_metadata(log);<br>
+ &nbsp; &nbsp; &nbsp; logbuff_coalesce_buffers(log);<br>
+<br>
+ &nbsp; &nbsp; &nbsp; /* Switch to the external log buffer */<br>
+ &nbsp; &nbsp; &nbsp; ext_log_start &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; = &amp;log-&gt;start;<br>
+ &nbsp; &nbsp; &nbsp; ext_con_start &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; = &amp;log-&gt;con;<br>
+ &nbsp; &nbsp; &nbsp; ext_log_end &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; = &amp;log-&gt;end;<br>
+ &nbsp; &nbsp; &nbsp; ext_logged_chars &nbsp; &nbsp; &nbsp; &nbsp;= &amp;log-&gt;chars;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; log_buf &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; = ext_log_buf;<br>
+ &nbsp; &nbsp; &nbsp; log_buf_len &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; = LOGBUFF_LEN;<br>
+<br>
+ &nbsp; &nbsp; &nbsp; spin_unlock_irqrestore(&amp;logbuf_lock, flags);<br>
+<br>
+ &nbsp; &nbsp; &nbsp; printk(KERN_NOTICE &quot;log_buf=%p\n&quot;, log_buf);<br>
+}<br>
+#endif /* CONFIG_LOGBUFFER */<br>
&nbsp;static int __init log_buf_len_setup(char *str)<br>
&nbsp;{<br>
+#ifdef CONFIG_LOGBUFFER<br>
+ &nbsp; &nbsp; &nbsp; /* Log buffer size is LOGBUFF_LEN bytes */<br>
+ &nbsp; &nbsp; &nbsp; printk(KERN_NOTICE<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;External log buffer configured; &quot;<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;&quot;ignoring log_buf_len param.\n&quot;);<br>
+ &nbsp; &nbsp; &nbsp; return 1;<br>
+#else<br>
 &nbsp; &nbsp; &nbsp; &nbsp;unsigned size = memparse(str, &amp;str);<br>
 &nbsp; &nbsp; &nbsp; &nbsp;unsigned long flags;<br>
<br>
@@ -173,6 +315,7 @@ static int __init log_buf_len_setup(char *str)<br>
 &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&nbsp;out:<br>
 &nbsp; &nbsp; &nbsp; &nbsp;return 1;<br>
+#endif /* CONFIG_LOGBUFFER */<br>
&nbsp;}<br>
<br>
&nbsp;__setup(&quot;log_buf_len=&quot;, log_buf_len_setup);<br>
@@ -230,7 +373,7 @@ static void boot_delay_msec(void)<br>
&nbsp;static inline void boot_delay_msec(void)<br>
&nbsp;{<br>
&nbsp;}<br>
-#endif<br>
+#endif /* CONFIG_BOOT_PRINTK_DELAY */<br>
<br>
&nbsp;/*<br>
 &nbsp;* Commands to do_syslog:<br>
@@ -740,7 +883,7 @@ out_restore_irqs:<br>
&nbsp;EXPORT_SYMBOL(printk);<br>
&nbsp;EXPORT_SYMBOL(vprintk);<br>
<br>
-#else<br>
+#else /* !CONFIG_PRINTK */<br>
<br>
&nbsp;asmlinkage long sys_syslog(int type, char __user *buf, int len)<br>
&nbsp;{<br>
@@ -751,7 +894,7 @@ static void call_console_drivers(unsigned start, unsigned end)<br>
&nbsp;{<br>
&nbsp;}<br>
<br>
-#endif<br>
+#endif /* CONFIG_PRINTK */<br>
<br>
&nbsp;static int __add_preferred_console(char *name, int idx, char *options,<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; char *brl_options)<br>
<font color="#888888">--<br>
<a href="http://1.6.0.4" target="_blank">1.6.0.4</a><br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br>
<a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
</font></blockquote></div><br><br clear="all"><br>

------=_Part_9828_10569136.1227639192528--
