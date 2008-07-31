Return-Path: <wg@grandegger.com>
Message-ID: <48921187.1090101@grandegger.com>
Date: Thu, 31 Jul 2008 21:24:55 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: i2c-mpc: make speed registers configurable via
	FDT
References: <4889EFFE.2070201@grandegger.com> <4889FD1D.4010804@freescale.com>
	<20080727012722.GH12191@secretlab.ca>
	<4891A744.6060005@grandegger.com>
	<9e4733910807310849g7e5612dbk9536733e061af8ad@mail.gmail.com>
	<4891F4D8.9090905@grandegger.com>
	<fa686aa40807311031r66f6451aw206faf54509c14d9@mail.gmail.com>
	<4891FC3A.7040609@freescale.com>
	<20080731180959.GA29057@secretlab.ca>
	<489200B6.9060906@freescale.com>
	<20080731182810.GB29097@secretlab.ca>
	<48920607.5040606@freescale.com>
In-Reply-To: <48920607.5040606@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Scott Wood <scottwood@freescale.com>, Linux I2C <i2c@lm-sensors.org>,
	Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Grant Likely wrote:
> 
>> No it doesn't, it depends on the register interface to decide
>> compatibility.  Clock interface is part of that. 
> 
> I don't think so.  The interface for programming the clock registers is
> identical on all 8[356]xx parts.  The only thing that matters is what specific
> values to put in the FDR and DFSR registers to get a desired I2C bus speed.
> That answer is dependent on the actual clock input to the device, which is
> external to the device.  I wouldn't call the input frequency a property of the
> I2C device.

No, the source clock is not identical for all 8[356]xx. Some use half or 
even a third of the SOC clock frequency. Linux must determine the real 
source clock frequency somehow. We may introduce the SOC property 
"i2c-clock-frequency", which could be fixed up by U-Boot or a pre-loader 
(in case U-Boot is not used). Like for other frequency properties as well.

>> I suggested encoding
>> the clock divider directly in compatible (implicit in the SoC version),
>> but it doesn't have to be that way.  If clock freq is obtained from
>> another property or some other method then that is okay too.
> 
> I think we agree on that.
> 
>> There is nothing wrong with it (as long as we agree and it gets
>> documented).  I certainly don't have a problem with doing it this way.
> 
> I propose the property "clock-frequency", like this:
> 
> 		i2c@3000 {
> 			#address-cells = <1>;
> 			#size-cells = <0>;
> 			cell-index = <0>;
> 			compatible = "fsl-i2c";
> 			reg = <0x3000 0x100>;
> 			interrupts = <14 0x8>;
> 			interrupt-parent = <&ipic>;
> 			dfsrr;
> 			clock-frequency = <0xblablabla>;  <-- added by U-Boot
> 		};

I think we already agreed to use the property "clock-frequency" for the 
real I2C clock frequency. If it is not provided, the old settings, e.g. 
from U-Boot, will be kept.

> Note that the dfsrr property already differentiates between 8xxx and 52xx, so
> maybe we don't need any other device tree changes.

It should be done via the compatible property.

Wolfgang.
