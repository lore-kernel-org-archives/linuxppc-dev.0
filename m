Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910809161132j3b0ff194hd60fcdf489fb19e4@mail.gmail.com>
Date: Tue, 16 Sep 2008 14:32:45 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: demuxing irqs
In-Reply-To: <20080916174935.GA13142@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910809131623pe990495l96b31bd546d9fa6b@mail.gmail.com>
	<9e4733910809141625u3cd94e7jf05584031be7c1d9@mail.gmail.com>
	<9e4733910809142006x350e96abs6af304d8807ccd67@mail.gmail.com>
	<20080916121740.GA9970@oksana.dev.rtsoft.ru>
	<9e4733910809160537s67812bf5x3d4d46a384f8237f@mail.gmail.com>
	<20080916131203.GA21641@oksana.dev.rtsoft.ru>
	<9e4733910809160636heaa545eld0da835b2d163811@mail.gmail.com>
	<20080916141422.GA29888@oksana.dev.rtsoft.ru>
	<9e4733910809160724x693c5af9y8df2f609e79f5005@mail.gmail.com>
	<20080916174935.GA13142@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Roland Dreier <rdreier@cisco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Sep 16, 2008 at 1:49 PM, Scott Wood <scottwood@freescale.com> wrote:
> On Tue, Sep 16, 2008 at 10:24:35AM -0400, Jon Smirl wrote:
>> On Tue, Sep 16, 2008 at 10:14 AM, Anton Vorontsov
>> <avorontsov@ru.mvista.com> wrote:
>> > Assume that GPIO 8 does not translate to any IRQ, but IRQ 8 is still
>> > valid virq b/c it is mapped for another IRQ controller (particularly
>> > lots of kernel code assumes that IRQ 8 is 8259 PIC's CMOS interrupt,
>> > the PIC and IRQ8 is widely used on PowerPC).
>>
>> Set the base in the GPIO struct such that this won't happen.  You can
>> set the base greater than MAX_IRQ.
>
> And then you'll conflict with some other subsystem that decides to engage
> in the same shenanigans.

That comment was target at GPIO's that don't support interrupts. Give
those GPIO numbers greater than MAX_IRQ in case someone tries to use
them with the IRQ subsystem. Then they'll get errors.

> Just allocate a chunk of virq space like any other cascaded IRQ
> controller.

That is what I did.

>
> -Scott
>



-- 
Jon Smirl
jonsmirl@gmail.com
