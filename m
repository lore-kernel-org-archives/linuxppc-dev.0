Return-Path: <wg@grandegger.com>
Message-ID: <4889F299.3080403@grandegger.com>
Date: Fri, 25 Jul 2008 17:34:49 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
References: <488982B5.4070102@grandegger.com> <4889942C.4040800@scram.de>	
	<48899736.8020400@grandegger.com>
	<fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
In-Reply-To: <fa686aa40807250612g34b5167dtbe70c810f30a5d32@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Fri, Jul 25, 2008 at 5:04 AM, Wolfgang Grandegger <wg@grandegger.com> wrote:
>> Jochen Friedrich wrote:
>>> Hi Wolfgang,
>>>
>>>> The I2C driver for the MPC currently uses a fixed speed hard-coded into
>>>> the driver. This patch adds the FDT properties "fdr" and "dfsrr" for the
>>>> corresponding I2C registers to make the speed configurable via FDT, e.g.:
>>>>
>>>>    i2c@3100 {
>>>>        compatible = "fsl-i2c";
>>>>        reg = <0x3100 0x100>;
>>>>        interrupts = <43 2>;
>>>>        interrupt-parent = <&mpic>;
>>>>        dfsrr = <0x20>;
>>>>        fdr = <0x03>;
>>>>    };
>>>
>>> Would it be possible to use the standard property "clock-frequency" for
>>> this
>>> and calculate the register settings in the driver?
> 
> Yes, please use something like clock-frequency or current-speed and do
> the calculation.
> 
>> Almost everything is possible in software, just for what price ;-). U-Boot
>> has some code in drivers/i2c/fsl_i2c.c to determine reasonable fdr and dfsrr
>> values for the MPC83/5/6xx boards. For the MPC82xx and MPC85xx it's even
>> more sophisticated.
>>
>> I was also thinking to just overtake the U-Boot settings if fdt and dfsrr is
>> not defined for the I2C node (instead of the debatable default values).
> 
> This is a perfectly valid option.  Personally, I'd prefer it encoded
> in the device tree, but if it looks like a valid speed has already
> been programmed in then I'm cool with the driver just preserving that.
>  If it turns out to causes problems the we can always change the code
> to be more conservative later.

How should the Linux driver decide if the registers have been already 
set by the boot-loader? The reset-values might be good as well. 
Therefore, if "clock-frequency" is not specified, the driver may simply 
not touch the fdr and dfsr registers (overtaking the values from the 
boot-loader).

What do you think.

Wolfgang.
