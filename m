Return-Path: <john.bonesio@xilinx.com>
From: John Bonesio <john.bonesio@xilinx.com>
To: Linuxppc-dev@ozlabs.org
Subject: ppc440 caches - change proposal [RFC]
Date: Tue, 8 Apr 2008 15:53:27 -0700
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <20080408225329.5EC171A8007D@mail11-dub.bigfish.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

We've discovered something interesting when not using a bootloader such as uboot to start Linux.

The Linux kernel seems to be depending on the bootloader to set up the ppc440 cache control registers, ivlim and dvlim, to set up the Normal and Transient areas in the caches. When a separate bootloader is not used, these cache control registers have random values.

I can think of a couple reasons why somone might not want to use a separate bootloader. Their device could be so small that there's not enough flash to store booth the bootloader, the kernel image, and other things they need in flash. They could want to improve bootup time for their device.

I was thinking it might be good to have the kernel initialize these cache control registers in it's own start up code. Or perhaps this could be done in the kernel's simple bootloader. We could probably put this change in a Xilinx specific startup file, but this change doesn't seem specific to Xilinx FPGA boards.

Thoughts?

- John
