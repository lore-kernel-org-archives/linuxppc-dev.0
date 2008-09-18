Return-Path: <linuxppc-embedded@ml.breakpoint.cc>
Date: Fri, 19 Sep 2008 00:13:35 +0200
From: Sebastian Siewior <linuxppc-embedded@ml.breakpoint.cc>
To: Ayman El-Khashab <AymanE@tanisys.com>
Subject: Re: Device tree configuration for I2C eeprom
Message-ID: <20080918221335.GA6420@Chamillionaire.breakpoint.cc>
References: <16691A8B34B5D9458EA3A1C37A11555A0137F7B6@tanisys-ex2.Tanisys.Local>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <16691A8B34B5D9458EA3A1C37A11555A0137F7B6@tanisys-ex2.Tanisys.Local>
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

* Ayman El-Khashab | 2008-09-18 14:44:44 [-0500]:

>Here is a snippet from the dts file, and I assume I need something like
>what I've added:
> 
>                        IIC0: i2c@ef600700 {
>                                compatible = "ibm,iic-460ex", "ibm,iic";
>                                reg = <ef600700 14>;
>                                interrupt-parent = <&UIC0>;
>                                interrupts = <2 4>;
>                                #address-cells = <1>;
>                                #size-cells = <0>;
>                                rtc@68 {
>                                        compatible = "stm,m41t80";
>                                        reg = <68>;
>                                };
>                                eeprom@50 {
>                                        compatible = "?????";
> 						    something
>                                        something;
>                                };

This should look like:
|                        IIC0: i2c@ef600700 {
|                                compatible = "ibm,iic-460ex", "ibm,iic";
|                                reg = <ef600700 14>;
|                                interrupt-parent = <&UIC0>;
|                                interrupts = <2 4>;
|                                #address-cells = <1>;
|                                #size-cells = <0>;
|                                rtc@68 {
|                                        compatible = "m41t80";
|                                        reg = <68>;
|                                };
|                                eeprom@50 {
|                                        compatible = "eeprom";
|                                        reg = <50>;
|                                };

Compatible is the ID of the driver. You can find it in the driver
itself: if you look in ./drivers/rtc/rtc-m41t80.c you will find a struct
m41t80_id which contains the ids. The same applies to the eeprom driver.
You might want to update your dts from current kernel tree which
contains the "/dts-v1/" tag at the beginning and then your field must
contain an 0x prefix.

>Once I do all that, how does one use the eeprom driver to read and write
>this part?
The eeprom driver should create an eeprom file somewhere in /sys I am
not sure where exactly. The help entry in Kconfig says that is module
provides only RO access to the eeprom.

Sebastian
