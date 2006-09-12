Return-Path: <peterarbejde@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.229])
	by ozlabs.org (Postfix) with ESMTP id B079A67A3E
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Sep 2006 00:06:25 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id i20so477245wra
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Sep 2006 07:06:23 -0700 (PDT)
Message-ID: <36468a5c0609120706i6c7e32efke7d8901d9ce4ae9b@mail.gmail.com>
Date: Tue, 12 Sep 2006 16:06:22 +0200
From: "Peter N. Andreasen" <peterarbejde@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Linux on custom Xilinx board with PPC405 hangs on boot
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_208461_25622348.1158069982953"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_208461_25622348.1158069982953
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have an FPGA board which is based on the Xilinx ML300 board but without
disk and display. It has 4MB flash, and 32MB SDRAM, and uses the uartlite
serial port.
The RAM is located at 0x0000'0000 - 0x01FF'FFFF
I downloaded the kernel from Montavista, built a board support package in
Xilinx Platform Studio, and managed to configure and build the kernel.
However when I transfer the resulting zImage.elf file to the board, the
attached terminal only shows:

loaded at:     00040000 00D4140E
board data at: 00D41183 00D41105
relocated to:  0004258F 00043501
zimage at:     00048550 0074E751
initrd at:     00740800 00D420FF
avail ram:     00D40500 20000000

Linux/PPC load: root=/dev/ram rw console=/dev/ttyS0
Uncompressing Linux...done.
Now booting the kernel

and then it dies.

In the debug window I have this:

XMD% dow c:/Hardi/zImage.initrd.elf
        section, .text: 0x00400000-0x004047b8
        section, .data: 0x00405000-0x004d1000
        section, .bss: 0x004d1000-0x004d41e0

Downloading ELF File c:/Hardi/zImage.initrd.elf
Program header record #0, Size = 0xD1000.
Downloading program section : Start = 0x00400000, length = 0x000d1000
Downloaded Program c:/Hardi/zImage.initrd.elf
Setting PC with program start addr = 0x00400000
PC reset to 0x00400000, Clearing MSR Register
XMD% con
Processor started. Type "stop" to stop processor
RUNNING> stop
XMD%
Processor stopped at PC: 0x6fbf0700

XMD% dis 0x6fbf0700
6FBF0700:   00000000
XMD%


so it looks like the processor somewhere is sent out in space -
Does anyone have an idea how to find the problem?

Peter

------=_Part_208461_25622348.1158069982953
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I have an FPGA board which is based on the Xilinx ML300 board but without disk and display. It has 4MB flash, and 32MB SDRAM, and uses the uartlite serial port.<br>The RAM is located at 0x0000'0000 - 0x01FF'FFFF<br>I downloaded the kernel from Montavista, built a board support package in Xilinx Platform Studio, and managed to configure and build the kernel. 
<br>However when I transfer the resulting zImage.elf file to the board, the attached terminal only shows:<br><br>loaded at:&nbsp;&nbsp;&nbsp;&nbsp; 00040000 00D4140E<br>board data at: 00D41183 00D41105<br>relocated to:&nbsp; 0004258F 00043501<br>
zimage at:&nbsp;&nbsp;&nbsp;&nbsp; 00048550 0074E751<br>initrd at:&nbsp;&nbsp;&nbsp;&nbsp; 00740800 00D420FF<br>avail ram:&nbsp;&nbsp;&nbsp;&nbsp; 00D40500 20000000<br><br>Linux/PPC load: root=/dev/ram rw console=/dev/ttyS0<br>Uncompressing Linux...done.<br>Now booting the kernel<br>
<br>and then it dies.<br><br>In the debug window I have this:<br><br>XMD% dow c:/Hardi/zImage.initrd.elf<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; section, .text: 0x00400000-0x004047b8<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; section, .data: 0x00405000-0x004d1000<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; section, .bss: 0x004d1000-0x004d41e0
<br><br>Downloading ELF File c:/Hardi/zImage.initrd.elf<br>Program header record #0, Size = 0xD1000.<br>Downloading program section : Start = 0x00400000, length = 0x000d1000<br>Downloaded Program c:/Hardi/zImage.initrd.elf
<br>Setting PC with program start addr = 0x00400000<br>PC reset to 0x00400000, Clearing MSR Register<br>XMD% con<br>Processor started. Type &quot;stop&quot; to stop processor<br>RUNNING&gt; stop<br>XMD%<br>Processor stopped at PC: 0x6fbf0700
<br><br>XMD% dis 0x6fbf0700<br>6FBF0700:&nbsp;&nbsp; 00000000<br>XMD%<br><br><br>so it looks like the processor somewhere is sent out in space - <br>Does anyone have an idea how to find the problem?<br><br>Peter<br><br>

------=_Part_208461_25622348.1158069982953--
