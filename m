Return-Path: <john.bonesio@xilinx.com>
Received: from IE1EHSOBE003.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16]) by ozlabs.org (Postfix) with ESMTP id 8B24EDDF1E
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Jul 2008 07:43:46 +1000 (EST)
Subject: Re: Linux on ML403 serial console problem
From: John Bonesio <john.bonesio@xilinx.com>
To: Anand Kumar S <sanandkumar@hcl.in>
In-Reply-To: <66E8AEE9980BB44CA5FCAD39EBA56AC604A5F1DF@CHN-HCLT-EVS02.HCLT.CORP.HCL.IN>
References: <66E8AEE9980BB44CA5FCAD39EBA56AC604A5F1DF@CHN-HCLT-EVS02.HCLT.CORP.HCL.IN>
Content-Type: multipart/alternative; boundary="=-iT26ifYefS2dFFbQVtXk"
Date: Thu, 3 Jul 2008 14:43:19 -0700
MIME-Version: 1.0
Message-ID: <20080703214320.D19C5A20095@mail25-dub.bigfish.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--=-iT26ifYefS2dFFbQVtXk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I don't have a clear idea about this, but it seems to me that there's
probably something in your root filesystem that is causing output to be
directed to a different console that the serial console. Maybe it's
using the wrong getty program.

- John

On Thu, 2008-07-03 at 15:42 +0530, Anand Kumar S wrote:
> Hi,
> =

>  =

> =

> I am using MVL 4.0.1 to boot on ML403 board. I have created the
> xparameters.h file using EDK 10.1 and I was able to boot the kernel
> with 32 MB of memory and UART set as std 16550 uart.
> =

> Since this board came without sysace flash card I am using ramdisk
> technique to boot linux. I created a small ramdisk with my test
> program which sleeps for 10 seconds and prints a hello
> =

> world using printf. I modified kernel init/main.c to execute /bin/test
> (my test program) from the RAMDISK. I created the ramdisk and appended
> with zImage using make zImage.initrd command
> =

>  =

> =

> I used dow method from xmd to download the zImage.initrd.elf on the
> board and I was able to boot the board till the point of executing
> my /bin/test. However I see that the print statements
> =

> from my test program are not coming on the serial port. I see that the
> printf calls tty_io write and it goes to uart_write routine in
> serial_core.c, however I am not able to see my prints on
> =

> the hyperterminal. I can see all the kernel printks except for this
> printf statement from my user program. Also all the kernel printks
> seem to call serial_8250_console write routine but the
> 
> user application seems to call the uart_write routine. Does someone
> have any idea about what might be going wrong here? Is it something to
> do with serial console settings ?
> =

>  =

> =

> Any help is greatly appreciated as I am really struggling with this
> problem for the past 3 days. Given below is the output from serial
> port. I do not have FB support or VT or VT console
> =

> Support enabled. Only SERIAL console support is enabled i.e
> SERIAL_CORE_CONSOLE/SERIAL_8250_CONSOLE support is enabled
> =

>  =

> =

> =E2=80=A6..
> =

> =E2=80=A6..
> =

> Serial: 8250/16550 driver $Revision: 1.90 $ 5 ports, IRQ sharing
> disabled
> =

> Registering platform device 'serial8250'. Parent at platform
> =

> ttyS0 at MMIO 0x0 (irq =3D 9) is a 16550A
> =

> io scheduler noop registered
> =

> io scheduler anticipatory registered
> =

> io scheduler deadline registered
> =

> io scheduler cfq registered
> =

> RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize
> =

> loop: loaded (max 8 devices)
> =

> PPP generic driver version 2.4.2
> =

> PPP Deflate Compression module registered
> =

> NET: Registered protocol family 24
> =

> xemac 0: using fifo mode.
> =

> eth0: Xilinx EMAC #0 at 81000000 mapped to 0xC30C0000, irq=3D0
> =

> i2c /dev entries driver
> =

> xilinx_iic.0 #0 at 0x81600000 mapped to 0xC30E0000, irq=3D6
> =

> mice: PS/2 mouse device common for all mice
> =

> NET: Registered protocol family 2
> =

> IP: routing cache hash table of 512 buckets, 4Kbytes
> =

> TCP: Hash tables configured (established 2048 bind 4096)
> =

> NET: Registered protocol family 1
> =

> NET: Registered protocol family 17
> =

> interrupts enabled =

> =

> TX interrupts enabled. register baseaddr c30c0000 offset 7fc is 8 =

> =

> TX interrupts enabled. register baseaddr c30c0000 offset ffc is 0 =

> =

> RX interrupts enabled. register baseaddr c30c0000 offset 17fc is 9 =

> =

> RX interrupts enabled. register baseaddr c30c0000 offset 1ffc is 0 =

> =

> GIER interrupts enabled. register baseaddr c30c0000 offset 7f8 is
> 80000000 =

> =

> Sending DHCP requests .,... OK
> =

> IP-Config: Got DHCP answer from 0.0.0.0, my address is 10.100.12.132
> =

> IP-Config: Complete:
> =

>       device=3Deth0, addr=3D10.100.12.132, mask=3D255.255.255.0,
> gw=3D10.100.12.1,
> =

>      host=3D10.100.12.132, domain=3Dhclt.corp.hcl.in, nis-domain=3D(none)=
,
> =

>      bootserver=3D0.0.0.0, rootserver=3D0.0.0.0, rootpath=3D
> =

> RAMDISK: Compressed image found at block 0
> =

> VFS: Mounted root (ext2 filesystem).
> =

> Freeing unused kernel memory: 124k init
> =

> done freeing memory. creating console =

> =

> console created =

> =

> running process /bin/test =

> =

> in tty_write
> =

> before calling write. buf contents h e l
> =

> core write
> =

> core write
> =

> core write
> =

> Kernel panic - not syncing: Attempted to kill init!
> =

>  <0>Rebooting in 180 seconds..<NULL>
> =

>  =

> =

> =

> =

> DISCLAIMER:
> -------------------------------------------------------------------------=
----------------------------------------------
> =

> The contents of this e-mail and any attachment(s) are confidential and
> intended for the named recipient(s) only.
> It shall not attach any liability on the originator or HCL or its
> affiliates. Any views or opinions presented in =

> this email are solely those of the author and may not necessarily
> reflect the opinions of HCL or its affiliates.
> Any form of reproduction, dissemination, copying, disclosure,
> modification, distribution and / or publication of =

> this message without the prior written consent of the author of this
> e-mail is strictly prohibited. If you have =

> received this email in error please delete it and notify the sender
> immediately. Before opening any mail and =

> attachments please check them for viruses and defect.
> =

> -------------------------------------------------------------------------=
----------------------------------------------
> =

> =

> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded


________________________________________________________________________

John Bonesio
Commercial Linux Solutions
john.bonesio@xilinx.com
(408) 879-5569


This email and any attachments are intended for the sole use of the named r=
ecipient(s) and contain(s) confidential information that may be proprietary=
, privileged or copyrighted under applicable law. If you are not the intend=
ed recipient, do not read, copy, or forward this email message or any attac=
hments. Delete this email message and any attachments immediately.


--=-iT26ifYefS2dFFbQVtXk
Content-Type: text/html; charset="utf-8"

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 TRANSITIONAL//EN">
<HTML>
<HEAD>
  <META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=UTF-8">
  <META NAME="GENERATOR" CONTENT="GtkHTML/3.12.2">
</HEAD>
<BODY LINK="#0000ff">
Hi,<BR>
<BR>
I don't have a clear idea about this, but it seems to me that there's probably something in your root filesystem that is causing output to be directed to a different console that the serial console. Maybe it's using the wrong getty program.<BR>
<BR>
- John<BR>
<BR>
On Thu, 2008-07-03 at 15:42 +0530, Anand Kumar S wrote:
<BLOCKQUOTE TYPE=CITE>
    <FONT SIZE="2"><FONT COLOR="#000000">Hi,</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">&nbsp;</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">I am using MVL 4.0.1 to boot on ML403 board. I have created the xparameters.h file using EDK 10.1 and I was able to boot the kernel with 32 MB of memory and UART set as std 16550 uart.</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">Since this board came without sysace flash card I am using ramdisk technique to boot linux. I created a small ramdisk with my test program which sleeps for 10 seconds and prints a hello</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">world using printf. I modified kernel init/main.c to execute /bin/test (my test program) from the RAMDISK. I created the ramdisk and appended with zImage using make zImage.initrd command</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">&nbsp;</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">I used dow method from xmd to download the zImage.initrd.elf on the board and I was able to boot the board till the point of executing my /bin/test. However I see that the print statements</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">from my test program are not coming on the serial port. I see that the printf calls tty_io write and it goes to uart_write routine in serial_core.c, however I am not able to see my prints on</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">the hyperterminal. I can see all the kernel printks except for this printf statement from my user program. Also all the kernel printks seem to call serial_8250_console write routine but the</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">user application seems to call the uart_write routine. Does someone have any idea about what might be going wrong here? Is it something to do with serial console settings ?</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">&nbsp;</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">Any help is greatly appreciated as I am really struggling with this problem for the past 3 days. Given below is the output from serial port. I do not have FB support or VT or VT console</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">Support enabled. Only SERIAL console support is enabled i.e SERIAL_CORE_CONSOLE/SERIAL_8250_CONSOLE support is enabled</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">&nbsp;</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">&#8230;..</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">&#8230;..</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">Serial: 8250/16550 driver $Revision: 1.90 $ 5 ports, IRQ sharing disabled</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">Registering platform device 'serial8250'. Parent at platform</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">ttyS0 at MMIO 0x0 (irq = 9) is a 16550A</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">io scheduler noop registered</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">io scheduler anticipatory registered</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">io scheduler deadline registered</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">io scheduler cfq registered</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">RAMDISK driver initialized: 16 RAM disks of 8192K size 1024 blocksize</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">loop: loaded (max 8 devices)</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">PPP generic driver version 2.4.2</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">PPP Deflate Compression module registered</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">NET: Registered protocol family 24</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">xemac 0: using fifo mode.</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">eth0: Xilinx EMAC #0 at 81000000 mapped to 0xC30C0000, irq=0</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">i2c /dev entries driver</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">xilinx_iic.0 #0 at 0x81600000 mapped to 0xC30E0000, irq=6</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">mice: PS/2 mouse device common for all mice</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">NET: Registered protocol family 2</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">IP: routing cache hash table of 512 buckets, 4Kbytes</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">TCP: Hash tables configured (established 2048 bind 4096)</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">NET: Registered protocol family 1</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">NET: Registered protocol family 17</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">interrupts enabled </FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">TX interrupts enabled. register baseaddr c30c0000 offset 7fc is 8 </FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">TX interrupts enabled. register baseaddr c30c0000 offset ffc is 0 </FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">RX interrupts enabled. register baseaddr c30c0000 offset 17fc is 9 </FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">RX interrupts enabled. register baseaddr c30c0000 offset 1ffc is 0 </FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">GIER interrupts enabled. register baseaddr c30c0000 offset 7f8 is 80000000 </FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">Sending DHCP requests .,... OK</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">IP-Config: Got DHCP answer from 0.0.0.0, my address is 10.100.12.132</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">IP-Config: Complete:</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; device=eth0, addr=10.100.12.132, mask=255.255.255.0, gw=10.100.12.1,</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">&nbsp;&nbsp;&nbsp;&nbsp; host=10.100.12.132, domain=hclt.corp.hcl.in, nis-domain=(none),</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">&nbsp;&nbsp;&nbsp;&nbsp; bootserver=0.0.0.0, rootserver=0.0.0.0, rootpath=</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">RAMDISK: Compressed image found at block 0</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">VFS: Mounted root (ext2 filesystem).</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">Freeing unused kernel memory: 124k init</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">done freeing memory. creating console </FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">console created </FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">running process /bin/test </FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">in tty_write</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">before calling write. buf contents h e l</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">core write</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">core write</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">core write</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">Kernel panic - not syncing: Attempted to kill init!</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">&nbsp;&lt;0&gt;Rebooting in 180 seconds..&lt;NULL&gt;</FONT></FONT><BR>
    <BR>
    <FONT SIZE="2"><FONT COLOR="#000000">&nbsp;</FONT></FONT><BR>
    <BR>
    <BR>
</BLOCKQUOTE>
<BLOCKQUOTE TYPE=CITE>
    <TABLE>
<TR>
<TD BGCOLOR="#ffffff">
<FONT COLOR="#000000">DISCLAIMER:</FONT><BR>
<FONT COLOR="#000000">-----------------------------------------------------------------------------------------------------------------------</FONT><BR>
<BR>
<FONT COLOR="#000000">The contents of this e-mail and any attachment(s) are confidential and intended for the named recipient(s) only.</FONT><BR>
<FONT COLOR="#000000">It shall not attach any liability on the originator or HCL or its affiliates. Any views or opinions presented in </FONT><BR>
<FONT COLOR="#000000">this email are solely those of the author and may not necessarily reflect the opinions of HCL or its affiliates.</FONT><BR>
<FONT COLOR="#000000">Any form of reproduction, dissemination, copying, disclosure, modification, distribution and / or publication of </FONT><BR>
<FONT COLOR="#000000">this message without the prior written consent of the author of this e-mail is strictly prohibited. If you have </FONT><BR>
<FONT COLOR="#000000">received this email in error please delete it and notify the sender immediately. Before opening any mail and </FONT><BR>
<FONT COLOR="#000000">attachments please check them for viruses and defect.</FONT><BR>
<BR>
<FONT COLOR="#000000">-----------------------------------------------------------------------------------------------------------------------</FONT><BR>
<BR>
</TD>
</TR>
</TABLE>
<PRE>
<FONT COLOR="#000000">_______________________________________________</FONT>
<FONT COLOR="#000000">Linuxppc-embedded mailing list</FONT>
<FONT COLOR="#000000"><A HREF="mailto:Linuxppc-embedded@ozlabs.org">Linuxppc-embedded@ozlabs.org</A></FONT>
<FONT COLOR="#000000"><A HREF="https://ozlabs.org/mailman/listinfo/linuxppc-embedded">https://ozlabs.org/mailman/listinfo/linuxppc-embedded</A></FONT>
</PRE>
</BLOCKQUOTE>
<TABLE CELLSPACING="0" CELLPADDING="0" WIDTH="100%">
<TR>
<TD>

<HR SIZE="1">
<BR>
<BR>
John Bonesio<BR>
Commercial Linux Solutions<BR>
john.bonesio@xilinx.com<BR>
(408) 879-5569
</TD>
</TR>
</TABLE>
<br clear=all> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
</BODY>
</HTML>


--=-iT26ifYefS2dFFbQVtXk--
