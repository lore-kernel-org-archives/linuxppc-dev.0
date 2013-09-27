Return-Path: <B07421@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe002.messaging.microsoft.com [65.55.88.12])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 760B32C0336
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 03:15:07 +1000 (EST)
Message-ID: <1380302098.24959.404.camel@snotra.buserror.net>
Subject: Re: [PATCH][v5] powerpc/mpc85xx:Add initial device tree support of
 T104x
From: Scott Wood <scottwood@freescale.com>
To: Prabhakar Kushwaha <prabhakar@freescale.com>
Date: Fri, 27 Sep 2013 12:14:58 -0500
In-Reply-To: <1380103852-15937-1-git-send-email-prabhakar@freescale.com>
References: <1380103852-15937-1-git-send-email-prabhakar@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Varun Sethi <Varun.Sethi@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Priyanka Jain <Priyanka.Jain@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-09-25 at 15:40 +0530, Prabhakar Kushwaha wrote:
> The QorIQ T1040/T1042 processor support four integrated 64-bit e5500 PA
> processor cores with high-performance data path acceleration architecture
> and network peripheral interfaces required for networking & telecommunications.
> 
> T1042 personality is a reduced personality of T1040 without Integrated 8-port
> Gigabit Ethernet switch.
> 
> The T1040/T1042 SoC includes the following function and features:
> 
>  - Four e5500 cores, each with a private 256 KB L2 cache
>  - 256 KB shared L3 CoreNet platform cache (CPC)
>  - Interconnect CoreNet platform
>  - 32-/64-bit DDR3L/DDR4 SDRAM memory controller with ECC and interleaving
>    support
>  - Data Path Acceleration Architecture (DPAA) incorporating acceleration
>  for the following functions:
>     -  Packet parsing, classification, and distribution
>     -  Queue management for scheduling, packet sequencing, and congestion
>     	management
>     -  Cryptography Acceleration (SEC 5.0)
>     - RegEx Pattern Matching Acceleration (PME 2.2)
>     - IEEE Std 1588 support
>     - Hardware buffer management for buffer allocation and deallocation
>  - Ethernet interfaces
>     - Integrated 8-port Gigabit Ethernet switch (T1040 only)
>     - Four 1 Gbps Ethernet controllers
>  - Two RGMII interfaces or one RGMII and one MII interfaces
>  - High speed peripheral interfaces
>    - Four PCI Express 2.0 controllers running at up to 5 GHz
>    - Two SATA controllers supporting 1.5 and 3.0 Gb/s operation
>    - Upto two QSGMII interface
>    - Upto six SGMII interface supporting 1000 Mbps
>    - One SGMII interface supporting upto 2500 Mbps
>  - Additional peripheral interfaces
>    - Two USB 2.0 controllers with integrated PHY
>    - SD/eSDHC/eMMC
>    -  eSPI controller
>    - Four I2C controllers
>    - Four UARTs
>    - Four GPIO controllers
>    - Integrated flash controller (IFC)
>    - Change this to  LCD/ HDMI interface (DIU) with 12 bit dual data rate
>    - TDM interface
>  - Multicore programmable interrupt controller (PIC)
>  - Two 8-channel DMA engines
>  - Single source clocking implementation
>  - Deep Sleep power implementaion (wakeup from GPIO/Timer/Ethernet/USB)
> 
> Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
> Signed-off-by: Priyanka Jain <Priyanka.Jain@freescale.com>
> Signed-off-by: Varun Sethi <Varun.Sethi@freescale.com>
> Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> ---
>  Based upon git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git
>  Branch next
> 
> Changes for v2: Incorporated Scott's comments
> 	- Update t1040si-post.dtsi
>     - update clock device tree node as per
>       http://patchwork.ozlabs.org/patch/274134/
>     - removed DMA node, It will be added later as per
>       http://patchwork.ozlabs.org/patch/271238/
>     - Updated display compatible field
>  
>  Changes for v3: Incorporated Scott's comments
>    - Updated soc compatible field
>    - updated clock compatible field
> 
>  Changes for v4: Sending as it is 
>  Changes for v5: Sending as it is 

This should have been marked as a numbered patch set along with
"powerpc/fsl-booke: Add initial T104x_QDS board support".

> +	display@180000 {
> +                compatible = "fsl,t1040-diu", "fsl,diu";
> +                reg = <0x180000 1000>;
> +                interrupts = <74 2 0 0>;
> +        };

Whitespace

> +l2switch@800000 {
> +			compatible = "fsl,t1040-l2s";
> +			reg = <0x800000 0x400000>;
> +};

s/l2s/l2-switch/

Is there a better name for this?  Is there a version number or register?

There should be a binding, even if it's just a trivial one establishing
the compatible name, similar to
Documentation/devicetree/bindings/i2c/trivial-devices.txt 

-Scott
