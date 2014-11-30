Return-Path: <danielle.costantino@gmail.com>
Received: from mail-ig0-x22c.google.com (mail-ig0-x22c.google.com
 [IPv6:2607:f8b0:4001:c05::22c])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42DAE1A090F
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 30 Nov 2014 15:30:58 +1100 (AEDT)
Received: by mail-ig0-f172.google.com with SMTP id hl2so11471678igb.17
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Nov 2014 20:30:54 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1416966097.15957.171.camel@freescale.com>
References: <1413538026-15739-1-git-send-email-valentin.longchamp@keymile.com>
 <1414537731.23458.120.camel@snotra.buserror.net>
 <5450AC85.40302@keymile.com> <20141113003418.GE2062@katana>
 <5465B285.7070005@keymile.com> <20141114082832.GA2180@katana>
 <1416274083.15957.96.camel@freescale.com>
 <20141125181347.GC9716@katana>
 <1416966097.15957.171.camel@freescale.com>
Date: Sat, 29 Nov 2014 20:30:54 -0800
Message-ID: <CAAVjN7fJyOh64p5UGRmv-UTnF47cERDfbHyHTuzQmQj8xTDEOQ@mail.gmail.com>
Subject: Re: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
From: Danielle Costantino <danielle.costantino@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Valentin Longchamp <valentin.longchamp@keymile.com>,
 Linux device trees <devicetree@vger.kernel.org>,
 Wolfram Sang <wsa@the-dreams.de>, "Boschung,
 Rainer" <Rainer.Boschung@keymile.com>, "Brunck,
 Holger" <Holger.Brunck@keymile.com>, Linux I2C <linux-i2c@vger.kernel.org>,
 Linux PowerPC Kernel <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I saw that this patch was marked as not applicable, but on most qoriq
devices the pre-scaler is 2 especially for p2020/p2010 devices
arch/powerpc/boot/dts/fsl/p2020si-post.dtsi

from the P2020 RM: p. 477
"Frequency divider ratio. Used to prescale the clock for bit rate
selection. The serial bit clock frequency of
SCL is equal to one half the platform ( CCB ) clock divided by the
designated divider ."

This means that the current dts for these devices are providing false
clock settings. I have a p2020 board and can take some scope
measurements next week to prove this. I think something should be
modified to address this.


On Tue, Nov 25, 2014 at 5:41 PM, Scott Wood <scottwood@freescale.com> wrote:
> On Tue, 2014-11-25 at 19:13 +0100, Wolfram Sang wrote:
>> On Mon, Nov 17, 2014 at 07:28:03PM -0600, Scott Wood wrote:
>> > On Fri, 2014-11-14 at 09:28 +0100, Wolfram Sang wrote:
>> > > > >
>> > > > > If we're going to change the device tree I'd rather just add a property
>> > > > > to say what the prescaler is.
>> > > >
>> > > >  We would however, leave the boards' device trees that use things like
>> > > > "fsl,mpc8543-i2c" as is and introduce the prescaler for the others requiring it.
>> > > >
>> > > >
>> > > > Now the drawback is that the driver would require a change, to parse this
>> > > > prescaler new prescaler property. Would this be OK from your point of view
>> > > > Wolfram ? If yes, I will send the patches for it.
>> > >
>> > > I don't think it is OK.
>> >
>> > Why?
>>
>> Because I thought it could be deduced. Then, a seperate property would
>> not be OK.
>>
>> > >  I'd think it can be deduced from the compatible property.
>> >
>> > For almost all existing device trees it cannot be.
>>
>> Pity :( If we do introduce a new property, it should probably be
>> "clock-div". Grepping through binding documentation, that seems
>> accepted. We should ask DT maintainers, too, to be safe.
>>
>> > If you want something that will work without changing device trees,
>> > you'll need to use SVR to identify the SoC.
>>
>> The driver is doing that already, see mpc_i2c_get_sec_cfg_8xxx(). Dunno
>> if it makes sense to add to it for consistency reasons?
>
> That's not SVR, but sure.  Better to avoid messing with existing device
> trees.
>
> -Scott
>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-i2c" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
- Danielle Costantino
