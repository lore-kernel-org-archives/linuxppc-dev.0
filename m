Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809141959v4b2b1942u7d6ca23cef87f268@mail.gmail.com>
Date: Sun, 14 Sep 2008 22:59:22 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Re: Device treee syntax for expanding mpc5200 gpios
In-Reply-To: <20080915024048.GA20312@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910809121343q641f4204pccf6ae110fbd6a04@mail.gmail.com>
	<20080915024048.GA20312@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Sep 14, 2008 at 10:40 PM, David Gibson
<david@gibson.dropbear.id.au> wrote:
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
>> 2) interrupt: 0 no int, 1 simple, 2 wakeup, 3 both
>> 3) interrupt type: 0 any transition, 1 rising, 2 falling, 3 pulse
>
> Maybe I'm misunderstanding the situation, but 2 and maybe 3 look more
> like configuration than something inherent to the hardware setup.
> Couldn't different drivers potentially choose different interrupt
> modes depending on their needs?  Remember the device tree describes
> the hardware, not how it's used.

This makes sense. Now that I understand more about the Linux interrupt
system I see that there is an API for setting interrupt type - #3.

I had type in there because I was copying from the existing interrupt node:
interrupts = <0x1 0xe 0x0>;
cell 1 = class critical, normal, sdma
cell 2 = number
cell 3 = level

Cell 3 is probably not needed in the existing definitions.

GPIO wake up interrupts come in on two different hardware interrupts
depending if they are normal or wake up.

		gpio_wkup: gpio-wkup@c00 {
			compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
			reg = <0xc00 0x40>;
			interrupts = <0x1 0x8 0x0 0x0 0x3 0x0>;
			interrupt-parent = <&mpc5200_pic>;
			gpio-controller;
			#gpio-cells = <4>;
		};

There's no existing API in the GPIO system to describe this case. You
have to decide if you want an interrupt to be able to wake the CPU up
from sleep mode. If you want the interrupt to do this, it will trigger
int 3 if the CPU is asleep, otherwise it triggers int 8. Should these
pins have two virqs? or should these two vectors be hidden from the
user of the interrupt?

-- 
Jon Smirl
jonsmirl@gmail.com
