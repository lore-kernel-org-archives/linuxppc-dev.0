Date: Wed, 04 Jun 2003 09:45:31 -0700
From: Peter Ryser <Peter.Ryser@xilinx.com>
Subject: Re: bootstrap of virtex-ii pro eval board ML300
To: Scott Anderson <sanders@mvista.com>
Cc: "Kerl, John" <John.Kerl@avnet.com>,
	??? <nari_dhy@nari-china.com>, linuxppc-embedded@lists.linuxppc.org
Message-id: <3EDE222B.38CBF@xilinx.com>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <384EB15A-953C-11D7-85A6-000A959CAB7C@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


As Scott describes correctly the preferred method of booting ML300 is through
System ACE CF. System ACE CF reads ACE files and programs the FPGA and the
PowerPC processor through the JTAG chain.

The ACE file is a concatenation of zero or one bitstream with zero to n ELF
files. Typically, it is one bitstream and one ELF file.
On power-up or reset System ACE CF reads the ACE file from the MicroDrive or
CompactFlash card and in a first step programs the FPGA. Then, in a second
step, from the same ACE file, it programs the processor, i.e. similar to an
external debugger it loads code and data contained in the ELF file into the
processor memories, sets the PC to the start address, and starts executing the
program.

For Linux, you will use the Linux kernel as the ELF file.

You can generate ACE files easily by using EDK by running the command
$ xmd genace.tcl implementation/system.bit arch/ppc/boot/images/zImage.embedded
top.ace
in your hardware project directory.

- Peter

-----
Some useful links:
System ACE CF: (http://www.xilinx.com/isp/systemace/systemacecf.htm
EDK: http://www.xilinx.com/edk
ML300: http://www.xilinx.com/ml300


Scott Anderson wrote:

> On Monday, June 2, 2003, at 01:48  PM, Kerl, John wrote:
> > You're saying that the entire zvmlinux.initrd file
> > (2-3 MB, say) is contained in the FPGA bitstream??
>
> I am saying that the entire zImage.embedded (without
> an initrd) is in the FPGA bitstream.  Its root partition
> is an ext2 partition on the IBM MicroDrive.
>
>    Scott
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
