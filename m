Return-Path: <adish.kuvelker@gmail.com>
Received: from mail-fx0-f161.google.com (mail-fx0-f161.google.com
	[209.85.220.161]) by ozlabs.org (Postfix) with ESMTP id BCF1BDDF3D
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 23:52:18 +1100 (EST)
Received: by fxm5 with SMTP id 5so11897854fxm.9
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 04:52:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <d9c5f2890902250439u58c819a5pbd4a1bdda11d1dc4@mail.gmail.com>
References: <d9c5f2890902250115s3867904fj22e8f5af2d469581@mail.gmail.com>
	<200902251327.02082.sr@denx.de>
	<d9c5f2890902250439u58c819a5pbd4a1bdda11d1dc4@mail.gmail.com>
Date: Wed, 25 Feb 2009 18:15:15 +0530
Message-ID: <d9c5f2890902250445j784bc66fp605740e86647ca12@mail.gmail.com>
Subject: Re: PPC 405 EX USB Development
From: Adish Kuvelker <adish.kuvelker@gmail.com>
To: Stefan Roese <sr@denx.de>
Content-Type: multipart/alternative; boundary=0016e6de005e7be7cf0463bd9b51
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0016e6de005e7be7cf0463bd9b51
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi Stefan,

Also in the SETUP stage where I have set my packet size as 1, as I treat
each of this 3 stages (SETUP, DATA and STATUS) as three different
stages/transactions,  I find that the "Non-Periodic Transmit FIFO/Queue
Status Register" read as soon as I write to the "Non-Periodic Transmit FIFO
Size Register" as "0x10500fa". Before writing the value is "0x80100". Is it
fine that the bit 7 which defines the termination of channel a right thing
to happen? Secondly since i am writing 2 bytes to the FIFO why should the
"Non-periodic TxFIFO Space Avail (NPTxFSpcAvail)" bits of USB0_GNPTXSTS be
0xfa?

The FIFO to which I write:
*USB0_GRXFSIZ - 0x213            USB0_GNPTXFSIZ - 0x1000213*
The above setting mean that my Non-Periodic Transmit register starts at
0x213. So I write my data (8 byte SETUP Token Data) in the following way:
-    Write the first 4 bytes to the starting adress of  0x1000 since I am
using Channel 0  --- (*(volatile unsigned  *)(DHc->base + 0x1000 + (bEnd *
0x1000) + 0x213 + fifo_address_offset))=*((volatile       unsigned
*)pSrcBuf);
-   Then increment the "fifo_adress_offset" by 4 and write the next 4 bytes.


I think that there is some problem in the SETUP (Token) Stage. Can you
please pass any pointers over this?

Regards;
Aadish

On Wed, Feb 25, 2009 at 6:09 PM, Adish Kuvelker <adish.kuvelker@gmail.com>wrote:

> Hi Stefan,
>
> I am working on the internal OTG controller. The synopsys DWC.
>
> Regards;
> Aadish
>
>
> On Wed, Feb 25, 2009 at 5:57 PM, Stefan Roese <sr@denx.de> wrote:
>
>> On Wednesday 25 February 2009, Adish Kuvelker wrote:
>> > I am developing a Host Controller Driver for the PPC405EX based board. I
>> > have a OTG controller on it, which I have to configure as Host
>> Controller
>> > and thus I am witting a HCD for the same. I am stuck at the Control
>> stage
>> > wherein although my SETUP stage seems to be going through I get a STALL.
>> >
>> > Can anyone help me in this regard as to where would I get a reference
>> code
>> > for this?
>>
>> Are you talking about the 405EX internal USB OTG controller (Synopsys DWC)
>> or
>> some other OTG controller?
>>
>> Best regards,
>> Stefan
>>
>
>

--0016e6de005e7be7cf0463bd9b51
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Stefan,<br><br>Also in the SETUP stage where I have set my packet size a=
s 1, as I treat=20
each of this 3 stages (SETUP, DATA and STATUS) as three different=20
stages/transactions,=A0 I find that the &quot;Non-Periodic Transmit FIFO/Qu=
eue=20
Status Register&quot; read as soon as I write to the &quot;Non-Periodic Tra=
nsmit=20
FIFO Size Register&quot; as &quot;0x10500fa&quot;. Before writing the value=
 is=20
&quot;0x80100&quot;. Is it fine that the bit 7 which defines the terminatio=
n=20
of channel a right thing to happen?
Secondly since i am writing 2 bytes to the FIFO why should the &quot;Non-pe=
riodic TxFIFO Space Avail (NPTxFSpcAvail)&quot; bits of USB0_GNPTXSTS be 0x=
fa?<br>
<br>The FIFO to which I write:
<br>*USB0_GRXFSIZ - 0x213=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 USB0_GNPTXFSIZ -=
 0x1000213*
<br>The above setting mean that my Non-Periodic Transmit register starts at=
=20
0x213. So I write my data (8 byte SETUP Token Data) in the following way:
<br>-=A0=A0=A0 Write the first 4 bytes to the starting adress of=A0 0x1000 =
since I=20
am using Channel 0=A0 --- (*(volatile unsigned=A0 *)(DHc-&gt;base + 0x1000 =
+=20
(bEnd * 0x1000) + 0x213 + fifo_address_offset))=3D*((volatile=A0=A0=A0=A0=
=A0=A0=20
unsigned *)pSrcBuf);
<br>-=A0=A0 Then increment the &quot;fifo_adress_offset&quot; by 4 and writ=
e the next 4 bytes.
<br>
<br>I think that there is some problem in the SETUP (Token) Stage. Can you=
=20
please pass any pointers over this?<br><br>Regards;<br>Aadish<br><br><div c=
lass=3D"gmail_quote">On Wed, Feb 25, 2009 at 6:09 PM, Adish Kuvelker <span =
dir=3D"ltr">&lt;<a href=3D"mailto:adish.kuvelker@gmail.com">adish.kuvelker@=
gmail.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Hi Stefan,<br><br=
>I am working on the internal OTG controller. The synopsys DWC.<br><br>Rega=
rds;<br>
Aadish<div><div></div><div class=3D"Wj3C7c"><br><br><div class=3D"gmail_quo=
te">On Wed, Feb 25, 2009 at 5:57 PM, Stefan Roese <span dir=3D"ltr">&lt;<a =
href=3D"mailto:sr@denx.de" target=3D"_blank">sr@denx.de</a>&gt;</span> wrot=
e:<br>

<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div><div></div><=
div>On Wednesday 25 February 2009, Adish Kuvelker wrote:<br>

&gt; I am developing a Host Controller Driver for the PPC405EX based board.=
 I<br>
&gt; have a OTG controller on it, which I have to configure as Host Control=
ler<br>
&gt; and thus I am witting a HCD for the same. I am stuck at the Control st=
age<br>
&gt; wherein although my SETUP stage seems to be going through I get a STAL=
L.<br>
&gt;<br>
&gt; Can anyone help me in this regard as to where would I get a reference =
code<br>
&gt; for this?<br>
<br>
</div></div>Are you talking about the 405EX internal USB OTG controller (Sy=
nopsys DWC) or<br>
some other OTG controller?<br>
<br>
Best regards,<br>
<font color=3D"#888888">Stefan<br>
</font></blockquote></div><br>
</div></div></blockquote></div><br>

--0016e6de005e7be7cf0463bd9b51--
