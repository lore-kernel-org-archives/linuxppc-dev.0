Return-Path: <felix@embedded-sol.com>
Message-ID: <49107C46.8060205@embedded-sol.com>
Date: Tue, 04 Nov 2008 18:45:58 +0200
From: Felix Radensky <felix@embedded-sol.com>
MIME-Version: 1.0
To: Ayman El-Khashab <AymanE@tanisys.com>
Subject: Re: Device tree configuration for I2C eeprom
References: <9e4733910809181521r3cd74119tfedd36567e3b5394@mail.gmail.com>	<20080919050441.GD25528@secretlab.ca>
	<16691A8B34B5D9458EA3A1C37A11555A0137F857@tanisys-ex2.Tanisys.Local>
In-Reply-To: <16691A8B34B5D9458EA3A1C37A11555A0137F857@tanisys-ex2.Tanisys.Local>
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
>
> Ok, here is what I used.  I see the nodes created in /sys/bus/i2c/... 
> but I see four of them at address 0x50,0x51,0x52,0x53.  That surprised
> me since I only have 3 of them in the device tree.  However, in any case
> I did not see a way to read or write them.  In one case I was able to
> cat the file "eeprom", but it was only 256 bytes and did not exist for
> the other 3 devices.  Here is the section of my device tree ... I do 
> see the controller being initialized in dmesg, it is just the read and
> write that is eluding me.
>
> One question I did have was within another sample device tree, there was
> a comment that "this makes address 0x50 and 0x51"?  Does that mean that
> large eeproms are spread over several nodes?  I searched around but
> could
> not find an example of how to use this at24 to access my E2 from
> userspace.
>
> Thanks
> Ayman
>
>
>                         IIC0: i2c@ef600700 {
>                                 compatible = "ibm,iic-460ex", "ibm,iic";
>                                 reg = <0xef600700 0x00000014>;
>                                 interrupt-parent = <&UIC0>;
>                                 interrupts = <0x2 0x4>;
>                                 #address-cells = <1>;
>                                 #size-cells = <0>;
>
>                                 at24@50 {
>                                         compatible = "at24,at24c128";
>                                         reg = <0x50>;
>                                 };
>                                 at24@52 {
>                                         compatible = "at24,at24c128";
>                                         reg = <0x52>;
>                                 };
>                                 at24@53 {
>                                         compatible = "at24,at24c128";
>                                         reg = <0x53>;
>                                 };
> 				}
>
>
>   
If you're using Denx kernel, you should add your  at24 device to 
i2c_devices[]
in drivers/i2c/busses/i2c-ibm_of.c This will pass your device tree data 
to at24 driver.

Felix.
