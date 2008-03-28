Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 656BCDDFA3
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Mar 2008 02:16:44 +1100 (EST)
Message-ID: <56434.79.33.233.21.1206717346.squirrel@nausicaa2.coritel.it>
In-Reply-To: <D06A33A2-7DE7-4E00-9AA0-1C11EE7D4375@kernel.crashing.org>
References: <47E8B19B.10705@coritel.it>
	<7F2C28B9-9B87-4F46-9C57-3666BB8F7EFD@kernel.crashing.org>
	<47E8F836.9060603@coritel.it>
	<D06A33A2-7DE7-4E00-9AA0-1C11EE7D4375@kernel.crashing.org>
Date: Fri, 28 Mar 2008 16:15:46 +0100 (CET)
Subject: Re: MPC8641D PCI-Express problem
From: marco.stornelli@coritel.it
To: "Kumar Gala" <galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>
> On Mar 25, 2008, at 8:03 AM, Marco Stornelli wrote:
>> Kumar Gala ha scritto:
>>> On Mar 25, 2008, at 3:02 AM, Marco Stornelli wrote:
>>>> Hi,
>>>>
>>>> do you remember my problem with the pci-express? I have an
>>>> mpc8641d_hpcn (rev. 2.0) board connected via pci-express with the
>>>> Xilinx ML555 evaluation board. I'm using the 2.6.24 kernel. I'm
>>>> observing this strange behavior:
>>>>
>>>> 1) I turn on the board and I stop the U-boot
>>>> 2) I load the FPGA microcode
>>>> 3) I start the system
>>>> 4) I load the driver module and I read a version register in the
>>>> FPGA
>>>> 5) The system crashes with a "machine check exception: transfer
>>>> error ack signal"
>>>> 6) reboot
>>>> 7) same procedure (without load the FPGA again)
>>>> 8) now I can read the registers!
>>>>
>>>> If I repeat the procedure again it doesn't work anymore. I think
>>>> it's a problem with pci-express controller. Have you got any
>>>> suggestions?
>>>>
>>>> Thanks.
>>> Where are you loading the FPGA microcode (linux, u-boot)?  Also, is
>>> the FPGA the only device connected over PCIe?
>>> - k
>> I load the FPGA with JTAG and with a Xilinx program without a
>> specific linux driver or u-boot. Yes, it is the only device
>> connected over PCIe.
>
> The issue may be related to the PCIe link training.  Are you able to
> access the FPGA in u-boot?  Can you try reseting the PCIe controller
> after you've loaded up the FPGA (see u-boot code in drivers/pci/
> fsl_pci_init.c and look for CONFIG_FSL_PCIE_RESET)
>
> - k
>

Ok I can try but I'm using the U-Boot 1.3.0 provided by Freescale with the
board, so I have to change the firmware, updating the U-Boot to the
version 1.3.2 to use CONFIG_FSL_PCIE_RESET. However, I've had the same
idea, but I check (with a warning) this case in the kernel function
fsl_check_pcie_link() (where the kernel check the value of LTSSM) but I've
never seen the warning during the start-up.
