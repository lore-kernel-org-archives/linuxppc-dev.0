Return-Path: <jochen@scram.de>
Message-ID: <477CCB0F.8020504@scram.de>
Date: Thu, 03 Jan 2008 12:46:23 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Jochen Friedrich <jochen@scram.de>,  linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>, linux-kernel@vger.kernel.org,
	"linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCHv3] powerpc: DBox2 Board Support
References: <477522DB.4000100@scram.de>
	<20080102112030.GB23168@localhost.localdomain>
In-Reply-To: <20080102112030.GB23168@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi David,

>> +/ {
>> +	model = "unknown,dbox2"; // boot wrapper fills in correct manufacturer
> 
> Probably better just to leave model out of the dts and let the
> bootwrapper add it.

Unfortunately, dtc requires a model:

$ dtc arch/powerpc/boot/dts/dbox2.dts
DTC: dts->dts  on file "arch/powerpc/boot/dts/dbox2.dts"
ERROR: Missing "model" property in /

>> +		flash@0,0 {
>> +			compatible = "cfi-flash";
>> +			reg = <0 0 800000>;
>> +			bank-width = <4>;
>> +			device-width = <1>;
>> +			#address-cells = <1>;
>> +			#size-cells = <1>;
>> +			partition@0 {
>> +				label = "BR bootloader";
>> +				reg = <0 20000>;
>> +				read-only;
>> +			};
>> +			partition@20000 {
>> +				label = "FLFS (U-Boot)";
>> +				reg = <20000 20000>;
>> +			};
>> +			partition@40000 {
>> +				label = "rootfs";
>> +				reg = <40000 7c0000>;
>> +			};
>> +			ovpartition@20000 {
> 
> Uh.. I really don't know what the MTD driver will handle these
> overlapping partitions.  I suspect it will not be pretty...
> 
>> +				label = "Flash without bootloader";
>> +				reg = <20000 7e0000>;
>> +			};
>> +			ovpartition@0 {
>> +				label = "Complete Flash";
>> +				reg = <0 800000>;
>> +				read-only;
>> +			};
>> +		};
>> +	};

MTD handles this correctly. dbox2 uses "Flash without bootloader" for flashing image updates and "Complete Flash" for creating a backup of everything.
OpenWRT also uses overlapping partitions BTW (and also for flashing updates).

Thanks,
Jochen
