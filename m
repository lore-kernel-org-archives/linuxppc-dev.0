Return-Path: <wg@grandegger.com>
Message-ID: <487DBB92.1070100@grandegger.com>
Date: Wed, 16 Jul 2008 11:12:50 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [lm-sensors] [PATCH] Support for DS75 thermal sensor
References: <487331DC.2020601@grandegger.com>	<20080708115319.111226e6@hyperion.delvare>	<4873670C.6080204@grandegger.com>	<20080708152935.7457bc90@hyperion.delvare>	<487754DA.1060207@grandegger.com>
	<20080711145613.14380360@hyperion.delvare>
In-Reply-To: <20080711145613.14380360@hyperion.delvare>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-dev@ozlabs.org, Alan Clucas <alanc@pipstechnology.co.uk>,
	Detlev Zundel <dzu@denx.de>, lm-sensors@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Jean,

Jean Delvare wrote:
> Hi Wolfgang,
> 
> On Fri, 11 Jul 2008 14:40:58 +0200, Wolfgang Grandegger wrote:
>> Jean Delvare wrote:
>>> There's no "detection" involved for the new-style i2c devices.
>>> Presumably you are still using the old binding model, not taking
>>> benefit of the patch at all. Use i2c_register_board_info() to
>>> instantiate your "ds75" i2c device from you board's platform code, and
>>> it should work.
>> I have some general question on I2C device probing. Our board does have 
>> two I2C buses. On the first on, there is an RTC at addr 0x32 and a DS75 
>> at 0x4c. Both are defined in the Flattened Device Tree and therefore 
>> i2c_register_board_info() will be called for them. On the second bus, 
>> there are other I2C devices. Nevertheless, probing for RTC and DS75 at 
>> addr 0x32 and 0x4c will be performed also on that bus. Is this the 
>> normal/intended behavior? Can such probing be suppressed?
> 
> Probing isn't supposed to happen at all for RTC chips. There are a few
> drivers which remain to be converted though (rtc-ds1672, rtc-max6900,
> rtc-pcf8583.) If you use one of these and would like to help converting
> it, please tell me (and Alessandro Zummo.)

OK. We ported an old RTC driver for the Epson RX8025 for our board. 
Unfortunately, it did not use the new bindings but I fixed that in the 
meantime. It will be posted for kernel inclusion soon.

> For hwmon chips, probing only occurs if the i2c adapter accepts to be
> probed, by setting the I2C_CLASS_HWMON flag in i2c_adapter.class. If
> you do not want a given i2c bus to be probed, then do not set the flag
> for that bus.

I see. My problem is that I2C_CLASS_HWMON is set in the I2C bus driver 
for the MPC:

   http://lxr.linux.no/linux+v2.6.26/drivers/i2c/busses/i2c-mpc.c#L314

If I disable it, the LM75 driver only probes the addresses of the I2C 
nodes defined in the FDT DTS file. I wonder if this should not be the 
default behaviour for kernels using OF platform description. For this 
reason, I have put Linuxppc-dev ML on CC. I also realized, that there 
are some patches for OF I2C pending. I will check.

Wolfgang.
