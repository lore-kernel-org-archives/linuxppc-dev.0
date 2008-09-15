Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809150616u3c50797cwbf48e139b239146c@mail.gmail.com>
Date: Mon, 15 Sep 2008 09:16:58 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: avorontsov@ru.mvista.com
Subject: Re: Device treee syntax for expanding mpc5200 gpios
In-Reply-To: <20080915130206.GA25628@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910809121343q641f4204pccf6ae110fbd6a04@mail.gmail.com>
	<20080915130206.GA25628@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 15, 2008 at 9:02 AM, Anton Vorontsov
<avorontsov@ru.mvista.com> wrote:
> On Fri, Sep 12, 2008 at 04:43:22PM -0400, Jon Smirl wrote:
>> I need to implement some more of the mpc5200's gpio capabilities.
>>
>> Right now we have:
>> gpios = <&gpio_wkup 0 0>;
>> first cell is index into the bank, and second is unused.
>>
>> What do we need to fully describe a mpc5200 gpio?
>>
>> 1) open drain: 1 enable
>
> This can be described in the gpios = <> property via second cell.
>
>> 2) interrupt: 0 no int, 1 simple, 2 wakeup, 3 both
>> 3) interrupt type: 0 any transition, 1 rising, 2 falling, 3 pulse
>
> These we describe via interrupts = <> proprty, so..
>
>> A gpio pin would then have four cells?
>>
>> Or should all of this be encoded into a single cell so that the
>> existing two cell syntax can be preserved?
>
> It is still possible to preserve two cells syntax and encode
> irq-specific information there, but this isn't pretty.
>
> I think that interrupts and their information could be encoded in
> the "interrupts" property... something like (QE example):
>
> qe_pio_e: gpio-controller@1460 {
>        #gpio-cells = <2>;
>        compatible = "fsl,mpc8360-qe-pario-bank",
>                     "fsl,mpc8323-qe-pario-bank";
>        reg = <0x1460 0x18>;
>        interrupts = <0 1 2 3 4 5 6 7 8 9 ...>;
>        interrupt-parent = <&qeic>;
>        gpio-controller;
> };
>
> qeic: interrupt-controller@80 {
>        #address-cells = <0>;
>        #interrupt-cells = <1>;
>        compatible = "fsl,qe-ic";
>        interrupt-controller;
>        reg = <0x80 0x80>;
>        big-endian;
>        interrupts = <32 8 33 8>;
>        interrupt-parent = <&ipic>;
> };
>
> That way it is easy to implement gpio_to_irq() call, and we won't
> need to bother with interrupt-specific information in the gpios = <>.

The easiest way to implement gpio_to_irq() is to arrange things so
that the gpio number used internally by linux is the same as the virq
number.  I did this in the code I posted in the other thread,

In the mpc5200 the level sensitivity of each gpio interrupt can be set
independently, but there is a kernel API for doing it.

By doing these two things none of the interrupt info needs to be
encoded into the device tree.


>
> It also correctly describes the hardware, there are really two
> distinct hw units: interrupt controller and gpio controller.
>
> Also, I think that gpio_to_irq() call would be a rare case, since
> you can always specify interrupts directly, i.e.
>
> device {
>        gpios = <&qe_pio_e 0 0>;
>        interrupts = <0>;
>        interrupt-parent = <&qeic>;
> };
>
> --
> Anton Vorontsov
> email: cbouatmailru@gmail.com
> irc://irc.freenode.net/bd2
>



-- 
Jon Smirl
jonsmirl@gmail.com
