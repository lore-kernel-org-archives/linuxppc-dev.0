Return-Path: <awilliam@nortel.com>
Received: from zcars04f.nortelnetworks.com (zcars04f.nortelnetworks.com
	[47.129.242.57]) by ozlabs.org (Postfix) with ESMTP id 11D03679E9
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Jun 2005 00:36:43 +1000 (EST)
Message-ID: <713043CE8B8E1348AF3C546DBE02C1B403AC5D5C@zcarhxm2.corp.nortel.com>
From: "Andrew Williams" <awilliam@nortel.com>
To: Nai-Hsien <dennis@loop.com.tw>, linuxppc-embedded@ozlabs.org
Date: Tue, 7 Jun 2005 10:17:24 -0400 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C56B6B.A140F7E4"
Subject: RE: MPC8272 runs application with segmentation fault
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C56B6B.A140F7E4
Content-Type: text/plain;
	charset="big5"

Take a alook at the checkcpu() routine in /cpu/mpc8260/cpu.c .
Validate that your CPU is correctly being identified, and thus initialized. 
We had identical symptoms with the 8270. 
 
We added the following after the case for the PVR_8260_HIP7:
   
        case PVR_8280a_HIP7:
        case PVR_8280_HIP7:
                k = 7;
                printf (CPU_ID_STR " (HiP%d Rev %02x, Mask ", k, rev);
                break;
 
include/asm-ppc/processor.h
 
    #define PVR_8280_HIP7   0x80822013 
    #define PVR_8280a_HIP7   0x80822014 
 
A.

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Nai-Hsien
Sent: June 7, 2005 9:11 AM
To: linuxppc-embedded@ozlabs.org
Subject: MPC8272 runs application with segmentation fault


Dear experts,
 
I have two hardware boards, one uses MPC8245 and the other one uses MPC8272.
Initially, I use the MPC8245 board to port Linux 2.4.20 and write some
applications.
I already do a lot of test on the MPC8245 board and all my application
programs work
fine.
 
After this, I use the same kernel configuration and same file system that
are being used
by the MPC8245 board to port the whole system to my MPC8272.
Now, I can boot the kernel and run busybox well. However, when
I run my application programs, I always get segmentation fault. Following is
a strace
dump. Could anybody give me some idea?
 
Thank you
Dennis
 
====================================================
execve("sbin/console", ["sbin/console"], [/* 6 vars */]) = 0
uname({sys="Linux", node="6200_linux", ...}) = 0
brk(0)                                  = 0x10059134
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or
directory)
open("/lib/libncurses.so.5", O_RDONLY)  = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\001"..., 1024) =
1024
fstat64(0x3, 0x7ffff098)                = 0
mmap(0xff97000, 362628, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xff97000
mprotect(0xffd4000, 112772, PROT_NONE)  = 0
mmap(0xffd7000, 86016, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED, 3, 0x30000) = 0xffd7000
mmap(0xffec000, 14468, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xffec000
close(3)                                = 0
open("/lib/libdl.so.2", O_RDONLY)       = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\34"..., 1024)
= 1024
fstat64(0x3, 0x7ffff078)                = 0
mmap(0xff74000, 74812, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xff74000
mprotect(0xff77000, 62524, PROT_NONE)   = 0
mmap(0xff84000, 12288, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED, 3, 0) = 0xff84000
close(3)                                = 0
open("/lib/libnsl.so.1", O_RDONLY)      = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0A\274"...,
1024) = 1024
fstat64(0x3, 0x7ffff058)                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) =
0x30017000
mmap(0xff3e000, 152068, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xff3e000
mprotect(0xff51000, 74244, PROT_NONE)   = 0
mmap(0xff5e000, 12288, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED, 3, 0x10000) = 0xff5e000
mmap(0xff61000, 8708, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xff61000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\322"..., 1024)
= 1024
fstat64(0x3, 0x7ffff038)                = 0
mmap(0xfddd000, 1379388, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0xfddd000
mprotect(0xff16000, 97340, PROT_NONE)   = 0
mmap(0xff1d000, 61440, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED, 3, 0x130000) = 0xff1d000
mmap(0xff2c000, 7228, PROT_READ|PROT_WRITE|PROT_EXEC,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0xff2c000
close(3)                                = 0
brk(0)                                  = 0x10059134
brk(0x1005a134)                         = 0x1005a134
brk(0x1005b000)                         = 0x1005b000
write(2, "before init_ncurses()\n", 22) = 22
write(2, "before initscr()\n", 17)      = 17
access("/usr/share/terminfo/v/vt100", R_OK) = 0
open("/usr/share/terminfo/v/vt100", O_RDONLY) = 3
read(3, "\32\1,\0\25\0\7\0\16\1\3\2", 12) = 12
read(3, "vt100|vt100-am|dec vt100 (w/adva"..., 44) = 44
read(3, "\0\1\0\0\1\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\1", 21) = 21
read(3, "\0", 1)                        = 1
read(3, "P\0\10\0\30\0\377\377\377\377\377\377\3\0", 14) = 14
read(3, "\377\377\0\0\2\0\4\0\25\0\32\0&\0.\0\377\377\377\3777\0"..., 540) =
540
read(3, "\7\0\r\0\33[%i%p1%d;%p2%dr\0\33[3g\0\33[H\33[J"..., 515) = 515
read(3, "", 1)                          = 0
read(3, "", 10)                         = 0
close(3)                                = 0
-- SIGSEGV (Segmentation fault) @ 0 (0) ---
+++ killed by SIGSEGV +++
Segmentation fault
 
 


------_=_NextPart_001_01C56B6B.A140F7E4
Content-Type: text/html;
	charset="big5"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=big5">
<TITLE>Message</TITLE>

<META content="MSHTML 6.00.2800.1498" name=GENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=#ffffff>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=565480514-07062005>Take a 
alook at the checkcpu() routine in /cpu/mpc8260/cpu.c .</SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=565480514-07062005>Validate that your CPU is correctly being identified, 
and thus initialized. </SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=565480514-07062005>We had 
identical symptoms with </SPAN></FONT><FONT face=Arial color=#0000ff 
size=2><SPAN class=565480514-07062005>the 8270. </SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=565480514-07062005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN class=565480514-07062005>We 
added the following after the case for the PVR_8260_HIP7:</SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=565480514-07062005>&nbsp;&nbsp; </SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=565480514-07062005>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 
PVR_8280a_HIP7:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; case 
PVR_8280_HIP7:<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
k = 
7;<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
printf (CPU_ID_STR " (HiP%d Rev %02x, Mask ", k, 
rev);<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
break;</SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=565480514-07062005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=565480514-07062005>include/asm-ppc/processor.h</SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=565480514-07062005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=565480514-07062005>&nbsp;&nbsp;&nbsp;&nbsp;#define 
PVR_8280_HIP7&nbsp;&nbsp; 0x80822013 </SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=565480514-07062005>&nbsp;&nbsp;&nbsp; #define PVR_8280a_HIP7&nbsp;&nbsp; 
0x80822014 </SPAN></FONT></DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=565480514-07062005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial color=#0000ff size=2><SPAN 
class=565480514-07062005>A.</SPAN></FONT></DIV>
<BLOCKQUOTE dir=ltr 
style="PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px solid; MARGIN-RIGHT: 0px">
  <DIV></DIV>
  <DIV class=OutlookMessageHeader lang=en-us dir=ltr align=left><FONT 
  face=Tahoma size=2>-----Original Message-----<BR><B>From:</B> 
  linuxppc-embedded-bounces@ozlabs.org 
  [mailto:linuxppc-embedded-bounces@ozlabs.org] <B>On Behalf Of 
  </B>Nai-Hsien<BR><B>Sent:</B> June 7, 2005 9:11 AM<BR><B>To:</B> 
  linuxppc-embedded@ozlabs.org<BR><B>Subject:</B> MPC8272 runs application with 
  segmentation fault<BR><BR></FONT></DIV>
  <DIV><FONT face="Times New Roman">Dear experts,</FONT></DIV>
  <DIV><FONT face="Times New Roman"></FONT>&nbsp;</DIV>
  <DIV><FONT face="Times New Roman">I have two hardware boards, one uses MPC8245 
  and the other one uses MPC8272.</FONT></DIV>
  <DIV><FONT face="Times New Roman">Initially, I use the MPC8245 board to port 
  Linux 2.4.20 and write some applications.</FONT></DIV>
  <DIV><FONT face="Times New Roman">I already do a lot of test on the MPC8245 
  board and all my application programs work</FONT></DIV>
  <DIV><FONT face="Times New Roman">fine.</FONT></DIV>
  <DIV><FONT face="Times New Roman"></FONT>&nbsp;</DIV>
  <DIV><FONT face="Times New Roman">After this, I use the same kernel 
  configuration&nbsp;and same file system that are being used</FONT></DIV>
  <DIV><FONT face="Times New Roman">by the MPC8245 board to port the whole 
  system to </FONT><FONT face="Times New Roman">my MPC8272.</FONT></DIV>
  <DIV><FONT face="Times New Roman">Now, I can boot the kernel and run busybox 
  well. However, when</FONT></DIV>
  <DIV><FONT face="Times New Roman">I run my application programs, I always get 
  segmentation fault. Following is a strace</FONT></DIV>
  <DIV><FONT face="Times New Roman">dump. Could anybody give me some 
  idea?</FONT></DIV>
  <DIV><FONT face="Times New Roman"></FONT>&nbsp;</DIV>
  <DIV><FONT face="Times New Roman">Thank you</FONT></DIV>
  <DIV><FONT face="Times New Roman">Dennis</FONT></DIV>
  <DIV><FONT face="Times New Roman"></FONT>&nbsp;</DIV>
  <DIV><FONT 
  face="Times New Roman">====================================================</FONT></DIV>
  <DIV><FONT face="Times New Roman">execve("sbin/console", ["sbin/console"], [/* 
  6 vars */]) = 0<BR>uname({sys="Linux", node="6200_linux", ...}) = 
  0<BR>brk(0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  = 0x10059134<BR>open("/etc/ld.so.preload", O_RDONLY)&nbsp;&nbsp;&nbsp; = -1 
  ENOENT (No such file or directory)<BR>open("/etc/ld.so.cache", 
  O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = -1 ENOENT (No such file or 
  directory)<BR>open("/lib/libncurses.so.5", O_RDONLY)&nbsp; = 3<BR>read(3, 
  "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\001"..., 1024) = 
  1024<BR>fstat64(0x3, 
  0x7ffff098)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  = 0<BR>mmap(0xff97000, 362628, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 
  0xff97000<BR>mprotect(0xffd4000, 112772, PROT_NONE)&nbsp; = 
  0<BR>mmap(0xffd7000, 86016, PROT_READ|PROT_WRITE|PROT_EXEC, 
  MAP_PRIVATE|MAP_FIXED, 3, 0x30000) = 0xffd7000<BR>mmap(0xffec000, 14468, 
  PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 
  0xffec000<BR>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  = 0<BR>open("/lib/libdl.so.2", O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 
  3<BR>read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0\34"..., 
  1024) = 1024<BR>fstat64(0x3, 
  0x7ffff078)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  = 0<BR>mmap(0xff74000, 74812, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 
  0xff74000<BR>mprotect(0xff77000, 62524, PROT_NONE)&nbsp;&nbsp; = 
  0<BR>mmap(0xff84000, 12288, PROT_READ|PROT_WRITE|PROT_EXEC, 
  MAP_PRIVATE|MAP_FIXED, 3, 0) = 
  0xff84000<BR>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  = 0<BR>open("/lib/libnsl.so.1", O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 
  3<BR>read(3, "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\0A\274"..., 
  1024) = 1024<BR>fstat64(0x3, 
  0x7ffff058)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  = 0<BR>mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 
  0) = 0x30017000<BR>mmap(0xff3e000, 152068, PROT_READ|PROT_EXEC, MAP_PRIVATE, 
  3, 0) = 0xff3e000<BR>mprotect(0xff51000, 74244, PROT_NONE)&nbsp;&nbsp; = 
  0<BR>mmap(0xff5e000, 12288, PROT_READ|PROT_WRITE|PROT_EXEC, 
  MAP_PRIVATE|MAP_FIXED, 3, 0x10000) = 0xff5e000<BR>mmap(0xff61000, 8708, 
  PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 
  0xff61000<BR>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  = 0<BR>open("/lib/libc.so.6", 
  O_RDONLY)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 3<BR>read(3, 
  "\177ELF\1\2\1\0\0\0\0\0\0\0\0\0\0\3\0\24\0\0\0\1\0\1\322"..., 1024) = 
  1024<BR>fstat64(0x3, 
  0x7ffff038)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  = 0<BR>mmap(0xfddd000, 1379388, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 
  0xfddd000<BR>mprotect(0xff16000, 97340, PROT_NONE)&nbsp;&nbsp; = 
  0<BR>mmap(0xff1d000, 61440, PROT_READ|PROT_WRITE|PROT_EXEC, 
  MAP_PRIVATE|MAP_FIXED, 3, 0x130000) = 0xff1d000<BR>mmap(0xff2c000, 7228, 
  PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 
  0xff2c000<BR>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  = 
  0<BR>brk(0)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  = 
  0x10059134<BR>brk(0x1005a134)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  = 
  0x1005a134<BR>brk(0x1005b000)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  = 0x1005b000<BR>write(2, "before init_ncurses()\n", 22) = 22<BR>write(2, 
  "before initscr()\n", 17)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; = 
  17<BR>access("/usr/share/terminfo/v/vt100", R_OK) = 
  0<BR>open("/usr/share/terminfo/v/vt100", O_RDONLY) = 3<BR>read(3, 
  "\32\1,\0\25\0\7\0\16\1\3\2", 12) = 12<BR>read(3, "vt100|vt100-am|dec vt100 
  (w/adva"..., 44) = 44<BR>read(3, "\0\1\0\0\1\0\0\0\0\0\0\0\0\0\1\0\0\0\0\0\1", 
  21) = 21<BR>read(3, "\0", 
  1)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  = 1<BR>read(3, "P\0\10\0\30\0\377\377\377\377\377\377\3\0", 14) = 
  14<BR>read(3, 
  "\377\377\0\0\2\0\4\0\25\0\32\0&amp;\0.\0\377\377\377\3777\0"..., 540) = 
  540<BR>read(3, "\7\0\r\0\33[%i%p1%d;%p2%dr\0\33[3g\0\33[H\33[J"..., 515) = 
  515<BR>read(3, "", 
  1)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  = 0<BR>read(3, "", 
  10)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  = 
  0<BR>close(3)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 
  = 0<BR>-- SIGSEGV (Segmentation fault) @ 0 (0) ---<BR>+++ killed by SIGSEGV 
  +++</FONT></DIV>
  <DIV><FONT face="Times New Roman">Segmentation fault</FONT></DIV>
  <DIV><FONT face="Times New Roman"></FONT>&nbsp;</DIV>
  <DIV><FONT face="Times New Roman"></FONT>&nbsp;</DIV></BLOCKQUOTE></BODY></HTML>

------_=_NextPart_001_01C56B6B.A140F7E4--
