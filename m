Date: Fri, 13 Feb 2004 07:24:32 -0800
From: Peter Ryser <Peter.Ryser@xilinx.com>
Subject: Re: ml300 boot loader question
In-reply-to: <20040211214947.87373.qmail@web21110.mail.yahoo.com>
To: Lou Rickard <lou_rickard@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Message-id: <402CEC30.9060503@xilinx.com>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
References: <20040211214947.87373.qmail@web21110.mail.yahoo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lou,

there are two parts involved in booting a Linux system on the Virtex-II
Pro FPGA on the ML300:

1. a bitstream that programs the FPGA. The bitstream is created with the
EDK kit from scratch or based on the EDK reference design for ML300
available at
http://www.xilinx.com/ise/embedded/edk_examples.htm (design # 6)
2. a Linux kernel created

Then, there are two main methods on how to bring up Linux.

a. With Impact and a SW debugger (BDI2000)
b. With System ACE CF.

In both cases first the bitstream is loaded to program the FPGA and the
then Linux kernel is loaded through the processor into main memory.
If  you use method a) you first program the FPGA with Impact and then
use the BDI2000 to download the Linux kernel into main memory. The
BDI2000 will then also set the PC to the start address of the Linux
kernel and on your command start executing the code.

If you use method b) you use EDK to generate an ACE file for example in
an EDK shell type
xmd genace.tcl -jprog -board ml300 -hw implementation/download.bit -elf
<path to linux kernel> -ace top.ace
See the EDK documentation for more details.

Now, copy the resulting top.ace file onto the MicroDrive shipping with
ML300, for example, into xilinx/myace. Set the rotary dial that selects
which configuration is loaded by the System ACE chip to the correct
number. When you hit the System ACE reset button the System ACE CF chip
starts loading the ACE file and as part of the process loads the FPGA
bitstream, downloads the Linux kernel into main memory, and boots Linux.

- Peter


Lou Rickard wrote:

>I'm having a hard time figuring out how to boot our
>kernel/filesystem on the ml300.  I suspect it's a
>problem with the bootloader, but not 100% sure.
>
>We're able to generate a file to program the FPGA with
>that will allow us to use the BDI2000 to boot the
>system.  From trial and error, I've gotten the
>impression that the FPGA file includes a bootloader of
>some kind: when we didn't include some of the binary
>firmware with the FPGA file we couldn't even get the
>BDI2000 to boot the system.  When we started including
>the binary firmware stuff (which I don't quite
>understand yet), the system came up to a state where
>we could boot with the BDI2000.
>
>So, based on that, I'm guessing that the systemace
>chip fills the bram with some sort of bootloader
>sometime around when it programs the FPGA.
>
>However, I haven't been able to build a FPGA file that
>would actually boot to a linux filesystem on the flash
>card.  The FPGA programs, but then nothing happens
>(this is with the BDI2000 unplugged, I don't think any
>software can be run with the BDI2000 plugged in unless
>it's downloaded via the BDI2000, but I could very well
>be incorrect).
>
>I've looked at the Monta Vista partitions that came
>with the kit.  I don't see any kind of stand alone
>boot loader, so I'm guessing that they have included
>their bootloader with the FPGA file.  I don't know if
>this is a modification of the bootloading binaries
>that come with the Xilinx development kit.
>
>Could anyone clue me in?
>
>Thanks,
>
>~lr
>
>
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
