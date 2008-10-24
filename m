Return-Path: <avorontsov@ru.mvista.com>
Date: Sat, 25 Oct 2008 02:37:48 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: GPIO - marking individual pins (not) available in device tree
Message-ID: <20081024223748.GA30499@oksana.dev.rtsoft.ru>
References: <4900ED81.3040202@genesi-usa.com>
	<20081024164120.GA14350@oksana.dev.rtsoft.ru>
	<20081024170128.GA20577@oksana.dev.rtsoft.ru>
	<49024986.5030406@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <49024986.5030406@genesi-usa.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	devicetree-discuss list <devicetree-discuss@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 24, 2008 at 05:17:42PM -0500, Matt Sealey wrote:
> Anton Vorontsov wrote:
>> On Fri, Oct 24, 2008 at 08:41:20PM +0400, Anton Vorontsov wrote:
>> [...]
>>>> Would we suggest a node;
>>>>
>>>> gpio-header {
>>>> 	compatible = "bplan,efika-gpio";
>>>> 	gpios = <&gpio-standard 16 0 17 0>;
>>>> };
>>>>
>>>> gpio-header2 {
>>>> 	compatible = "bplan,efika-gpio-wkup";
>>>> 	gpios = <&gpio-wkup 18 0>;
>>>> };
>>> IMO this looks very reasonable. You properly describe the hardware:
>>> physical device (header) and its resources.
>>
>> If there are actually two headers, that is. If you use two nodes
>> just to specify which gpio is wkup, that is's a bit ugly... Why not
>>
>> gpio-header {
>> 	compatible = "bplan,<board>-gpio-header";
>> 	gpios = <&standard 16 0
>> 		 &standard 17 0
>> 		 &wakeup 18 0>;
>> }
>>
>> And the driver whould know that on this particular <board>
>> third gpio is the wakeup one?
>
> Good point, I concede to your much better plan :D

;-)

> Back to the other discussion, where we give individual GPIOs some
> names so they are detectable and not just programmable as a bank,
> do you have any ideas about that? :/

Pure GPIOs don't have names. But when you use bindings they
automatically translate to names. For example FHCI bindings:

                usb@6c0 {
                        compatible = "fsl,mpc8360-qe-usb",
                                     "fsl,mpc8323-qe-usb";
                        reg = <0x6c0 0x40 0x8b00 0x100>;
                        interrupts = <11>;
                        interrupt-parent = <&qeic>;
                        fsl,fullspeed-clock = "clk21";
                        fsl,lowspeed-clock = "brg9";
                        gpios = <&qe_pio_b  2 0   /* USBOE */
                                 &qe_pio_b  3 0   /* USBTP */
                                 &qe_pio_b  8 0   /* USBTN */
                                 &qe_pio_b  9 0   /* USBRP */
                                 &qe_pio_b 11 0   /* USBRN */
                                 &bcsr13    5 0   /* SPEED */
                                 &bcsr13    4 1>; /* POWER */
                };

The bindings specify that gpios[0] (here qe_pio_b 2) is USBOE,
gpios[1] (here qe_pin_b 3) is USBTP, and so on.

There is nothing new in this. You can see the reg = <> property in
these bindings. It specify two regions: 0x6c0 0x40 - USB Regs
and 0x8b00 0x100 - USB parameter ram. Pure addresses don't have
names until bindings applied.

The same is for interrupts. Device may specify several interrupts:

                enet0: ethernet@24000 {
                        cell-index = <0>;
                        device_type = "network";
                        model = "TSEC";
                        compatible = "gianfar";
                        reg = <0x24000 0x1000>;
                        local-mac-address = [ 00 00 00 00 00 00 ];
                        interrupts = <32 0x8 33 0x8 34 0x8>;
                        interrupt-parent = <&ipic>;
                        phy-handle = <&phy1c>;
                        linux,network-index = <0>;
                };

IRQ 32 is tx interrupt, IRQ33 is rx interrupt, and IRQ34 is
error-reporting interrupt.

But w/o any bindings nobody can tell what does IRQ33 mean (well,
actually we can tell it for ipic on this particular processor,
since it has hard-coded "SOC device<->irq" mapping. But it might
be not true for other controllers, or even ipic's external
interrupts).

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
