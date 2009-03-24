Return-Path: <johns.daniel@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.250])
	by ozlabs.org (Postfix) with ESMTP id CDADEDDF55
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 08:22:16 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c38so1753814ana.39
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 14:22:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <651BE815-4BF6-4AA3-AA43-C0B7C98A0FCC@kernel.crashing.org>
References: <ba5d9360903241324n57aa74caq2dd2bcdd2a885e19@mail.gmail.com>
	<651BE815-4BF6-4AA3-AA43-C0B7C98A0FCC@kernel.crashing.org>
Date: Tue, 24 Mar 2009 16:13:55 -0500
Message-ID: <ba5d9360903241413u47a199d4kbde3ed9af238a916@mail.gmail.com>
Subject: Re: PCIe interrupts in the device tree
From: Johns Daniel <johns.daniel@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: multipart/alternative; boundary=0016e644d6f6553dce0465e3dc66
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--0016e644d6f6553dce0465e3dc66
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

On Tue, Mar 24, 2009 at 3:54 PM, Kumar Gala <galak@kernel.crashing.org>wrote:

>
> On Mar 24, 2009, at 3:24 PM, Johns Daniel wrote:
>
>  Could somebody please explain the declaration of the PCIe interrupts
>> in the device tree?
>>
>> I was under the impression that PCIe interrupts in the PowerPC Linux
>> kernel default to using INTx signaling (vs. external IRQ pin assertion
>> and MSI signaling). Am I right?
>>
>> If so, then do the interrupt-map lines in the DTS refer to the
>> internal IRQ used by Freescale processors to implement INTx virtual
>> wire interrupts?
>>
>> For example, in the mpc8536ds.dts file, under "pci1: pcie@ffe09000" we
>> have:
>>                interrupt-map = <
>>                        /* IDSEL 0x0 */
>>                        0000 0 0 1 &mpic 4 1
>>                        0000 0 0 2 &mpic 5 1
>>                        0000 0 0 3 &mpic 6 1
>>                        0000 0 0 4 &mpic 7 1
>>                        >;
>> Are the 4, 5, 6, and 7 internal or external IRQs?
>>
>
> The .dts and linux make no distinction between internal & external IRQs.
>  This is a silly artifact of Freescale UMs.  IRQ 0 starts at offset 0x50000
> and each 0x20 offset is another IRQ.  So typically External 0 == IRQ0,
> Internal 0 == IRQ16.
>
> So this says that Ext 4, 5, 6, 7 and wired to INTA, INTB, INTC, INTD for
> this particular PCIe controller.
>

When you say "wired", do you mean hard-wired?
If so, how would you specify and use INTx message interrupts?


>
>
>  And the "msi@41600" section in the same mpc8536ds.dts file does NOT
>> affect PCIe interrupts unless a driver calls pci_enable_msi()?
>>
>
> correct.
>
> - k
>

--0016e644d6f6553dce0465e3dc66
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<br><div class=3D"gmail_quote">On Tue, Mar 24, 2009 at 3:54 PM, Kumar Gala =
<span dir=3D"ltr">&lt;<a href=3D"mailto:galak@kernel.crashing.org">galak@ke=
rnel.crashing.org</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote=
" style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0=
.8ex; padding-left: 1ex;">
<div class=3D"im"><br>
On Mar 24, 2009, at 3:24 PM, Johns Daniel wrote:<br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Could somebody please explain the declaration of the PCIe interrupts<br>
in the device tree?<br>
<br>
I was under the impression that PCIe interrupts in the PowerPC Linux<br>
kernel default to using INTx signaling (vs. external IRQ pin assertion<br>
and MSI signaling). Am I right?<br>
<br>
If so, then do the interrupt-map lines in the DTS refer to the<br>
internal IRQ used by Freescale processors to implement INTx virtual<br>
wire interrupts?<br>
<br>
For example, in the mpc8536ds.dts file, under &quot;pci1: pcie@ffe09000&quo=
t; we have:<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupt-map =3D &lt;<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* IDSEL 0x0 */<br>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00000 0 0 1 &amp;mpic 4 1<br=
>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00000 0 0 2 &amp;mpic 5 1<br=
>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00000 0 0 3 &amp;mpic 6 1<br=
>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00000 0 0 4 &amp;mpic 7 1<br=
>
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&gt;;<br>
Are the 4, 5, 6, and 7 internal or external IRQs?<br>
</blockquote>
<br></div>
The .dts and linux make no distinction between internal &amp; external IRQs=
. =A0This is a silly artifact of Freescale UMs. =A0IRQ 0 starts at offset 0=
x50000 and each 0x20 offset is another IRQ. =A0So typically External 0 =3D=
=3D IRQ0, Internal 0 =3D=3D IRQ16.<br>

<br>
So this says that Ext 4, 5, 6, 7 and wired to INTA, INTB, INTC, INTD for th=
is particular PCIe controller.<div class=3D"im"></div></blockquote><div><br=
>When you say &quot;wired&quot;, do you mean hard-wired?<br>If so, how woul=
d you specify and use INTx message interrupts?<br>
=A0<br></div><blockquote class=3D"gmail_quote" style=3D"border-left: 1px so=
lid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;"><div=
 class=3D"im"><br>
<br>
<blockquote class=3D"gmail_quote" style=3D"border-left: 1px solid rgb(204, =
204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
And the &quot;msi@41600&quot; section in the same mpc8536ds.dts file does N=
OT<br>
affect PCIe interrupts unless a driver calls pci_enable_msi()?<br>
</blockquote>
<br></div>
correct.<br><font color=3D"#888888">
<br>
- k<br>
</font></blockquote></div><br>

--0016e644d6f6553dce0465e3dc66--
