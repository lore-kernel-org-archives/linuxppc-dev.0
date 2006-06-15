Return-Path: <gmuruga@gdatech.com>
Received: from darwaza.gdatech.com (darwaza.gdatech.com [66.237.41.98])
	by ozlabs.org (Postfix) with ESMTP id 28C3467B62
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 Jun 2006 05:25:17 +1000 (EST)
Received: from darwaza.gdatech.com ([192.168.200.118])
	by [127.0.0.1] ([127.0.0.1]) (port 7027) (Abaca EPG outproxy filter
	1.3.4.5154-maint13 $Rev: 5154 $) id r66f122516D-00-c875
	for linuxppc-embedded@ozlabs.org prabhat_singh@satyam.com;
	Thu, 15 Jun 2006 12:25:16 -0700
Message-Id: <7.0.0.16.0.20060615122006.01d96cc8@gdatech.com>
Date: Thu, 15 Jun 2006 12:27:11 -0700
To: "Prabhat_Singh" <Prabhat_Singh@Satyam.com>, <linuxppc-embedded@ozlabs.org>
From: "G.Muruganandam" <gmuruga@gdatech.com>
Subject: Re: Problem in PCI initialization
In-Reply-To: <D8595042F3765A4285B848A78A2C2ED10494917B@bsdmsg002.corp.sa
	tyam.ad>
References: <D8595042F3765A4285B848A78A2C2ED10494917B@bsdmsg002.corp.satyam.ad>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====================_1906578==.ALT"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--=====================_1906578==.ALT
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Transfer-Encoding: quoted-printable


Before testing the PCI in linux, you need to make=20
sure that the PCI is working under u-boot with out any issues.

Here are the check list.

1. pci long command under u-boot should display=20
the pci configuration registers of the device in PCI bus
     consistently.

2. Check the PCI BAR registers at offset=20
0x10,0x14 and 0x18 are configured with proper values based on
     whether it is a PCI memory mapped device or IO mapped device.

3. Check the TLB setting under U-boot whether it=20
is set correctly for the PCI memory and/or IO regions.
    If you are using the u-boot 1.1.x, you should=20
look at init.S for the particular board/cpu.

Hope this helps!

Thanks
G.Muruganandam


At 11:39 PM 6/14/2006, Prabhat_Singh wrote:
>Content-class: urn:content-classes:message
>Content-Transfer-Encoding: 7bit
>Content-Type: multipart/alternative;
>         boundary=3D"----_=3D_NextPart_001_01C69046.65DE2215"
>
>Hi all
>I am using MPC8248 based board which has got one PCI interface at 66 MHz .
>
>I am not able to initialize PCI, I am really=20
>clueless and getting the following errors.
>
>Can any one tell me what is wrong with this?
>
>But I am initializing the pci in uboot also and=20
>there in uboot able to detect the network card,=20
>but while boot its give first time the machine=20
>check exception and then its reseting itself and=20
>then in second try it (uboot) is working fine.=20
>Do the register sets in uboot is again read by=20
>linux during linux PCI initialization?
>
>Someone please help.
>
>## Booting image at ffd00000 ...
>Image Name: Linux-2.4.28-1.3.1-517
>Image Type: PowerPC Linux Kernel Image (gzip compressed)
>Data Size: 643461 Bytes =3D 628.4 kB
>Load Address: 00000000
>Entry Point: 00000000
>Verifying Checksum ... OK
>Uncompressing Kernel Image ... OK
>## Current stack ends at 0x01FAB390 =3D> set upper limit to 0x00800000
>No initrd
>## Transferring control to Linux (at address 00000000) ...
>Memory BAT mapping: BAT2=3D32Mb, BAT3=3D0Mb, residual: 0Mb
>
>Linux version 2.4.28-1.3.1-517=20
>(root@localhost.localdomain) (gcc version 3.3.4)=20
>#280 Tue Jun 13 16:17:02 IST 2006
>
>On node 0 totalpages: 8192
>
>zone(0): 8192 pages.
>
>zone(1): 0 pages.
>
>zone(2): 0 pages.
>
>Kernel command line: console=3DttyS0,115200 root=3D1f00
>
>Calibrating delay loop... 266.24 BogoMIPS
>
>Memory: 30712k available (1228k kernel code, 368k data, 64k init, 0k=
 highmem)
>
>Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)
>
>Inode cache hash table entries: 2048 (order: 2, 16384 bytes)
>
>Mount cache hash table entries: 512 (order: 0, 4096 bytes)
>
>Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)
>
>Page-cache hash table entries: 8192 (order: 3, 32768 bytes)
>
>POSIX conformance testing by UNIFIX
>
>PCI: Probing PCI hardware
>
>Scanning bus 00
>
>Oops: kernel access of bad area, sig: 11
>
>NIP: C000C6DC XER: 00000000 LR: C0003FAC SP:=20
>C0183DC0 REGS: c0183d10 TRAP: 0300 Not tainted
>
>MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
>
>DAR: 00000024, DSISR: 20000000
>
>TASK =3D c023a000[14] '=A2p=C0 }=AC' Last syscall: -1
>
>last math 00000000 last altivec 00000000
>
>GPR00: 00000000 C0183DC0 C023A000 C0183E80=20
>00000024 20000000 C0170000 00000439
>
>GPR08: 00000000 C0183D20 00000000 00000000=20
>22004084 B5FFFFFF 01FF8000 007FFC1E
>
>GPR16: 00000001 00000000 FFFFFFFF 007FFC00=20
>00001032 00183E70 00000000 C0003FAC
>
>GPR24: 00000000 00030001 00000008 20000000=20
>C0183E80 00000024 00000024 00000008
>
>Call backtrace:
>
>C0019384 C0003FAC 00000000 C0003FAC 00000000 C0003FAC C0184214
>
>C0003FAC C0184380 C0003FAC C01844F0 C0003FAC C0184664 C0003FAC
>
>C01847D0 C0003FAC C0184940 C0003FAC C0184AB4 C0003FAC C0184C24
>
>C0003FAC C0184D94 C0003FAC C0184F04 C0003FAC C0185074 C0003FAC
>
>00000000 C0003FAC 00000000 C0003FAC 00000000
>
>Kernel panic: Aiee, killing interrupt handler!
>
>In interrupt handler - not syncing
>
><0>Rebooting in 180 seconds..
>
>
>
>DISCLAIMER:
>This email (including any attachments) is=20
>intended for the sole use of the intended=20
>recipient/s and may contain material that is=20
>CONFIDENTIAL AND PRIVATE COMPANY INFORMATION.=20
>Any review or reliance by others or copying or=20
>distribution or forwarding of any or all of the=20
>contents in this message is STRICTLY PROHIBITED.=20
>If you are not the intended recipient, please=20
>contact the sender by email and delete all=20
>copies; your cooperation in this regard is appreciated..
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded

--=====================_1906578==.ALT
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html>
<body>
<br>
Before testing the PCI in linux, you need to make sure that the PCI is
working under u-boot with out any issues. <br><br>
Here are the check list.<br><br>
1. pci long command under u-boot should display the pci configuration
registers of the device in PCI bus <br>
&nbsp;&nbsp;&nbsp; consistently.<br><br>
2. Check the PCI BAR registers at offset 0x10,0x14 and 0x18 are
configured with proper values based on <br>
&nbsp;&nbsp;&nbsp; whether it is a PCI memory mapped device or IO mapped
device. <br><br>
3. Check the TLB setting under U-boot whether it is set correctly for the
PCI memory and/or IO regions. <br>
&nbsp;&nbsp; If you are using the u-boot 1.1.x, you should look at init.S
for the particular board/cpu. <br><br>
Hope this helps!<br><br>
Thanks<br>
G.Muruganandam<br>
&nbsp; <br><br>
At 11:39 PM 6/14/2006, Prabhat_Singh wrote:<br>
<blockquote type=3Dcite class=3Dcite cite=3D"">Content-class:
urn:content-classes:message<br>
Content-Transfer-Encoding: 7bit<br>
Content-Type: multipart/alternative;<br>
<x-tab>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</x-tab>
boundary=3D&quot;----_=3D_NextPart_001_01C69046.65DE2215&quot;<br><br>
<font size=3D2>Hi all<br>
I am using MPC8248 based board which has got one PCI interface at 66 MHz
.<br>
&nbsp;<br>
I am not able to initialize PCI, I am really clueless and getting the
following errors.<br>
&nbsp;<br>
Can any one tell me what is wrong with this?<br>
&nbsp;<br>
But I am initializing the pci in uboot also and there in uboot able to
detect the network card, but while boot its give first time the machine
check exception and then its reseting itself and then in second try it
(uboot) is working fine. Do the register sets in uboot is again read by
linux during linux PCI initialization?<br>
&nbsp;<br>
Someone please help.<br>
&nbsp;<br>
</font><font face=3D"Courier New, Courier" size=3D2>## Booting image at
ffd00000 ...<br>
Image Name: Linux-2.4.28-1.3.1-517<br>
Image Type: PowerPC Linux Kernel Image (gzip compressed)<br>
Data Size: 643461 Bytes =3D 628.4 kB<br>
Load Address: 00000000<br>
Entry Point: 00000000<br>
Verifying Checksum ... OK<br>
Uncompressing Kernel Image ... OK<br>
## Current stack ends at 0x01FAB390 =3D&gt; set upper limit to
0x00800000<br>
No initrd<br>
## Transferring control to Linux (at address 00000000) ...<br>
Memory BAT mapping: BAT2=3D32Mb, BAT3=3D0Mb, residual: 0Mb<br>
&nbsp;<br>
Linux version 2.4.28-1.3.1-517 (root@localhost.localdomain) (gcc version
3.3.4) #280 Tue Jun 13 16:17:02 IST 2006<br>
&nbsp;<br>
On node 0 totalpages: 8192<br>
&nbsp;<br>
zone(0): 8192 pages.<br>
&nbsp;<br>
zone(1): 0 pages.<br>
&nbsp;<br>
zone(2): 0 pages.<br>
&nbsp;<br>
Kernel command line: console=3DttyS0,115200 root=3D1f00<br>
&nbsp;<br>
Calibrating delay loop... 266.24 BogoMIPS<br>
&nbsp;<br>
Memory: 30712k available (1228k kernel code, 368k data, 64k init, 0k
highmem)<br>
&nbsp;<br>
Dentry cache hash table entries: 4096 (order: 3, 32768 bytes)<br>
&nbsp;<br>
Inode cache hash table entries: 2048 (order: 2, 16384 bytes)<br>
&nbsp;<br>
Mount cache hash table entries: 512 (order: 0, 4096 bytes)<br>
&nbsp;<br>
Buffer cache hash table entries: 1024 (order: 0, 4096 bytes)<br>
&nbsp;<br>
Page-cache hash table entries: 8192 (order: 3, 32768 bytes)<br>
&nbsp;<br>
POSIX conformance testing by UNIFIX<br>
&nbsp;<br>
PCI: Probing PCI hardware<br>
&nbsp;<br>
Scanning bus 00<br>
&nbsp;<br>
Oops: kernel access of bad area, sig: 11<br>
&nbsp;<br>
NIP: C000C6DC XER: 00000000 LR: C0003FAC SP: C0183DC0 REGS: c0183d10
TRAP: 0300 Not tainted<br>
&nbsp;<br>
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11<br>
&nbsp;<br>
DAR: 00000024, DSISR: 20000000<br>
&nbsp;<br>
TASK =3D c023a000[14] '=A2p=C0 }=AC' Last syscall: -1 <br>
&nbsp;<br>
last math 00000000 last altivec 00000000<br>
&nbsp;<br>
GPR00: 00000000 C0183DC0 C023A000 C0183E80 00000024 20000000 C0170000
00000439 <br>
&nbsp;<br>
GPR08: 00000000 C0183D20 00000000 00000000 22004084 B5FFFFFF 01FF8000
007FFC1E <br>
&nbsp;<br>
GPR16: 00000001 00000000 FFFFFFFF 007FFC00 00001032 00183E70 00000000
C0003FAC <br>
&nbsp;<br>
GPR24: 00000000 00030001 00000008 20000000 C0183E80 00000024 00000024
00000008 <br>
&nbsp;<br>
Call backtrace: <br>
&nbsp;<br>
C0019384 C0003FAC 00000000 C0003FAC 00000000 C0003FAC C0184214 <br>
&nbsp;<br>
C0003FAC C0184380 C0003FAC C01844F0 C0003FAC C0184664 C0003FAC <br>
&nbsp;<br>
C01847D0 C0003FAC C0184940 C0003FAC C0184AB4 C0003FAC C0184C24 <br>
&nbsp;<br>
C0003FAC C0184D94 C0003FAC C0184F04 C0003FAC C0185074 C0003FAC <br>
&nbsp;<br>
00000000 C0003FAC 00000000 C0003FAC 00000000 <br>
&nbsp;<br>
Kernel panic: Aiee, killing interrupt handler!<br>
&nbsp;<br>
In interrupt handler - not syncing<br>
&nbsp;<br>
&lt;0&gt;Rebooting in 180 seconds..<br>
</font>&nbsp;<br>
&nbsp;<br>
<br>
DISCLAIMER:<br>
This email (including any attachments) is intended for the sole use of
the intended recipient/s and may contain material that is CONFIDENTIAL
AND PRIVATE COMPANY INFORMATION. Any review or reliance by others or
copying or distribution or forwarding of any or all of the contents in
this message is STRICTLY PROHIBITED. If you are not the intended
recipient, please contact the sender by email and delete all copies; your
cooperation in this regard is appreciated.. <br>
_______________________________________________<br>
Linuxppc-embedded mailing list<br>
Linuxppc-embedded@ozlabs.org<br>
<a href=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded" eudora=3D"=
autourl">
https://ozlabs.org/mailman/listinfo/linuxppc-embedded</a></blockquote>
</body>
</html>

--=====================_1906578==.ALT--
