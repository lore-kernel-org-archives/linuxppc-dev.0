Return-Path: <pku.leo@gmail.com>
Received: from mail-ob0-f179.google.com (mail-ob0-f179.google.com
 [209.85.214.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 93114B6FA3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jun 2012 14:06:27 +1000 (EST)
Received: by obbup19 with SMTP id up19so9929708obb.38
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jun 2012 21:06:23 -0700 (PDT)
MIME-Version: 1.0
Sender: pku.leo@gmail.com
In-Reply-To: <4FCE4A5A.3020603@freescale.com>
References: <1336737235-15370-1-git-send-email-chenhui.zhao@freescale.com>
 <1336737235-15370-4-git-send-email-chenhui.zhao@freescale.com>
 <4FC93D74.3090200@freescale.com>
 <20120604113609.GC20676@localhost.localdomain>
 <4FCD3E8B.30805@freescale.com>
 <94F013E7935FF44C83EBE7784D62AD3F09335D27@039-SN2MPN1-022.039d.mgd.msft.net>
 <4FCE2FB8.9080307@freescale.com>
 <94F013E7935FF44C83EBE7784D62AD3F093360C1@039-SN2MPN1-022.039d.mgd.msft.net>
 <4FCE4A5A.3020603@freescale.com>
Date: Wed, 6 Jun 2012 12:06:22 +0800
Message-ID: <CADRPPNSzTNPkNExBnNu1iD2hqyRG=Cw+y+PnjTRWxjP_ib1Kww@mail.gmail.com>
Subject: Re: [PATCH v5 4/5] fsl_pmc: Add API to enable device as wakeup event
 source
From: Li Yang <leoli@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Li Yang-R58472 <r58472@freescale.com>,
 Zhao Chenhui-B35336 <B35336@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 6, 2012 at 2:05 AM, Scott Wood <scottwood@freescale.com> wrote:
> On 06/05/2012 11:49 AM, Li Yang-R58472 wrote:
>>
>>

>>>>> On 06/04/2012 06:36 AM, Zhao Chenhui wrote:
>>>>>> On Fri, Jun 01, 2012 at 05:08:52PM -0500, Scott Wood wrote:
>>>>>>> On 05/11/2012 06:53 AM, Zhao Chenhui wrote:
>>>>>>>> +int mpc85xx_pmc_set_wake(struct platform_device *pdev, bool
>>>>>>>> +enable)
>>>>>>>
>>>>>>> Why does it have to be a platform_device? =C2=A0Would a bare device=
_node
>>>>> work
>>>>>>> here? =C2=A0If it's for stuff like device_may_wakeup() that could b=
e in
>>>>>>> a platform_device wrapper function.
>>>>>>
>>>>>> It does not have to be a platform_device. I think it can be a struct
>>>>> device.
>>>>>
>>>>> Why does it even need that? =C2=A0The low level mechanism for influen=
cing
>>>>> PMCDR should only need a device node, not a Linux device struct.
>>>>
>>>> It does no harm to pass the device structure and makes more sense for
>>> object oriented interface design.
>>>
>>> It does do harm if you don't have a device structure to pass, if for so=
me
>>> reason you found the device by directly looking for it rather than goin=
g
>>> through the device model.
>>
>> Whether or not a device is a wakeup source not only depends on the
>> SoC specification but also the configuration and current state for
>> the device. =C2=A0I only expect the device driver to have this knowledge
>> and call this function rather than some standalone platform code.
>> Therefore I don't think your concern matters.
>
> First, I think it's bad API to force the passing of a higher level
> object when a lower level object would suffice (and there are no
> legitimate future-proofing or abstraction reasons for hiding the lower
> level object).
>
> But regardless, the entity you call a "device driver" may or may not use
> the standard driver model (e.g. look at PCI root complexes), and your
> assumption about what platform code knows may or may not be correct. =C2=
=A0I
> could just as well say that only platform code knows about the SoC
> clock/power routing during a given low power state.

Good point.  We need to fix such non-standard drivers.  The new PM
framework depends a lot on the standard Linux Driver Model.  We need
to change our drivers to make them work better with PM.  Also we have
already submitted a patch series to change the PCI root complex driver
in that regard.

>
>>>>>>> Who is setting can_wakeup for these devices?
>>>>>>
>>>>>> The device driver is responsible to set can_wakeup.
>>>>>
>>>>> How would the device driver know how to set it? =C2=A0Wouldn't this d=
epend
>>>>> on the particular SoC and low power mode?
>>>>
>>>> It is based on the "fsl,magic-packet" and "fsl,wake-on-filer" device
>>> tree properties.
>>>
>>> fsl,magic-packet was a mistake. =C2=A0It is equivalent to checking the
>>> compatible for etsec. =C2=A0It does not convey any information about wh=
ether
>>
>> It can be described either by explicit feature property or by the
>> compatible. =C2=A0I don't think it is a problem that we choose one again=
st
>> another.
>
> I do think it's a problem, because it's unnecessarily complicated, and
> more error prone (we probably didn't have fsl,magic-packet on all the
> SoCs that support it before the .dtsi refactoring). =C2=A0But my point wa=
s
> that it says nothing about whether the eTSEC will still be functioning
> during a low power state.
>
>>> the eTSEC is still active in a given low power mode.
>>
>> Whether or not the eTSEC is still active in both sleep and deep sleep
>> is only depending on if we set it to be a wakeup source.
>
> Only because we happen to support eTSEC as a wakeup source on all SoCs.
>
>> If it behaves differently for low power modes in the future, we could
>> address that by adding additional property.
>>
>>>
>>> How is fsl,wake-os-filer relevant to this decision? =C2=A0When will it =
be set
>>> but not fsl,magic-packet?
>>
>> I mean either fsl,magic-packet or fsl,wake-on-filer shows it can be a
>> wakeup source. =C2=A0Currently we don't have an SoC to have wake-on-file=
r
>> while not wake-on-magic. =C2=A0But I think it's better to consider both =
as
>> they are independent features.
>
> You're not willing to consider an SoC where waking on eTSEC is
> unsupported, but you're willing to consider an eTSEC that has
> wake-on-filer but magic packet support has for some reason been dropped?

Good findings.  :)  I think it's fine to keep the extra that have
already been done as long as it does no harm.  But we should stop
adding more extras that are not necessary for now.

>
>>> What about devices other than ethernet? =C2=A0What about differences be=
tween
>>> ordinary sleep and deep sleep?
>>
>> There is no difference for sleep and deep sleep for all wakeup sources c=
urrently.
>
> I recall being able to wake an mpc85xx chip (maybe mpc8544?) from
> ordinary sleep using the DUART (even though the manual suggests that
> only external interrupts can be used -- not even eTSEC). =C2=A0You can't =
do
> that in deep sleep.

I doubt that as the blocks are clock gated in sleep.  We only have
MPC8536 and P1022 in the e500 family to support deep sleep now.  I
agree with you the sleep and deep sleep can imply different wakeup
source in the future.  But can we worry about it later?

>
> You ignored "what about devices other than ethernet".

No, I haven't.  Other devices are so at least for now.

- Leo
