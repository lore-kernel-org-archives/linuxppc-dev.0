Return-Path: <atulsdeshmukh@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) by ozlabs.org (Postfix) with ESMTP id 03A59B70A5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 Aug 2010 20:11:07 +1000 (EST)
Received: by yxm8 with SMTP id 8so1664051yxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 03 Aug 2010 03:11:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20100802175952.GA27967@oksana.dev.rtsoft.ru>
References: <AANLkTi=ke8Yiy39dONFkMPpm5H8vhRy1jVyaKLuG8r4e@mail.gmail.com>
	<AANLkTikGL6LKJyWjK946enVwkUzviOsHasYbzV1Wj2LR@mail.gmail.com>
	<20100802134857.GA8689@oksana.dev.rtsoft.ru>
	<AANLkTikRq95=4Pbhne9CikR-gEHOOp7tETdV0Lnr0Chh@mail.gmail.com>
	<20100802175952.GA27967@oksana.dev.rtsoft.ru>
Date: Tue, 3 Aug 2010 15:41:05 +0530
Message-ID: <AANLkTi=sc+fZAzczZUPaJo8pi08JTDLqHPup7jy_=pMY@mail.gmail.com>
Subject: Re: Issues to access Compact Flash Card on MPC8360E
From: Atul Deshmukh <atulsdeshmukh@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=0016e6469a3a02f8a2048ce88912
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e6469a3a02f8a2048ce88912
Content-Type: text/plain; charset=ISO-8859-1

Thanks a lot Anton,

I was confused with "ata-generic" entry at pata@3.0 node.
Now the things are pretty much clear..
Earlier we thought that IORD and IOWR pins would be from GPIO, so thought
had to do bit-banging. But after going through the schematics, we come to
know that pins could be from LGPL0/1.

On Mon, Aug 2, 2010 at 11:29 PM, Anton Vorontsov <cbouatmailru@gmail.com>wrote:

> On Mon, Aug 02, 2010 at 07:44:22PM +0530, Atul Deshmukh wrote:
> > Thanks a lot Anton,
> > From the dts entry given below,
> >
> > localbus@e0005000 {
> >          #address-cells = <2>;
> >                #size-cells = <1>;
> >                compatible = "fsl,mpc8349e-localbus",
> >                             "fsl,pq2pro-localbus";
> >                reg = <0xe0005000 0xd8>;
> >                ranges = <0x3 0x0 0xf0000000 0x210>;
> >                pata@3,0 {
> >                        compatible = "fsl,mpc8349emitx-pata",
> > "ata-generic";
> >                        reg = <0x3 0x0 0x10 0x3 0x20c 0x4>;
> >                        reg-shift = <1>;
> >                        pio-mode = <6>;
> >                        interrupts = <23 0x8>;
> >                       interrupt-parent = <&ipic>;
> >                };
> >        };
> >
> >
> The driver is drivers/ata/pata_of_platform.c.
>
> > controls PCI-based IDE-controller where we can plug in our CF card...Am I
> > right???
>
> Nope, no PCI involved. CF is almost* directly connected to
> the localbus.
>
> > But in our design we don't use any controller we directly connects CF
> card
> > to local bus where UPM controls it..
>
> Yes, that's exactly how CF is done on MPC8349EmITX boards.
>
> > Can you please explain how the interface is implemented in MPC8349..
>
> Via localbus + UPM.
>
> * 'almost' is because there are some buffers and inverters, see
>  schematics:
>
> http://www.freescale.com/files/32bit/hardware_tools/schematics/MPC8349EMITXESCH.pdf
>
> --
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
>



-- 
Regards,
Atul

--0016e6469a3a02f8a2048ce88912
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Thanks a lot Anton,<br><br>I was confused with &quot;ata-generic&quot; entr=
y at pata@3.0 node.<br>Now the things are pretty much clear..<br>Earlier we=
 thought that IORD and IOWR pins would be from GPIO, so thought had to do b=
it-banging. But after going through the schematics, we come to know that pi=
ns could be from LGPL0/1.<br>
<br><div class=3D"gmail_quote">On Mon, Aug 2, 2010 at 11:29 PM, Anton Voron=
tsov <span dir=3D"ltr">&lt;<a href=3D"mailto:cbouatmailru@gmail.com">cbouat=
mailru@gmail.com</a>&gt;</span> wrote:<br><blockquote class=3D"gmail_quote"=
 style=3D"border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.=
8ex; padding-left: 1ex;">
<div class=3D"im">On Mon, Aug 02, 2010 at 07:44:22PM +0530, Atul Deshmukh w=
rote:<br>
&gt; Thanks a lot Anton,<br>
&gt; From the dts entry given below,<br>
&gt;<br>
&gt; localbus@e0005000 {<br>
&gt; =A0 =A0 =A0 =A0 =A0#address-cells =3D &lt;2&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0#size-cells =3D &lt;1&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D &quot;fsl,mpc8349e-local=
bus&quot;,<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 &quot;fsl,pq2p=
ro-localbus&quot;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D &lt;0xe0005000 0xd8&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ranges =3D &lt;0x3 0x0 0xf0000000 0x210=
&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pata@3,0 {<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0compatible =3D &quot;fs=
l,mpc8349emitx-pata&quot;,<br>
&gt; &quot;ata-generic&quot;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg =3D &lt;0x3 0x0 0x1=
0 0x3 0x20c 0x4&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0reg-shift =3D &lt;1&gt;=
;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pio-mode =3D &lt;6&gt;;=
<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0interrupts =3D &lt;23 0=
x8&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 interrupt-parent =3D &lt;&=
amp;ipic&gt;;<br>
&gt; =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0};<br>
&gt; =A0 =A0 =A0 =A0};<br>
&gt;<br>
&gt;<br></div>
The driver is drivers/ata/pata_of_platform.c.<br>
<div class=3D"im"><br>
&gt; controls PCI-based IDE-controller where we can plug in our CF card...A=
m I<br>
&gt; right???<br>
<br>
</div>Nope, no PCI involved. CF is almost* directly connected to<br>
the localbus.<br>
<div class=3D"im"><br>
&gt; But in our design we don&#39;t use any controller we directly connects=
 CF card<br>
&gt; to local bus where UPM controls it..<br>
<br>
</div>Yes, that&#39;s exactly how CF is done on MPC8349EmITX boards.<br>
<div class=3D"im"><br>
&gt; Can you please explain how the interface is implemented in MPC8349..<b=
r>
<br>
</div>Via localbus + UPM.<br>
<br>
* &#39;almost&#39; is because there are some buffers and inverters, see<br>
 =A0schematics:<br>
 =A0<a href=3D"http://www.freescale.com/files/32bit/hardware_tools/schemati=
cs/MPC8349EMITXESCH.pdf" target=3D"_blank">http://www.freescale.com/files/3=
2bit/hardware_tools/schematics/MPC8349EMITXESCH.pdf</a><br>
<font color=3D"#888888"><br>
--<br>
</font><div><div></div><div class=3D"h5">Anton Vorontsov<br>
email: <a href=3D"mailto:cbouatmailru@gmail.com">cbouatmailru@gmail.com</a>=
<br>
irc://<a href=3D"http://irc.freenode.net/bd2" target=3D"_blank">irc.freenod=
e.net/bd2</a><br>
</div></div></blockquote></div><br><br clear=3D"all"><br>-- <br>Regards,<br=
>Atul <br><br>=A0 <br>

--0016e6469a3a02f8a2048ce88912--
