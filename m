Return-Path: <lipovsky@cs.bu.edu>
Received: from cs3.bu.edu (cs3.bu.edu [128.197.12.8])
	by ozlabs.org (Postfix) with ESMTP id 10FD2DDEB9
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Feb 2007 09:12:12 +1100 (EST)
Received: from BosLipovskyIPC (host5.gsadvisors.net [65.206.107.5] (may be
	forged)) (authenticated bits=0)
	by cs3.bu.edu (8.13.6/8.13.6) with ESMTP id l0VM1Ynx021729
	for <linuxppc-embedded@ozlabs.org>; Wed, 31 Jan 2007 17:02:05 -0500
From: "Ilya Lipovsky" <lipovsky@cs.bu.edu>
To: <linuxppc-embedded@ozlabs.org>
Subject: Huge page support for PowerPC 32 bit and WIMG flexibility
Date: Wed, 31 Jan 2007 17:01:34 -0500
Message-ID: <000b01c74583$7166e6f0$3a0d10ac@Radstone.Local>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000C_01C74559.8890DEF0"
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

------=_NextPart_000_000C_01C74559.8890DEF0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,

 

I am not experienced in kernel development, so please be patient.

 

After exploring the latest (2.19.2) sources it appears that there is no huge
page support for the 32 bit powerpc platform. I deduced it by starting from
0x300 in head_32.S and comparing notes with head_64.S. It appears that the
only sensible path for hashing in a huge page (on 64bit ppc) is via:

 

0x300: data_access -> do_hash_page -> hash_page -> hash_huge_page

 

Unfortunately, on the 32bit, all paths that do anything useful end up in
create_hpte() found in hash_low_32.S. I noticed someone on this mailing list
claiming huge page support for IBM 44x core. Is it possible to make it
general enough to encompass ppc32 in general?

 

Another issue I have is the absence of control over hardware specific
attributes of memory such as WIMG. More concretely, I am interested in
having the ability to allocate off the heap in such a way so as to
explicitly set the M (coherency) bit off (independently of SMP or non-SMP
mode). This is needed because some multicore PowerPC platforms (e.g. 745x)
perform an extra address broadcast to guarantee cache coherency per each
store miss on a cacheline. This degrades performance for store-bound
programs.

 

I understand that hashing pages as non-cache-coherent makes data contained
therein a potential victim to cache coherency paradoxes. Nevertheless, since
I am working on high performance library, I am prepared to shift coherency
guarantees to the library, which is supposed the one managing the data flow
between memory and CPU caches intelligently.

 

So, I have 2 main questions:

 

1)       What's so special about ppc32 that it didn't get the matching
feature of huge page support that ppc64 has? Who is responsible/willing to
fix it?

2)       Is it appropriate to provide a syscall mechanism (parallel to
sys_brk, sys_mmap, and sys_shmget) to add WIMG settings?

 

Overall, the vision here is to be able (from user-side, on powerpc32) to
call:

 

shmid = shmget(2, LENGTH, SHM_HUGETLB | IPC_CREAT | SHM_R | SHM_W |
POWERPC_NONCOHERENT);

shmaddr = shmat(shmid, ADDR, SHMAT_FLAGS);

 

And get a segment mapped with wimg=0bxx0x (actually, I assume all x's are
0). This would be very nice!

 

 

Thank you,

-Ilya

 

P.S. As a side note, it is pretty difficult to read kernel sources
(especially assembly ones) because of the lack of comments for people who
are not in the kernel hacker "circle." For example, what in the whole world
is "paca??"


------=_NextPart_000_000C_01C74559.8890DEF0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
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
 /* List Definitions */
 @list l0
	{mso-list-id:1568959370;
	mso-list-type:hybrid;
	mso-list-template-ids:-455312616 67698705 67698713 67698715 67698703 =
67698713 67698715 67698703 67698713 67698715;}
@list l0:level1
	{mso-level-text:"%1\)";
	mso-level-tab-stop:.5in;
	mso-level-number-position:left;
	text-indent:-.25in;}
ol
	{margin-bottom:0in;}
ul
	{margin-bottom:0in;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DEN-US link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Hi,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I am not experienced in kernel development, so please =
be
patient.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>After exploring the latest (2.19.2) sources it =
appears that
there is no huge page support for the 32 bit powerpc platform. I deduced =
it by
starting from 0x300 in head_32.S and comparing notes with head_64.S. It =
appears
that the only sensible path for hashing in a huge page (on 64bit ppc) is =
via:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>0x300: data_access -&gt; do_hash_page -&gt; hash_page =
-&gt;
hash_huge_page<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Unfortunately, on the 32bit, all paths that do =
anything
useful end up in create_hpte() found in hash_low_32.S. I noticed someone =
on
this mailing list claiming huge page support for IBM 44x core&#8230; Is =
it
possible to make it general enough to encompass ppc32 in =
general?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Another issue I have is the absence of control over =
hardware
specific attributes of memory such as WIMG. More concretely, I am =
interested in
having the ability to allocate off the heap in such a way so as to =
explicitly<b><span
style=3D'font-weight:bold'> </span></b>set the M (coherency) bit off =
(independently
of SMP or non-SMP mode). This is needed because some multicore PowerPC
platforms (e.g. 745x) perform an extra address broadcast to guarantee =
cache coherency
per each store miss on a cacheline. This degrades performance for =
store-bound programs.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>I understand that hashing pages as non-cache-coherent =
makes
data contained therein a potential victim to cache coherency paradoxes.
Nevertheless, since I am working on high performance library, I am =
prepared to shift
coherency guarantees to the library, which is supposed the one managing =
the
data flow between memory and CPU caches =
intelligently.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>So, I have 2 main =
questions:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>1)<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>What&#8217;s
so special about ppc32 that it didn&#8217;t get the matching feature of =
huge
page support that ppc64 has? Who is responsible/willing to fix =
it?<o:p></o:p></span></font></p>

<p class=3DMsoNormal =
style=3D'margin-left:.5in;text-indent:-.25in;mso-list:l0 level1 =
lfo1'><![if !supportLists]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'><span
style=3D'mso-list:Ignore'>2)<font size=3D1 face=3D"Times New =
Roman"><span
style=3D'font:7.0pt "Times New =
Roman"'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
</span></font></span></span></font><![endif]><font
size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;font-family:Arial'>Is it appropriate
to provide a syscall mechanism (parallel to sys_brk, sys_mmap, and =
sys_shmget)
to add WIMG settings?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Overall, the vision here is to be able (from =
user-side, on powerpc32)
to call:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>shmid =3D shmget(2, =
LENGTH, SHM_HUGETLB
| IPC_CREAT | SHM_R | SHM_W | =
POWERPC_NONCOHERENT);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier New"'>shmaddr =3D =
shmat(shmid, ADDR,
SHMAT_FLAGS);<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3DArial><span
style=3D'font-size:10.0pt;font-family:Arial'>And get a segment mapped =
with wimg=3D0bxx0x
(actually, I assume all x&#8217;s are 0). This would be very =
nice!<o:p></o:p></span></font></p>

<p class=3DMsoNormal style=3D'text-autospace:none'><font size=3D2 =
face=3D"Courier New"><span
style=3D'font-size:10.0pt;font-family:"Courier =
New"'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>Thank you,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>-Ilya<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span =
style=3D'font-size:10.0pt;
font-family:Arial'>P.S. As a side note, it is pretty difficult to read =
kernel
sources (especially assembly ones) because of the lack of comments for =
people
who are not in the kernel hacker &#8220;circle.&#8221; For example, what =
in the
whole world is &#8220;paca??&#8221;<o:p></o:p></span></font></p>

</div>

</body>

</html>

------=_NextPart_000_000C_01C74559.8890DEF0--
