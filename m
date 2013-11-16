Return-Path: <neorf3k@gmail.com>
Received: from mail-ea0-x231.google.com (mail-ea0-x231.google.com
 [IPv6:2a00:1450:4013:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EF7942C00C3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Nov 2013 02:11:19 +1100 (EST)
Received: by mail-ea0-f177.google.com with SMTP id n15so159594ead.8
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Nov 2013 07:11:14 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_539C892B-5880-4FDB-9488-089CDC377192"
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: Problem reading and programming memory location...
From: neorf3k <neorf3k@gmail.com>
In-Reply-To: <20131116152933.276f9939@crub>
Date: Sat, 16 Nov 2013 16:11:10 +0100
Message-Id: <21E5D9F6-3B8E-45FE-8144-0CEFAE8F5371@gmail.com>
References: <985685C7-0122-4D45-96D1-4412E9774A5D@gmail.com>
 <20131113083259.1b69ed18@crub>
 <50EBA514-5BB1-40B3-B27B-309A829D2E05@gmail.com>
 <20131113190606.2a5d08fb@crub>
 <5DC55309-D920-44CE-8F89-AB7FA6BD383A@gmail.com>
 <20131114100917.31f674d7@crub>
 <51E043E6-19FB-4655-9B3C-3B81F868DC47@gmail.com>
 <20131116152933.276f9939@crub>
To: Anatolij Gustschin <agust@denx.de>
Cc: Linux Ppc Dev List Dev List <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--Apple-Mail=_539C892B-5880-4FDB-9488-089CDC377192
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hi Anatolij,
thank you so much for you answer=85 monday i=92ll test=85=20
i answer you just to complete the information:
we are using an mpc5200b and the details for that reg located at: =
0x10020000 are:

Chip select 4 specification:
Lp_cs4
bus size: 8 bit
bus control: 2 wait state R/W ACK disabled
size allocated: 4 KByte

Our Register 8 bit LP_cs4 (we want to write)

cs4 offset: 0x001

Thank you again..

Lorenzo

On 16/nov/2013, at 03:29 PM, Anatolij Gustschin <agust@denx.de> wrote:

> Hi Lorenzo,
>=20
> see my comments below.
>=20
> On Fri, 15 Nov 2013 17:27:30 +0100
> neorf3k <neorf3k@gmail.com> wrote:
>=20
>> Hello again, I=92ve tried this code, but we are not able to
>> change cs4 reg value=85 what could be?
>>=20
>> =97
>>=20
>> #define MALab_DEVICE_NAME	"MALab"
>> #define MPC5xxx_MM_CS4_START	(MBAR_BASE + 0x0024)
>> #define MPC5xxx_MM_CS4_STOP	(MBAR_BASE + 0x0028)
>> #define MPC5xxx_MM_IPBI	 (MBAR_BASE + 0x0054)
>>=20
>> #define MALab_MM_START	 0x10020000U
>> #define MALab_MM_END	 0x10020FFFU
>=20
> Please change MALab_MM_END to 0x10030000U.
>=20
>> #define MALab_MM_SIZE	 0x00001000U
>>=20
>> int init_module(void) { ...
>>    u16 cs4_start_value;
>>    u16 cs4_stop_value;
>>    u32 cs4_enable_value;
>>=20
>>    u8 rvoice_ioaddr_value;
>>=20
>>=20
>>    // reserve a page of memory for our hardware /proc/iomem
>>    if ( check_region(MALab_MM_START,MALab_MM_SIZE) ) {
>>        printk (KERN_ALERT "LED init_module: memory already in =
use\n");
>>        return -EBUSY;
>>    }
>>=20
>>=20
>>    =
request_mem_region(MALab_MM_START,MALab_MM_SIZE,MALab_DEVICE_NAME);
>>=20
>>=20
>>    void __iomem *cs0_reg   =3D ioremap ((volatile unsigned =
long)(MBAR_BASE + 0x0300), 4);
>>    void __iomem *cs3_reg   =3D ioremap ((volatile unsigned =
long)(MBAR_BASE + 0x030C), 4);
>>=20
>>    void __iomem *ipbi_cr =3D ioremap ((volatile unsigned =
long)(MPC5xxx_MM_IPBI), 4);
>>    void __iomem *cs4_start  =3D ioremap ((volatile unsigned =
long)(MPC5xxx_MM_CS4_START + 2), 2);
>>    void __iomem *cs4_stop   =3D ioremap ((volatile unsigned =
long)(MPC5xxx_MM_CS4_STOP + 2), 2);
>>=20
>>    void __iomem *cs4_enable   =3D ioremap ((volatile unsigned =
long)(MBAR_BASE + 0x0310), 4);
>>    void __iomem *cs_ctrl_reg   =3D ioremap ((volatile unsigned =
long)(MBAR_BASE + 0x0318), 4);
>=20
>=20
> this might work, but this is not how ioremap() supposed to be used.
> The mapping is done in 4k-page granularity, so it would be better
> to just map the internal register range my one ioremap() call, i.e.
>=20
>    reg_base =3D ioremap(MBAR_BASE, 0x400);
>=20
> and then to calculate the register offsets, i.e.
>=20
>   cs0_reg =3D reg_base + 0x0300;
>   cs0_reg =3D reg_base + 0x030C;
>   ...
>   ipbi_cr =3D reg_base + 0x0054;
>   cs4_start =3D reg_base + 0x0026;
>   cs4_stop =3D reg_base + 0x002a;
>   ...
>=20
> For FPGA mapping you need a separate ioremap() call of course.
>=20
>>    void __iomem *rvoice_ioaddr   =3D ioremap ((volatile unsigned =
long)(MALab_MM_START), MALab_MM_SIZE);
>>=20
>>    //disable CSO
>>=20
>>    out_be32(cs0_reg, 0x0004ed00);
>>=20
>>=20
>>    //disable CS3
>>=20
>>    out_be32(cs3_reg, 0x0002cf00);
>>=20
>>    // enable LocalBus chip select CS4
>>    out_be32(ipbi_cr, 0x00290001);
>=20
> The comment and the code doesn't match here, the code disables
> CS4 to configure the its range, so the comment is confusing.
>=20
>>    cs4_start_value=3Din_be16(cs4_start);
>>    cs4_start_value=3DMALab_MM_START >>16;
>>    out_be16(cs4_start, cs4_start_value);
>>    cs4_stop_value=3Din_be16(cs4_stop);
>>    cs4_stop_value=3DMALab_MM_END >>16;
>>    out_be16(cs4_stop, cs4_stop_value);
>=20
> Here is the problem. The _minimal_ chip select range _must_
> be 64 KiB, otherwise the register access can't work. Your
> current chip select 4 range is less then 1 KiB:
>=20
>  0x10020FFF - 0x10020000 =3D 0xFFF
>=20
> Since you right-shift the start and stop values by 16,
> the chip select start and stop registers are both 0x1002.
> The resulting chip select address range is 0. Therefore
> please set MALab_MM_END value to 0x10030000.
>=20
> Thanks,
> Anatolij


--Apple-Mail=_539C892B-5880-4FDB-9488-089CDC377192
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html =
charset=3Dwindows-1252"></head><body style=3D"word-wrap: break-word; =
-webkit-nbsp-mode: space; -webkit-line-break: after-white-space;">Hi =
Anatolij,<div>thank you so much for you answer=85 monday i=92ll =
test=85&nbsp;</div><div>i answer you just to complete the =
information:</div><div>we are using an mpc5200b and the details for that =
reg located at: 0x10020000 are:</div><div><br></div><div><div>Chip =
select 4 specification:</div><div>Lp_cs4</div><div>bus size: 8 =
bit</div><div>bus control: 2 wait state R/W ACK disabled</div><div>size =
allocated: 4 KByte</div><div><br></div><div>Our Register 8 bit LP_cs4 =
(we want to write)</div><div><br></div><div>cs4 offset: =
0x001</div><div><br></div><div>Thank you =
again..</div><div><br></div><div>Lorenzo</div><div><br></div><div><div>On =
16/nov/2013, at 03:29 PM, Anatolij Gustschin &lt;<a =
href=3D"mailto:agust@denx.de">agust@denx.de</a>&gt; wrote:</div><br =
class=3D"Apple-interchange-newline"><blockquote type=3D"cite"><div =
style=3D"font-size: 12px; font-style: normal; font-variant: normal; =
font-weight: normal; letter-spacing: normal; line-height: normal; =
orphans: auto; text-align: start; text-indent: 0px; text-transform: =
none; white-space: normal; widows: auto; word-spacing: 0px; =
-webkit-text-stroke-width: 0px;">Hi Lorenzo,<br><br>see my comments =
below.<br><br>On Fri, 15 Nov 2013 17:27:30 +0100<br>neorf3k &lt;<a =
href=3D"mailto:neorf3k@gmail.com">neorf3k@gmail.com</a>&gt; =
wrote:<br><br><blockquote type=3D"cite">Hello again, I=92ve tried this =
code, but we are not able to<br>change cs4 reg value=85 what could =
be?<br><br>=97<br><br>#define MALab_DEVICE_NAME<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>"MALab"<br>#define MPC5xxx_MM_CS4_START<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>(MBAR_BASE + 0x0024)<br>#define MPC5xxx_MM_CS4_STOP<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span>(MBAR_BASE + 0x0028)<br>#define MPC5xxx_MM_IPBI<span =
class=3D"Apple-tab-span" style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>(MBAR_BASE + =
0x0054)<br><br>#define MALab_MM_START<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>0x10020000U<br>#define =
MALab_MM_END<span class=3D"Apple-tab-span" style=3D"white-space: pre;">	=
</span><span =
class=3D"Apple-converted-space">&nbsp;</span>0x10020FFFU<br></blockquote><=
br>Please change MALab_MM_END to 0x10030000U.<br><br><blockquote =
type=3D"cite">#define MALab_MM_SIZE<span class=3D"Apple-tab-span" =
style=3D"white-space: pre;">	</span><span =
class=3D"Apple-converted-space">&nbsp;</span>0x00001000U<br><br>int =
init_module(void) { ...<br>&nbsp;&nbsp;&nbsp;u16 =
cs4_start_value;<br>&nbsp;&nbsp;&nbsp;u16 =
cs4_stop_value;<br>&nbsp;&nbsp;&nbsp;u32 =
cs4_enable_value;<br><br>&nbsp;&nbsp;&nbsp;u8 =
rvoice_ioaddr_value;<br><br><br>&nbsp;&nbsp;&nbsp;// reserve a page of =
memory for our hardware /proc/iomem<br>&nbsp;&nbsp;&nbsp;if ( =
check_region(MALab_MM_START,MALab_MM_SIZE) ) =
{<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printk (KERN_ALERT "LED =
init_module: memory already in =
use\n");<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;return =
-EBUSY;<br>&nbsp;&nbsp;&nbsp;}<br><br><br>&nbsp;&nbsp;&nbsp;request_mem_re=
gion(MALab_MM_START,MALab_MM_SIZE,MALab_DEVICE_NAME);<br><br><br>&nbsp;&nb=
sp;&nbsp;void __iomem *cs0_reg &nbsp;&nbsp;=3D ioremap ((volatile =
unsigned long)(MBAR_BASE + 0x0300), 4);<br>&nbsp;&nbsp;&nbsp;void =
__iomem *cs3_reg &nbsp;&nbsp;=3D ioremap ((volatile unsigned =
long)(MBAR_BASE + 0x030C), 4);<br><br>&nbsp;&nbsp;&nbsp;void __iomem =
*ipbi_cr =3D ioremap ((volatile unsigned long)(MPC5xxx_MM_IPBI), =
4);<br>&nbsp;&nbsp;&nbsp;void __iomem *cs4_start &nbsp;=3D ioremap =
((volatile unsigned long)(MPC5xxx_MM_CS4_START + 2), =
2);<br>&nbsp;&nbsp;&nbsp;void __iomem *cs4_stop &nbsp;&nbsp;=3D ioremap =
((volatile unsigned long)(MPC5xxx_MM_CS4_STOP + 2), =
2);<br><br>&nbsp;&nbsp;&nbsp;void __iomem *cs4_enable &nbsp;&nbsp;=3D =
ioremap ((volatile unsigned long)(MBAR_BASE + 0x0310), =
4);<br>&nbsp;&nbsp;&nbsp;void __iomem *cs_ctrl_reg &nbsp;&nbsp;=3D =
ioremap ((volatile unsigned long)(MBAR_BASE + 0x0318), =
4);<br></blockquote><br><br>this might work, but this is not how =
ioremap() supposed to be used.<br>The mapping is done in 4k-page =
granularity, so it would be better<br>to just map the internal register =
range my one ioremap() call, i.e.<br><br>&nbsp;&nbsp;&nbsp;reg_base =3D =
ioremap(MBAR_BASE, 0x400);<br><br>and then to calculate the register =
offsets, i.e.<br><br>&nbsp;&nbsp;cs0_reg =3D reg_base + =
0x0300;<br>&nbsp;&nbsp;cs0_reg =3D reg_base + =
0x030C;<br>&nbsp;&nbsp;...<br>&nbsp;&nbsp;ipbi_cr =3D reg_base + =
0x0054;<br>&nbsp;&nbsp;cs4_start =3D reg_base + =
0x0026;<br>&nbsp;&nbsp;cs4_stop =3D reg_base + =
0x002a;<br>&nbsp;&nbsp;...<br><br>For FPGA mapping you need a separate =
ioremap() call of course.<br><br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;void __iomem *rvoice_ioaddr =
&nbsp;&nbsp;=3D ioremap ((volatile unsigned long)(MALab_MM_START), =
MALab_MM_SIZE);<br><br>&nbsp;&nbsp;&nbsp;//disable =
CSO<br><br>&nbsp;&nbsp;&nbsp;out_be32(cs0_reg, =
0x0004ed00);<br><br><br>&nbsp;&nbsp;&nbsp;//disable =
CS3<br><br>&nbsp;&nbsp;&nbsp;out_be32(cs3_reg, =
0x0002cf00);<br><br>&nbsp;&nbsp;&nbsp;// enable LocalBus chip select =
CS4<br>&nbsp;&nbsp;&nbsp;out_be32(ipbi_cr, =
0x00290001);<br></blockquote><br>The comment and the code doesn't match =
here, the code disables<br>CS4 to configure the its range, so the =
comment is confusing.<br><br><blockquote =
type=3D"cite">&nbsp;&nbsp;&nbsp;cs4_start_value=3Din_be16(cs4_start);<br>&=
nbsp;&nbsp;&nbsp;cs4_start_value=3DMALab_MM_START =
&gt;&gt;16;<br>&nbsp;&nbsp;&nbsp;out_be16(cs4_start, =
cs4_start_value);<br>&nbsp;&nbsp;&nbsp;cs4_stop_value=3Din_be16(cs4_stop);=
<br>&nbsp;&nbsp;&nbsp;cs4_stop_value=3DMALab_MM_END =
&gt;&gt;16;<br>&nbsp;&nbsp;&nbsp;out_be16(cs4_stop, =
cs4_stop_value);<br></blockquote><br>Here is the problem. The _minimal_ =
chip select range _must_<br>be 64 KiB, otherwise the register access =
can't work. Your<br>current chip select 4 range is less then 1 =
KiB:<br><br>&nbsp;0x10020FFF - 0x10020000 =3D 0xFFF<br><br>Since you =
right-shift the start and stop values by 16,<br>the chip select start =
and stop registers are both 0x1002.<br>The resulting chip select address =
range is 0. Therefore<br>please set MALab_MM_END value to =
0x10030000.<br><br>Thanks,<br>Anatolij</div></blockquote></div><br></div><=
/body></html>=

--Apple-Mail=_539C892B-5880-4FDB-9488-089CDC377192--
