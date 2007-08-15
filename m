Return-Path: <mail4mz@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.187])
	by ozlabs.org (Postfix) with ESMTP id 44FA2DDE3E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Aug 2007 07:12:42 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id f5so28787rvb
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Aug 2007 14:12:40 -0700 (PDT)
Message-ID: <5c9cd53b0708151412v2f5feb74v9e0b49d114b83021@mail.gmail.com>
Date: Wed, 15 Aug 2007 17:12:40 -0400
From: "mike zheng" <mail4mz@gmail.com>
To: "Becky Bruce" <becky.bruce@freescale.com>
Subject: Re: System crash on boot_e500.S on 2.4Kernel
In-Reply-To: <FC996AA4-4C5F-4B36-A9E9-5F931D054F1C@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5892_22188120.1187212360616"
References: <5c9cd53b0708141321h62f0ddd1k3a57a37f52e93894@mail.gmail.com>
	<36201C92-F117-4273-9FA7-13665CF0C6DB@freescale.com>
	<5c9cd53b0708150659u2ba88a9as5055b42fb1e2be67@mail.gmail.com>
	<FC996AA4-4C5F-4B36-A9E9-5F931D054F1C@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_5892_22188120.1187212360616
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Here is the PC value before the rfi:

cds8458>halt
           Target CPU:           : MPC85xx (e500v2 rev.1)
           Target state            : halted
           Debug entry cause  : instruction breakpoint
           Current PC             : 0x0000015c
           Current CR             : 0x24024022
           Current MSR          : 0x00012100
           Current LR              :0x00000148
           Current CCSRBAR  :0x0_e000000

After the rfi:

#step timeout defected
 cds8458>halt
           Target CPU:           : MPC85xx (e500v2 rev.1)
           Target state            : halted
           Debug entry cause  : COP halt
           Current PC             : 0xfff81300
           Current CR             : 0x24024022
           Current MSR          : 0x00001000
           Current LR              :0x00000148
           Current CCSRBAR  :0x0_e000000



On 8/15/07, Becky Bruce <becky.bruce@freescale.com> wrote:
>
>
> On Aug 15, 2007, at 8:59 AM, mike zheng wrote:
>
> > I use BDI to debug these two instructions. And here are the output
> > of BDI just before the "rfi". The content of R6, R7 is different
> > from SRR0(SPR26) and SRR1(SPR27).
>
> I see you have not printed the pc/nia once you stop.  Are you sure
> you're stopped where you think?  Please check this.
>
> -B
>
> >
> > cds8548>res run
> >
> > - TARGET: processing user reset request
> >
> > - BDI asserts HRESET
> >
> > - Reset JTAG controller passed
> >
> > - JTAG exists check passed
> >
> > - IDCODE is 0x0003901D
> >
> > - SVR is 0x80390011
> >
> > - PVR is 0x80210010
> >
> > - CCSRBAR is 0x0_ff700000
> >
> > - BDI removes HRESET
> >
> > - TARGET: Target PVR is 0x80210010
> >
> > - TARGET: resetting target passed
> >
> > cds8548>halt
> >
> > Target CPU : MPC85xx (e500v2 rev.1)
> >
> > Target state : halted
> >
> > Debug entry cause : COP halt
> >
> > Current PC : 0xfff82560
> >
> > Current CR : 0x88000042
> >
> > Current MSR : 0x00021200
> >
> > Current LR : 0xfff8aa4c
> >
> > Current CCSRBAR : 0x0_e0000000
> >
> > cds8548>ci
> >
> > cds8548>bi 0x0000015c
> >
> > Breakpoint identification is 0
> >
> > cds8548>go
> >
> > - TARGET: stopped
> >
> > cds8548>rd
> >
> > GPR00: 00000000 0ffabd20 00000200 00000008
> >
> > GPR04: 00000000 00000001 00000020 00000160
> >
> > GPR08: 1f8b0808 00000148 0ffabace 0ffe08b0
> >
> > GPR12: 00000006 764deddb 10000300 007fff00
> >
> > GPR16: 00000001 ffffffff 007fff25 0ffff9d8
> >
> > GPR20: 007ffeb0 00000000 0fffaa3c 0ffae490
> >
> > GPR24: 00000000 00000003 02000040 007fff25
> >
> > GPR28: 007fff00 0ffab3b8 0fcd6000 007ffeb0
> >
> > CR : 24024022 MSR: 00021200
> >
> > cds8548>rdspr 26
> >
> > SPR 26 : 0xfff81300 - 519424
> >
> > cds8548>rdspr 27
> >
> > SPR 27 : 0x00001000 4096
> >
> > cds8548>
> >
> >
> >
> >
> >
> >
> > On 8/14/07, Andy Fleming <afleming@freescale.com> wrote:
> > On Aug 14, 2007, at 15:21, mike zheng wrote:
> >
> > >
> > > Hi All,
> > >
> > > I am trying to bring up MPC8548 CDS board on 2.4 kernel. I have
> > > problem in the head_e500.S. The "mtspr SRR0, r7; mtspr SRR1 r6"
> > > does not work for me. The content of R7 and R6 are not moved to
> > > SRR0 and SRR1.  I am using the tool-chain from Freescale for 2.6
> > > kernel.
> > >
> > > Any idea on this issue?
> >
> > Just to check...how do you know it doesn't work?
> >
> > Andy
> >
> > _______________________________________________
> > Linuxppc-embedded mailing list
> > Linuxppc-embedded@ozlabs.org
> > https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>

------=_Part_5892_22188120.1187212360616
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Here is the PC value before the rfi:</div>
<div>&nbsp;</div>
<div>cds8458&gt;halt</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Target CPU:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : MPC85xx (e500v2 rev.1)</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Target state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : halted</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Debug entry cause&nbsp; : instruction breakpoint</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current PC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x0000015c</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current CR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x24024022</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Current MSR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x00012100</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Current LR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :0x00000148</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current CCSRBAR&nbsp; :0x0_e000000</div>
<div>&nbsp;</div>
<div>After the rfi:</div>
<div>&nbsp;</div>
<div>#step timeout defected</div>
<div>
<div>cds8458&gt;halt</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Target CPU:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : MPC85xx (e500v2 rev.1)</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Target state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : halted</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Debug entry cause&nbsp; : COP halt</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current PC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0xfff81300</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current CR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x24024022</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Current MSR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x00001000</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Current LR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :0x00000148</div>
<div>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current CCSRBAR&nbsp; :0x0_e000000</div></div>
<div><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 8/15/07, <b class="gmail_sendername">Becky Bruce</b> &lt;<a href="mailto:becky.bruce@freescale.com">becky.bruce@freescale.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br>On Aug 15, 2007, at 8:59 AM, mike zheng wrote:<br><br>&gt; I use BDI to debug these two instructions. And here are the output
<br>&gt; of BDI just before the &quot;rfi&quot;. The content of R6, R7 is different<br>&gt; from SRR0(SPR26) and SRR1(SPR27).<br><br>I see you have not printed the pc/nia once you stop.&nbsp;&nbsp;Are you sure<br>you&#39;re stopped where you think?&nbsp;&nbsp;Please check this.
<br><br>-B<br><br>&gt;<br>&gt; cds8548&gt;res run<br>&gt;<br>&gt; - TARGET: processing user reset request<br>&gt;<br>&gt; - BDI asserts HRESET<br>&gt;<br>&gt; - Reset JTAG controller passed<br>&gt;<br>&gt; - JTAG exists check passed
<br>&gt;<br>&gt; - IDCODE is 0x0003901D<br>&gt;<br>&gt; - SVR is 0x80390011<br>&gt;<br>&gt; - PVR is 0x80210010<br>&gt;<br>&gt; - CCSRBAR is 0x0_ff700000<br>&gt;<br>&gt; - BDI removes HRESET<br>&gt;<br>&gt; - TARGET: Target PVR is 0x80210010
<br>&gt;<br>&gt; - TARGET: resetting target passed<br>&gt;<br>&gt; cds8548&gt;halt<br>&gt;<br>&gt; Target CPU : MPC85xx (e500v2 rev.1)<br>&gt;<br>&gt; Target state : halted<br>&gt;<br>&gt; Debug entry cause : COP halt<br>
&gt;<br>&gt; Current PC : 0xfff82560<br>&gt;<br>&gt; Current CR : 0x88000042<br>&gt;<br>&gt; Current MSR : 0x00021200<br>&gt;<br>&gt; Current LR : 0xfff8aa4c<br>&gt;<br>&gt; Current CCSRBAR : 0x0_e0000000<br>&gt;<br>&gt; cds8548&gt;ci
<br>&gt;<br>&gt; cds8548&gt;bi 0x0000015c<br>&gt;<br>&gt; Breakpoint identification is 0<br>&gt;<br>&gt; cds8548&gt;go<br>&gt;<br>&gt; - TARGET: stopped<br>&gt;<br>&gt; cds8548&gt;rd<br>&gt;<br>&gt; GPR00: 00000000 0ffabd20 00000200 00000008
<br>&gt;<br>&gt; GPR04: 00000000 00000001 00000020 00000160<br>&gt;<br>&gt; GPR08: 1f8b0808 00000148 0ffabace 0ffe08b0<br>&gt;<br>&gt; GPR12: 00000006 764deddb 10000300 007fff00<br>&gt;<br>&gt; GPR16: 00000001 ffffffff 007fff25 0ffff9d8
<br>&gt;<br>&gt; GPR20: 007ffeb0 00000000 0fffaa3c 0ffae490<br>&gt;<br>&gt; GPR24: 00000000 00000003 02000040 007fff25<br>&gt;<br>&gt; GPR28: 007fff00 0ffab3b8 0fcd6000 007ffeb0<br>&gt;<br>&gt; CR : 24024022 MSR: 00021200
<br>&gt;<br>&gt; cds8548&gt;rdspr 26<br>&gt;<br>&gt; SPR 26 : 0xfff81300 - 519424<br>&gt;<br>&gt; cds8548&gt;rdspr 27<br>&gt;<br>&gt; SPR 27 : 0x00001000 4096<br>&gt;<br>&gt; cds8548&gt;<br>&gt;<br>&gt;<br>&gt;<br>&gt;<br>
&gt;<br>&gt;<br>&gt; On 8/14/07, Andy Fleming &lt;<a href="mailto:afleming@freescale.com">afleming@freescale.com</a>&gt; wrote:<br>&gt; On Aug 14, 2007, at 15:21, mike zheng wrote:<br>&gt;<br>&gt; &gt;<br>&gt; &gt; Hi All,
<br>&gt; &gt;<br>&gt; &gt; I am trying to bring up MPC8548 CDS board on 2.4 kernel. I have<br>&gt; &gt; problem in the head_e500.S. The &quot;mtspr SRR0, r7; mtspr SRR1 r6&quot;<br>&gt; &gt; does not work for me. The content of R7 and R6 are not moved to
<br>&gt; &gt; SRR0 and SRR1.&nbsp;&nbsp;I am using the tool-chain from Freescale for 2.6<br>&gt; &gt; kernel.<br>&gt; &gt;<br>&gt; &gt; Any idea on this issue?<br>&gt;<br>&gt; Just to check...how do you know it doesn&#39;t work?<br>
&gt;<br>&gt; Andy<br>&gt;<br>&gt; _______________________________________________<br>&gt; Linuxppc-embedded mailing list<br>&gt; <a href="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</a><br>&gt; <a href="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a><br><br></blockquote></div><br>

------=_Part_5892_22188120.1187212360616--
