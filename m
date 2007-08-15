Return-Path: <mail4mz@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.191])
	by ozlabs.org (Postfix) with ESMTP id 76FD8DDE2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Aug 2007 08:46:27 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so258454rvf
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Aug 2007 15:46:26 -0700 (PDT)
Message-ID: <5c9cd53b0708151546y18714a46i785cdb5f23ef1536@mail.gmail.com>
Date: Wed, 15 Aug 2007 18:46:26 -0400
From: "mike zheng" <mail4mz@gmail.com>
To: "Andy Fleming" <afleming@freescale.com>
Subject: Re: System crash on boot_e500.S on 2.4Kernel
In-Reply-To: <DF88391F-F3B9-4DDB-8A27-F610E931AFB7@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6024_16554068.1187217986404"
References: <5c9cd53b0708141321h62f0ddd1k3a57a37f52e93894@mail.gmail.com>
	<36201C92-F117-4273-9FA7-13665CF0C6DB@freescale.com>
	<5c9cd53b0708150659u2ba88a9as5055b42fb1e2be67@mail.gmail.com>
	<FC996AA4-4C5F-4B36-A9E9-5F931D054F1C@freescale.com>
	<5c9cd53b0708151412v2f5feb74v9e0b49d114b83021@mail.gmail.com>
	<DF88391F-F3B9-4DDB-8A27-F610E931AFB7@freescale.com>
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

------=_Part_6024_16554068.1187217986404
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Andy,

Here is BDI output of the register value after line 212. The value of R6, R7
is 0x20, 0x160. However the value of SRR0(SPR26), SRR1(SPR27) is 0xfff81300
and 0x00001000. Why are they different from r7 and r6? We just did the
mtspr, the value should be the same. The rfi jump to 0xfff81300 is because
of the value in SRR0.


211  mtspr SRR0, r7
212  mtspr SRR1, r6
213  rfi
214
215   /*4. Clear out PIDs & Search info */
216   li r6, 0


BDI output:

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



On 8/15/07, Andy Fleming <afleming@freescale.com> wrote:
>
>
> On Aug 15, 2007, at 16:12, mike zheng wrote:
>
> > Here is the PC value before the rfi:
> >
> > cds8458>halt
> >            Target CPU:           : MPC85xx (e500v2 rev.1)
> >            Target state            : halted
> >            Debug entry cause  : instruction breakpoint
> >            Current PC             : 0x0000015c
> >            Current CR             : 0x24024022
> >            Current MSR          : 0x00012100
> >            Current LR              :0x00000148
> >            Current CCSRBAR  :0x0_e000000
> >
> > After the rfi:
> >
> > #step timeout defected
> > cds8458>halt
> >            Target CPU:           : MPC85xx (e500v2 rev.1)
> >            Target state            : halted
> >            Debug entry cause  : COP halt
> >            Current PC             : 0xfff81300
> >            Current CR             : 0x24024022
> >            Current MSR          : 0x00001000
> >            Current LR              :0x00000148
> >            Current CCSRBAR  :0x0_e000000
>
> Ok, I'm sure your problem isn't that SRR0 isn't getting updated
> properly.  I suspect something is going wrong during the rfi.
> Possibly something in your TLBs.  However, what is happening is most
> likely that you have hit an exception, and SRR0 and SRR1 have been
> updated.  I'm a little confused by the addresses where you first
> invoke "halt".  It looks like you're in the middle of flash, which is
> an odd place in u-boot to be.


The first halt is at 0x0000015c, which is the break point I set after line
212. It is in the memory, not flash.

And if you look at your PC, it doesn't seem like you step.  It looks
> like something goes wrong with the debugging.  My suggestion is to
> check your TLB setup and your IVOR setup.  Find out if the IVORs are
> pointing at an exception at fff81300.


All the TLB and IVOR setup is from Uboot, the kernel haven't touched them
yet.

Andy
>

------=_Part_6024_16554068.1187217986404
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Andy,</div>
<div>&nbsp;</div>
<div>Here is BDI output of the register value after line 212. The value of R6, R7 is 0x20, 0x160. However the value of SRR0(SPR26), SRR1(SPR27) is 0xfff81300 and 0x00001000. Why are they different from r7 and r6? We just did the mtspr, the value should be the same. The rfi jump to 0xfff81300 is because of the value in SRR0.
</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>211 &nbsp;mtspr SRR0, r7&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; </div>
<div>212&nbsp; mtspr SRR1, r6</div>
<div>213&nbsp; rfi</div>
<div>214 </div>
<div>215&nbsp;&nbsp; /*4. Clear out PIDs &amp; Search info */</div>
<div>216&nbsp;&nbsp; li r6, 0</div>
<div><br>&nbsp;</div>
<div>BDI output:</div>
<div>
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
<p>cds8548&gt;</p><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 8/15/07, <b class="gmail_sendername">Andy Fleming</b> &lt;<a href="mailto:afleming@freescale.com">afleming@freescale.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br>On Aug 15, 2007, at 16:12, mike zheng wrote:<br><br>&gt; Here is the PC value before the rfi:<br>&gt;<br>
&gt; cds8458&gt;halt<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Target CPU:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : MPC85xx (e500v2 rev.1)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Target state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: halted<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Debug entry cause&nbsp;&nbsp;: instruction breakpoint<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current PC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x0000015c
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current CR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x24024022<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current MSR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: 0x00012100<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current LR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:0x00000148<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current CCSRBAR&nbsp;&nbsp;:0x0_e000000<br>&gt;<br>
&gt; After the rfi:<br>&gt;<br>&gt; #step timeout defected<br>&gt; cds8458&gt;halt<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Target CPU:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : MPC85xx (e500v2 rev.1)<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Target state&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: halted<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Debug entry cause&nbsp;&nbsp;: COP halt
<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current PC&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0xfff81300<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current CR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; : 0x24024022<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current MSR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;: 0x00001000<br>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current LR&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;:0x00000148<br>
&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Current CCSRBAR&nbsp;&nbsp;:0x0_e000000<br><br>Ok, I&#39;m sure your problem isn&#39;t that SRR0 isn&#39;t getting updated<br>properly.&nbsp;&nbsp;I suspect something is going wrong during the rfi.<br>Possibly something in your TLBs.&nbsp;&nbsp;However, what is happening is most
<br>likely that you have hit an exception, and SRR0 and SRR1 have been<br>updated.&nbsp;&nbsp;I&#39;m a little confused by the addresses where you first<br>invoke &quot;halt&quot;.&nbsp;&nbsp;It looks like you&#39;re in the middle of flash, which is
<br>an odd place in u-boot to be.</blockquote>
<div>&nbsp;</div>
<div>The first halt is at 0x0000015c, which is the break point I set after line 212. It is in the memory, not flash.</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">And if you look at your PC, it doesn&#39;t seem like you step.&nbsp;&nbsp;It looks<br>like something goes wrong with the debugging.&nbsp;&nbsp;My suggestion is to
<br>check your TLB setup and your IVOR setup.&nbsp;&nbsp;Find out if the IVORs are<br>pointing at an exception at fff81300.</blockquote>
<div>&nbsp;</div>
<div>All the TLB and IVOR setup is from Uboot, the kernel haven&#39;t touched them yet.</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Andy<br></blockquote></div><br>

------=_Part_6024_16554068.1187217986404--
