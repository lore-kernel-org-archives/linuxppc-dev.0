Return-Path: <felix@embedded-sol.com>
Message-ID: <4910AAC4.2090303@embedded-sol.com>
Date: Tue, 04 Nov 2008 22:04:20 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Ayman El-Khashab <AymanE@tanisys.com>
Subject: Re: Device tree configuration for I2C eeprom
References: <9e4733910809181521r3cd74119tfedd36567e3b5394@mail.gmail.com>	<20080919050441.GD25528@secretlab.ca>	<16691A8B34B5D9458EA3A1C37A11555A0137F857@tanisys-ex2.Tanisys.Local>	<49107C46.8060205@embedded-sol.com>
	<16691A8B34B5D9458EA3A1C37A11555A0137F85A@tanisys-ex2.Tanisys.Local>
In-Reply-To: <16691A8B34B5D9458EA3A1C37A11555A0137F85A@tanisys-ex2.Tanisys.Local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ayman El-Khashab wrote:
> Felix Radensky <mailto:felix@embedded-sol.com> said on Tuesday, November
> 04, 2008 10:46 AM:
>
>   
>> If you're using Denx kernel, you should add your  at24 device
>> to i2c_devices[] in drivers/i2c/busses/i2c-ibm_of.c This will
>> pass your device tree data to at24 driver.
>>     
>
> I am using the Denx kernel and I see the at24 printing out in dmesg.
> Here is 
> my latest device tree.  Further, I changed the aforementioned file by
> adding
> the following lines as shown.  The at24 driver is in i2c/chips/at24.c
>
> But I still do not see anything obvious show up that I can open to read
> and
> write the eeprom ... what am I missing.  I would have thought there must
> be
> a working example somewhere?
>
>
>
> static struct i2c_driver_device i2c_devices[] __initdata = {
>         {"ricoh,rs5c372a", "rtc-rs5c372", "rs5c372a",},
>         {"ricoh,rs5c372b", "rtc-rs5c372", "rs5c372b",},
>         {"ricoh,rv5c386",  "rtc-rs5c372", "rv5c386",},
>         {"ricoh,rv5c387a", "rtc-rs5c372", "rv5c387a",},
>         {"dallas,ds1307",  "rtc-ds1307",  "ds1307",},
>         {"dallas,ds1337",  "rtc-ds1307",  "ds1337",},
>         {"dallas,ds1338",  "rtc-ds1307",  "ds1338",},
>         {"dallas,ds1339",  "rtc-ds1307",  "ds1339",},
>         {"dallas,ds1340",  "rtc-ds1307",  "ds1340",},
>         {"stm,m41t00",     "rtc-ds1307",  "m41t00"},
>         {"dallas,ds1374",  "rtc-ds1374",  "rtc-ds1374",},
>         {"stm,m41t80",     "rtc-m41t80",  "m41t80",},
>         {"atmel,at24c128", "at24",        "at24c128",},
>         {"spd,at24c02",    "at24",        "at24c02",},
> };
>
>
>
>                        IIC0: i2c@ef600700 {
>                                 compatible = "ibm,iic-460ex", "ibm,iic";
>                                 reg = <0xef600700 0x00000014>;
>                                 interrupt-parent = <&UIC0>;
>                                 interrupts = <0x2 0x4>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
>
>                                 at24@50 {
>                                         compatible = "atmel,at24c128";
>                                         reg = <0x50>;
>                                 };
>                                 spd@51 {
>                                         compatible = "spd,at24c02";
>                                         reg = <0x51>;
>                                 };
>                                 at24@52 {
>                                         compatible = "atmel,at24c128";
>                                         reg = <0x52>;
>                                 };
>                                 at24@53 {
>                                         compatible = "atmel,at24c128";
>                                         reg = <0x53>;
>                                 };
>   
The first entry in the table matches "compatible" property in device tree,
the second one - i2c driver name, and the third one - i2c device name in
the driver id table (see at24_ids[] in at24.c). So in your case it should
look like this:

{"atmel,at24c128",  "at24",   "24c128"}
{"spd,at24c02",       "at24",   "spd"}

Felix.
