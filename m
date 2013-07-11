Return-Path: <Ravi.Rao@us.fujitsu.com>
Received: from fncnmp04.fnc.fujitsu.com (fncnmp04.fnc.fujitsu.com
 [168.127.0.57]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "fncnmp04.fnc.fujitsu.com",
 Issuer "Entrust Certification Authority - L1C" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 881592C0342
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jul 2013 02:51:51 +1000 (EST)
From: "Rao, Ravi" <Ravi.Rao@us.fujitsu.com>
To: "'linux-usb@vger.kernel.org'" <linux-usb@vger.kernel.org>,
 "'linuxppc-dev@lists.ozlabs.org'" <linuxppc-dev@lists.ozlabs.org>
Subject: kernel hang when initializing usb
Date: Thu, 11 Jul 2013 16:41:17 +0000
Message-ID: <4E5A07CF014F73489C60025F5BCB78347FEC53CE@RCHEXMBP2.fnc.net.local>
Content-Type: multipart/alternative;
 boundary="_000_4E5A07CF014F73489C60025F5BCB78347FEC53CERCHEXMBP2fncnet_"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_4E5A07CF014F73489C60025F5BCB78347FEC53CERCHEXMBP2fncnet_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable


Hi Tony/Greg/Liu,
    I'am Ravi working on a P2040 based custom board which has a compact fla=
sh connected to USB port via CYPRESS USB to IDE bridge. I am able to see th=
e USB mass storage device from uboot but when I boot to kernel it hangs.
Below is the dump that shows the part where it hangs. I have added some deb=
ug prints and narrowed down that the hang happens when it is trying to writ=
e to port status(portsc) register.

>>>>>
ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI Host Controller
fsl-ehci fsl-ehci.0: new USB bus registered, assigned bus number 1
fsl-ehci fsl-ehci.0: Before invoking reset
ehci_fsl_setup got invoked..
Before invoking ehci_readl
Before invoking ehci_halt
ehci_writel invoked with val=3D0x0, reg=3D0xf125e148
Before invoking ehci_init
Before invoking ehci_reset
ehci_writel invoked with val=3D0x80002, reg=3D0xf125e140
ehci_writel invoked with val=3D0x3, reg=3D0xf125e1a8
Before invoking ehci_fsl_reinit
Entering ehci_fsl_usb_setup with op_mode=3D0x1 have_sysif_regs=3D0x1
Completed SNOOPing of 4GB space
Before invoking ehci_fsl_setup_phy with phy_mode=3D0x2
Entering ehci_fsl_setup_phy, portsc=3D0x0 port_offset=3D0x0 port_status_add=
r=3D0xf125e184
Before invoking mdelay, cntrlr_ver=3D0x1
Before invoking ehci_writel, portsc=3D0x0 port_offset=3D0x0 port_status_add=
r=3D0xf125e184
ehci_writel invoked with val=3D0x0, reg=3D0xf125e184
>>>>>>


Kernel I am using is Linux version 3.0.51-rt75 and it looks like it has all=
 the required patches described in the thread(http://thread.gmane.org/gmane=
.linux.usb.general/58763/focus=3D58795) but I still see the hang.
Can one you give some pointers to troubleshoot what may be causing this han=
g
Below is the email in which Tony had mentioned that he is also seeing the h=
ang even after applying all the prescribed patches.
Tony were you able to find the cause for the hang ? If so can you please sh=
are what was the fix that you made.

>>>>
Re: [ 011/108] powerpc/usb: fix bug of kernel hang when initializing usb Re=
move Highlighting [In reply to]
Greg KH <gregkh [at] linuxfoundation> writes:

> 3.0-stable review patch. If anyone has any objections, please let me know=
.
>
> ------------------
>
> From: Shengzhou Liu <Shengzhou.Liu [at] freescale>
>
> commit 28c56ea1431421dec51b7b229369e991481453df upstream.
>
> If USB UTMI PHY is not enable, writing to portsc register will lead to
> kernel hang during boot up.

I apologize for the late response, but I was encountering this same
hang (on an 8315) and applied this patch. (For what it's worth, I'm
only seeing it after many warm boots; a cold boot / hard power cycle
solves the issue, but since this is eventually going to be locked up
in a box without a console...)

I encountered the hang again this evening, so this fix (plus the snoop
fix) is not sufficientl

Reading through the original thread, it seems that an additional delay
might be required:

http://article.gmane.org/gmane.linux.usb.general/58795

> First, the SDK kernel had a delay after setting that bit, I added
> that back in. This is not what fixed it but it looks like the
> right thing to do, though please, use msleep rather than udelay
> here if possible (not in atomic context).

However, I never saw a patch to that effect. I'm assuming (hoping!)
it's something as simple as:

------------------------------------------------------------------------
diff --git a/drivers/usb/host/ehci-fsl.c b/drivers/usb/host/ehci-fsl.c
index 09fd214..d58c1c6 100644
--- a/drivers/usb/host/ehci-fsl.c
+++ b/drivers/usb/host/ehci-fsl.c
@@ -236,6 +236,7 @@ static void ehci_fsl_setup_phy(struct ehci_hcd *ehci,
case FSL_USB2_PHY_UTMI:
/* enable UTMI PHY */
setbits32(non_ehci + FSL_SOC_USB_CTRL, CTRL_UTMI_PHY_EN);
+ msleep(5);
portsc |=3D PORT_PTS_UTMI;
break;
case FSL_USB2_PHY_NONE:
------------------------------------------------------------------------

But confirmation would be nice. Also, which SDK kernel was this
compared against? I just downloaded the 8315ERDB BSP, and the kernel
there doesn't seem to have any of this in it.

There was also the follow-on patch that enabled snooping (to deal with
cache coherency?):

http://article.gmane.org/gmane.linux.usb.general/58798

(If there was a formal patch there, it looks like it got scrambled on
gmane, and I can't find another list archive.)

Is that also needed for consistent results here? (Or are we wandering
astray from "-stable" material?)

Thanks,
Tony.
>>>>

Thanks & Regards,
Ravi..

--_000_4E5A07CF014F73489C60025F5BCB78347FEC53CERCHEXMBP2fncnet_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" xmlns:o=3D"urn:schemas-micr=
osoft-com:office:office" xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" xmlns=3D"http:=
//www.w3.org/TR/REC-html40">
<head>
<meta http-equiv=3D"Content-Type" content=3D"text/html; charset=3Dus-ascii"=
>
<meta name=3D"Generator" content=3D"Microsoft Word 14 (filtered medium)">
<style><!--
/* Font Definitions */
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
/* Style Definitions */
p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoPlainText, li.MsoPlainText, div.MsoPlainText
	{mso-style-priority:99;
	mso-style-link:"Plain Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.PlainTextChar
	{mso-style-name:"Plain Text Char";
	mso-style-priority:99;
	mso-style-link:"Plain Text";
	font-family:"Calibri","sans-serif";}
span.EmailStyle19
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
span.EmailStyle22
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:#1F497D;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page WordSection1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.WordSection1
	{page:WordSection1;}
--></style><!--[if gte mso 9]><xml>
<o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
<o:shapelayout v:ext=3D"edit">
<o:idmap v:ext=3D"edit" data=3D"1" />
</o:shapelayout></xml><![endif]-->
</head>
<body lang=3D"EN-US" link=3D"blue" vlink=3D"purple">
<div class=3D"WordSection1">
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Hi Tony/Greg/Liu,<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&nbsp;&nbsp;&nbsp; I&#8217;am Ravi working on=
 a P2040 based custom board which has a compact flash connected to USB port=
 via CYPRESS USB to IDE bridge. I am able to see the USB mass storage
 device from uboot but when I boot to kernel it hangs.<o:p></o:p></span></p=
>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Below is the dump that shows the part where i=
t hangs. I have added some debug prints and narrowed down that the hang hap=
pens when it is trying to write to port status(portsc)
 register.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&gt;&gt;&gt;&gt;&gt;
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">ehci_hcd: USB 2.0 'Enhanced' Host Controller =
(EHCI) Driver<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">ohci_hcd: USB 1.1 'Open' Host Controller (OHC=
I) Driver<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">fsl-ehci fsl-ehci.0: Freescale On-Chip EHCI H=
ost Controller<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">fsl-ehci fsl-ehci.0: new USB bus registered, =
assigned bus number 1<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">fsl-ehci fsl-ehci.0: Before invoking reset
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">ehci_fsl_setup got invoked..<o:p></o:p></span=
></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Before invoking ehci_readl<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Before invoking ehci_halt<o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">ehci_writel invoked with val=3D0x0, reg=3D0xf=
125e148<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Before invoking ehci_init<o:p></o:p></span></=
p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Before invoking ehci_reset<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">ehci_writel invoked with val=3D0x80002, reg=
=3D0xf125e140<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">ehci_writel invoked with val=3D0x3, reg=3D0xf=
125e1a8<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Before invoking ehci_fsl_reinit<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Entering ehci_fsl_usb_setup with op_mode=3D0x=
1 have_sysif_regs=3D0x1<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Completed SNOOPing of 4GB space<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Before invoking ehci_fsl_setup_phy with phy_m=
ode=3D0x2<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Entering ehci_fsl_setup_phy, portsc=3D0x0 por=
t_offset=3D0x0 port_status_addr=3D0xf125e184<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Before invoking mdelay, cntrlr_ver=3D0x1<o:p>=
</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Before invoking ehci_writel, portsc=3D0x0 por=
t_offset=3D0x0 port_status_addr=3D0xf125e184<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">ehci_writel invoked with val=3D0x0, reg=3D0xf=
125e184<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&gt;&gt;&gt;&gt;&gt;&gt;<o:p>&nbsp;</o:p></sp=
an></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoPlainText"><span style=3D"font-family:&quot;Courier New&quot=
;">Kernel I am using is Linux version 3.0.51-rt75 and it looks like it has =
all the required patches described in the thread(</span><a href=3D"http://t=
hread.gmane.org/gmane.linux.usb.general/58763/focus=3D58795">http://thread.=
gmane.org/gmane.linux.usb.general/58763/focus=3D58795</a><span style=3D"fon=
t-family:&quot;Courier New&quot;">)
 but I still see the hang.</span><o:p></o:p></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Can one you give some pointers to troubleshoo=
t what may be causing this hang<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Below is the email in which Tony had mentione=
d that he is also seeing the hang even after applying all the prescribed pa=
tches.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Tony were you able to find the cause for the =
hang ? If so can you please share what was the fix that you made.<o:p></o:p=
></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&gt;&gt;&gt;&gt;<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Re: [ 011/108] powerpc/usb: fix bug of kernel=
 hang when initializing usb Remove Highlighting [In reply to]<o:p></o:p></s=
pan></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Greg KH &lt;gregkh [at] linuxfoundation&gt; w=
rites:<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&gt; 3.0-stable review patch. If anyone has a=
ny objections, please let me know.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&gt;<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&gt; ------------------<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&gt;<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&gt; From: Shengzhou Liu &lt;Shengzhou.Liu [a=
t] freescale&gt;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&gt;<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&gt; commit 28c56ea1431421dec51b7b229369e9914=
81453df upstream.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&gt;<o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&gt; If USB UTMI PHY is not enable, writing t=
o portsc register will lead to<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&gt; kernel hang during boot up.<o:p></o:p></=
span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">I apologize for the late response, but I was =
encountering this same<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">hang (on an 8315) and applied this patch. (Fo=
r what it's worth, I'm<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">only seeing it after many warm boots; a cold =
boot / hard power cycle<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">solves the issue, but since this is eventuall=
y going to be locked up<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">in a box without a console...)<o:p></o:p></sp=
an></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">I encountered the hang again this evening, so=
 this fix (plus the snoop<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">fix) is not sufficientl<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Reading through the original thread, it seems=
 that an additional delay<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">might be required:<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><a href=3D"http://article.gmane.org/gmane.lin=
ux.usb.general/58795">http://article.gmane.org/gmane.linux.usb.general/5879=
5</a><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&gt; First, the SDK kernel had a delay after =
setting that bit, I added<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&gt; that back in. This is not what fixed it =
but it looks like the<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&gt; right thing to do, though please, use ms=
leep rather than udelay<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&gt; here if possible (not in atomic context)=
.<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">However, I never saw a patch to that effect. =
I'm assuming (hoping!)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">it's something as simple as:<o:p></o:p></span=
></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">---------------------------------------------=
---------------------------<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">diff --git a/drivers/usb/host/ehci-fsl.c b/dr=
ivers/usb/host/ehci-fsl.c<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">index 09fd214..d58c1c6 100644<o:p></o:p></spa=
n></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">--- a/drivers/usb/host/ehci-fsl.c<o:p></o:p><=
/span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&#43;&#43;&#43; b/drivers/usb/host/ehci-fsl.c=
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">@@ -236,6 &#43;236,7 @@ static void ehci_fsl_=
setup_phy(struct ehci_hcd *ehci,<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">case FSL_USB2_PHY_UTMI:<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">/* enable UTMI PHY */<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">setbits32(non_ehci &#43; FSL_SOC_USB_CTRL, CT=
RL_UTMI_PHY_EN);<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">&#43; msleep(5);<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">portsc |=3D PORT_PTS_UTMI;<o:p></o:p></span><=
/p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">break;<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">case FSL_USB2_PHY_NONE:<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">---------------------------------------------=
---------------------------<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">But confirmation would be nice. Also, which S=
DK kernel was this<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">compared against? I just downloaded the 8315E=
RDB BSP, and the kernel<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">there doesn't seem to have any of this in it.=
<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">There was also the follow-on patch that enabl=
ed snooping (to deal with<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">cache coherency?):<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><a href=3D"http://article.gmane.org/gmane.lin=
ux.usb.general/58798">http://article.gmane.org/gmane.linux.usb.general/5879=
8</a><o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">(If there was a formal patch there, it looks =
like it got scrambled on<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">gmane, and I can't find another list archive.=
)<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Is that also needed for consistent results he=
re? (Or are we wandering<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">astray from &quot;-stable&quot; material?)<o:=
p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;"><o:p>&nbsp;</o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Thanks,<o:p></o:p></span></p>
<p class=3D"MsoNormal" style=3D"text-autospace:none"><span style=3D"font-fa=
mily:&quot;Courier New&quot;">Tony.
<o:p></o:p></span></p>
<p class=3D"MsoNormal">&gt;&gt;&gt;&gt;<o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal"><o:p>&nbsp;</o:p></p>
<p class=3D"MsoNormal">Thanks &amp; Regards,<o:p></o:p></p>
<p class=3D"MsoNormal">Ravi..<o:p></o:p></p>
</div>
</body>
</html>

--_000_4E5A07CF014F73489C60025F5BCB78347FEC53CERCHEXMBP2fncnet_--
