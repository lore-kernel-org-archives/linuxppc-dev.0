Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62EAE67B3A
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 15:09:54 +1000 (EST)
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306E04FEA@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467306E04FEA@zch01exm40.ap.freescale.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AECCB669-2D0C-4F40-9756-A434F89D7187@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add QE device tree definition
Date: Fri, 30 Jun 2006 00:09:47 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 29, 2006, at 11:52 PM, Li Yang-r58472 wrote:

>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Friday, June 30, 2006 12:11 PM
>> To: Li Yang-r58472
>> Cc: linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH] Add QE device tree definition
>>
>> [snip]
>>
>>>>> +   2) SPI (Serial Peripheral Interface)
>>>>> +
>>>>> +   Required properties:
>>>>> +   - device_type : should be "spi".
>>>>> +   - compatible : should be "fsl_spi".
>>>>> +   - mode : the spi operation mode, it can be "cpu" or "qe".
>>>>
>>>> What does it mean for the spi to be in "qe" mode?
>>> That means:
>>> The SPI can operate in QE mode or in CPU mode. In QE mode SPI is
>>> compatible to the MPC826x SPI, and is controlled by QE RISC. In CPU
>>> mode, the SPI is controlled wholly by the CPU without any QE RISC
>>> intervention.
>>
>> In QE mode does software get involved at all?
>
> Yes, of course.  The driver needs to do initialization, and deal  
> with the BDs.

So what exactly does the QE do in this mode?

>>>>> +   - reg : offset to the register set and its length.
>>>>> +   - interrupts : <a b> where a is the interrupt number and b  
>>>>> is a
>>>>> +     field that represents an encoding of the sense and level
>>>>> +     information for the interrupt.  This should be encoded
>>>>> based on
>>>>> +     the information in section 2) depending on the type of
>>>>> interrupt
>>>>> +     controller you have.
>>>>> +   - interrupt-parent : the phandle for the interrupt controller
>>>>> that
>>>>> +     services interrupts for this device.
>>>>> +
>>>>> +   Example:
>>>>> +	spi@4c0 {
>>>>> +		device_type = "spi";
>>>>> +		compatible = "fsl_spi";
>>>>> +		reg = <4c0 40>;
>>>>> +		interrupts = <82 0>;
>>>>> +		interrupt-parent = <700>;
>>>>> +		mode = "cpu";
>>>>> +	};
>>>>> +
>>
>> [snip]
>>
>>>>> +   5) Parallel I/O Ports
>>>>> +
>>>>> +   This node configures Parallel I/O ports for CPUs with QE
>>>>> support.
>>>>> +   The node should reside in the "soc" node of the tree.  For  
>>>>> each
>>>>> +   device that using parallel I/O ports, a child node should be
>>>>> created.
>>>>> +   See the definition of the Pin configuration nodes below for  
>>>>> more
>>>>> +   information.
>>>>> +
>>>>> +   Required properties:
>>>>> +   - device_type : should be "par_io".
>>>>> +   - reg : offset to the register set and its length.
>>>>> +
>>>>> +   Example:
>>>>> +	par_io@1400 {
>>>>> +		reg = <1400 100>;
>>>>> +		#address-cells = <1>;
>>>>> +		#size-cells = <0>;
>>>>> +		device_type = "par_io";
>>>>> +		ucc_pin@01 {
>>>>> +			......
>>>>> +		};
>>>>> +
>>>>
>>>> Can you explain this further, I'm not getting the relationship
>>>> between a par_io & ucc_pin.  An example maybe helpful.
>>>
>>> Each QE device needs to configure Parallel I/O Ports pin
>>> configuration in order to work, for example the configuration for
>>> ucc1 is ucc_pin@01.  par_io is a container for all these
>>> configurations and gives the base for parallel io port register.  I
>>> will paste dts file for 8360 to give an example.
>>
>> Maybe its the name that's confusing me, ucc_pin@01 describes what
>> exactly?  A single pin? or all the pin configs for ucc 1?
>
> All pin configs to ucc1.
> Could you suggest a more proper name?

Let me think on this now that I understand what's going on.

- k
