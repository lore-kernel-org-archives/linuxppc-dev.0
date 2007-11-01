Return-Path: <dcogley@uslinc.com>
Received: from mtao05.charter.net (mtao05.charter.net [209.225.8.179])
	by ozlabs.org (Postfix) with ESMTP id E7943DDE08
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Nov 2007 08:03:47 +1100 (EST)
Received: from aa04.charter.net ([10.20.200.156]) by mtao05.charter.net
	(InterMail vM.7.08.02.00 201-2186-121-20061213) with ESMTP
	id <20071101210345.URDE29426.mtao05.charter.net@aa04.charter.net>
	for <linuxppc-embedded@ozlabs.org>; Thu, 1 Nov 2007 17:03:45 -0400
Received: from DCOGLEYNEW ([71.93.35.174]) by aa04.charter.net with ESMTP
	id <20071101210344.LPEE1254.aa04.charter.net@DCOGLEYNEW>
	for <linuxppc-embedded@ozlabs.org>; Thu, 1 Nov 2007 17:03:44 -0400
From: "Dave Cogley" <dcogley@uslinc.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Kernel malloc buffers how to make contiguous in user space?
Date: Thu, 1 Nov 2007 14:03:10 -0700
Message-ID: <008101c81cca$9c95be90$2001a8c0@DCOGLEYNEW>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0082_01C81C8F.F036E690"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0082_01C81C8F.F036E690
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello,

 

I am using a scatter gather DMA operation provided on the PPC44EPx to handle
a large data move of 2MB from sixteen 128k kmalloc buffers.  I have sixteen
scatter / gather descriptors pointing to the allocated memory which will be
transferred to a peripheral on the EBC.  This all appears to be setup and
working correctly.  Now I want to provide these 16 kmalloc buffers to a user
space process and make them all appear as a contiguous 2MB buffer.

 

When the handler is called pageptr appears to be a valid page but the kernel
traps with "Bad page state" "Trying to fix it up, but a reboot is needed"
when returned from the handler.  Am I missing something required to modify
the page state for the requested page?  Am I even handling the nopage
request correctly?  I notice the nopage handler gets called for every 4096
byte page it is trying to map.  How do I map my 128k memory area into the 4k
page requests?  Is there example code somewhere that demonstrates using a
contiguous memory buffer in user space when it is comprised of multiple
buffers in the kernel space?

 

 

First I am allocating 16 buffers using kmalloc:

 

#define DMABLOCKSIZE          1024 * 128

 

for (I = 0; I < 16; i++)

{

            device->dma_buf[i] = kmalloc(DMABLOCKSIZE, GFP_DMA |
GFP_KERNEL);

            sgl->phyaddress = virt_to_phys(device->dma_buf[i]);

}

 

Then I am doing the following in the nopage handler:

 

page* nopage_handler(struct vma, ul address, int* type)

{

            unsigned long physaddr = address - vma->start;

            int index = physaddr / DMABLOCKSIZE;

            int off = physaddr % DMABLOCKSIZE;

            struct page* pageptr = virt_to_page(device->dma_buf[index] +
off);

 

            get_page(pageptr);

            if (type)

                        *type = VM_FAULT_MINOR;

 

            return pageptr;

}

 

 

Dave Cogley

Software Engineer

Ultra Stereo Labs, Inc.

(805) 549-0161

mailto:dcogley@uslinc.com

 


------=_NextPart_000_0082_01C81C8F.F036E690
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hello,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am using a scatter gather DMA operation provided on =
the
PPC44EPx to handle a large data move of 2MB from sixteen 128k kmalloc =
buffers.&nbsp;
I have sixteen scatter / gather descriptors pointing to the allocated =
memory
which will be transferred to a peripheral on the EBC.&nbsp; This all =
appears to
be setup and working correctly.&nbsp; Now I want to provide these 16 =
kmalloc
buffers to a user space process and make them all appear as a contiguous =
2MB buffer.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>When the handler is called pageptr appears to be a =
valid
page but the kernel traps with &#8220;Bad page state&#8221; =
&#8220;Trying to
fix it up, but a reboot is needed&#8221; when returned from the =
handler.&nbsp;
Am I missing something required to modify the page state for the =
requested
page?&nbsp; Am I even handling the nopage request correctly?&nbsp; I =
notice the
nopage handler gets called for every 4096 byte page it is trying to =
map.&nbsp;
How do I map my 128k memory area into the 4k page requests?&nbsp; Is =
there example
code somewhere that demonstrates using a contiguous memory buffer in =
user space
when it is comprised of multiple buffers in the kernel =
space?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>First I am allocating 16 buffers using =
kmalloc:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>#define =
DMABLOCKSIZE&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 1024
* 128<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>for (I =3D 0; I &lt; 16; =
i++)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; device-&gt;dma_buf[i]
=3D kmalloc(DMABLOCKSIZE, GFP_DMA | =
GFP_KERNEL);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; sgl-&gt;phyaddress
=3D virt_to_phys(device-&gt;dma_buf[i]);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Then I am doing the following in the nopage =
handler:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>page* nopage_handler(struct vma, ul address, int* =
type)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>{<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; unsigned
long physaddr =3D address &#8211; =
vma-&gt;start;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; int
index =3D physaddr / DMABLOCKSIZE;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; int
off =3D physaddr % DMABLOCKSIZE;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; struct
page* pageptr =3D virt_to_page(device-&gt;dma_buf[index] + =
off);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; get_page(pageptr);<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; if
(type)<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; *type
=3D VM_FAULT_MINOR;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp; return
pageptr;<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>}<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Dave Cogley<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Software Engineer<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Ultra Stereo Labs, Inc.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>(805) 549-0161<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><a =
href=3D"mailto:dcogley@uslinc.com">mailto:dcogley@uslinc.com</a></span></=
font><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
style=3D'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_0082_01C81C8F.F036E690--
