Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 1C90CDDE1D
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 09:02:37 +1100 (EST)
Message-ID: <49C41278.6060801@grandegger.com>
Date: Fri, 20 Mar 2009 23:02:32 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>, linuxppc-dev@ozlabs.org
Subject: Re: powerpc/85xx: Add support for the "socrates" board (MPC8544)
References: <49C26434.30302@grandegger.com>
	<20090320041022.GB30527@yookeroo.seuss>
In-Reply-To: <20090320041022.GB30527@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Thu, Mar 19, 2009 at 04:26:44PM +0100, Wolfgang Grandegger wrote:
>> This patch adds support for the "socrates" board based on the MPC8544.
>> Supported are Ethernet, serial console, I2C, I2C-based RTC and
>> temperature sensors, NOR and NAND flash, PCI, USB, CAN and Lime
>> display controller.
>>
>> The multiplexing of FPGA interrupts onto PowerPC interrupt lines is
>> supported through our own fpga_pic interrupt controller driver.
>>
>> For example the SJA1000 controller is level low sensitive connected to
>> fpga_pic line 2 and is routed to the second (of three) irq lines to
>> the CPU:
> 
> A few minor device tree nits.
> 
>> +	soc8544@e0000000 {
>> +		#address-cells = <1>;
>> +		#size-cells = <1>;
>> +		device_type = "soc";
>> +
>> +		ranges = <0x00000000 0xe0000000 0x00100000>;
>> +		reg = <0xe0000000 0x00001000>;	// CCSRBAR 1M
>> +		bus-frequency = <0>;		// Filled in by U-Boot
>> +		compatible = "fsl,socrates-immr", "simple-bus";
> 
> This should probably refer to 8544 instead of socrates.  Unless you
> really do have a board-specific version of the SoC...

OK, that should then be:

   +		compatible = "fsl,mpc8544-immr", "simple-bus";

It should always be with the prefix "mpc", I guess. But some of the
following compatible names are without that prefix:

$ grep -h '\-l2-cache-controller' *
			compatible = "fsl,8540-l2-cache-controller";
			compatible = "fsl,mpc8536-l2-cache-controller";
			compatible = "fsl,8540-l2-cache-controller";
			compatible = "fsl,8541-l2-cache-controller";
			compatible = "fsl,8544-l2-cache-controller";
			compatible = "fsl,8548-l2-cache-controller";
			compatible = "fsl,8555-l2-cache-controller";
			compatible = "fsl,8540-l2-cache-controller";
			compatible = "fsl,8568-l2-cache-controller";
			compatible = "fsl,mpc8572-l2-cache-controller";
			compatible = "fsl,mpc8572-l2-cache-controller";
			compatible = "fsl,mpc8572-l2-cache-controller";
			compatible = "fsl,8548-l2-cache-controller";
			compatible = "fsl,8560-l2-cache-controller";
			compatible = "fsl,mpc8544-l2-cache-controller";
			compatible = "fsl,mpc8544-l2-cache-controller";
			compatible = "fsl,8540-l2-cache-controller";
			compatible = "fsl,8540-l2-cache-controller";
			compatible = "fsl,8540-l2-cache-controller";
			compatible = "fsl,mpc8548-l2-cache-controller";
			compatible = "fsl,mpc8548-l2-cache-controller";
			compatible = "fsl,8540-l2-cache-controller";
			compatible = "fsl,8540-l2-cache-controller";

That's confusing.

Wolfgang.
