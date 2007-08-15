Return-Path: <mail4mz@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.186])
	by ozlabs.org (Postfix) with ESMTP id 38F2FDDECC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Aug 2007 23:59:43 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so1489203rvf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Aug 2007 06:59:42 -0700 (PDT)
Message-ID: <5c9cd53b0708150659u2ba88a9as5055b42fb1e2be67@mail.gmail.com>
Date: Wed, 15 Aug 2007 09:59:41 -0400
From: "mike zheng" <mail4mz@gmail.com>
To: "Andy Fleming" <afleming@freescale.com>
Subject: Re: System crash on boot_e500.S on 2.4Kernel
In-Reply-To: <36201C92-F117-4273-9FA7-13665CF0C6DB@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_5508_8130366.1187186381987"
References: <5c9cd53b0708141321h62f0ddd1k3a57a37f52e93894@mail.gmail.com>
	<36201C92-F117-4273-9FA7-13665CF0C6DB@freescale.com>
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

------=_Part_5508_8130366.1187186381987
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I use BDI to debug these two instructions. And here are the output of BDI
just before the "rfi". The content of R6, R7 is different from SRR0(SPR26)
and SRR1(SPR27).


cds8548>res run

- TARGET: processing user reset request

- BDI asserts HRESET

- Reset JTAG controller passed

- JTAG exists check passed

- IDCODE is 0x0003901D

- SVR is 0x80390011

- PVR is 0x80210010

- CCSRBAR is 0x0_ff700000

- BDI removes HRESET

- TARGET: Target PVR is 0x80210010

- TARGET: resetting target passed

cds8548>halt

Target CPU : MPC85xx (e500v2 rev.1)

Target state : halted

Debug entry cause : COP halt

Current PC : 0xfff82560

Current CR : 0x88000042

Current MSR : 0x00021200

Current LR : 0xfff8aa4c

Current CCSRBAR : 0x0_e0000000

cds8548>ci

cds8548>bi 0x0000015c

Breakpoint identification is 0

cds8548>go

- TARGET: stopped

cds8548>rd

GPR00: 00000000 0ffabd20 00000200 00000008

GPR04: 00000000 00000001 00000020 00000160

GPR08: 1f8b0808 00000148 0ffabace 0ffe08b0

GPR12: 00000006 764deddb 10000300 007fff00

GPR16: 00000001 ffffffff 007fff25 0ffff9d8

GPR20: 007ffeb0 00000000 0fffaa3c 0ffae490

GPR24: 00000000 00000003 02000040 007fff25

GPR28: 007fff00 0ffab3b8 0fcd6000 007ffeb0

CR : 24024022 MSR: 00021200

cds8548>rdspr 26

SPR 26 : 0xfff81300 - 519424

cds8548>rdspr 27

SPR 27 : 0x00001000 4096

cds8548>





On 8/14/07, Andy Fleming <afleming@freescale.com> wrote:
>
>
> On Aug 14, 2007, at 15:21, mike zheng wrote:
>
> >
> > Hi All,
> >
> > I am trying to bring up MPC8548 CDS board on 2.4 kernel. I have
> > problem in the head_e500.S. The "mtspr SRR0, r7; mtspr SRR1 r6"
> > does not work for me. The content of R7 and R6 are not moved to
> > SRR0 and SRR1.  I am using the tool-chain from Freescale for 2.6
> > kernel.
> >
> > Any idea on this issue?
>
> Just to check...how do you know it doesn't work?
>
> Andy
>

------=_Part_5508_8130366.1187186381987
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>I use BDI to debug these two instructions. And here are the output of BDI just before the &quot;rfi&quot;. The content of R6, R7 is different from SRR0(SPR26) and SRR1(SPR27).</div>
<div>&nbsp;</div>
<div><font size="2">
<p>cds8548&gt;res run</p>
<p>- TARGET: processing user reset request</p>
<p>- BDI asserts HRESET</p>
<p>- Reset JTAG controller passed</p>
<p>- JTAG exists check passed</p>
<p>- IDCODE is 0x0003901D</p>
<p>- SVR is 0x80390011</p>
<p>- PVR is 0x80210010</p>
<p>- CCSRBAR is 0x0_ff700000</p>
<p>- BDI removes HRESET</p>
<p>- TARGET: Target PVR is 0x80210010</p>
<p>- TARGET: resetting target passed</p>
<p>cds8548&gt;halt</p>
<p>Target CPU : MPC85xx (e500v2 rev.1)</p>
<p>Target state : halted</p>
<p>Debug entry cause : COP halt</p>
<p>Current PC : 0xfff82560</p>
<p>Current CR : 0x88000042</p>
<p>Current MSR : 0x00021200</p>
<p>Current LR : 0xfff8aa4c</p>
<p>Current CCSRBAR : 0x0_e0000000</p>
<p>cds8548&gt;ci</p>
<p>cds8548&gt;bi 0x0000015c</p>
<p>Breakpoint identification is 0</p>
<p>cds8548&gt;go</p>
<p>- TARGET: stopped</p>
<p>cds8548&gt;rd</p>
<p>GPR00: 00000000 0ffabd20 00000200 00000008</p>
<p>GPR04: 00000000 00000001 00000020 00000160</p>
<p>GPR08: 1f8b0808 00000148 0ffabace 0ffe08b0</p>
<p>GPR12: 00000006 764deddb 10000300 007fff00</p>
<p>GPR16: 00000001 ffffffff 007fff25 0ffff9d8</p>
<p>GPR20: 007ffeb0 00000000 0fffaa3c 0ffae490</p>
<p>GPR24: 00000000 00000003 02000040 007fff25</p>
<p>GPR28: 007fff00 0ffab3b8 0fcd6000 007ffeb0</p>
<p>CR : 24024022 MSR: 00021200</p>
<p>cds8548&gt;rdspr 26</p>
<p>SPR 26 : 0xfff81300 - 519424</p>
<p>cds8548&gt;rdspr 27</p>
<p>SPR 27 : 0x00001000 4096</p>
<p>cds8548&gt;</p></font><br><br>&nbsp;</div><br><br>
<div><span class="gmail_quote">On 8/14/07, <b class="gmail_sendername">Andy Fleming</b> &lt;<a href="mailto:afleming@freescale.com">afleming@freescale.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br>On Aug 14, 2007, at 15:21, mike zheng wrote:<br><br>&gt;<br>&gt; Hi All,<br>&gt;<br>&gt; I am trying to bring up MPC8548 CDS board on 
2.4 kernel. I have<br>&gt; problem in the head_e500.S. The &quot;mtspr SRR0, r7; mtspr SRR1 r6&quot;<br>&gt; does not work for me. The content of R7 and R6 are not moved to<br>&gt; SRR0 and SRR1.&nbsp;&nbsp;I am using the tool-chain from Freescale for 
2.6<br>&gt; kernel.<br>&gt;<br>&gt; Any idea on this issue?<br><br>Just to check...how do you know it doesn&#39;t work?<br><br>Andy<br></blockquote></div><br>

------=_Part_5508_8130366.1187186381987--
