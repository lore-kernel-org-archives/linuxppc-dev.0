Return-Path: <neorf3k@gmail.com>
Received: from mail-ea0-x22f.google.com (mail-ea0-x22f.google.com
 [IPv6:2a00:1450:4013:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DDBB02C0109
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 21:20:42 +1100 (EST)
Received: by mail-ea0-f175.google.com with SMTP id z10so797985ead.34
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Nov 2013 02:20:33 -0800 (PST)
Content-Type: multipart/alternative;
 boundary="Apple-Mail=_03A9CE99-1647-436D-937E-C579926E4226"
Mime-Version: 1.0 (Mac OS X Mail 7.0 \(1822\))
Subject: Re: Problem reading and programming memory location...
From: neorf3k <neorf3k@gmail.com>
In-Reply-To: <20131116152933.276f9939@crub>
Date: Tue, 19 Nov 2013 11:20:24 +0100
Message-Id: <F24AEED4-A8F7-4DE8-A1BB-D0BED489A223@gmail.com>
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


--Apple-Mail=_03A9CE99-1647-436D-937E-C579926E4226
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=windows-1252

Hello Anatolij, this is our code, used at University, but again it =
doesn=92t work=85

How i told, the only information we have about that reg are:

Chip select 4 specification:
Lp_cs4
bus size: 8 bit
bus control: 2 wait state R/W ACK disabled
size allocated: 4 KByte

Our Register 8 bit LP_cs4 (we want to write)

cs4 offset: 0x001

The code we have used:

=97=97
#define MBAR_BASE       0xF0000000
#define MALab_MM_START	 0x10020000U
#define MALab_MM_END	 0x10030000U
#define MALab_MM_SIZE	 0x00010000U

#define MALab_DEVICE_NAME	"MALab"

int init_module(void) { ...
    u16 cs4_start_value;
    u16 cs4_stop_value;
    u32 cs4_enable_value;
    u32 cs0_reg_value;
    u32 cs3_reg_value;
    u32 ipbi_cr_value;
    u32 cs_ctrl_reg_value;
    u8 rvoice_ioaddr_value;
   =20
   =20
    // reserve a page of memory for our hardware /proc/iomem
    if ( check_region(MALab_MM_START,MALab_MM_SIZE) ) {
        printk (KERN_ALERT "LED init_module: memory already in use\n");
        return -EBUSY;
    }
   =20
    request_region(MALab_MM_START,MALab_MM_SIZE,MALab_DEVICE_NAME);
   =20
    void __iomem *reg_base =3D ioremap(MBAR_BASE, 0x400);
    void __iomem *cs0_reg   =3D reg_base + 0x0300;
    void __iomem *cs1_reg   =3D reg_base + 0x0304;
    void __iomem *cs2_reg   =3D reg_base + 0x0308;
    void __iomem *cs3_reg   =3D reg_base + 0x030C;
    void __iomem *ipbi_cr =3D reg_base + 0x0054;
    void __iomem *cs4_start  =3D reg_base + 0x0024;
    void __iomem *cs4_stop   =3D reg_base + 0x0028;
    void __iomem *cs4_enable   =3D reg_base + 0x0310;
    void __iomem *cs_ctrl_reg   =3D reg_base + 0x0318;
    void __iomem *rvoice_ioaddr   =3D ioremap ((volatile unsigned =
long)(MALab_MM_START), MALab_MM_SIZE);
   =20
    printk(KERN_ALERT =93r_ioaddr: 0x%08x\n", (u32)rvoice_ioaddr);
   =20
    //Chip Select 0/Boot Configuration Register: CE=3D0
    cs0_reg_value =3Din_be32(cs0_reg);
    out_be32(cs0_reg, (cs0_reg_value &=3D ~0x00010000));
   =20
    //Chip Select 3 Configuration Register: CE=3D0
    cs3_reg_value =3Din_be32(cs3_reg);
    out_be32(cs3_reg, (cs3_reg_value &=3D ~0x00010000));
   =20
    //enable LocalBus chip select CS4 to hit on our address range
    ipbi_cr_value=3Din_be32(ipbi_cr);
    out_be32(ipbi_cr, (ipbi_cr_value &=3D 0x00100001));
    out_be32(ipbi_cr, (ipbi_cr_value |=3D 0x00100001));
    out_be16(cs4_start+2, MALab_MM_START >>16);
    out_be16(cs4_stop+2, MALab_MM_END >>16);

    // LocalBus Chip Select 4 Configuration Register
    out_be32(cs4_enable, 0x0002DC00);
   =20
    //Enable Chip Select Control Register
    cs_ctrl_reg_value=3Din_be32(cs_ctrl_reg);
    out_be32(cs_ctrl_reg, (cs_ctrl_reg_value |=3D 0x01000000));
   =20
    //start solution A
    rvoice_ioaddr_value=3Din_8(rvoice_ioaddr);
    rvoice_ioaddr_value=3D0xAA;
    printk("A r_ioaddr_value---before : %x \n",in_8(rvoice_ioaddr));
   =20
    out_8(rvoice_ioaddr, rvoice_ioaddr_value);
   =20
    printk("A r_ioaddr_value---after : %x \n",in_8(rvoice_ioaddr));
    //end solution A
   =20
    //start solution B
    *(volatile u8 *)rvoice_ioaddr =3D 0xAA;
    printk("\n B r_ioaddr_value %x\n",*(volatile u8 *)rvoice_ioaddr);
    //end solution B

   =20
    ... }
=97=97

the result is:

rvoice_ioaddr: 0xc9080000
A rvoice_ioaddr_value---before : 10=20
A rvoice_ioaddr_value---after : 10=20
B rvoice_ioaddr_value 10
=97=97

we found some information on this post: =
http://linuxppc.10917.n7.nabble.com/MPC5200b-kernel-module-memory-mapping-=
td59862.html

Thanks again=85

Lorenzo


--Apple-Mail=_03A9CE99-1647-436D-937E-C579926E4226
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html;
	charset=windows-1252

<html><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: space; =
-webkit-line-break: after-white-space;">Hello Anatolij, this is our =
code, used at University, but again it doesn=92t =
work=85<div><br></div><div>How i told, the only information we have =
about that reg are:</div><div><div><br></div><div><div>Chip select 4 =
specification:</div><div>Lp_cs4</div><div>bus size: 8 bit</div><div>bus =
control: 2 wait state R/W ACK disabled</div><div>size allocated: 4 =
KByte</div><div><br></div><div>Our Register 8 bit LP_cs4 (we want to =
write)</div><div><br></div><div>cs4 offset: =
0x001</div></div></div><div><br></div><div>The code we have =
used:</div><div><br></div><div>=97=97</div><div><div style=3D"margin: =
0px; font-size: 11px; font-family: Menlo; color: rgb(120, 73, =
42);">#define MBAR_BASE &nbsp; &nbsp; &nbsp; <span style=3D"color: =
#272ad8">0xF0000000</span></div><div style=3D"margin: 0px; font-size: =
11px; font-family: Menlo; color: rgb(120, 73, 42);">#define =
MALab_MM_START<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span> <span style=3D"color: #272ad8">0x10020000</span>U</div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; color: =
rgb(120, 73, 42);">#define MALab_MM_END<span class=3D"Apple-tab-span" =
style=3D"white-space:pre">	</span> <span style=3D"color: =
#272ad8">0x10030000</span>U</div><div style=3D"margin: 0px; font-size: =
11px; font-family: Menlo; color: rgb(120, 73, 42);">#define =
MALab_MM_SIZE<span class=3D"Apple-tab-span" style=3D"white-space:pre">	=
</span> <span style=3D"color: #272ad8">0x00010000</span>U</div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; min-height: =
13px;"><br></div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Menlo; color: rgb(120, 73, 42);">#define =
MALab_DEVICE_NAME<span class=3D"Apple-tab-span" style=3D"white-space:pre">=
	</span><span style=3D"color: #d12f1b">"MALab"</span></div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; min-height: =
13px;"><br></div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Menlo;"><span style=3D"color: #bb2ca2">int</span> =
init_module(<span style=3D"color: #bb2ca2">void</span>) { ...</div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo;">&nbsp; =
&nbsp; u16 cs4_start_value;</div><div style=3D"margin: 0px; font-size: =
11px; font-family: Menlo;">&nbsp; &nbsp; u16 cs4_stop_value;</div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo;">&nbsp; =
&nbsp; u32 cs4_enable_value;</div><div style=3D"margin: 0px; font-size: =
11px; font-family: Menlo;">&nbsp; &nbsp; u32 cs0_reg_value;</div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo;">&nbsp; =
&nbsp; u32 cs3_reg_value;</div><div style=3D"margin: 0px; font-size: =
11px; font-family: Menlo;">&nbsp; &nbsp; u32 ipbi_cr_value;</div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo;">&nbsp; =
&nbsp; u32 cs_ctrl_reg_value;</div><div style=3D"margin: 0px; font-size: =
11px; font-family: Menlo;">&nbsp; &nbsp; u8 rvoice_ioaddr_value;</div><p =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; min-height: =
13px;">&nbsp;&nbsp; &nbsp;<br class=3D"webkit-block-placeholder"></p><p =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; min-height: =
13px;">&nbsp;&nbsp; &nbsp;<br class=3D"webkit-block-placeholder"></p><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; color: rgb(0, =
132, 0);"><span style=3D"color: #000000">&nbsp; &nbsp; </span>// reserve =
a page of memory for our hardware /proc/iomem</div><div style=3D"margin: =
0px; font-size: 11px; font-family: Menlo;">&nbsp; &nbsp; <span =
style=3D"color: #bb2ca2">if</span> ( =
check_region(MALab_MM_START,MALab_MM_SIZE) ) {</div><div style=3D"margin: =
0px; font-size: 11px; font-family: Menlo; color: rgb(209, 47, =
27);"><span style=3D"color: #000000">&nbsp; &nbsp; &nbsp; &nbsp; printk =
(KERN_ALERT </span>"LED init_module: memory already in use\n"<span =
style=3D"color: #000000">);</span></div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Menlo;">&nbsp; &nbsp; &nbsp; &nbsp; <span =
style=3D"color: #bb2ca2">return</span> -EBUSY;</div><div style=3D"margin: =
0px; font-size: 11px; font-family: Menlo;">&nbsp; &nbsp; }</div><p =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; min-height: =
13px;">&nbsp;&nbsp; &nbsp;<br class=3D"webkit-block-placeholder"></p><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo;">&nbsp; =
&nbsp; =
request_region(MALab_MM_START,MALab_MM_SIZE,MALab_DEVICE_NAME);</div><p =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; min-height: =
13px;">&nbsp;&nbsp; &nbsp;<br class=3D"webkit-block-placeholder"></p><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo;">&nbsp; =
&nbsp; <span style=3D"color: #bb2ca2">void</span> __iomem *reg_base =3D =
ioremap(MBAR_BASE, <span style=3D"color: =
#272ad8">0x400</span>);</div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Menlo;">&nbsp; &nbsp; <span style=3D"color: =
#bb2ca2">void</span> __iomem *cs0_reg &nbsp; =3D reg_base + <span =
style=3D"color: #272ad8">0x0300</span>;</div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Menlo;">&nbsp; &nbsp; <span style=3D"color: =
#bb2ca2">void</span> __iomem *cs1_reg &nbsp; =3D reg_base + <span =
style=3D"color: #272ad8">0x0304</span>;</div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Menlo;">&nbsp; &nbsp; <span style=3D"color: =
#bb2ca2">void</span> __iomem *cs2_reg &nbsp; =3D reg_base + <span =
style=3D"color: #272ad8">0x0308</span>;</div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Menlo;">&nbsp; &nbsp; <span style=3D"color: =
#bb2ca2">void</span> __iomem *cs3_reg &nbsp; =3D reg_base + <span =
style=3D"color: #272ad8">0x030C</span>;</div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Menlo;">&nbsp; &nbsp; <span style=3D"color: =
#bb2ca2">void</span> __iomem *ipbi_cr =3D reg_base + <span style=3D"color:=
 #272ad8">0x0054</span>;</div><div style=3D"margin: 0px; font-size: =
11px; font-family: Menlo;">&nbsp; &nbsp; <span style=3D"color: =
#bb2ca2">void</span> __iomem *cs4_start&nbsp; =3D reg_base + <span =
style=3D"color: #272ad8">0x0024</span>;</div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Menlo;">&nbsp; &nbsp; <span style=3D"color: =
#bb2ca2">void</span> __iomem *cs4_stop &nbsp; =3D reg_base + <span =
style=3D"color: #272ad8">0x0028</span>;</div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Menlo;">&nbsp; &nbsp; <span style=3D"color: =
#bb2ca2">void</span> __iomem *cs4_enable &nbsp; =3D reg_base + <span =
style=3D"color: #272ad8">0x0310</span>;</div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Menlo;">&nbsp; &nbsp; <span style=3D"color: =
#bb2ca2">void</span> __iomem *cs_ctrl_reg &nbsp; =3D reg_base + <span =
style=3D"color: #272ad8">0x0318</span>;</div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Menlo;">&nbsp; &nbsp; <span style=3D"color: =
#bb2ca2">void</span> __iomem *rvoice_ioaddr &nbsp; =3D ioremap ((<span =
style=3D"color: #bb2ca2">volatile</span> <span style=3D"color: =
#bb2ca2">unsigned</span> <span style=3D"color: =
#bb2ca2">long</span>)(MALab_MM_START), MALab_MM_SIZE);</div><p =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; min-height: =
13px;">&nbsp;&nbsp; &nbsp;<br class=3D"webkit-block-placeholder"></p><div =
style=3D"margin: 0px;"><font face=3D"Menlo"><span style=3D"font-size: =
11px;">&nbsp; &nbsp; printk(KERN_ALERT&nbsp;</span></font><font =
color=3D"#d12f1b" face=3D"Menlo"><span style=3D"font-size: =
11px;">=93r_ioaddr: 0x%08x\n"</span></font><font face=3D"Menlo"><span =
style=3D"font-size: 11px;">, (u32)rvoice_ioaddr);</span></font></div><p =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; min-height: =
13px;">&nbsp;&nbsp; &nbsp;<br class=3D"webkit-block-placeholder"></p><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; color: rgb(0, =
132, 0);"><span style=3D"color: #000000">&nbsp; &nbsp; </span>//Chip =
Select 0/Boot Configuration Register: CE=3D0</div><div style=3D"margin: =
0px; font-size: 11px; font-family: Menlo;">&nbsp; &nbsp; cs0_reg_value =
=3Din_be32(cs0_reg);</div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Menlo;">&nbsp; &nbsp; out_be32(cs0_reg, (cs0_reg_value =
&amp;=3D ~<span style=3D"color: #272ad8">0x00010000</span>));</div><p =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; min-height: =
13px;">&nbsp;&nbsp; &nbsp;<br class=3D"webkit-block-placeholder"></p><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; color: rgb(0, =
132, 0);"><span style=3D"color: #000000">&nbsp; &nbsp; </span>//Chip =
Select 3 Configuration Register: CE=3D0</div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Menlo;">&nbsp; &nbsp; cs3_reg_value =
=3Din_be32(cs3_reg);</div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Menlo;">&nbsp; &nbsp; out_be32(cs3_reg, (cs3_reg_value =
&amp;=3D ~<span style=3D"color: #272ad8">0x00010000</span>));</div><p =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; min-height: =
13px;">&nbsp;&nbsp; &nbsp;<br class=3D"webkit-block-placeholder"></p><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; color: rgb(0, =
132, 0);"><span style=3D"color: #000000">&nbsp; &nbsp; </span>//enable =
LocalBus chip select CS4 to hit on our address range</div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo;">&nbsp; =
&nbsp; ipbi_cr_value=3Din_be32(ipbi_cr);</div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Menlo;">&nbsp; &nbsp; out_be32(ipbi_cr, =
(ipbi_cr_value &amp;=3D <span style=3D"color: =
#272ad8">0x00100001</span>));</div><div style=3D"margin: 0px; font-size: =
11px; font-family: Menlo;">&nbsp; &nbsp; out_be32(ipbi_cr, =
(ipbi_cr_value |=3D <span style=3D"color: =
#272ad8">0x00100001</span>));</div><div style=3D"margin: 0px; font-size: =
11px; font-family: Menlo;">&nbsp; &nbsp; out_be16(cs4_start+<span =
style=3D"color: #272ad8">2</span>, MALab_MM_START &gt;&gt;<span =
style=3D"color: #272ad8">16</span>);</div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Menlo;">&nbsp; &nbsp; =
out_be16(cs4_stop+<span style=3D"color: #272ad8">2</span>, MALab_MM_END =
&gt;&gt;<span style=3D"color: #272ad8">16</span>);</div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; min-height: =
13px;"><br></div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Menlo; color: rgb(0, 132, 0);"><span style=3D"color: =
#000000">&nbsp; &nbsp; </span>// LocalBus Chip Select 4 Configuration =
Register</div><div style=3D"margin: 0px; font-size: 11px; font-family: =
Menlo;">&nbsp; &nbsp; out_be32(cs4_enable, <span style=3D"color: =
#272ad8">0x0002DC00</span>);</div><p style=3D"margin: 0px; font-size: =
11px; font-family: Menlo; min-height: 13px;">&nbsp;&nbsp; &nbsp;<br =
class=3D"webkit-block-placeholder"></p><div style=3D"margin: 0px; =
font-size: 11px; font-family: Menlo; color: rgb(0, 132, 0);"><span =
style=3D"color: #000000">&nbsp; &nbsp; </span>//Enable Chip Select =
Control Register</div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Menlo;">&nbsp; &nbsp; =
cs_ctrl_reg_value=3Din_be32(cs_ctrl_reg);</div><div style=3D"margin: =
0px; font-size: 11px; font-family: Menlo;">&nbsp; &nbsp; =
out_be32(cs_ctrl_reg, (cs_ctrl_reg_value |=3D <span style=3D"color: =
#272ad8">0x01000000</span>));</div><p style=3D"margin: 0px; font-size: =
11px; font-family: Menlo; min-height: 13px;">&nbsp;&nbsp; &nbsp;<br =
class=3D"webkit-block-placeholder"></p><div style=3D"margin: 0px; =
font-size: 11px; font-family: Menlo; color: rgb(0, 132, 0);"><span =
style=3D"color: #000000">&nbsp; &nbsp; </span>//start solution =
A</div><div style=3D"margin: 0px; font-size: 11px; font-family: =
Menlo;">&nbsp; &nbsp; rvoice_ioaddr_value=3Din_8(rvoice_ioaddr);</div><div=
 style=3D"margin: 0px; font-size: 11px; font-family: Menlo;">&nbsp; =
&nbsp; rvoice_ioaddr_value=3D<span style=3D"color: =
#272ad8">0xAA</span>;</div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Menlo; color: rgb(209, 47, 27);"><span style=3D"color: =
#000000">&nbsp; &nbsp; printk(</span>"A r_ioaddr_value---before : %x =
\n"<span style=3D"color: #000000">,in_8(rvoice_ioaddr));</span></div><p =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; min-height: =
13px;">&nbsp;&nbsp; &nbsp;<br class=3D"webkit-block-placeholder"></p><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo;">&nbsp; =
&nbsp; out_8(rvoice_ioaddr, rvoice_ioaddr_value);</div><p style=3D"margin:=
 0px; font-size: 11px; font-family: Menlo; min-height: =
13px;">&nbsp;&nbsp; &nbsp;<br class=3D"webkit-block-placeholder"></p><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; color: =
rgb(209, 47, 27);"><span style=3D"color: #000000">&nbsp; &nbsp; =
printk(</span>"A r_ioaddr_value---after : %x \n"<span style=3D"color: =
#000000">,in_8(rvoice_ioaddr));</span></div><div style=3D"margin: 0px; =
font-size: 11px; font-family: Menlo; color: rgb(0, 132, 0);"><span =
style=3D"color: #000000">&nbsp; &nbsp; </span>//end solution A</div><p =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; min-height: =
13px;">&nbsp;&nbsp; &nbsp;<br class=3D"webkit-block-placeholder"></p><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; color: rgb(0, =
132, 0);"><span style=3D"color: #000000">&nbsp; &nbsp; </span>//start =
solution B</div><div style=3D"margin: 0px; font-size: 11px; font-family: =
Menlo;">&nbsp; &nbsp; *(<span style=3D"color: #bb2ca2">volatile</span> =
u8 *)rvoice_ioaddr =3D <span style=3D"color: =
#272ad8">0xAA</span>;</div><div style=3D"margin: 0px; font-size: 11px; =
font-family: Menlo;">&nbsp; &nbsp; printk(<span style=3D"color: =
#d12f1b">"\n B r_ioaddr_value %x\n"</span>,*(<span style=3D"color: =
#bb2ca2">volatile</span> u8 *)rvoice_ioaddr);</div><div style=3D"margin: =
0px; font-size: 11px; font-family: Menlo; color: rgb(0, 132, 0);"><span =
style=3D"color: #000000">&nbsp; &nbsp; </span>//end solution B</div><div =
style=3D"margin: 0px; font-size: 11px; font-family: Menlo; min-height: =
13px;"><br></div><p style=3D"margin: 0px; font-size: 11px; font-family: =
Menlo; min-height: 13px;">&nbsp;&nbsp; &nbsp;<br =
class=3D"webkit-block-placeholder"></p><div style=3D"margin: 0px; =
font-size: 11px; font-family: Menlo;">&nbsp; &nbsp; ... =
}</div></div><div>=97=97</div><div><br></div><div>the result =
is:</div><div><br></div><div><div>rvoice_ioaddr: 0xc9080000</div><div>A =
rvoice_ioaddr_value---before : 10&nbsp;</div><div>A =
rvoice_ioaddr_value---after : 10&nbsp;</div><div>B rvoice_ioaddr_value =
10</div></div><div>=97=97</div><div><br></div><div>we found some =
information on this post:&nbsp;<a =
href=3D"http://linuxppc.10917.n7.nabble.com/MPC5200b-kernel-module-memory-=
mapping-td59862.html">http://linuxppc.10917.n7.nabble.com/MPC5200b-kernel-=
module-memory-mapping-td59862.html</a></div><div><br></div><div>Thanks =
again=85</div><div><br></div><div>Lorenzo</div><div><br></div></body></htm=
l>=

--Apple-Mail=_03A9CE99-1647-436D-937E-C579926E4226--
