Return-Path: <hbabu@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F18DB67B39
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Apr 2006 08:46:25 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k35MkMeO016803
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Apr 2006 18:46:22 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k35MnYXm154502
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Apr 2006 16:49:34 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id
	k35MkLO4017924
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Apr 2006 16:46:21 -0600
In-Reply-To: <20060404114306.8DC0F679EF@ozlabs.org>
To: Michael Ellerman <michael@ellerman.id.au>
MIME-Version: 1.0
Subject: Re: [PATCH] powerpc: Disable and EOI interrupts
	in	machine_crash_shutdown()
Message-ID: <OF58EBE15D.861A2E78-ON87257147.007964B2-88257147.007D18EA@us.ibm.com>
From: Haren Myneni <hbabu@us.ibm.com>
Date: Wed, 5 Apr 2006 15:50:57 -0700
Content-Type: multipart/alternative;
	boundary="=_alternative 007D18E688257147_="
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multipart message in MIME format.
--=_alternative 007D18E688257147_=
Content-Type: text/plain; charset="US-ASCII"

linuxppc-dev-bounces+hbabu=us.ibm.com@ozlabs.org wrote on 04/04/2006 
04:43:01 AM:

> We've seen several bugs caused by interrupt weirdness in the kdump 
kernel.
> Panicking from an interrupt handler means we fail to EOI the interrupt, 
and
> so the second kernel never gets that interrupt ever again. We also see 
hangs
> on JS20 where we take interrupts in the second kernel early during boot.
> 
> This patch fixes both those problems, and although it adds more code to 
the
> crash path I think it is the best solution.
> 

Michael,
        Noticing the following issues when invoked kdump boot using 
soft-reset. But the kdump boot is successful. Not a problem using sysrq-c 
or Oops.

rtas_call retuned these error messages
"xics_disable_irq: irq=655360: ibm_set_xive(0xff) returned -3" for IRQ# 
182

"xics_disable_irq: irq=589825: ibm_set_xive(0xff) returned -3" for IRQ# 
216

cat /proc/interrupts
18:       2997       3401       1317       1442   XICS      Edge      IPI
134:          0          0          0          0   XICS      Edge 
ehci_hcd:usb1, ohci_hcd:usb2, ohci_hcd:usb3
167:       2169          0          0          0   XICS      Edge      ipr
182:         55          0          0          0   XICS      Edge 
hvc_console
216:          0          0          0          0   XICS      Edge RAS_EPOW
BAD:        117

Thanks
Haren
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
> 
>  arch/powerpc/kernel/crash.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> Index: kdump/arch/powerpc/kernel/crash.c
> ===================================================================
> --- kdump.orig/arch/powerpc/kernel/crash.c
> +++ kdump/arch/powerpc/kernel/crash.c
> @@ -22,6 +22,7 @@
>  #include <linux/elf.h>
>  #include <linux/elfcore.h>
>  #include <linux/init.h>
> +#include <linux/irq.h>
>  #include <linux/types.h>
> 
>  #include <asm/processor.h>
> @@ -174,6 +175,8 @@ static void crash_kexec_prepare_cpus(voi
> 
>  void default_machine_crash_shutdown(struct pt_regs *regs)
>  {
> +   unsigned int irq;
> +
>     /*
>      * This function is only called after the system
>      * has paniced or is otherwise in a critical state.
> @@ -186,6 +189,16 @@ void default_machine_crash_shutdown(stru
>      */
>     local_irq_disable();
> 
> +   for_each_irq(irq) {
> +      struct irq_desc *desc = irq_descp(irq);
> +
> +      if (desc->status & IRQ_INPROGRESS)
> +         desc->handler->end(irq);
> +
> +      if (!(desc->status & IRQ_DISABLED))
> +         desc->handler->disable(irq);
> +   }
> +
>     if (ppc_md.kexec_cpu_down)
>        ppc_md.kexec_cpu_down(1, 0);
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev

--=_alternative 007D18E688257147_=
Content-Type: text/html; charset="US-ASCII"


<br>
<br><font size=2><tt>linuxppc-dev-bounces+hbabu=us.ibm.com@ozlabs.org wrote
on 04/04/2006 04:43:01 AM:<br>
<br>
&gt; We've seen several bugs caused by interrupt weirdness in the kdump
kernel.<br>
&gt; Panicking from an interrupt handler means we fail to EOI the interrupt,
and<br>
&gt; so the second kernel never gets that interrupt ever again. We also
see hangs<br>
&gt; on JS20 where we take interrupts in the second kernel early during
boot.<br>
&gt; <br>
&gt; This patch fixes both those problems, and although it adds more code
to the<br>
&gt; crash path I think it is the best solution.<br>
&gt; </tt></font>
<br>
<br><font size=2><tt>Michael,</tt></font>
<br><font size=2><tt>&nbsp; &nbsp; &nbsp; &nbsp; Noticing the following
issues when invoked kdump boot using soft-reset. But the kdump boot is
successful. Not a problem using sysrq-c or Oops.</tt></font>
<br>
<br><font size=2><tt>rtas_call retuned these error messages</tt></font>
<br><font size=2><tt>&quot;xics_disable_irq: irq=655360: ibm_set_xive(0xff)
returned -3&quot; for IRQ# 182<br>
<br>
&quot;xics_disable_irq: irq=589825: ibm_set_xive(0xff) returned -3&quot;
for IRQ# 216<br>
<br>
cat /proc/interrupts<br>
18: &nbsp; &nbsp; &nbsp; 2997 &nbsp; &nbsp; &nbsp; 3401 &nbsp; &nbsp; &nbsp;
1317 &nbsp; &nbsp; &nbsp; 1442 &nbsp; XICS &nbsp; &nbsp; &nbsp;Edge &nbsp;
&nbsp; &nbsp;IPI<br>
134: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0
&nbsp; XICS &nbsp; &nbsp; &nbsp;Edge &nbsp; &nbsp; &nbsp;ehci_hcd:usb1,
ohci_hcd:usb2, ohci_hcd:usb3<br>
167: &nbsp; &nbsp; &nbsp; 2169 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp;
&nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp;
XICS &nbsp; &nbsp; &nbsp;Edge &nbsp; &nbsp; &nbsp;ipr<br>
182: &nbsp; &nbsp; &nbsp; &nbsp; 55 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0
&nbsp; XICS &nbsp; &nbsp; &nbsp;Edge &nbsp; &nbsp; &nbsp;hvc_console<br>
216: &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0
&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;0
&nbsp; XICS &nbsp; &nbsp; &nbsp;Edge &nbsp; &nbsp; &nbsp;RAS_EPOW<br>
BAD: &nbsp; &nbsp; &nbsp; &nbsp;117<br>
</tt></font>
<br><font size=2><tt>Thanks</tt></font>
<br><font size=2><tt>Haren<br>
&gt; Signed-off-by: Michael Ellerman &lt;michael@ellerman.id.au&gt;<br>
&gt; ---<br>
&gt; <br>
&gt; &nbsp;arch/powerpc/kernel/crash.c | &nbsp; 13 +++++++++++++<br>
&gt; &nbsp;1 file changed, 13 insertions(+)<br>
&gt; <br>
&gt; Index: kdump/arch/powerpc/kernel/crash.c<br>
&gt; ===================================================================<br>
&gt; --- kdump.orig/arch/powerpc/kernel/crash.c<br>
&gt; +++ kdump/arch/powerpc/kernel/crash.c<br>
&gt; @@ -22,6 +22,7 @@<br>
&gt; &nbsp;#include &lt;linux/elf.h&gt;<br>
&gt; &nbsp;#include &lt;linux/elfcore.h&gt;<br>
&gt; &nbsp;#include &lt;linux/init.h&gt;<br>
&gt; +#include &lt;linux/irq.h&gt;<br>
&gt; &nbsp;#include &lt;linux/types.h&gt;<br>
&gt; &nbsp;<br>
&gt; &nbsp;#include &lt;asm/processor.h&gt;<br>
&gt; @@ -174,6 +175,8 @@ static void crash_kexec_prepare_cpus(voi<br>
&gt; &nbsp;<br>
&gt; &nbsp;void default_machine_crash_shutdown(struct pt_regs *regs)<br>
&gt; &nbsp;{<br>
&gt; + &nbsp; unsigned int irq;<br>
&gt; +<br>
&gt; &nbsp; &nbsp; /*<br>
&gt; &nbsp; &nbsp; &nbsp;* This function is only called after the system<br>
&gt; &nbsp; &nbsp; &nbsp;* has paniced or is otherwise in a critical state.<br>
&gt; @@ -186,6 +189,16 @@ void default_machine_crash_shutdown(stru<br>
&gt; &nbsp; &nbsp; &nbsp;*/<br>
&gt; &nbsp; &nbsp; local_irq_disable();<br>
&gt; &nbsp;<br>
&gt; + &nbsp; for_each_irq(irq) {<br>
&gt; + &nbsp; &nbsp; &nbsp;struct irq_desc *desc = irq_descp(irq);<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp;if (desc-&gt;status &amp; IRQ_INPROGRESS)<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; desc-&gt;handler-&gt;end(irq);<br>
&gt; +<br>
&gt; + &nbsp; &nbsp; &nbsp;if (!(desc-&gt;status &amp; IRQ_DISABLED))<br>
&gt; + &nbsp; &nbsp; &nbsp; &nbsp; desc-&gt;handler-&gt;disable(irq);<br>
&gt; + &nbsp; }<br>
&gt; +<br>
&gt; &nbsp; &nbsp; if (ppc_md.kexec_cpu_down)<br>
&gt; &nbsp; &nbsp; &nbsp; &nbsp;ppc_md.kexec_cpu_down(1, 0);<br>
&gt; &nbsp;<br>
&gt; _______________________________________________<br>
&gt; Linuxppc-dev mailing list<br>
&gt; Linuxppc-dev@ozlabs.org<br>
&gt; https://ozlabs.org/mailman/listinfo/linuxppc-dev<br>
</tt></font>
--=_alternative 007D18E688257147_=--
