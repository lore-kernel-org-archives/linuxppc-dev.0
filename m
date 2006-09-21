Return-Path: <peterarbejde@gmail.com>
Received: from nz-out-0102.google.com (nz-out-0102.google.com [64.233.162.198])
	by ozlabs.org (Postfix) with ESMTP id 99C1C67B9D
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 17:40:15 +1000 (EST)
Received: by nz-out-0102.google.com with SMTP id i1so252221nzh
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Sep 2006 00:40:13 -0700 (PDT)
Message-ID: <36468a5c0609210040o3f2fad38r7f6f9848ffa48ec8@mail.gmail.com>
Date: Thu, 21 Sep 2006 09:40:13 +0200
From: "Peter N. Andreasen" <peterarbejde@gmail.com>
To: "Liu Dave-r63238" <DaveLiu@freescale.com>,
	"Linas Vepstas" <linas@austin.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: Linux on custom Xilinx board with PPC405 hangs on boot
In-Reply-To: <995B09A8299C2C44B59866F6391D263516BFD2@zch01exm21.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_889_31881336.1158824413215"
References: <20060920235716.GV29167@austin.ibm.com>
	<995B09A8299C2C44B59866F6391D263516BFD2@zch01exm21.fsl.freescale.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_889_31881336.1158824413215
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Liu, Linas, list
Thanks a lot for the answers. It helped me to review the hardware
configuration again.
The problem was the definition of the Flash size.
It turns out that the Xilinx generated header files define the size of the
Flash. But the kernel also has a configuration option: Memory Technology
Devices / Mapping Drivers for Chip Access / Physical Length of Chip Mapping
My arch/ppc/platforms/xilinx_ocp/xparameters_ml300.h defines this as 4Mbyte,
but the option in the kernel was set to 64 Mbyte (an extra 0 which I had not
seen)
thanks again
Peter




On 9/21/06, Liu Dave-r63238 <DaveLiu@freescale.com> wrote:
>
> <snip>
> > > Instruction machine check in kernel mode.
> > > Oops: machine check, sig: 7
> > > NIP: C00A2960 XER: 40000000 LR: C009CBD8 SP: C04D9D90 REGS:
> > c04d9ce0 TRAP:
> > > 0200    Not tainted
> > > MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
> >
> > Machine checks happen when some hunk of hardware is wired to
> > the machine-check pin of the cpu chip, and that bit of
> > hardware decides to raise the wire.  I'd say the first step
> > is to figure ou what hardware is wired up this way, and what
> > would make it unhappy enough to assert a machine check.
> >
> > SRR1 has bits that state what caused he machine check. -- e.g
> > partity error on data or address bus, "transfer error", or MC signal.
>
> The PPC405 has different registers for machine check. Unlike classic
> powerpc.
>
> -Dave
>

------=_Part_889_31881336.1158824413215
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Liu, Linas, list<br>Thanks a lot for the answers. It helped me to review the hardware configuration again.<br>The problem was the definition of the Flash size.<br>It turns out that the Xilinx generated header files define the size of the Flash. But the kernel also has a configuration option: Memory Technology Devices / Mapping Drivers for Chip Access / Physical Length of Chip Mapping
<br>My arch/ppc/platforms/xilinx_ocp/xparameters_ml300.h defines this as 4Mbyte, but the option in the kernel was set to 64 Mbyte (an extra 0 which I had not seen)<br>thanks again<br>Peter<br><br><br><br><br><div><span class="gmail_quote">
On 9/21/06, <b class="gmail_sendername">Liu Dave-r63238</b> &lt;<a href="mailto:DaveLiu@freescale.com">DaveLiu@freescale.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
&lt;snip&gt;<br>&gt; &gt; Instruction machine check in kernel mode.<br>&gt; &gt; Oops: machine check, sig: 7<br>&gt; &gt; NIP: C00A2960 XER: 40000000 LR: C009CBD8 SP: C04D9D90 REGS:<br>&gt; c04d9ce0 TRAP:<br>&gt; &gt; 0200&nbsp;&nbsp;&nbsp;&nbsp;Not tainted
<br>&gt; &gt; MSR: 00009030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11<br>&gt;<br>&gt; Machine checks happen when some hunk of hardware is wired to<br>&gt; the machine-check pin of the cpu chip, and that bit of<br>&gt; hardware decides to raise the wire.&nbsp;&nbsp;I'd say the first step
<br>&gt; is to figure ou what hardware is wired up this way, and what<br>&gt; would make it unhappy enough to assert a machine check.<br>&gt;<br>&gt; SRR1 has bits that state what caused he machine check. -- e.g<br>&gt; partity error on data or address bus, &quot;transfer error&quot;, or MC signal.
<br><br>The PPC405 has different registers for machine check. Unlike classic<br>powerpc.<br><br>-Dave<br></blockquote></div><br>

------=_Part_889_31881336.1158824413215--
