Return-Path: <dennis@loop.com.tw>
Received: from loop.com.tw (mail02.loop.com.tw [211.23.53.221])
	by ozlabs.org (Postfix) with ESMTP id 5D838679EB
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Jun 2005 23:40:05 +1000 (EST)
Message-ID: <010301c56c2f$7fbb4810$0102000a@loop.com.tw>
From: "Nai-Hsien" <dennis@loop.com.tw>
To: "Andrew Williams" <awilliam@nortel.com>, <linuxppc-embedded@ozlabs.org>
References: <713043CE8B8E1348AF3C546DBE02C1B403AC5D5C@zcarhxm2.corp.nortel.com>
Date: Wed, 8 Jun 2005 21:39:24 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0100_01C56C72.8A274C70"
Subject: Re: MPC8272 runs application with segmentation fault
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

------=_NextPart_000_0100_01C56C72.8A274C70
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

MessageAndrew,
I believe I already modify my u-boot to detect the processor.

If I statically link my program, I find that the program can run
on my MPC8272 platform properly, so I think maybe the problem
is caused by shared library. However, the same file system (of course,
same shared library) can run on my MPC8245 platform.

With the observation, I think my kernel is not handling shared library
properly. Is there any part of the kernel I should check?

I added some code in do_page_fault() to dump some information, shown
as below, when my program get problem.

PID=3D34(console): Trap=3D300, NIP=3D0x0ffc6d90, LR=3D0x0ffc6d20, VM: =
(start=3D0x30000000,
end=3D0x30017000, flags=3D0x00000875), addr=3D0x2e313056
Segmentation fault

Thank you
Dennis

  ----- Original Message -----=20
  From: Andrew Williams=20
  To: Nai-Hsien ; linuxppc-embedded@ozlabs.org=20
  Sent: Tuesday, June 07, 2005 10:17 PM
  Subject: RE: MPC8272 runs application with segmentation fault


  Take a alook at the checkcpu() routine in /cpu/mpc8260/cpu.c .
  Validate that your CPU is correctly being identified, and thus =
initialized.=20
  We had identical symptoms with the 8270.=20

  We added the following after the case for the PVR_8260_HIP7:
    =20
          case PVR_8280a_HIP7:
          case PVR_8280_HIP7:
                  k =3D 7;
                  printf (CPU_ID_STR " (HiP%d Rev %02x, Mask ", k, rev);
                  break;

  include/asm-ppc/processor.h

      #define PVR_8280_HIP7   0x80822013=20
      #define PVR_8280a_HIP7   0x80822014=20

  A.
    -----Original Message-----
    From: linuxppc-embedded-bounces@ozlabs.org =
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Nai-Hsien
    Sent: June 7, 2005 9:11 AM
    To: linuxppc-embedded@ozlabs.org
    Subject: MPC8272 runs application with segmentation fault


    Dear experts,

    I have two hardware boards, one uses MPC8245 and the other one uses =
MPC8272.
    Initially, I use the MPC8245 board to port Linux 2.4.20 and write =
some applications.
    I already do a lot of test on the MPC8245 board and all my =
application programs work
    fine.

    After this, I use the same kernel configuration and same file system =
that are being used
    by the MPC8245 board to port the whole system to my MPC8272.
    Now, I can boot the kernel and run busybox well. However, when
    I run my application programs, I always get segmentation fault. =
Following is a strace
    dump. Could anybody give me some idea?

    Thank you
    Dennis

    =
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
    execve("sbin/console", ["sbin/console"], [/* 6 vars */]) =3D 0
    uname({sys=3D"Linux", node=3D"6200_linux", ...}) =3D 0
    brk(0)                                  =3D 0x10059134
    open("/etc/ld.so.preload", O_RDONLY)    =3D -1 ENOENT (No such file =
or directory)
    open("/etc/ld.so.cache", O_RDONLY)      =3D -1 ENOENT (No such file =
or directory)
    open("/lib/libncurses.so.5", O_RDONLY)  =3D 3
    read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\001"..., =
1024) =3D 1024
    fstat64(0x3, 0x7ffff098)                =3D 0
    mmap(0xff97000, 362628, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0xff97000
    mprotect(0xffd4000, 112772, PROT_NONE)  =3D 0
    mmap(0xffd7000, 86016, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED, 3, 0x30000) =3D 0xffd7000
    mmap(0xffec000, 14468, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0xffec000
    close(3)                                =3D 0
    open("/lib/libdl.so.2", O_RDONLY)       =3D 3
    read(3, =
"\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\34"..., 1024) =3D =
1024
    fstat64(0x3, 0x7ffff078)                =3D 0
    mmap(0xff74000, 74812, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0xff74000
    mprotect(0xff77000, 62524, PROT_NONE)   =3D 0
    mmap(0xff84000, 12288, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED, 3, 0) =3D 0xff84000
    close(3)                                =3D 0
    open("/lib/libnsl.so.1", O_RDONLY)      =3D 3
    read(3, =
"\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0A\274"..., 1024) =
=3D 1024
    fstat64(0x3, 0x7ffff058)                =3D 0
    mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, =
-1, 0) =3D 0x30017000
    mmap(0xff3e000, 152068, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0xff3e000
    mprotect(0xff51000, 74244, PROT_NONE)   =3D 0
    mmap(0xff5e000, 12288, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED, 3, 0x10000) =3D 0xff5e000
    mmap(0xff61000, 8708, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0xff61000
    close(3)                                =3D 0
    open("/lib/libc.so.6", O_RDONLY)        =3D 3
    read(3, =
"\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\322"..., 1024) =3D =
1024
    fstat64(0x3, 0x7ffff038)                =3D 0
    mmap(0xfddd000, 1379388, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) =3D =
0xfddd000
    mprotect(0xff16000, 97340, PROT_NONE)   =3D 0
    mmap(0xff1d000, 61440, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED, 3, 0x130000) =3D 0xff1d000
    mmap(0xff2c000, 7228, PROT_READ|PROT_WRITE|PROT_EXEC, =
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) =3D 0xff2c000
    close(3)                                =3D 0
    brk(0)                                  =3D 0x10059134
    brk(0x1005a134)                         =3D 0x1005a134
    brk(0x1005b000)                         =3D 0x1005b000
    write(2, "before init_ncurses()\n", 22) =3D 22
    write(2, "before initscr()\n", 17)      =3D 17
    access("/usr/share/terminfo/v/vt100", R_OK) =3D 0
    open("/usr/share/terminfo/v/vt100", O_RDONLY) =3D 3
    read(3, "\32\1,\0\25\0\7\0\16\1\3\2", 12) =3D 12
    read(3, "vt100|vt100-am|dec vt100 (w/adva"..., 44) =3D 44
    read(3, "\0\1\0\0\1\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\1", 21) =3D 21
    read(3, "\0", 1)                        =3D 1
    read(3, "P\0\10\0\30\0\377\377\377\377\377\377\3\0", 14) =3D 14
    read(3, =
"\377\377\0\0\2\0\4\0\25\0\32\0&\0.\0\377\377\377\3777\0"..., 540) =3D =
540
    read(3, "\7\0\r\0\33[%i%p1%d;%p2%dr\0\33[3g\0\33[H\33[J"..., 515) =
=3D 515
    read(3, "", 1)                          =3D 0
    read(3, "", 10)                         =3D 0
    close(3)                                =3D 0
    -- SIGSEGV (Segmentation fault) @ 0 (0) ---
    +++ killed by SIGSEGV +++
    Segmentation fault


------=_NextPart_000_0100_01C56C72.8A274C70
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>Message</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3D"Times New Roman">Andrew,</FONT></DIV>
<DIV><FONT face=3D"Times New Roman">I believe I already modify my u-boot =
to detect=20
the processor.</FONT></DIV>
<DIV><FONT face=3D"Times New Roman"></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Times New Roman">If I statically link my program, I =
find that=20
the program can run</FONT></DIV>
<DIV><FONT face=3D"Times New Roman">on my MPC8272 platform properly, so =
I think=20
maybe the problem</FONT></DIV>
<DIV><FONT face=3D"Times New Roman">is caused by shared library. =
However, the same=20
file system (of course,</FONT></DIV>
<DIV><FONT face=3D"Times New Roman">same shared library) can run on my =
MPC8245=20
platform.</FONT></DIV>
<DIV><FONT face=3D"Times New Roman"></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Times New Roman">With the observation, I think my =
kernel is not=20
handling shared library</FONT></DIV>
<DIV><FONT face=3D"Times New Roman">properly. Is there any part of the =
kernel I=20
should check?</FONT></DIV>
<DIV><FONT face=3D"Times New Roman"></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Times New Roman">I added some code in do_page_fault() =
to dump=20
some information, shown</FONT></DIV>
<DIV><FONT face=3D"Times New Roman">as below,&nbsp;when my </FONT><FONT=20
face=3D"Times New Roman">program get problem.</FONT></DIV>
<DIV><FONT face=3D"Times New Roman"></FONT>&nbsp;</DIV>
<DIV>
<DIV><FONT face=3D"Times New Roman">PID=3D34(console): Trap=3D300, =
NIP=3D0x0ffc6d90,=20
LR=3D0x0ffc6d20, VM: (start=3D0x30000000,</FONT></DIV>
<DIV><FONT face=3D"Times New Roman">end=3D0x30017000, =
flags=3D0x00000875),=20
addr=3D0x2e313056<BR>Segmentation fault</FONT></DIV>
<DIV><FONT face=3D"Times New Roman"></FONT>&nbsp;</DIV>
<DIV><FONT face=3D"Times New Roman">Thank you</FONT></DIV></DIV>
<DIV><FONT face=3D"Times New Roman">Dennis</FONT></DIV>
<DIV><FONT face=3D"Times New Roman"></FONT>&nbsp;</DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt =B7s=B2=D3=A9=FA=C5=E9">----- Original =
Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt =B7s=B2=D3=A9=FA=C5=E9; =
font-color: black"><B>From:</B>=20
  <A title=3Dawilliam@nortel.com =
href=3D"mailto:awilliam@nortel.com">Andrew=20
  Williams</A> </DIV>
  <DIV style=3D"FONT: 10pt =B7s=B2=D3=A9=FA=C5=E9"><B>To:</B> <A =
title=3Ddennis@loop.com.tw=20
  href=3D"mailto:dennis@loop.com.tw">Nai-Hsien</A> ; <A=20
  title=3Dlinuxppc-embedded@ozlabs.org=20
  =
href=3D"mailto:linuxppc-embedded@ozlabs.org">linuxppc-embedded@ozlabs.org=
</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt =B7s=B2=D3=A9=FA=C5=E9"><B>Sent:</B> Tuesday, =
June 07, 2005 10:17=20
PM</DIV>
  <DIV style=3D"FONT: 10pt =B7s=B2=D3=A9=FA=C5=E9"><B>Subject:</B> RE: =
MPC8272 runs application with=20
  segmentation fault</DIV>
  <DIV><BR></DIV>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D565480514-07062005>Take=20
  a alook at the checkcpu() routine in /cpu/mpc8260/cpu.c =
.</SPAN></FONT></DIV>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
  class=3D565480514-07062005>Validate that your CPU is correctly being =
identified,=20
  and thus initialized. </SPAN></FONT></DIV>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D565480514-07062005>We=20
  had identical symptoms with </SPAN></FONT><FONT face=3DArial =
color=3D#0000ff=20
  size=3D2><SPAN class=3D565480514-07062005>the 8270. =
</SPAN></FONT></DIV>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
  class=3D565480514-07062005></SPAN></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN =
class=3D565480514-07062005>We=20
  added the following after the case for the =
PVR_8260_HIP7:</SPAN></FONT></DIV>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
  class=3D565480514-07062005>&nbsp;&nbsp; </SPAN></FONT></DIV>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
  class=3D565480514-07062005>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
case=20
  PVR_8280a_HIP7:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case=20
  =
PVR_8280_HIP7:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  k =3D=20
  =
7;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;=20
  printf (CPU_ID_STR " (HiP%d Rev %02x, Mask ", k,=20
  =
rev);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;=20
  break;</SPAN></FONT></DIV>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
  class=3D565480514-07062005></SPAN></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
  =
class=3D565480514-07062005>include/asm-ppc/processor.h</SPAN></FONT></DIV=
>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
  class=3D565480514-07062005></SPAN></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
  class=3D565480514-07062005>&nbsp;&nbsp;&nbsp;&nbsp;#define=20
  PVR_8280_HIP7&nbsp;&nbsp; 0x80822013 </SPAN></FONT></DIV>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
  class=3D565480514-07062005>&nbsp;&nbsp;&nbsp; #define =
PVR_8280a_HIP7&nbsp;&nbsp;=20
  0x80822014 </SPAN></FONT></DIV>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
  class=3D565480514-07062005></SPAN></FONT>&nbsp;</DIV>
  <DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
  class=3D565480514-07062005>A.</SPAN></FONT></DIV>
  <BLOCKQUOTE dir=3Dltr=20
  style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px =
solid; MARGIN-RIGHT: 0px">
    <DIV></DIV>
    <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr =
align=3Dleft><FONT=20
    face=3DTahoma size=3D2>-----Original Message-----<BR><B>From:</B>=20
    linuxppc-embedded-bounces@ozlabs.org=20
    [mailto:linuxppc-embedded-bounces@ozlabs.org] <B>On Behalf Of=20
    </B>Nai-Hsien<BR><B>Sent:</B> June 7, 2005 9:11 AM<BR><B>To:</B>=20
    linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> MPC8272 runs =
application=20
    with segmentation fault<BR><BR></FONT></DIV>
    <DIV><FONT face=3D"Times New Roman">Dear experts,</FONT></DIV>
    <DIV><FONT face=3D"Times New Roman"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"Times New Roman">I have two hardware boards, one =
uses=20
    MPC8245 and the other one uses MPC8272.</FONT></DIV>
    <DIV><FONT face=3D"Times New Roman">Initially, I use the MPC8245 =
board to port=20
    Linux 2.4.20 and write some applications.</FONT></DIV>
    <DIV><FONT face=3D"Times New Roman">I already do a lot of test on =
the MPC8245=20
    board and all my application programs work</FONT></DIV>
    <DIV><FONT face=3D"Times New Roman">fine.</FONT></DIV>
    <DIV><FONT face=3D"Times New Roman"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"Times New Roman">After this, I use the same =
kernel=20
    configuration&nbsp;and same file system that are being =
used</FONT></DIV>
    <DIV><FONT face=3D"Times New Roman">by the MPC8245 board to port the =
whole=20
    system to </FONT><FONT face=3D"Times New Roman">my =
MPC8272.</FONT></DIV>
    <DIV><FONT face=3D"Times New Roman">Now, I can boot the kernel and =
run busybox=20
    well. However, when</FONT></DIV>
    <DIV><FONT face=3D"Times New Roman">I run my application programs, I =
always=20
    get segmentation fault. Following is a strace</FONT></DIV>
    <DIV><FONT face=3D"Times New Roman">dump. Could anybody give me some =

    idea?</FONT></DIV>
    <DIV><FONT face=3D"Times New Roman"></FONT>&nbsp;</DIV>
    <DIV><FONT face=3D"Times New Roman">Thank you</FONT></DIV>
    <DIV><FONT face=3D"Times New Roman">Dennis</FONT></DIV>
    <DIV><FONT face=3D"Times New Roman"></FONT>&nbsp;</DIV>
    <DIV><FONT=20
    face=3D"Times New =
Roman">=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D</FONT></DIV>
    <DIV><FONT face=3D"Times New Roman">execve("sbin/console", =
["sbin/console"],=20
    [/* 6 vars */]) =3D 0<BR>uname({sys=3D"Linux", node=3D"6200_linux", =
...}) =3D=20
    =
0<BR>brk(0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    =3D 0x10059134<BR>open("/etc/ld.so.preload", =
O_RDONLY)&nbsp;&nbsp;&nbsp; =3D -1=20
    ENOENT (No such file or directory)<BR>open("/etc/ld.so.cache",=20
    O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D -1 ENOENT (No such file =
or=20
    directory)<BR>open("/lib/libncurses.so.5", O_RDONLY)&nbsp; =3D =
3<BR>read(3,=20
    "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\001"..., 1024) =
=3D=20
    1024<BR>fstat64(0x3,=20
    =
0x7ffff098)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    =3D 0<BR>mmap(0xff97000, 362628, PROT_READ|PROT_EXEC, MAP_PRIVATE, =
3, 0) =3D=20
    0xff97000<BR>mprotect(0xffd4000, 112772, PROT_NONE)&nbsp; =3D=20
    0<BR>mmap(0xffd7000, 86016, PROT_READ|PROT_WRITE|PROT_EXEC,=20
    MAP_PRIVATE|MAP_FIXED, 3, 0x30000) =3D 0xffd7000<BR>mmap(0xffec000, =
14468,=20
    PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, =
-1, 0)=20
    =3D=20
    =
0xffec000<BR>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    =3D 0<BR>open("/lib/libdl.so.2", =
O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    =3D 3<BR>read(3, =
"\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\34"...,=20
    1024) =3D 1024<BR>fstat64(0x3,=20
    =
0x7ffff078)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    =3D 0<BR>mmap(0xff74000, 74812, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, =
0) =3D=20
    0xff74000<BR>mprotect(0xff77000, 62524, PROT_NONE)&nbsp;&nbsp; =3D=20
    0<BR>mmap(0xff84000, 12288, PROT_READ|PROT_WRITE|PROT_EXEC,=20
    MAP_PRIVATE|MAP_FIXED, 3, 0) =3D=20
    =
0xff84000<BR>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    =3D 0<BR>open("/lib/libnsl.so.1", =
O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=20
    3<BR>read(3, =
"\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0A\274"...,=20
    1024) =3D 1024<BR>fstat64(0x3,=20
    =
0x7ffff058)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    =3D 0<BR>mmap(NULL, 4096, PROT_READ|PROT_WRITE, =
MAP_PRIVATE|MAP_ANONYMOUS, -1,=20
    0) =3D 0x30017000<BR>mmap(0xff3e000, 152068, PROT_READ|PROT_EXEC, =
MAP_PRIVATE,=20
    3, 0) =3D 0xff3e000<BR>mprotect(0xff51000, 74244, =
PROT_NONE)&nbsp;&nbsp; =3D=20
    0<BR>mmap(0xff5e000, 12288, PROT_READ|PROT_WRITE|PROT_EXEC,=20
    MAP_PRIVATE|MAP_FIXED, 3, 0x10000) =3D 0xff5e000<BR>mmap(0xff61000, =
8708,=20
    PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, =
-1, 0)=20
    =3D=20
    =
0xff61000<BR>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    =3D 0<BR>open("/lib/libc.so.6",=20
    O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D 3<BR>read(3, =

    "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\322"..., 1024) =
=3D=20
    1024<BR>fstat64(0x3,=20
    =
0x7ffff038)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    =3D 0<BR>mmap(0xfddd000, 1379388, PROT_READ|PROT_EXEC, MAP_PRIVATE, =
3, 0) =3D=20
    0xfddd000<BR>mprotect(0xff16000, 97340, PROT_NONE)&nbsp;&nbsp; =3D=20
    0<BR>mmap(0xff1d000, 61440, PROT_READ|PROT_WRITE|PROT_EXEC,=20
    MAP_PRIVATE|MAP_FIXED, 3, 0x130000) =3D 0xff1d000<BR>mmap(0xff2c000, =
7228,=20
    PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, =
-1, 0)=20
    =3D=20
    =
0xff2c000<BR>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    =3D=20
    =
0<BR>brk(0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    =3D=20
    =
0x10059134<BR>brk(0x1005a134)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    =3D=20
    =
0x1005a134<BR>brk(0x1005b000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    =3D 0x1005b000<BR>write(2, "before init_ncurses()\n", 22) =3D =
22<BR>write(2,=20
    "before initscr()\n", 17)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =3D=20
    17<BR>access("/usr/share/terminfo/v/vt100", R_OK) =3D=20
    0<BR>open("/usr/share/terminfo/v/vt100", O_RDONLY) =3D 3<BR>read(3,=20
    "\32\1,\0\25\0\7\0\16\1\3\2", 12) =3D 12<BR>read(3, =
"vt100|vt100-am|dec vt100=20
    (w/adva"..., 44) =3D 44<BR>read(3,=20
    "\0\1\0\0\1\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\1", 21) =3D 21<BR>read(3, =
"\0",=20
    =
1)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    =3D 1<BR>read(3, "P\0\10\0\30\0\377\377\377\377\377\377\3\0", 14) =
=3D=20
    14<BR>read(3,=20
    "\377\377\0\0\2\0\4\0\25\0\32\0&amp;\0.\0\377\377\377\3777\0"..., =
540) =3D=20
    540<BR>read(3, "\7\0\r\0\33[%i%p1%d;%p2%dr\0\33[3g\0\33[H\33[J"..., =
515) =3D=20
    515<BR>read(3, "",=20
    =
1)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=20
    =3D 0<BR>read(3, "",=20
    =
10)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;=20
    =3D=20
    =
0<BR>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
    =3D 0<BR>-- SIGSEGV (Segmentation fault) @ 0 (0) ---<BR>+++ killed =
by SIGSEGV=20
    +++</FONT></DIV>
    <DIV><FONT face=3D"Times New Roman">Segmentation fault</FONT></DIV>
    <DIV><FONT face=3D"Times New Roman"></FONT>&nbsp;</DIV>
    <DIV><FONT=20
face=3D"Times New =
Roman"></FONT>&nbsp;</DIV></BLOCKQUOTE></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_0100_01C56C72.8A274C70--
