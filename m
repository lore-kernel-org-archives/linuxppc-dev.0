Return-Path: <robh@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 8DFA91A02A5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 09:05:50 +1100 (AEDT)
Received: from mail.kernel.org (localhost [127.0.0.1])
 by mail.kernel.org (Postfix) with ESMTP id C49EF20534
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 22:05:48 +0000 (UTC)
Received: from mail-yk0-f172.google.com (mail-yk0-f172.google.com
 [209.85.160.172])
 (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 2EDEC20524
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 22:05:47 +0000 (UTC)
Received: by ykfs79 with SMTP id s79so32224489ykf.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 14:05:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1447726048.2262.385.camel@freescale.com>
References: <1445841852-6830-1-git-send-email-dongsheng.wang@freescale.com>
 <20151116172611.GA27814@rob-hp-laptop>
 <1447726048.2262.385.camel@freescale.com>
From: Rob Herring <robh@kernel.org>
Date: Tue, 17 Nov 2015 16:05:26 -0600
Message-ID: <CAL_JsqLQPj43S=x4j2VenGC+-CSYxwPSMkQxB5HxGz+Uv_G3vA@mail.gmail.com>
Subject: Re: [PATCH v4] Documentation: dt: binding: fsl: add devicetree
 binding for describing RCPM
To: Scott Wood <scottwood@freescale.com>
Cc: Dongsheng Wang <dongsheng.wang@freescale.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 stuart.yoder@freescale.com, shawnguo@kernel.org,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 jason.jin@freescale.com, Chenhui Zhao <chenhui.zhao@freescale.com>,
 Tang Yuantian <Yuantian.Tang@freescale.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 16, 2015 at 8:07 PM, Scott Wood <scottwood@freescale.com> wrote:
> On Mon, 2015-11-16 at 11:26 -0600, Rob Herring wrote:
>> +Sudeep
>>
>> On Mon, Oct 26, 2015 at 02:44:12PM +0800, Dongsheng Wang wrote:
>> > From: Wang Dongsheng <dongsheng.wang@freescale.com>
>> >
>> > RCPM is the Run Control and Power Management module performs all
>> > device-level tasks associated with device run control and power
>> > management.
>> >
>> > Add this for freescale powerpc platform and layerscape platform.
>>
>> [...]
>>
>> > @@ -0,0 +1,64 @@
>> > +* Run Control and Power Management
>> > +-------------------------------------------
>> > +The RCPM performs all device-level tasks associated with device run
>> > control
>> > +and power management.
>> > +
>> > +Required properites:
>> > +  - reg : Offset and length of the register set of the RCPM block.
>> > +  - fsl,#rcpm-wakeup-cells : The number of IPPDEXPCR register cells in
>> > the
>> > +   fsl,rcpm-wakeup property.
>>
>> [...]
>>
>> > +* Freescale RCPM Wakeup Source Device Tree Bindings
>> > +-------------------------------------------
>> > +Required fsl,rcpm-wakeup property should be added to a device node if the
>> > device
>> > +can be used as a wakeup source.
>> > +
>> > +  - fsl,rcpm-wakeup: Consists of a pointer to the rcpm node and the
>> > IPPDEXPCR
>> > +   register cells. The number of IPPDEXPCR register cells is defined
>> > in
>> > +   "fsl,#rcpm-wakeup-cells" in the rcpm node. The first register
>> > cell is
>> > +   the bit mask that should be set in IPPDEXPCR0, and the second
>> > register
>> > +   cell is for IPPDEXPCR1, and so on.
>>
>> We just merged a common wakeup source binding[1]. It doesn't really work
>> in a similar way to what you have done, but I'd like to see something
>> common here. How exactly wakeup is done tends to depend on whether
>> interrupts are also wakeup signals or wake-up signally is completely
>> separate from interrupts. Depending on that, I think there are 2 options
>> here:
>>
>> - Use the common binding and implement a stacked irqdomain for the
>> wakeup controller.
>
> I'm not sure what a stacked irqdomain is, but the mechanism described here
> isn't about interrupts at all.  It's about controlling whether certain devices
> are kept awake in order to have the possibility of generating a wakeup.  I
> believe the actual wakeup comes via the ordinary device interrupt.

Stacked irqdomains were recently added. They allow you to have
multiple layers of control of interrupt lines. What you typically see
is device interrupts will go to both the main interrupt controller and
a special wake-up controller. So both devices need to be controlled.
The main controller can be powered down in suspend, but the wake-up
controller remains powered and can bring the cpu and interrupt
controller back up.

Keeping a device awake (clocks and power on) is somewhat different
than wake-up mechanisms and we generally have the subsystems needed
for that. Directly exposing another block's registers to a client
driver is generally not the right way to do things. Although there is
syscon for all the misc signals the h/w designers just clumped
together.

>> - Extend the common binding to allow a phandle+args value to point to
>> the wakeup controller.
>
> Possibly, but the description in the common binding would have to be fairly
> vague to make the semantics fit.
>
> The current common binding is also a bit confusing by saying that the presence
> of the property means that all of the device's interrupts can be used as
> wakeup events, but then saying that there can also be a dedicated wakeup but
> not making it clear how to represent that...  Overloading it with device power
> control might muddy things even further.

I believe it just means any device interrupt can be used or only the
irq named "wakeup" can be used.

Rob
