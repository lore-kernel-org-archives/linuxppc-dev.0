Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809101039l39eed2cdl43b2004bee334687@mail.gmail.com>
Date: Wed, 10 Sep 2008 13:39:34 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Wolfgang Grandegger" <wg@grandegger.com>
Subject: Re: interrupt cells on mpc5200
In-Reply-To: <48C7FBCD.10803@grandegger.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910809100940g400bab3ck6f68ee24ae8d4573@mail.gmail.com>
	<48C7FBCD.10803@grandegger.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 10, 2008 at 12:54 PM, Wolfgang Grandegger <wg@grandegger.com> wrote:
> Jon Smirl wrote:
>> mpc5200 interrupts have three cells in the device tree. How are these
>> interpreted?
>> Middle one is the interrupt number. Last one seems to always be zero.
>> What does the first one do, edge/level?
>>
>> I searched through /Documentation and could find anything about three
>> cells for interrupts.
>>
>> I understand the first one for gpio_wkup on interrupt 8. How does a
>> gpio_wkup generate an interrupt on interrupt 3?
>>
>>               gpio_wkup: gpio-wkup@c00 {
>>                       compatible = "fsl,mpc5200b-gpio-wkup","fsl,mpc5200-gpio-wkup";
>>                       reg = <0xc00 0x40>;
>>                       interrupts = <0x1 0x8 0x0 0x0 0x3 0x0>;
>>                       interrupt-parent = <&mpc5200_pic>;
>>                       gpio-controller;
>>                       #gpio-cells = <2>;
>>               };
>
> See
> http://lxr.linux.no/linux+v2.6.26.5/Documentation/powerpc/mpc52xx-device-tree-bindings.txt#L263

Why was I too blind to see that file? So there must be someway to turn
a gpio_wkup into a critical interrupt which causes the interrupt 3
which is a feature I don't need.

Any hints on a good way to measure the length of pulses? They are
between 500us and 2ms long. I was thinking of using an interrupt on
the leading edge, starting a timer, and then flipping the gpio to
cause an interrupt on the trailing edge. I don't need extreme
accuracy.

-- 
Jon Smirl
jonsmirl@gmail.com
