Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id A9AB7B7BD6
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 24 Oct 2009 04:27:55 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Jake Magee <jakemagee@gmail.com>
Date: Fri, 23 Oct 2009 11:27:45 -0600
Subject: RE: Page map BUG on program exit
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330BEA902@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330707311@midas.usurf.usu.edu>
	<a8142e730910221528j185a7d51h6caa604b8695ee50@mail.gmail.com>
In-Reply-To: <a8142e730910221528j185a7d51h6caa604b8695ee50@mail.gmail.com>
Content-Type: multipart/alternative;
	boundary="_000_BB99A6BA28709744BF22A68E6D7EB51F0330BEA902midasusurfusu_"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_000_BB99A6BA28709744BF22A68E6D7EB51F0330BEA902midasusurfusu_
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Jake,

That is exactly what I needed.  Patch 34113 worked like a charm.

Thanks for the help!

Jonathan



Here ya go Jonathan,
http://patchwork.ozlabs.org/patch/34047/
http://patchwork.ozlabs.org/patch/34113/

Both patches work for my situation, but I went with the second set as a fin=
al patch(34113).

- Jake Magee
On Thu, Oct 22, 2009 at 3:57 PM, Jonathan Haws <Jonathan.Haws@sdl.usu.edu<m=
ailto:Jonathan.Haws@sdl.usu.edu>> wrote:
All,

I am using a 405EX CPU on a custom board.  The layout and hardware is very =
similar to the AMCC Kilauea board.  Here is the output of uname -a:

Linux (none) 2.6.30.3-wolverine-dirty #3 PREEMPT Thu Sep 10 11:41:37 MDT 20=
09 ppc unknown

I am getting the following BUG output when my program exits:

BUG: Bad page map in process main  pte:980005d7 pmd:0d840400
addr:48000000 vm_flags:400844fb anon_vma:(null) mapping:cd8454f8 index:9800=
0
vma->vm_file->f_op->mmap: fpga_mmap+0x0/0x178 [fpgaDriver]
Call Trace:
[cd84dc40] [c0006f0c] show_stack+0x44/0x16c (unreliable)
[cd84dc80] [c00ba314] print_bad_pte+0x140/0x1d0
[cd84dcb0] [c00ba3ec] vm_normal_page+0x48/0x50
[cd84dcc0] [c00bb2ec] unmap_vmas+0x214/0x614
[cd84dd40] [c00bffe0] exit_mmap+0xd0/0x1b4
[cd84dd70] [c0031e40] mmput+0x50/0x134
[cd84dd80] [c0036470] exit_mm+0x114/0x13c
[cd84ddb0] [c0037d80] do_exit+0xc0/0x68c
[cd84de00] [c0038390] do_group_exit+0x44/0xd8
[cd84de10] [c0044468] get_signal_to_deliver+0x1f8/0x430
[cd84de70] [c0008224] do_signal+0x54/0x29c
[cd84df40] [c0010d5c] do_user_signal+0x74/0xc4

I have an FPGA on the PCIe bus that I am mapping BAR0 to user space with a =
call to mmap().  The mapping works just fine and I can access all the regis=
ters in the BAR without a problem.  However, on exit this comes up.

A Google search showed tons of people with similar problems in standard dis=
tributions (Ubuntu primarily), but no resolutions.

Has anyone seen this crop up before and know what the issue is?  I include =
any source code, if that is required.

Thanks!

Jonathan



_______________________________________________
Linuxppc-dev mailing list
Linuxppc-dev@lists.ozlabs.org<mailto:Linuxppc-dev@lists.ozlabs.org>
https://lists.ozlabs.org/listinfo/linuxppc-dev


--_000_BB99A6BA28709744BF22A68E6D7EB51F0330BEA902midasusurfusu_
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" xmlns:w=3D"urn:sc=
hemas-microsoft-com:office:word" xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii"=
>
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
	{color:blue;
	text-decoration:underline;}
p
	{mso-margin-top-alt:auto;
	margin-right:0in;
	mso-margin-bottom-alt:auto;
	margin-left:0in;
	font-size:12.0pt;
	font-family:"Times New Roman";}
span.EmailStyle17
	{mso-style-type:personal-reply;
	font-family:Arial;
	color:navy;}
@page Section1
	{size:8.5in 11.0in;
	margin:1.0in 1.25in 1.0in 1.25in;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DEN-US link=3Dblue vlink=3Dblue>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Jake,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>That is exactly what I needed. &nbsp;P=
atch
34113 worked like a charm.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Thanks for the help!<o:p></o:p></span>=
</font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'>Jonathan<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 color=3Dnavy face=3DArial><span style=
=3D'font-size:
10.0pt;font-family:Arial;color:navy'><o:p>&nbsp;</o:p></span></font></p>

<div style=3D'border:none;border-left:solid blue 1.5pt;padding:0in 0in 0in =
4.0pt'>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><font size=3D3
face=3D"Times New Roman"><span style=3D'font-size:12.0pt'>Here ya go Jonath=
an,<br>
<a href=3D"http://patchwork.ozlabs.org/patch/34047/">http://patchwork.ozlab=
s.org/patch/34047/</a><br>
<a href=3D"http://patchwork.ozlabs.org/patch/34113/">http://patchwork.ozlab=
s.org/patch/34113/</a><br>
<br>
Both patches work for my situation, but I went with the second set as a fin=
al
patch(34113).<br>
<br>
- Jake Magee<o:p></o:p></span></font></p>

<div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>On Thu, Oct 22, 2009 at 3:57 PM, Jonathan Haws &lt;<a
href=3D"mailto:Jonathan.Haws@sdl.usu.edu">Jonathan.Haws@sdl.usu.edu</a>&gt;
wrote:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'>All,<br>
<br>
I am using a 405EX CPU on a custom board. &nbsp;The layout and hardware is =
very
similar to the AMCC Kilauea board. &nbsp;Here is the output of uname -a:<br=
>
<br>
Linux (none) 2.6.30.3-wolverine-dirty #3 PREEMPT Thu Sep 10 11:41:37 MDT 20=
09
ppc unknown<br>
<br>
I am getting the following BUG output when my program exits:<br>
<br>
BUG: Bad page map in process main &nbsp;pte:980005d7 pmd:0d840400<br>
addr:48000000 vm_flags:400844fb anon_vma:(null) mapping:cd8454f8 index:9800=
0<br>
vma-&gt;vm_file-&gt;f_op-&gt;mmap: fpga_mmap+0x0/0x178 [fpgaDriver]<br>
Call Trace:<br>
[cd84dc40] [c0006f0c] show_stack+0x44/0x16c (unreliable)<br>
[cd84dc80] [c00ba314] print_bad_pte+0x140/0x1d0<br>
[cd84dcb0] [c00ba3ec] vm_normal_page+0x48/0x50<br>
[cd84dcc0] [c00bb2ec] unmap_vmas+0x214/0x614<br>
[cd84dd40] [c00bffe0] exit_mmap+0xd0/0x1b4<br>
[cd84dd70] [c0031e40] mmput+0x50/0x134<br>
[cd84dd80] [c0036470] exit_mm+0x114/0x13c<br>
[cd84ddb0] [c0037d80] do_exit+0xc0/0x68c<br>
[cd84de00] [c0038390] do_group_exit+0x44/0xd8<br>
[cd84de10] [c0044468] get_signal_to_deliver+0x1f8/0x430<br>
[cd84de70] [c0008224] do_signal+0x54/0x29c<br>
[cd84df40] [c0010d5c] do_user_signal+0x74/0xc4<br>
<br>
I have an FPGA on the PCIe bus that I am mapping BAR0 to user space with a =
call
to mmap(). &nbsp;The mapping works just fine and I can access all the regis=
ters
in the BAR without a problem. &nbsp;However, on exit this comes up.<br>
<br>
A Google search showed tons of people with similar problems in standard
distributions (Ubuntu primarily), but no resolutions.<br>
<br>
Has anyone seen this crop up before and know what the issue is? &nbsp;I inc=
lude
any source code, if that is required.<br>
<br>
Thanks!<br>
<br>
Jonathan<br>
<br>
<br>
<br>
_______________________________________________<br>
Linuxppc-dev mailing list<br>
<a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.ozlabs.=
org</a><br>
<a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_blank=
">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><o:p></o:p></span></fon=
t></p>

</div>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span style=3D=
'font-size:
12.0pt'><o:p>&nbsp;</o:p></span></font></p>

</div>

</div>

</body>

</html>

--_000_BB99A6BA28709744BF22A68E6D7EB51F0330BEA902midasusurfusu_--
