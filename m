Return-Path: <LukeBrowning@us.ibm.com>
In-Reply-To: <20061012120310.6B5A967BD5@ozlabs.org>
To: Michael Ellerman <michael@ellerman.id.au>
MIME-Version: 1.0
Subject: Re: [PATCH 1/2] Add support for stopping spus from xmon
From: Luke Browning <LukeBrowning@us.ibm.com>
Message-ID: <OF47E899DB.A06D1502-ON83257206.00106CF2-83257206.00122A1D@us.ibm.com>
Date: Fri, 13 Oct 2006 01:18:23 -0200
Content-Type: multipart/alternative;
	boundary="=_alternative 0010C1C583257206_="
Cc: linuxppc-dev@ozlabs.org,
	linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org,
	Arnd Bergmann <arnd.bergmann@de.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 0010C1C583257206_=
Content-Type: text/plain; charset="US-ASCII"

linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org wrote on 
10/12/2006 09:03:08 AM:

> This patch adds support for stopping, and restarting, spus
> from xmon. We use the spu master runcntl bit to stop execution,
> this is apparently the "right" way to control spu execution and
> spufs will be changed in the future to use this bit.
> 
> Testing has shown that to restart execution we have to turn the
> master runcntl bit on and also rewrite the spu runcntl bit, even
> if it is already set to 1 (running).
> 
> Stopping spus is triggered by the xmon command 'ss' - "spus stop"
> perhaps. Restarting them is triggered via 'sr'. Restart doesn't
> start execution on spus unless they were running prior to being
> stopped by xmon.
> 
> Walking the spu->full_list in xmon after a panic, would mean
> corruption of any spu struct would make all the others
> inaccessible. To avoid this, and also to make the next patch
> easier, we cache pointers to all spus during boot.

The spe affinity code drop created an array of spu pointers that
is indexed by spu->number.  We have a couple of other fields in
there that are needed for multiple spu scheduling operations. 
Maybe, you can use this array.  The name of the arry is lspu[]
for logical spus.

> 
> We attempt to catch and recover from errors while stopping and
> restarting the spus, but as with most xmon functionality there are
> no guarantees that performing these operations won't crash xmon
> itself.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> 
>  arch/powerpc/platforms/cell/spu_base.c |    4 
>  arch/powerpc/xmon/xmon.c               |  142 
> ++++++++++++++++++++++++++++++++-
>  include/asm-powerpc/xmon.h             |    2 
>  3 files changed, 146 insertions(+), 2 deletions(-)
> 
> Index: to-merge/arch/powerpc/platforms/cell/spu_base.c
> ===================================================================
> --- to-merge.orig/arch/powerpc/platforms/cell/spu_base.c
> +++ to-merge/arch/powerpc/platforms/cell/spu_base.c
> @@ -38,6 +38,7 @@
>  #include <asm/spu.h>
>  #include <asm/spu_priv1.h>
>  #include <asm/mmu_context.h>
> +#include <asm/xmon.h>
> 
>  #include "interrupt.h"
> 
> @@ -914,6 +915,9 @@ static int __init init_spu_base(void)
>           break;
>        }
>     }
> +
> +   xmon_register_spus(&spu_full_list);
> +
>     return ret;
>  }
>  module_init(init_spu_base);
> Index: to-merge/arch/powerpc/xmon/xmon.c
> ===================================================================
> --- to-merge.orig/arch/powerpc/xmon/xmon.c
> +++ to-merge/arch/powerpc/xmon/xmon.c
> @@ -35,6 +35,8 @@
>  #include <asm/rtas.h>
>  #include <asm/sstep.h>
>  #include <asm/bug.h>
> +#include <asm/spu.h>
> +#include <asm/spu_priv1.h>
> 
>  #ifdef CONFIG_PPC64
>  #include <asm/hvcall.h>
> @@ -145,6 +147,8 @@ static void xmon_print_symbol(unsigned l
>                 const char *after);
>  static const char *getvecname(unsigned long vec);
> 
> +static int do_spu_cmd(void);
> +
>  int xmon_no_auto_backtrace;
> 
>  extern int print_insn_powerpc(unsigned long, unsigned long, int);
> @@ -207,8 +211,12 @@ Commands:\n\
>    mi   show information about memory allocation\n\
>    p    call a procedure\n\
>    r   print registers\n\
> -  s   single step\n\
> -  S   print special registers\n\
> +  s   single step\n"
> +#ifdef CONFIG_PPC_CELL
> +"  ss   stop execution on all spus\n\
> +  sr   restore execution on stopped spus\n"
> +#endif
> +"  S   print special registers\n\
>    t   print backtrace\n\
>    x   exit monitor and recover\n\
>    X   exit monitor and dont recover\n"
> @@ -516,6 +524,7 @@ int xmon(struct pt_regs *excp)
>        xmon_save_regs(&regs);
>        excp = &regs;
>     }
> +
>     return xmon_core(excp, 0);
>  }
>  EXPORT_SYMBOL(xmon);
> @@ -808,6 +817,8 @@ cmds(struct pt_regs *excp)
>           cacheflush();
>           break;
>        case 's':
> +         if (do_spu_cmd() == 0)
> +            break;
>           if (do_step(excp))
>              return cmd;
>           break;
> @@ -2630,3 +2641,130 @@ void __init xmon_setup(void)
>     if (xmon_early)
>        debugger(NULL);
>  }
> +
> +#ifdef CONFIG_PPC_CELL
> +
> +struct spu_info {
> +   struct spu *spu;
> +   u64 saved_mfc_sr1_RW;
> +   u32 saved_spu_runcntl_RW;
> +   u8 stopped_ok;
> +};
> +
> +#define XMON_NUM_SPUS   16   /* Enough for current hardware */
> +
> +static struct spu_info spu_info[XMON_NUM_SPUS];
> +
> +void xmon_register_spus(struct list_head *list)
> +{
> +   struct spu *spu;
> +
> +   list_for_each_entry(spu, list, full_list) {
> +      if (spu->number >= XMON_NUM_SPUS) {
> +         WARN_ON(1);
> +         continue;
> +      }
> +
> +      spu_info[spu->number].spu = spu;
> +      spu_info[spu->number].stopped_ok = 0;
> +   }
> +}
> +
> +static void stop_spus(void)
> +{
> +   struct spu *spu;
> +   int i;
> +   u64 tmp;
> +
> +   for (i = 0; i < XMON_NUM_SPUS; i++) {
> +      if (!spu_info[i].spu)
> +         continue;
> +
> +      if (setjmp(bus_error_jmp) == 0) {
> +         catch_memory_errors = 1;
> +         sync();
> +
> +         spu = spu_info[i].spu;
> +
> +         spu_info[i].saved_spu_runcntl_RW =
> +            in_be32(&spu->problem->spu_runcntl_RW);
> +
> +         tmp = spu_mfc_sr1_get(spu);
> +         spu_info[i].saved_mfc_sr1_RW = tmp;
> +
> +         tmp &= ~MFC_STATE1_MASTER_RUN_CONTROL_MASK;
> +         spu_mfc_sr1_set(spu, tmp);
> +
> +         sync();
> +         __delay(200);
> +
> +         spu_info[i].stopped_ok = 1;
> +         printf("Stopped spu %.2d\n", i);
> +      } else {
> +         catch_memory_errors = 0;
> +         printf("*** Error stopping spu %.2d\n", i);
> +      }
> +      catch_memory_errors = 0;
> +   }
> +}
> +
> +static void restart_spus(void)
> +{
> +   struct spu *spu;
> +   int i;
> +
> +   for (i = 0; i < XMON_NUM_SPUS; i++) {
> +      if (!spu_info[i].spu)
> +         continue;
> +
> +      if (!spu_info[i].stopped_ok) {
> +         printf("*** Error, spu %d was not successfully stopped"
> +               ", not restarting\n", i);
> +         continue;
> +      }
> +
> +      if (setjmp(bus_error_jmp) == 0) {
> +         catch_memory_errors = 1;
> +         sync();
> +
> +         spu = spu_info[i].spu;
> +         spu_mfc_sr1_set(spu, spu_info[i].saved_mfc_sr1_RW);
> +         out_be32(&spu->problem->spu_runcntl_RW,
> +               spu_info[i].saved_spu_runcntl_RW);
> +
> +         sync();
> +         __delay(200);
> +
> +         printf("Restarted spu %.2d\n", i);
> +      } else {
> +         catch_memory_errors = 0;
> +         printf("*** Error restarting spu %.2d\n", i);
> +      }
> +      catch_memory_errors = 0;
> +   }
> +}
> +
> +static int do_spu_cmd(void)
> +{
> +   int cmd;
> +
> +   cmd = inchar();
> +   switch (cmd) {
> +   case 's':
> +      stop_spus();
> +      break;
> +   case 'r':
> +      restart_spus();
> +      break;
> +   default:
> +      return -1;
> +   }
> +
> +   return 0;
> +}
> +#else /* ! CONFIG_PPC_CELL */
> +static int do_spu_cmd(void)
> +{
> +   return -1;
> +}
> +#endif
> Index: to-merge/include/asm-powerpc/xmon.h
> ===================================================================
> --- to-merge.orig/include/asm-powerpc/xmon.h
> +++ to-merge/include/asm-powerpc/xmon.h
> @@ -14,8 +14,10 @@
> 
>  #ifdef CONFIG_XMON
>  extern void xmon_setup(void);
> +extern void xmon_register_spus(struct list_head *list);
>  #else
>  static inline void xmon_setup(void) { };
> +static inline void xmon_register_spus(struct list_head *list) { };
>  #endif
> 
>  #endif /* __KERNEL __ */
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

--=_alternative 0010C1C583257206_=
Content-Type: text/html; charset="US-ASCII"


<br><tt><font size=2>linuxppc-dev-bounces+lukebrowning=us.ibm.com@ozlabs.org
wrote on 10/12/2006 09:03:08 AM:<br>
<br>
&gt; This patch adds support for stopping, and restarting, spus<br>
&gt; from xmon. We use the spu master runcntl bit to stop execution,<br>
&gt; this is apparently the &quot;right&quot; way to control spu execution
and<br>
&gt; spufs will be changed in the future to use this bit.<br>
&gt; <br>
&gt; Testing has shown that to restart execution we have to turn the<br>
&gt; master runcntl bit on and also rewrite the spu runcntl bit, even<br>
&gt; if it is already set to 1 (running).<br>
&gt; <br>
&gt; Stopping spus is triggered by the xmon command 'ss' - &quot;spus stop&quot;<br>
&gt; perhaps. Restarting them is triggered via 'sr'. Restart doesn't<br>
&gt; start execution on spus unless they were running prior to being<br>
&gt; stopped by xmon.<br>
&gt; <br>
&gt; Walking the spu-&gt;full_list in xmon after a panic, would mean<br>
&gt; corruption of any spu struct would make all the others<br>
&gt; inaccessible. To avoid this, and also to make the next patch<br>
&gt; easier, we cache pointers to all spus during boot.<br>
</font></tt>
<br><tt><font size=2>The spe affinity code drop created an array of spu
pointers that</font></tt>
<br><tt><font size=2>is indexed by spu-&gt;number. &nbsp;We have a couple
of other fields in</font></tt>
<br><tt><font size=2>there that are needed for multiple spu scheduling
operations. &nbsp;</font></tt>
<br><tt><font size=2>Maybe, you can use this array. &nbsp;The name of the
arry is lspu[]</font></tt>
<br><tt><font size=2>for logical spus.</font></tt>
<br>
<br><tt><font size=2>&gt; <br>
&gt; We attempt to catch and recover from errors while stopping and<br>
&gt; restarting the spus, but as with most xmon functionality there are<br>
&gt; no guarantees that performing these operations won't crash xmon<br>
&gt; itself.<br>
&gt; <br>
&gt; Signed-off-by: Michael Ellerman &lt;michael@ellerman.id.au&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; &nbsp;arch/powerpc/platforms/cell/spu_base.c | &nbsp; &nbsp;4 <br>
&gt; &nbsp;arch/powerpc/xmon/xmon.c &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; &nbsp; | &nbsp;142 <br>
&gt; ++++++++++++++++++++++++++++++++-<br>
&gt; &nbsp;include/asm-powerpc/xmon.h &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
&nbsp; | &nbsp; &nbsp;2 <br>
&gt; &nbsp;3 files changed, 146 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; Index: to-merge/arch/powerpc/platforms/cell/spu_base.c<br>
&gt; ===================================================================<br>
&gt; --- to-merge.orig/arch/powerpc/platforms/cell/spu_base.c<br>
&gt; +++ to-merge/arch/powerpc/platforms/cell/spu_base.c<br>
&gt; @@ -38,6 +38,7 @@<br>
&gt; &nbsp;#include &lt;asm/spu.h&gt;<br>
&gt; &nbsp;#include &lt;asm/spu_priv1.h&gt;<br>
&gt; &nbsp;#include &lt;asm/mmu_context.h&gt;<br>
&gt; +#include &lt;asm/xmon.h&gt;<br>
&gt; &nbsp;<br>
&gt; &nbsp;#include &quot;interrupt.h&quot;<br>
&gt; &nbsp;<br>
&gt; @@ -914,6 +915,9 @@ static int __init init_spu_base(void)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;}<br>
&gt; &nbsp; &nbsp; }<br>
&gt; +<br>
&gt; + &nbsp; xmon_register_spus(&amp;spu_full_list);<br>
&gt; +<br>
&gt; &nbsp; &nbsp; return ret;<br>
&gt; &nbsp;}<br>
&gt; &nbsp;module_init(init_spu_base);<br>
&gt; Index: to-merge/arch/powerpc/xmon/xmon.c<br>
&gt; ===================================================================<br>
&gt; --- to-merge.orig/arch/powerpc/xmon/xmon.c<br>
&gt; +++ to-merge/arch/powerpc/xmon/xmon.c<br>
&gt; @@ -35,6 +35,8 @@<br>
&gt; &nbsp;#include &lt;asm/rtas.h&gt;<br>
&gt; &nbsp;#include &lt;asm/sstep.h&gt;<br>
&gt; &nbsp;#include &lt;asm/bug.h&gt;<br>
&gt; +#include &lt;asm/spu.h&gt;<br>
&gt; +#include &lt;asm/spu_priv1.h&gt;<br>
&gt; &nbsp;<br>
&gt; &nbsp;#ifdef CONFIG_PPC64<br>
&gt; &nbsp;#include &lt;asm/hvcall.h&gt;<br>
&gt; @@ -145,6 +147,8 @@ static void xmon_print_symbol(unsigned l<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; const char
*after);<br>
&gt; &nbsp;static const char *getvecname(unsigned long vec);<br>
&gt; &nbsp;<br>
&gt; +static int do_spu_cmd(void);<br>
&gt; +<br>
&gt; &nbsp;int xmon_no_auto_backtrace;<br>
&gt; &nbsp;<br>
&gt; &nbsp;extern int print_insn_powerpc(unsigned long, unsigned long,
int);<br>
&gt; @@ -207,8 +211,12 @@ Commands:\n\<br>
&gt; &nbsp; &nbsp;mi &nbsp; show information about memory allocation\n\<br>
&gt; &nbsp; &nbsp;p &nbsp; &nbsp;call a procedure\n\<br>
&gt; &nbsp; &nbsp;r &nbsp; print registers\n\<br>
&gt; - &nbsp;s &nbsp; single step\n\<br>
&gt; - &nbsp;S &nbsp; print special registers\n\<br>
&gt; + &nbsp;s &nbsp; single step\n&quot;<br>
&gt; +#ifdef CONFIG_PPC_CELL<br>
&gt; +&quot; &nbsp;ss &nbsp; stop execution on all spus\n\<br>
&gt; + &nbsp;sr &nbsp; restore execution on stopped spus\n&quot;<br>
&gt; +#endif<br>
&gt; +&quot; &nbsp;S &nbsp; print special registers\n\<br>
&gt; &nbsp; &nbsp;t &nbsp; print backtrace\n\<br>
&gt; &nbsp; &nbsp;x &nbsp; exit monitor and recover\n\<br>
&gt; &nbsp; &nbsp;X &nbsp; exit monitor and dont recover\n&quot;<br>
&gt; @@ -516,6 +524,7 @@ int xmon(struct pt_regs *excp)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;xmon_save_regs(&amp;regs);<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;excp = &amp;regs;<br>
&gt; &nbsp; &nbsp; }<br>
&gt; +<br>
&gt; &nbsp; &nbsp; return xmon_core(excp, 0);<br>
&gt; &nbsp;}<br>
&gt; &nbsp;EXPORT_SYMBOL(xmon);<br>
&gt; @@ -808,6 +817,8 @@ cmds(struct pt_regs *excp)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; cacheflush();<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;case 's':<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; if (do_spu_cmd() == 0)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;break;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; if (do_step(excp))<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;return cmd;<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; break;<br>
&gt; @@ -2630,3 +2641,130 @@ void __init xmon_setup(void)<br>
&gt; &nbsp; &nbsp; if (xmon_early)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;debugger(NULL);<br>
&gt; &nbsp;}<br>
&gt; +<br>
&gt; +#ifdef CONFIG_PPC_CELL<br>
&gt; +<br>
&gt; +struct spu_info {<br>
&gt; + &nbsp; struct spu *spu;<br>
&gt; + &nbsp; u64 saved_mfc_sr1_RW;<br>
&gt; + &nbsp; u32 saved_spu_runcntl_RW;<br>
&gt; + &nbsp; u8 stopped_ok;<br>
&gt; +};<br>
&gt; +<br>
&gt; +#define XMON_NUM_SPUS &nbsp; 16 &nbsp; /* Enough for current hardware
*/<br>
&gt; +<br>
&gt; +static struct spu_info spu_info[XMON_NUM_SPUS];<br>
&gt; +<br>
&gt; +void xmon_register_spus(struct list_head *list)<br>
&gt; +{<br>
&gt; + &nbsp; struct spu *spu;<br>
&gt; +<br>
&gt; + &nbsp; list_for_each_entry(spu, list, full_list) {<br>
&gt; + &nbsp; &nbsp; &nbsp;if (spu-&gt;number &gt;= XMON_NUM_SPUS) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; WARN_ON(1);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; continue;<br>
&gt; + &nbsp; &nbsp; &nbsp;}<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp;spu_info[spu-&gt;number].spu = spu;<br>
&gt; + &nbsp; &nbsp; &nbsp;spu_info[spu-&gt;number].stopped_ok = 0;<br>
&gt; + &nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void stop_spus(void)<br>
&gt; +{<br>
&gt; + &nbsp; struct spu *spu;<br>
&gt; + &nbsp; int i;<br>
&gt; + &nbsp; u64 tmp;<br>
&gt; +<br>
&gt; + &nbsp; for (i = 0; i &lt; XMON_NUM_SPUS; i++) {<br>
&gt; + &nbsp; &nbsp; &nbsp;if (!spu_info[i].spu)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; continue;<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp;if (setjmp(bus_error_jmp) == 0) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; catch_memory_errors = 1;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; sync();<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; spu = spu_info[i].spu;<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; spu_info[i].saved_spu_runcntl_RW =<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;in_be32(&amp;spu-&gt;problem-&gt;spu_runcntl_RW);<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; tmp = spu_mfc_sr1_get(spu);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; spu_info[i].saved_mfc_sr1_RW = tmp;<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; tmp &amp;= ~MFC_STATE1_MASTER_RUN_CONTROL_MASK;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; spu_mfc_sr1_set(spu, tmp);<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; sync();<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; __delay(200);<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; spu_info[i].stopped_ok = 1;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; printf(&quot;Stopped spu %.2d\n&quot;,
i);<br>
&gt; + &nbsp; &nbsp; &nbsp;} else {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; catch_memory_errors = 0;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; printf(&quot;*** Error stopping spu
%.2d\n&quot;, i);<br>
&gt; + &nbsp; &nbsp; &nbsp;}<br>
&gt; + &nbsp; &nbsp; &nbsp;catch_memory_errors = 0;<br>
&gt; + &nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static void restart_spus(void)<br>
&gt; +{<br>
&gt; + &nbsp; struct spu *spu;<br>
&gt; + &nbsp; int i;<br>
&gt; +<br>
&gt; + &nbsp; for (i = 0; i &lt; XMON_NUM_SPUS; i++) {<br>
&gt; + &nbsp; &nbsp; &nbsp;if (!spu_info[i].spu)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; continue;<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp;if (!spu_info[i].stopped_ok) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; printf(&quot;*** Error, spu %d was not
successfully stopped&quot;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &quot;, not restarting\n&quot;,
i);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; continue;<br>
&gt; + &nbsp; &nbsp; &nbsp;}<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp;if (setjmp(bus_error_jmp) == 0) {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; catch_memory_errors = 1;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; sync();<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; spu = spu_info[i].spu;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; spu_mfc_sr1_set(spu, spu_info[i].saved_mfc_sr1_RW);<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; out_be32(&amp;spu-&gt;problem-&gt;spu_runcntl_RW,<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; spu_info[i].saved_spu_runcntl_RW);<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; sync();<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; __delay(200);<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; printf(&quot;Restarted spu %.2d\n&quot;,
i);<br>
&gt; + &nbsp; &nbsp; &nbsp;} else {<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; catch_memory_errors = 0;<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; printf(&quot;*** Error restarting spu
%.2d\n&quot;, i);<br>
&gt; + &nbsp; &nbsp; &nbsp;}<br>
&gt; + &nbsp; &nbsp; &nbsp;catch_memory_errors = 0;<br>
&gt; + &nbsp; }<br>
&gt; +}<br>
&gt; +<br>
&gt; +static int do_spu_cmd(void)<br>
&gt; +{<br>
&gt; + &nbsp; int cmd;<br>
&gt; +<br>
&gt; + &nbsp; cmd = inchar();<br>
&gt; + &nbsp; switch (cmd) {<br>
&gt; + &nbsp; case 's':<br>
&gt; + &nbsp; &nbsp; &nbsp;stop_spus();<br>
&gt; + &nbsp; &nbsp; &nbsp;break;<br>
&gt; + &nbsp; case 'r':<br>
&gt; + &nbsp; &nbsp; &nbsp;restart_spus();<br>
&gt; + &nbsp; &nbsp; &nbsp;break;<br>
&gt; + &nbsp; default:<br>
&gt; + &nbsp; &nbsp; &nbsp;return -1;<br>
&gt; + &nbsp; }<br>
&gt; +<br>
&gt; + &nbsp; return 0;<br>
&gt; +}<br>
&gt; +#else /* ! CONFIG_PPC_CELL */<br>
&gt; +static int do_spu_cmd(void)<br>
&gt; +{<br>
&gt; + &nbsp; return -1;<br>
&gt; +}<br>
&gt; +#endif<br>
&gt; Index: to-merge/include/asm-powerpc/xmon.h<br>
&gt; ===================================================================<br>
&gt; --- to-merge.orig/include/asm-powerpc/xmon.h<br>
&gt; +++ to-merge/include/asm-powerpc/xmon.h<br>
&gt; @@ -14,8 +14,10 @@<br>
&gt; &nbsp;<br>
&gt; &nbsp;#ifdef CONFIG_XMON<br>
&gt; &nbsp;extern void xmon_setup(void);<br>
&gt; +extern void xmon_register_spus(struct list_head *list);<br>
&gt; &nbsp;#else<br>
&gt; &nbsp;static inline void xmon_setup(void) { };<br>
&gt; +static inline void xmon_register_spus(struct list_head *list) { };<br>
&gt; &nbsp;#endif<br>
&gt; &nbsp;<br>
&gt; &nbsp;#endif /* __KERNEL __ */<br>
&gt; _______________________________________________<br>
&gt; Linuxppc-dev mailing list<br>
&gt; Linuxppc-dev@ozlabs.org<br>
&gt; https://ozlabs.org/mailman/listinfo/linuxppc-dev<br>
</font></tt>
--=_alternative 0010C1C583257206_=--
