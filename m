Date: Mon, 13 Oct 2003 22:43:20 -0700
From: Peter Ryser <Peter.Ryser@xilinx.com>
Subject: Re: debug Montavista on ML300
In-reply-to: <002501c3906c$91a87570$4a44900a@hydingnb>
To: hyding <nari_dhy@nari-china.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>,
	"Kerl, John" <John.Kerl@avnet.com>
Message-id: <3F8B8CF8.4000708@xilinx.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <002501c3906c$91a87570$4a44900a@hydingnb>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

you have a few options to download the Linux kernel to the board
depending on your work environment:

1. If you are using V2PDK, i.e the tool set that ships with the ML300,
then use GDB to download the kernel with the P4 cable.
    a) open a V2PDK shell
    b) change directories to the location where your Linux kernel resides
    c) start GDB, download and start the kernel
          $ powerpc-eabi-gdb -nw -nx zImage.embedded
          (gdb) target ocd xilinx
          (gdb) set download-write-size 0
          (gdb) load
          (gdb) c

2. If you are using EDK then use XMD to download the kernel with the P4
cable.
    a) open a xygwin shell
    b) change directories to the location where your Linux kernel resides
    c) start XMD, download and start the kernel
          $ xmd
          XMD% ppcc
          XMD% dow zImage.embedded
          XMD% run

3. If you are using a 3rd party debugger follow the instructions of the
debugger manufacturer.

4. To generate an ACE file out of the bitstream and the Linux kernel
follow the instructions in the V2PDK or EDK documentation.

- Peter


hyding wrote:

>hi,
>    Maybe this is not the right place to ask questions. But i wish
>someone in this list will give me some help. Any hint will be
>appreciable.
>
>    I am doing some work on ML300. After i generate the configuration
>file(top.bit), i don't know how to download the OS image to DDR SDRAM.
>Can i use the Parallel Cabel IV to download the OS image to DDR SDRAM?
>>From some docs, i see the method to combine the configuration .bit file
>and OS image into a .ace file. Put the .ace into the CF card, the FPGA
>will be configured with this .ace after power. But how to make the .ace
>file including the .bit file and OS?
>
>    Thanks!
>
>---
>ding hou yong
>Nanjing Electrical Automation Institute
>Tel: 86-25-3429900-2425
>GSM: 86-(0)13814021009
>FAX: 86-25-3429900-2425
>Email: nari_dhy@nari-china.com
>Http: www.nari-china.com
>---
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
