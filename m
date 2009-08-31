Return-Path: <john.p.price@l-3com.com>
Received: from smtp2out.l-3com.com (smtp2out.l-3com.com [166.20.51.112])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ironport2.l-3com.com", Issuer "Equifax" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 151DFB70BA
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 Aug 2009 23:39:34 +1000 (EST)
From: john.p.price@l-3com.com
Received: from boreas.corp.sds.l-3com.com (boreas [148.104.130.14])
	by merlin.sds.l-3com.com (8.13.7/8.13.7) with ESMTP id n7VDS8wv012049
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Aug 2009 09:28:08 -0400
MIME-Version: 1.0
Content-Type: multipart/related; type="multipart/alternative";
	boundary="----_=_NextPart_001_01CA2A3E.E0F5689B"
Subject: remapping 4MB of kernel space with remap_pfn_range() and nopage()
Date: Mon, 31 Aug 2009 09:28:07 -0400
Message-ID: <B9639434CFA424438117913649CDB7870F06B7D3@MA_EXCHANGE.corp.sds.l-3com.com>
To: <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01CA2A3E.E0F5689B
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_002_01CA2A3E.E0F5689B"


------_=_NextPart_002_01CA2A3E.E0F5689B
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'm using linux kernel 2.6.29.1 I've been using the mmap system call to
map 4MB of contiguous kernel memory (RAM), obtained by get_free_pages
with order =3D=3D 10, to user space.  One implementation I have uses
remap_pfn_range(), its seems to work ok, I do have other issues I just
want to make sure its reasonable to use the reamp_pfn_range call for
what I am doing.

=20

Now in LDD3 it says not to use the remap_pfn_range() call because it
only gives access to reserved pages and physical addresses above the top
of physical memory.  LDD3 makes reference to the using the nopage and
notes about maintaining proper reference counts with clusters of pages.
The material in the book on this issue seems dated.

=20

Is there still a limitation with using remap_pfn_range() remap kernel
ram to user space?

=20

So in a test driver I made using the "fault" (previously called nopage)
method for that purpose.=20

here's a snipet of the fault callback;

=20

offset =3D vmf->pgoff << PAGE_SHIFT;
if( offset > dev->dma_buff_size)
{
printk("ds3b3_vm_fault: SIGBUS - my_offset: %#x vmf_pgoff: %#x
page_shift: %i \n",
offset, vmf->pgoff, PAGE_SHIFT);
return VM_FAULT_SIGBUS;
}

addr =3D (char *)vma->vm_start;
addr +=3D offset;

page =3D virt_to_page( addr );

get_page(page);
vmf->page =3D page;

=20

When the application loads the module the following is printed on the
console;

=20

          My kprintfs from the fault handler:

<4>ds3b3_vm_fault: entered - vma->vm_start: 0x48000000 vma->vm_end
0x483fd000
<4>ds3b3_vm_fault: entered - vma->vm_flags: 0x820fb vma->vm_pgoff 0x0
<4>ds3b3_vm_fault: entered - vmf->flags: 0x1 vmf->pgoff 0x0
vmf->virtual_address: 0x48000000
<4>ds3b3_vm_fault: SUCCESS - vmf->page: 0xc13d1000

=20

=20

Kernel output to the console:
<1>BUG: Bad page map in process dcb pte:880004d2 pmd:0c5ec400
<1>addr:48000000 vm_flags:000820fb anon_vma null) mapping:ce4927d0
index:0
<1>vma->vm_ops->fault: ds3b3_vm_fault+0x0/0xf8 [ds3b3]
<1>vma->vm_file->f_op->mmap: ds3b3_nopage_mmap+0x0/0x4c [ds3b3]
<4>Call Trace:
<4>[cd659d80] [c0006bc0] show_stack+0x44/0x16c (unreliable)
<4>[cd659dc0] [c00627c8] print_bad_pte+0x140/0x1cc
<4>[cd659df0] [c00628d0] vm_normal_page+0x7c/0xb4
<4>[cd659e00] [c00630b4] follow_page+0xf4/0x1f0
<4>[cd659e20] [c00645e4] __get_user_pages+0x130/0x3ec
<4>[cd659e80] [c0064b28] make_pages_present+0x8c/0xc4
<4>[cd659e90] [c0066780] mlock_vma_pages_range+0x74/0x9c
<4>[cd659eb0] [c0068efc] mmap_region+0x1dc/0x3c8
<4>[cd659f10] [c00037b8] sys_mmap+0x78/0x100
<4>[cd659f40] [c000e558] ret_from_syscall+0x0/0x3c

=20

I do not understand why the first page of the buffer is determined to be
a bad page? Do I need to perform any initialization to the buffer pages
after allocation and prior to the application calling mmap or do I need
to set a specific vm flag(s)?=20


Any comments or advice would be appreciated.

thanks

=20

=20

John Price  <john.p.price@l-3com.com
<blocked::mailto:john.p.price@l-3com.com> >=20

781-970-1743
L-3 Communications
Security & Detection Systems Division,=20
10E Commerce Way, Woburn, MA 01801


------_=_NextPart_002_01CA2A3E.E0F5689B
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<meta http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:Verdana;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0in;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Arial","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
p.MsoAcetate, li.MsoAcetate, div.MsoAcetate
	{mso-style-priority:99;
	mso-style-link:"Balloon Text Char";
	margin:0in;
	margin-bottom:.0001pt;
	font-size:8.0pt;
	font-family:"Tahoma","sans-serif";}
span.EmailStyle17
	{mso-style-type:personal-compose;
	font-family:"Arial","sans-serif";
	color:windowtext;}
span.BalloonTextChar
	{mso-style-name:"Balloon Text Char";
	mso-style-priority:99;
	mso-style-link:"Balloon Text";
	font-family:"Tahoma","sans-serif";}
.MsoChpDefault
	{mso-style-type:export-only;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.0in 1.0in 1.0in;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"2050" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:black'>I'm using linux kernel 2.6.29.1 I've been using the mmap =
system
call to map 4MB of contiguous kernel memory (RAM), obtained by =
get_free_pages
with order =3D=3D 10, to user space. &nbsp;One implementation I have =
uses
remap_pfn_range(), its seems to work ok, I do have other issues I just =
want to
make sure its reasonable to use the reamp_pfn_range call for what I am =
doing.<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:black'>Now in LDD3 it says not to use the remap_pfn_range() call =
because
it only gives access to reserved pages and physical addresses above the =
top of physical
memory.&nbsp; LDD3 makes reference to the using the nopage and notes =
about
maintaining proper reference counts with clusters of pages.&nbsp; The =
material
in the book on this issue seems dated.<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:black'>Is there still a limitation with using remap_pfn_range() =
remap
kernel ram to user space?<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:black'>So in a test driver I made using the &quot;fault&quot; =
(previously
called nopage) method for that purpose. <br>
<br>
here's a snipet of the fault callback;<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><span =
style=3D'font-size:10.0pt;
font-family:"Verdana","sans-serif";color:blue'>offset =3D vmf-&gt;pgoff =
&lt;&lt;
PAGE_SHIFT;<br>
if( offset &gt; dev-&gt;dma_buff_size)<br>
{<br>
printk(&quot;ds3b3_vm_fault: SIGBUS - my_offset: %#x vmf_pgoff: %#x =
page_shift:
%i \n&quot;,<br>
offset, vmf-&gt;pgoff, PAGE_SHIFT);<br>
return VM_FAULT_SIGBUS;<br>
}<br>
<br>
addr =3D (char *)vma-&gt;vm_start;<br>
addr +=3D offset;<br>
<br>
page =3D virt_to_page( addr );<br>
<br>
get_page(page);<br>
vmf-&gt;page =3D page;<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><span =
style=3D'font-size:10.0pt;
font-family:"Verdana","sans-serif";color:black'><o:p>&nbsp;</o:p></span><=
/p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:black'>When the application loads the module the following is =
printed on
the console;<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:black'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:black'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; My =
kprintfs
from the fault handler:<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><span =
style=3D'font-size:10.0pt;
font-family:"Verdana","sans-serif";color:blue'>&lt;4&gt;ds3b3_vm_fault: =
entered
- vma-&gt;vm_start: 0x48000000 vma-&gt;vm_end 0x483fd000<br>
&lt;4&gt;ds3b3_vm_fault: entered - vma-&gt;vm_flags: 0x820fb =
vma-&gt;vm_pgoff
0x0<br>
&lt;4&gt;ds3b3_vm_fault: entered - vmf-&gt;flags: 0x1 vmf-&gt;pgoff 0x0
vmf-&gt;virtual_address: 0x48000000<br>
&lt;4&gt;ds3b3_vm_fault: SUCCESS - vmf-&gt;page: =
0xc13d1000<o:p></o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><span =
style=3D'font-size:10.0pt;
font-family:"Verdana","sans-serif";color:blue'><o:p>&nbsp;</o:p></span></=
p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:blue'><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><span =
style=3D'font-size:10.0pt;
font-family:"Verdana","sans-serif"'>Kernel output to the console<span
style=3D'color:blue'>:<br>
&lt;1&gt;BUG: Bad page map in process dcb pte:880004d2 pmd:0c5ec400<br>
&lt;1&gt;addr:48000000 vm_flags:000820fb anon_vma<img width=3D15 =
height=3D15
id=3D"Picture_x0020_1" src=3D"cid:image001.gif@01CA2A1A.37C11F00"
alt=3D"http://http.cdnlayer.com/lq/images/questions/images/smilies/frown.=
gif">null)
mapping:ce4927d0 index:0<br>
&lt;1&gt;vma-&gt;vm_ops-&gt;fault: ds3b3_vm_fault+0x0/0xf8 [ds3b3]<br>
&lt;1&gt;vma-&gt;vm_file-&gt;f_op-&gt;mmap: ds3b3_nopage_mmap+0x0/0x4c =
[ds3b3]<br>
&lt;4&gt;Call Trace:<br>
&lt;4&gt;[cd659d80] [c0006bc0] show_stack+0x44/0x16c (unreliable)<br>
&lt;4&gt;[cd659dc0] [c00627c8] print_bad_pte+0x140/0x1cc<br>
&lt;4&gt;[cd659df0] [c00628d0] vm_normal_page+0x7c/0xb4<br>
&lt;4&gt;[cd659e00] [c00630b4] follow_page+0xf4/0x1f0<br>
&lt;4&gt;[cd659e20] [c00645e4] __get_user_pages+0x130/0x3ec<br>
&lt;4&gt;[cd659e80] [c0064b28] make_pages_present+0x8c/0xc4<br>
&lt;4&gt;[cd659e90] [c0066780] mlock_vma_pages_range+0x74/0x9c<br>
&lt;4&gt;[cd659eb0] [c0068efc] mmap_region+0x1dc/0x3c8<br>
&lt;4&gt;[cd659f10] [c00037b8] sys_mmap+0x78/0x100<br>
&lt;4&gt;[cd659f40] [c000e558] =
ret_from_syscall+0x0/0x3c<o:p></o:p></span></span></p>

<p class=3DMsoNormal style=3D'margin-left:.5in'><span =
style=3D'font-size:10.0pt;
font-family:"Verdana","sans-serif";color:black'><o:p>&nbsp;</o:p></span><=
/p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"Verdana","sans-serif";
color:black'>I do not understand why the first page of the buffer is =
determined
to be a bad page? Do I need to perform any initialization to the buffer =
pages
after allocation and prior to the application calling mmap or do I need =
to set
a specific vm flag(s)? <br>
<br>
<br>
Any comments or advice would be appreciated.<br>
<br>
thanks<o:p></o:p></span></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Times =
New Roman","serif";
color:blue'>John Price&nbsp; &lt;</span><span style=3D'font-size:12.0pt;
font-family:"Times New Roman","serif"'><a
href=3D"blocked::mailto:john.p.price@l-3com.com"
title=3D"blocked::mailto:john.p.price@l-3com.com"><span =
style=3D'font-size:10.0pt;
color:blue'>john.p.price@l-3com.com</span></a></span><span =
style=3D'font-size:
10.0pt;font-family:"Times New =
Roman","serif";color:blue'>&gt;&nbsp;</span><span
style=3D'font-size:12.0pt;font-family:"Times New =
Roman","serif"'><o:p></o:p></span></p>

<p class=3DMsoNormal><span style=3D'font-size:10.0pt;font-family:"Times =
New Roman","serif";
color:blue'>781-970-1743<br>
L-3 Communications<br>
Security &amp; Detection Systems Division, <br>
10E Commerce Way, Woburn, MA 01801</span><o:p></o:p></p>

</div>

</body>

</html>

------_=_NextPart_002_01CA2A3E.E0F5689B--

------_=_NextPart_001_01CA2A3E.E0F5689B
Content-Type: image/gif;
	name="image001.gif"
Content-Transfer-Encoding: base64
Content-ID: <image001.gif@01CA2A1A.37C11F00>
Content-Description: image001.gif
Content-Location: image001.gif

R0lGODlhDwAPANU/AP/4oNLLfs7IfNXPgN/Yhv/3m//7zv/4p//5sd3WhP/83P/6vf/3nf/4q/ry
lv/70v/5sP/81f31mO7nj//4ov/7x8rDef/7yvHqkcO9dcfBd+bfiv/6wP/3mf/4pf/7ydzVhP72
mP/70f/83f/7y//6vP/4qvbulP/82cK8dfjwlerjjP/82P/5r//5tcvFevnxlf/7xv/6v//4o//5
tOjhi+Hah9TNf//6wtnSgvz0l//6u+PciMG7dAAAAKSkpCH5BAEAAD8ALAAAAAAPAA8AAAaTwJ9Q
6CsWh8hfUcF6XDhHpE8x8kUMMR/k4Bv6WCiroSKj+RiOrvLhE5FwO1cD4MN0fZXLpwgxces1NkUL
CyVFAAwFRRsJA0UICC0NFAUdEicrCQEvRR4zFAAFEjowEwQBGilFIQ4qJ0ZFAhk9PXcTKz48BCAD
Fj60aj4bBDk3AhaztLVeAwIayspqXr/QUUlKsElBADs=

------_=_NextPart_001_01CA2A3E.E0F5689B--
