Return-Path: <tmike@recipes4linux.com>
Received: from smtpauth05.mail.atl.earthlink.net
	(smtpauth05.mail.atl.earthlink.net [209.86.89.65])
	by ozlabs.org (Postfix) with ESMTP id AA9E667EB7
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Aug 2005 00:39:06 +1000 (EST)
From: "T Michael Turney" <tmike@recipes4linux.com>
To: <murahari@samsung.com>,
	<linuxppc-dev@ozlabs.org>
Date: Thu, 11 Aug 2005 07:29:21 -0700
Message-ID: <GEEKLLHMFHLAJOBEEELHMEICDAAA.tmike@recipes4linux.com>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0017_01C59E46.64070C50"
In-Reply-To: <0IL100L2IEO6NG@ms13.samsung.com>
Subject: RE: copy_from_user problem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_0017_01C59E46.64070C50
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit

Samsung Enterprise Portal mySingleMurahari,
I always start simple and work up to the harder things.  Try to access a
single
long word in the ioctl, e.g.,

int

chr1_ioctl(struct inode *ino, struct file *filp, unsigned int cmd, unsigned
long arg)

{

   int ret = 0;

  unsigned int userdata;



   switch(cmd)

   {

      case IOCTL_WIN_DEBUG_READ_CODE:

      {

        ret = get_user(userdata, (unsigned int *)arg);

        ......

         }

}

}



The two O'Reilly books, Linux Device Drivers and Understanding the Linux
Kernel are also good

references for how to use the get_user and copy_from_user macros.

Hope this helps.

Cheers,

T.mike

  -----Original Message-----
  From: linuxppc-dev-bounces@ozlabs.org
[mailto:linuxppc-dev-bounces@ozlabs.org]On Behalf Of V MURAHARI
  Sent: Wednesday, August 10, 2005 7:53 PM
  To: linuxppc-dev@ozlabs.org
  Subject: copy_from_user problem



  Hello,

  I am working on a character driver for reading and writing the registers
to FPGA in our system.

  I am using driver ioctl to read/write to these registers of FPGA. As the
function call to the ioctl is being made, the printk trace shows that the
call goes to switch->copy_from_user. As soon as the call is made to
copy_from_user, the kernel crashes

  Can someone help me with this problem?




****************************************************************************
***********************

   Unhandled kernel unaligned access in
unaligned.c::emulate_load_store_insn, line 483

  :

  $0 : 00000000 10001f00 8fbf0034 02a01021 801157a0 8fe8e000 10001f00
ffff00ff

  $8 : 8fe8ffe0 00001f00 00000000 00000003 74652053 8fe9fed8 0000000a
50434942

  $16: 10001f01 00000001 801157a0 0000000f 8fe8fee8 00000104 00000000
0000000f

  $24: 00000000 2ac0fdb0                   8fe8e000 8fe8fe38 00000001
8012010c

  Hi : 00000000

  Lo : 00000000

  epc  : 8011f774    Tainted: GF

  Status: 10001f02

  Cause : 00800014

  Process rsgbm (pid: 317, stackpage=8fe8e000)

  Stack:    802d920a 0000000a 10001f01 0000003c 10001f01 0000003c 8012010c

   80120104 caa8f356 8fe82008 8fe82000 0000000f 00000000 7fff7d00 7fff7d00

   0000c001 00000003 10012808 ffffffff caa8e548 00004000 8fe9e272 00000150

   7fff7d00 ffffffea 00000000 00000240 8fe82000 00000000 00000001 00000001

   7ebff310 00000000 0000000f 8fef24e0 00000004 7ebff3e8 00000000 0000002e

   80159c6c ...

  Call Trace:   [<8012010c>] [<80120104>] [<caa8f356>] [<caa8e548>]
[<80159c6c>]

   [<8010a5c4>] [<80271dc4>]



  Code: 8c820004  24110001  ac430000 <ac620004> ac800000  ac800004  ac800000
ac800004

    8f820004



  Unit Fault Handler !!! (INDEX=10)


****************************************************************************
**********************

  int

  chr1_ioctl(struct inode *ino, struct file *filp, unsigned int cmd,

        unsigned long arg)

  {

     int ret = 0;

     n2_debug_rw_reg *dw;



     switch(cmd)

     {

        case IOCTL_WIN_DEBUG_READ_CODE:

        {

     n2_debug_rw_reg test;

          printk("%s %d\n", current->comm, current->pid);

          printk("%lx\n", arg);

          copy_from_user(&test, (n2_debug_rw_reg*)arg,
sizeof(n2_debug_rw_reg));

          printk("%lx %lx\n", ((n2_debug_rw_reg*)arg)->data,
((n2_debug_rw_reg*)arg)->

  addr);

           }

  }

  }



  Thanks & Regards,

  --Murahari

------=_NextPart_000_0017_01C59E46.64070C50
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Samsung Enterprise Portal mySingle</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dwindows-1252">
<STYLE>P {
	MARGIN-TOP: 5px; FONT-SIZE: 9pt; MARGIN-BOTTOM: 5px; FONT-FAMILY: =
Arial, arial
}
TD {
	MARGIN-TOP: 5px; FONT-SIZE: 9pt; MARGIN-BOTTOM: 5px; FONT-FAMILY: =
Arial, arial
}
LI {
	MARGIN-TOP: 5px; FONT-SIZE: 9pt; MARGIN-BOTTOM: 5px; FONT-FAMILY: =
Arial, arial
}
</STYLE>

<META content=3D"MSHTML 6.00.2800.1458" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D372591414-11082005>Murahari,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D372591414-11082005>I=20
always start simple and work up to the harder things.&nbsp; Try to =
access a=20
single</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D372591414-11082005>long=20
word in the ioctl, e.g.,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D372591414-11082005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2><SPAN class=3D372591414-11082005>
<P><FONT color=3D#0000ff>int</FONT></P>
<P><FONT color=3D#0000ff>chr1_ioctl(struct inode *ino, struct file =
*filp, unsigned=20
int cmd,<SPAN class=3D372591414-11082005> </SPAN>unsigned long =
arg)</FONT></P>
<P><FONT color=3D#0000ff>{</FONT></P>
<P><FONT color=3D#0000ff>&nbsp;&nbsp;&nbsp;int ret =3D 0;</FONT></P>
<P><SPAN class=3D372591414-11082005><FONT color=3D#0000ff>&nbsp; =
unsigned int=20
userdata;</FONT></SPAN></P>
<P><FONT color=3D#0000ff size=3D2></FONT>&nbsp;</P>
<P><FONT color=3D#0000ff>&nbsp;&nbsp;&nbsp;switch(cmd)</FONT></P>
<P><FONT color=3D#0000ff>&nbsp;&nbsp;&nbsp;{</FONT></P>
<P><FONT color=3D#0000ff>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case=20
IOCTL_WIN_DEBUG_READ_CODE:</FONT></P>
<P><FONT =
color=3D#0000ff>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{</FONT></P>
<P><SPAN class=3D372591414-11082005><FONT=20
color=3D#0000ff>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <FONT =
size=3D2>ret =3D=20
get_user(userdata, (unsigned int *)arg);</FONT></FONT></SPAN></P>
<P><FONT color=3D#0000ff><SPAN class=3D372591414-11082005><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;......</FONT></S=
PAN>&nbsp;</FONT></P>
<P><FONT=20
color=3D#0000ff>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}</=
FONT></P>
<P><FONT color=3D#0000ff>}</FONT></P>
<P><FONT color=3D#0000ff>}</FONT></P>
<P><FONT color=3D#0000ff size=3D2><SPAN=20
class=3D372591414-11082005></SPAN></FONT>&nbsp;</P>
<P><FONT color=3D#0000ff size=3D2><SPAN class=3D372591414-11082005>The =
two O'Reilly=20
books, Linux Device Drivers and Understanding the Linux Kernel are also=20
good</SPAN></FONT></P>
<P><FONT color=3D#0000ff size=3D2><SPAN =
class=3D372591414-11082005>references for how=20
to use the get_user and copy_from_user macros.</SPAN></FONT></P>
<P><FONT color=3D#0000ff size=3D2><SPAN class=3D372591414-11082005>Hope =
this=20
helps.</SPAN></FONT></P>
<P><FONT color=3D#0000ff size=3D2><SPAN=20
class=3D372591414-11082005>Cheers,</SPAN></FONT></P>
<P><FONT color=3D#0000ff size=3D2><SPAN=20
class=3D372591414-11082005>T.mike</SPAN></FONT></P></SPAN></FONT></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
  <DIV class=3DOutlookMessageHeader dir=3Dltr align=3Dleft><FONT =
face=3DTahoma=20
  size=3D2>-----Original Message-----<BR><B>From:</B>=20
  linuxppc-dev-bounces@ozlabs.org =
[mailto:linuxppc-dev-bounces@ozlabs.org]<B>On=20
  Behalf Of </B>V MURAHARI<BR><B>Sent:</B> Wednesday, August 10, 2005 =
7:53=20
  PM<BR><B>To:</B> linuxppc-dev@ozlabs.org<BR><B>Subject:</B> =
copy_from_user=20
  problem<BR><BR></FONT></DIV>
  <P>
  <P>Hello,=20
  <P>I am working on a character driver for reading and writing the =
registers to=20
  FPGA in our system.</P>
  <P>I am using driver ioctl to read/write to these registers of FPGA. =
As the=20
  function call to the ioctl is being made, the printk trace shows that =
the call=20
  goes to switch-&gt;copy_from_user. As soon as the call is made to=20
  copy_from_user, the kernel crashes</P>
  <P>Can someone help me with this problem?</P>
  <P>&nbsp;</P>
  =
<P>**********************************************************************=
*****************************</P>
  <P>&nbsp;Unhandled kernel unaligned access in=20
  unaligned.c::emulate_load_store_insn, line 483</P>
  <P>:</P>
  <P>$0 : 00000000 10001f00 8fbf0034 02a01021 801157a0 8fe8e000 10001f00 =

  ffff00ff</P>
  <P>$8 : 8fe8ffe0 00001f00 00000000 00000003 74652053 8fe9fed8 0000000a =

  50434942</P>
  <P>$16: 10001f01 00000001 801157a0 0000000f 8fe8fee8 00000104 00000000 =

  0000000f</P>
  <P>$24: 00000000 2ac0fdb0=20
  =
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;8fe8e000=20
  8fe8fe38 00000001 8012010c</P>
  <P>Hi : 00000000</P>
  <P>Lo : 00000000</P>
  <P>epc &nbsp;: 8011f774 &nbsp;&nbsp;&nbsp;Tainted: GF</P>
  <P>Status: 10001f02</P>
  <P>Cause : 00800014</P>
  <P>Process rsgbm (pid: 317, stackpage=3D8fe8e000)</P>
  <P>Stack: &nbsp;&nbsp;&nbsp;802d920a 0000000a 10001f01 0000003c =
10001f01=20
  0000003c 8012010c</P>
  <P>&nbsp;80120104 caa8f356 8fe82008 8fe82000 0000000f 00000000 =
7fff7d00=20
  7fff7d00</P>
  <P>&nbsp;0000c001 00000003 10012808 ffffffff caa8e548 00004000 =
8fe9e272=20
  00000150</P>
  <P>&nbsp;7fff7d00 ffffffea 00000000 00000240 8fe82000 00000000 =
00000001=20
  00000001</P>
  <P>&nbsp;7ebff310 00000000 0000000f 8fef24e0 00000004 7ebff3e8 =
00000000=20
  0000002e</P>
  <P>&nbsp;80159c6c ...</P>
  <P>Call Trace: &nbsp;&nbsp;[&lt;8012010c&gt;] [&lt;80120104&gt;]=20
  [&lt;caa8f356&gt;] [&lt;caa8e548&gt;] [&lt;80159c6c&gt;]</P>
  <P>&nbsp;[&lt;8010a5c4&gt;] [&lt;80271dc4&gt;]</P>
  <P>&nbsp;</P>
  <P>Code: 8c820004 &nbsp;24110001 &nbsp;ac430000 &lt;ac620004&gt; =
ac800000=20
  &nbsp;ac800004 &nbsp;ac800000 &nbsp;ac800004</P>
  <P>&nbsp;&nbsp;8f820004</P>
  <P>&nbsp;</P>
  <P>Unit Fault Handler !!! (INDEX=3D10)</P>
  =
<P>**********************************************************************=
****************************</P>
  <P>int</P>
  <P>chr1_ioctl(struct inode *ino, struct file *filp, unsigned int =
cmd,</P>
  <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;unsigned long arg)</P>
  <P>{</P>
  <P>&nbsp;&nbsp;&nbsp;int ret =3D 0;</P>
  <P>&nbsp;&nbsp;&nbsp;n2_debug_rw_reg *dw;</P>
  <P>&nbsp;</P>
  <P>&nbsp;&nbsp;&nbsp;switch(cmd)</P>
  <P>&nbsp;&nbsp;&nbsp;{</P>
  <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;case =
IOCTL_WIN_DEBUG_READ_CODE:</P>
  <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;{</P>
  <P>&nbsp;&nbsp;&nbsp;n2_debug_rw_reg test;</P>
  <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printk("%s %d\n",=20
  current-&gt;comm, current-&gt;pid);</P>
  <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printk("%lx\n", =
arg);</P>
  =
<P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;copy_from_user(&amp;te=
st,=20
  (n2_debug_rw_reg*)arg, sizeof(n2_debug_rw_reg));</P>
  <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;printk("%lx %lx\n", =

  ((n2_debug_rw_reg*)arg)-&gt;data, ((n2_debug_rw_reg*)arg)-&gt;</P>
  <P>addr);</P>
  <P>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;}</P>
  <P>}</P>
  <P>}</P>
  <P>&nbsp;</P>
  <P>Thanks &amp; Regards,</P>
  <P>--Murahari</P></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_0017_01C59E46.64070C50--
