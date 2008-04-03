Return-Path: <johaahn@gmail.com>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.171])
	by ozlabs.org (Postfix) with ESMTP id E196EDDF6C
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Apr 2008 00:23:12 +1100 (EST)
Received: by wf-out-1314.google.com with SMTP id 25so3140053wfa.15
	for <linuxppc-dev@ozlabs.org>; Thu, 03 Apr 2008 06:23:10 -0700 (PDT)
Message-ID: <7e0dd21a0804030623s3571716fk8585b517c9aac1ed@mail.gmail.com>
Date: Thu, 3 Apr 2008 13:23:10 +0000
From: "Johann Baudy" <johaahn@gmail.com>
To: "John Linn" <john.linn@xilinx.com>
Subject: Re: [PATCH 3/3][POWERPC][V2] Xilinx: boot support for Xilinx uart
	16550.
In-Reply-To: <20080402165216.C835D1CF8088@mail12-sin.bigfish.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_892_19083957.1207228990751"
References: <12071551351007-git-send-email-john.linn@xilinx.com>
	<20080402165216.C835D1CF8088@mail12-sin.bigfish.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_892_19083957.1207228990751
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi John,

I've a small question about ns16550 boot support.
I can't see any code related to either "clock-frequency" or "current-speed"
key words.
Such actions are performed in of_serial.c to get appropriate baud rate
(update of UART_DLL and UART_DLM).

Is it needed or is it a misunderstanding?
Personally, I have added this below debug code (dirty :)) to make it work.

diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c
index f8f1b2f..850e223 100644
--- a/arch/powerpc/boot/ns16550.c
+++ b/arch/powerpc/boot/ns16550.c
@@ -26,6 +26,9 @@
 #define UART_MSR    6    /* In:  Modem Status Register */
 #define UART_SCR    7    /* I/O: Scratch Register */

+#define UART_LCR_DLAB 0x80      /* Divisor latch access */
+#define UART_LCR_8_DATA_BITS 0x03
+
 static unsigned char *reg_base;
 static u32 reg_shift;

@@ -56,6 +59,10 @@ int ns16550_console_init(void *devp, struct
serial_console_data *scdp)
 {
     int n;
     unsigned long reg_phys;
+  unsigned long divisor=0;
+  unsigned long spd=0, clk=0;
+
+

     n = getprop(devp, "virtual-reg", &reg_base, sizeof(reg_base));
     if (n != sizeof(reg_base)) {
@@ -75,5 +82,23 @@ int ns16550_console_init(void *devp, struct
serial_console_data *scdp)
     scdp->tstc = ns16550_tstc;
     scdp->close = NULL;

+    n = getprop(devp, "current-speed", &spd, sizeof(spd));
+
+
+    n = getprop(devp, "clock-frequency", &clk, sizeof(clk));
+
+
+  if(spd&&clk)
+  {
+
+     divisor = clk / (spd * 16UL);
+
+     out_8(reg_base + (UART_FCR << reg_shift), 0x06);
+     out_8(reg_base + (UART_LCR << reg_shift),
UART_LCR_8_DATA_BITS|UART_LCR_DLAB);
+     out_8(reg_base + (UART_DLL << reg_shift), divisor&0xff);
+     out_8(reg_base + (UART_DLM << reg_shift), (divisor>>8)&0xff);
+     out_8(reg_base + (UART_LCR << reg_shift), UART_LCR_8_DATA_BITS);
+
+  }
     return 0;

Best regards,
Johann

On Wed, Apr 2, 2008 at 4:52 PM, John Linn <john.linn@xilinx.com> wrote:

> The Xilinx 16550 uart core is not a standard 16550 because it uses
> word-based addressing rather than byte-based adressing. With
> additional properties it is compatible with the open firmware
> 'ns16550' compatible binding.
>
> This code updates the ns16550 driver to use the reg-offset property
> so that the Xilinx UART 16550 can be used with it. The reg-shift
> was already being handled.
>
> Signed-off-by: John Linn <john.linn@xilinx.com>
> ---
>  arch/powerpc/boot/ns16550.c |    5 +++++
>  1 files changed, 5 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c
> index f8f1b2f..da9d2c2 100644
> --- a/arch/powerpc/boot/ns16550.c
> +++ b/arch/powerpc/boot/ns16550.c
> @@ -56,6 +56,7 @@ int ns16550_console_init(void *devp, struct
> serial_console_data *scdp)
>  {
>        int n;
>        unsigned long reg_phys;
> +       u32 reg_offset;
>
>        n = getprop(devp, "virtual-reg", &reg_base, sizeof(reg_base));
>        if (n != sizeof(reg_base)) {
> @@ -65,6 +66,10 @@ int ns16550_console_init(void *devp, struct
> serial_console_data *scdp)
>                reg_base = (void *)reg_phys;
>        }
>
> +       n = getprop(devp, "reg-offset", &reg_offset, sizeof(reg_offset));
> +       if (n == sizeof(reg_offset))
> +               reg_base += reg_offset;
> +
>        n = getprop(devp, "reg-shift", &reg_shift, sizeof(reg_shift));
>        if (n != sizeof(reg_shift))
>                reg_shift = 0;
> --
> 1.5.2.1
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Johann Baudy
johaahn@gmail.com

------=_Part_892_19083957.1207228990751
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi John,<br><br>I&#39;ve a small question about ns16550 boot support.<br>I can&#39;t see any code related to either &quot;clock-frequency&quot; or &quot;current-speed&quot; key words.<br>Such actions are performed in of_serial.c to get appropriate baud rate (update of UART_DLL and UART_DLM).<br>
<br>Is it needed or is it a misunderstanding? <br>Personally, I have added this below debug code (dirty :)) to make it work.<br><br>diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c<br>index f8f1b2f..850e223 100644<br>
--- a/arch/powerpc/boot/ns16550.c<br>+++ b/arch/powerpc/boot/ns16550.c<br>@@ -26,6 +26,9 @@<br>&nbsp;#define UART_MSR&nbsp;&nbsp;&nbsp; 6&nbsp;&nbsp;&nbsp; /* In:&nbsp; Modem Status Register */<br>&nbsp;#define UART_SCR&nbsp;&nbsp;&nbsp; 7&nbsp;&nbsp;&nbsp; /* I/O: Scratch Register */<br>&nbsp;<br>+#define UART_LCR_DLAB 0x80&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /* Divisor latch access */<br>
+#define UART_LCR_8_DATA_BITS 0x03<br>+<br>&nbsp;static unsigned char *reg_base;<br>&nbsp;static u32 reg_shift;<br>&nbsp;<br>@@ -56,6 +59,10 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp)<br>&nbsp;{<br>&nbsp;&nbsp;&nbsp;&nbsp; int n;<br>
&nbsp;&nbsp;&nbsp;&nbsp; unsigned long reg_phys;<br>+&nbsp; unsigned long divisor=0;<br>+&nbsp; unsigned long spd=0, clk=0;<br>+<br>+<br>&nbsp;<br>&nbsp;&nbsp;&nbsp;&nbsp; n = getprop(devp, &quot;virtual-reg&quot;, &amp;reg_base, sizeof(reg_base));<br>&nbsp;&nbsp;&nbsp;&nbsp; if (n != sizeof(reg_base)) {<br>
@@ -75,5 +82,23 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp)<br>&nbsp;&nbsp;&nbsp;&nbsp; scdp-&gt;tstc = ns16550_tstc;<br>&nbsp;&nbsp;&nbsp;&nbsp; scdp-&gt;close = NULL;<br>&nbsp;<br>+&nbsp;&nbsp;&nbsp; n = getprop(devp, &quot;current-speed&quot;, &amp;spd, sizeof(spd));<br>
+<br>+<br>+&nbsp;&nbsp;&nbsp; n = getprop(devp, &quot;clock-frequency&quot;, &amp;clk, sizeof(clk));<br>+<br>+<br>+&nbsp; if(spd&amp;&amp;clk)<br>+&nbsp; {<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp; divisor = clk / (spd * 16UL);<br>+<br>+&nbsp;&nbsp;&nbsp;&nbsp; out_8(reg_base + (UART_FCR &lt;&lt; reg_shift), 0x06);<br>
+&nbsp;&nbsp;&nbsp;&nbsp; out_8(reg_base + (UART_LCR &lt;&lt; reg_shift), UART_LCR_8_DATA_BITS|UART_LCR_DLAB);<br>+&nbsp;&nbsp;&nbsp;&nbsp; out_8(reg_base + (UART_DLL &lt;&lt; reg_shift), divisor&amp;0xff);<br>+&nbsp;&nbsp;&nbsp;&nbsp; out_8(reg_base + (UART_DLM &lt;&lt; reg_shift), (divisor&gt;&gt;8)&amp;0xff);<br>
+&nbsp;&nbsp;&nbsp;&nbsp; out_8(reg_base + (UART_LCR &lt;&lt; reg_shift), UART_LCR_8_DATA_BITS);<br>+<br>+&nbsp; }<br>&nbsp;&nbsp;&nbsp;&nbsp; return 0;<br>&nbsp;<br>Best regards,<br>Johann<br><br><div class="gmail_quote">On Wed, Apr 2, 2008 at 4:52 PM, John Linn &lt;<a href="mailto:john.linn@xilinx.com">john.linn@xilinx.com</a>&gt; wrote:<br>
<blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">The Xilinx 16550 uart core is not a standard 16550 because it uses<br>
word-based addressing rather than byte-based adressing. With<br>
additional properties it is compatible with the open firmware<br>
&#39;ns16550&#39; compatible binding.<br>
<br>
This code updates the ns16550 driver to use the reg-offset property<br>
so that the Xilinx UART 16550 can be used with it. The reg-shift<br>
was already being handled.<br>
<br>
Signed-off-by: John Linn &lt;<a href="mailto:john.linn@xilinx.com">john.linn@xilinx.com</a>&gt;<br>
---<br>
&nbsp;arch/powerpc/boot/ns16550.c | &nbsp; &nbsp;5 +++++<br>
&nbsp;1 files changed, 5 insertions(+), 0 deletions(-)<br>
<br>
diff --git a/arch/powerpc/boot/ns16550.c b/arch/powerpc/boot/ns16550.c<br>
index f8f1b2f..da9d2c2 100644<br>
--- a/arch/powerpc/boot/ns16550.c<br>
+++ b/arch/powerpc/boot/ns16550.c<br>
@@ -56,6 +56,7 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp)<br>
&nbsp;{<br>
 &nbsp; &nbsp; &nbsp; &nbsp;int n;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;unsigned long reg_phys;<br>
+ &nbsp; &nbsp; &nbsp; u32 reg_offset;<br>
<br>
 &nbsp; &nbsp; &nbsp; &nbsp;n = getprop(devp, &quot;virtual-reg&quot;, &amp;reg_base, sizeof(reg_base));<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (n != sizeof(reg_base)) {<br>
@@ -65,6 +66,10 @@ int ns16550_console_init(void *devp, struct serial_console_data *scdp)<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg_base = (void *)reg_phys;<br>
 &nbsp; &nbsp; &nbsp; &nbsp;}<br>
<br>
+ &nbsp; &nbsp; &nbsp; n = getprop(devp, &quot;reg-offset&quot;, &amp;reg_offset, sizeof(reg_offset));<br>
+ &nbsp; &nbsp; &nbsp; if (n == sizeof(reg_offset))<br>
+ &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; reg_base += reg_offset;<br>
+<br>
 &nbsp; &nbsp; &nbsp; &nbsp;n = getprop(devp, &quot;reg-shift&quot;, &amp;reg_shift, sizeof(reg_shift));<br>
 &nbsp; &nbsp; &nbsp; &nbsp;if (n != sizeof(reg_shift))<br>
 &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;reg_shift = 0;<br>
--<br>
<a href="http://1.5.2.1" target="_blank">1.5.2.1</a><br>
<br>
<br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href="mailto:Linuxppc-dev@ozlabs.org">Linuxppc-dev@ozlabs.org</a><br>
<a href="https://ozlabs.org/mailman/listinfo/linuxppc-dev" target="_blank">https://ozlabs.org/mailman/listinfo/linuxppc-dev</a><br>
</blockquote></div><br><br clear="all"><br>-- <br>Johann Baudy<br><a href="mailto:johaahn@gmail.com">johaahn@gmail.com</a>

------=_Part_892_19083957.1207228990751--
