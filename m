Return-Path: <Andre.Schwarz@matrix-vision.de>
Received: from p15137414.pureserver.info (matrixvision.de [217.160.213.229])
	by ozlabs.org (Postfix) with ESMTP id 01F68DDDF5
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Apr 2008 19:19:52 +1100 (EST)
Message-ID: <47F73625.9040903@matrix-vision.de>
Date: Sat, 05 Apr 2008 10:19:49 +0200
From: =?ISO-8859-1?Q?Andr=E9_Schwarz?= <Andre.Schwarz@matrix-vision.de>
MIME-Version: 1.0
To: kim.phillips@freescale.com
Subject: MPC8343 - "unable to handle paging request @ 0"
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kim,

sorry for the general questions - but I'm running out of ideas.
We never ever had that many problems getting a PowerPC running during=20
the past 10 years.

I've cross-checked the hardware and design with Freescale FAE.=20
Everything looks fine and is approved.

We're running latest u-boot v1.3.2 and kernel 2.6.25-rc8 from Denx.

A MPC5200B System is up and running fine with this scenario, so=20
hopefully there are no basic problems.

The MPC8343B (rev.3.1) is working pretty fine with u-boot including=20
mtest. Only problem is a the TSECs not working with our RGMII phy - but=20
this can wait.

I've set up a dts based on the MPC834x_mds and removed the 2nd PCI bus=20
and local bus stuff.
Kernel has been build with a new platform "MVBLM7" which is the name of=20
our board - nothing special so far.
u-boot fills out all parameters (clocks, mem, initrd @ chosen, ...)=20
correctly and the kernel is started exactly the same way as the MPC5200B=20
system using "bootm kernel_add initrd_addr dtb_addr".

Kernel starts and crashes with "unable to handle kernel paging request @=20
00000000".

After turning debug on in some files I can see that the initrd memory=20
gets reserved and the dtb is parsed correctly.
PCI memory/io spaces are set up fine.

At first I thought this is a problem with the device tree since the call=20
trace always points to "of_"-functions and "strcmp".
So I removed nearly everything from the kernel and dts including PCI,=20
net, USB and peripherals leaving only a minimum (cpu, mem, soc-node with=20
ipic and serial).

Unfortunately the error is still the same !

I wonder if there are some basic issues regarding MPC8343 or=20
specialities from the Freescale boards not being present on our board.

Major difference is the CPU (MPC8343B), 512MB RAM (using 2 BATs of=20
course) and nothing else on the local bus besides the Nor-Flash.
Of course the MPC8343 has only a single PCI-32 and only one USB.

Do you have any hints on this ?
Do you suggest to wait for the 2.6.25 release ?
Do you know of any MPC8343 based boards already up and running ?

regards,
Andr=E9 Schwarz

MATRIX VISION GmbH, Talstra=DFe 16, DE-71570 Oppenweiler  - Registergeric=
ht: Amtsgericht Stuttgart, HRB 271090
Gesch=E4ftsf=FChrer: Gerhard Thullner, Werner Armingeon, Uwe Furtner
