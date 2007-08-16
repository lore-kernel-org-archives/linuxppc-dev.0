Return-Path: <mail4mz@gmail.com>
Received: from rv-out-0910.google.com (rv-out-0910.google.com [209.85.198.184])
	by ozlabs.org (Postfix) with ESMTP id 4B0A6DDDE7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Aug 2007 00:37:49 +1000 (EST)
Received: by rv-out-0910.google.com with SMTP id c27so400724rvf
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Aug 2007 07:37:47 -0700 (PDT)
Message-ID: <5c9cd53b0708160737u5dc174a0q9433a6e4d2ee0afd@mail.gmail.com>
Date: Thu, 16 Aug 2007 10:37:47 -0400
From: "mike zheng" <mail4mz@gmail.com>
To: "Andy Fleming" <afleming@freescale.com>
Subject: Re: System crash on boot_e500.S on 2.4Kernel
In-Reply-To: <8513767D-F467-49EA-816B-48567E13F56D@freescale.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_6720_16311599.1187275067592"
References: <5c9cd53b0708141321h62f0ddd1k3a57a37f52e93894@mail.gmail.com>
	<36201C92-F117-4273-9FA7-13665CF0C6DB@freescale.com>
	<5c9cd53b0708150659u2ba88a9as5055b42fb1e2be67@mail.gmail.com>
	<FC996AA4-4C5F-4B36-A9E9-5F931D054F1C@freescale.com>
	<5c9cd53b0708151412v2f5feb74v9e0b49d114b83021@mail.gmail.com>
	<DF88391F-F3B9-4DDB-8A27-F610E931AFB7@freescale.com>
	<5c9cd53b0708151546y18714a46i785cdb5f23ef1536@mail.gmail.com>
	<8513767D-F467-49EA-816B-48567E13F56D@freescale.com>
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

------=_Part_6720_16311599.1187275067592
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 8/15/07, Andy Fleming <afleming@freescale.com> wrote:
>
>
> On Aug 15, 2007, at 17:46, mike zheng wrote:
>
> > Hi Andy,
> >
> > Here is BDI output of the register value after line 212. The value
> > of R6, R7 is 0x20, 0x160. However the value of SRR0(SPR26), SRR1
> > (SPR27) is 0xfff81300 and 0x00001000. Why are they different from
> > r7 and r6? We just did the mtspr, the value should be the same. The
> > rfi jump to 0xfff81300 is because of the value in SRR0.
>
>
> Yes, it's very strange.  But it's also pretty much impossible for the
> mtspr to just fail like that.  A more likely scenario is that the BDI
> is getting bad information.  Could you take a look at your IVORs?
> I'm very curious to see if fff81300 is an interrupt vector.


Now I know the BDI need debug vector to be set properly. I manually change
the IVPR and IVOR15 for BDI, and will update you the progress.

Andy
>

------=_Part_6720_16311599.1187275067592
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br>
<div><span class="gmail_quote">On 8/15/07, <b class="gmail_sendername">Andy Fleming</b> &lt;<a href="mailto:afleming@freescale.com">afleming@freescale.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid"><br>On Aug 15, 2007, at 17:46, mike zheng wrote:<br><br>&gt; Hi Andy,<br>&gt;<br>&gt; Here is BDI output of the register value after line 212. The value
<br>&gt; of R6, R7 is 0x20, 0x160. However the value of SRR0(SPR26), SRR1<br>&gt; (SPR27) is 0xfff81300 and 0x00001000. Why are they different from<br>&gt; r7 and r6? We just did the mtspr, the value should be the same. The
<br>&gt; rfi jump to 0xfff81300 is because of the value in SRR0.<br><br><br>Yes, it&#39;s very strange.&nbsp;&nbsp;But it&#39;s also pretty much impossible for the<br>mtspr to just fail like that.&nbsp;&nbsp;A more likely scenario is that the BDI
<br>is getting bad information.&nbsp;&nbsp;Could you take a look at your IVORs?<br>I&#39;m very curious to see if fff81300 is an interrupt vector.</blockquote>
<div>&nbsp;</div>
<div>Now I know the BDI need debug vector to be set properly. I manually change the IVPR and IVOR15 for BDI, and will update you the progress.</div><br>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">Andy<br></blockquote></div><br>

------=_Part_6720_16311599.1187275067592--
