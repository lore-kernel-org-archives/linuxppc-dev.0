Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809181521r3cd74119tfedd36567e3b5394@mail.gmail.com>
Date: Thu, 18 Sep 2008 18:21:36 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Sebastian Siewior" <linuxppc-embedded@ml.breakpoint.cc>
Subject: Re: Device tree configuration for I2C eeprom
In-Reply-To: <20080918221335.GA6420@Chamillionaire.breakpoint.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <16691A8B34B5D9458EA3A1C37A11555A0137F7B6@tanisys-ex2.Tanisys.Local>
	<20080918221335.GA6420@Chamillionaire.breakpoint.cc>
Cc: Ayman El-Khashab <AymanE@tanisys.com>, Linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 18, 2008 at 6:13 PM, Sebastian Siewior
<linuxppc-embedded@ml.breakpoint.cc> wrote:
> * Ayman El-Khashab | 2008-09-18 14:44:44 [-0500]:
>
>>Here is a snippet from the dts file, and I assume I need something like
>>what I've added:
>>
>>                        IIC0: i2c@ef600700 {
>>                                compatible = "ibm,iic-460ex", "ibm,iic";
>>                                reg = <ef600700 14>;
>>                                interrupt-parent = <&UIC0>;
>>                                interrupts = <2 4>;
>>                                #address-cells = <1>;
>>                                #size-cells = <0>;
>>                                rtc@68 {
>>                                        compatible = "stm,m41t80";
>>                                        reg = <68>;
>>                                };
>>                                eeprom@50 {
>>                                        compatible = "?????";
>>                                                   something
>>                                        something;
>>                                };
>
> This should look like:
> |                        IIC0: i2c@ef600700 {
> |                                compatible = "ibm,iic-460ex", "ibm,iic";
> |                                reg = <ef600700 14>;
> |                                interrupt-parent = <&UIC0>;
> |                                interrupts = <2 4>;
> |                                #address-cells = <1>;
> |                                #size-cells = <0>;
> |                                rtc@68 {
> |                                        compatible = "m41t80";
> |                                        reg = <68>;
> |                                };
> |                                eeprom@50 {
> |                                        compatible = "eeprom";


The new eeprom driver is at24, eeprom is the old one. at24 has write support.

EEPROMs from most vendors (AT24)

Enable this driver to get read/write support to most I2C EEPROMs,
after you configure the driver to know about each EEPROM on
your target board. Use these generic chip names, instead of
vendor-specific ones like at24c64 or 24lc02:

24c00, 24c01, 24c02, spd (readonly 24c02), 24c04, 24c08,
24c16, 24c32, 24c64, 24c128, 24c256, 24c512, 24c1024

Unless you like data loss puzzles, always be sure that any chip
you configure as a 24c32 (32 kbit) or larger is NOT really a
24c16 (16 kbit) or smaller, and vice versa. Marking the chip
as read-only won't help recover from this. Also, if your chip
has any software write-protect mechanism you may want to review the
code to make sure this driver won't turn it on by accident.

If you use this with an SMBus adapter instead of an I2C adapter,
full functionality is not available. Only smaller devices are
supported (24c16 and below, max 4 kByte).

This driver can also be built as a module. If so, the module
will be called at24.
> |                                        reg = <50>;
> |                                };
>
> Compatible is the ID of the driver. You can find it in the driver
> itself: if you look in ./drivers/rtc/rtc-m41t80.c you will find a struct
> m41t80_id which contains the ids. The same applies to the eeprom driver.
> You might want to update your dts from current kernel tree which
> contains the "/dts-v1/" tag at the beginning and then your field must
> contain an 0x prefix.
>
>>Once I do all that, how does one use the eeprom driver to read and write
>>this part?
> The eeprom driver should create an eeprom file somewhere in /sys I am
> not sure where exactly. The help entry in Kconfig says that is module
> provides only RO access to the eeprom.
>
> Sebastian
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>



-- 
Jon Smirl
jonsmirl@gmail.com
