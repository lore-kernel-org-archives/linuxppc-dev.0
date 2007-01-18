Return-Path: <wmaxfield@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.249])
	by ozlabs.org (Postfix) with ESMTP id 0F498DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Jan 2007 09:16:40 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id b21so197166ana
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Jan 2007 14:16:39 -0800 (PST)
Message-ID: <45a1b53e0701181416p20e597aarb5a32efbdfcf0a6f@mail.gmail.com>
Date: Thu, 18 Jan 2007 16:16:38 -0600
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: ppc <linuxppc-embedded@ozlabs.org>
Subject: General fx60 notes,
	Question regarding forcing EDK to locate program code at an address
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_134897_14934715.1169158598319"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_134897_14934715.1169158598319
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

  We are working on debugging an FX60 load.  We appear to have something
going into our DDR ram from the compact flash.

   We have learned some things about the fx60 I'd like to share without
giving away secrets.

  It turns out that the FX60 JTAG controller should be hooked up to PPC_1 as
the primary power pc in the chip.

   We found the 8.1 command line impact almost never runs right, so we use
7.1 impact to generate our system ace file.

   Our .opt file looks like the following.  Note that you MUST identify each
device on the jtag chain (minus the system.ace) in order for the
system.aceto do its magic Load the Xilinx trick.  If you don't tell it
of all the
devices on the chain, it will error out, even if those devices are cpld's
and there is not any xilinx load for them in the system.ace file.

genace.opt:

-ace system.ace
-hw implementation/download.bit
-board user
-target ppc_hw
-configdevice devicenr 1 idcode 0x21eb4093 irlength 14 partname xc4vfx60
-configdevice devicenr 2 idcode 0x16d8a093 irlength 8 partname xc2c128
-debugdevice devicenr 1 cpunr 2
-elf linux/zImage.elf
-elf ppc405_0/code/memtest.elf


our command line is as follows
xmd -tcl genace.tcl  -opt genace.opt


The debug device appears to affect which cpu gets the PC reset location
after the .elf file is located.

 The memtest.elf file is stuck in the ppc405_0 directory because that is
where it started, and the gui won't let us change it without rebuilding the
project.
 We are loading two .elf files so that we have the program counter set to
the internal (Block Ram) memory test/boot loader after the .elf files are
finished loading.  This lets us look at our ddr ram memory and prove the
linux load made it there.  The first .elf file loads, then the second one,
then the pc is set to the start address of the second .elf file.  Since the
second .elf file loads into block ram, it is doing nothing, as that is
determined by the bitstream in the fpga fabric.  There may be easier ways to
do this.

MY QUESTION:

  What I would like to do is create a .elf file with the Xilinx EDK and
force it to be located at a particular address (0x400000 for example).
  I've looked and looked, but obviously I've not looked at the right
places.
  Does anyone know how to do this with the Xilinx EDK?

We'll be using this to prove that we can or cannot execute out of DDR ram.

------=_Part_134897_14934715.1169158598319
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>&nbsp; We are working on debugging an FX60 load.&nbsp; We appear to have something going into our DDR ram from the compact flash.<br><br>&nbsp;&nbsp; We have learned some things about the fx60 I&#39;d like to share without giving away secrets.
<br><br>&nbsp; It turns out that the FX60 JTAG controller should be hooked up to PPC_1 as the primary power pc in the chip.<br><br>&nbsp;&nbsp; We found the 8.1 command line impact almost never runs right, so we use 7.1 impact to generate our system ace file.&nbsp; 
<br><br>&nbsp;&nbsp; Our .opt file looks like the following.&nbsp; Note that you MUST identify each device on the jtag chain (minus the system.ace) in order for the system.ace to do its magic Load the Xilinx trick.&nbsp; If you don&#39;t tell it of all the devices on the chain, it will error out, even if those devices are cpld&#39;s and there is not any xilinx load for them in the 
system.ace file.<br><br>genace.opt:<br><br>-ace system.ace<br>-hw implementation/download.bit<br>-board user<br>-target ppc_hw<br>-configdevice devicenr 1 idcode 0x21eb4093 irlength 14 partname xc4vfx60<br>-configdevice devicenr 2 idcode 0x16d8a093 irlength 8 partname xc2c128
<br>-debugdevice devicenr 1 cpunr 2<br>-elf linux/zImage.elf<br>-elf ppc405_0/code/memtest.elf<br><br><br>our command line is as follows<br>xmd -tcl genace.tcl&nbsp; -opt genace.opt<br><br><br>The debug device appears to affect which cpu gets the PC reset location after the .elf file is located.
<br>&nbsp;&nbsp;&nbsp;&nbsp;  <br>&nbsp;The memtest.elf file is stuck in the ppc405_0 directory because that is where it started, and the gui won&#39;t let us change it without rebuilding the project.<br>&nbsp;We are loading two .elf files so that we have the program counter set to the internal (Block Ram) memory test/boot loader after the .elf files are finished loading.&nbsp; This lets us look at our ddr ram memory and prove the linux load made it there.&nbsp; The first .elf file loads, then the second one, then the pc is set to the start address of the second .elf file.&nbsp; Since the second .elf file loads into block ram, it is doing nothing, as that is determined by the bitstream in the fpga fabric.&nbsp; There may be easier ways to do this.
<br><br>MY QUESTION:<br><br>&nbsp; What I would like to do is create a .elf file with the Xilinx EDK and force it to be located at a particular address (0x400000 for example).&nbsp; <br>&nbsp; I&#39;ve looked and looked, but obviously I&#39;ve not looked at the right places.&nbsp; 
<br>&nbsp; Does anyone know how to do this with the Xilinx EDK?&nbsp; <br><br>We&#39;ll be using this to prove that we can or cannot execute out of DDR ram.<br>
<br><br>

------=_Part_134897_14934715.1169158598319--
