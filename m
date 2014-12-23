Return-Path: <prvs=0434e0312a=valentin.longchamp@keymile.com>
Received: from mail-de.keymile.com (mail-de.keymile.com [195.8.104.250])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7569A1A0C8F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Dec 2014 00:23:15 +1100 (AEDT)
Message-ID: <54996CB5.8030808@keymile.com>
Date: Tue, 23 Dec 2014 14:23:01 +0100
From: Valentin Longchamp <valentin.longchamp@keymile.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, Wolfram Sang <wsa@the-dreams.de>
Subject: Re: [PATCH] i2c-qoriq: modified compatibility for correct prescaler
References: <1413538026-15739-1-git-send-email-valentin.longchamp@keymile.com>	
 <1414537731.23458.120.camel@snotra.buserror.net>	
 <5450AC85.40302@keymile.com> <20141113003418.GE2062@katana>	
 <5465B285.7070005@keymile.com> <20141114082832.GA2180@katana>	
 <1416274083.15957.96.camel@freescale.com> <20141125181347.GC9716@katana>
 <1416966097.15957.171.camel@freescale.com> <54899FB4.9010207@keymile.com>
In-Reply-To: <54899FB4.9010207@keymile.com>
Content-Type: text/plain; charset=utf-8
Cc: Linux device trees <devicetree@vger.kernel.org>,
 danielle.costantino@gmail.com, "Boschung,
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

Wolfgang, Scott,

On 12/11/2014 02:44 PM, Valentin Longchamp wrote:
> Hi all,
> 
> Picking up this issue again.
> 
> On 11/26/2014 02:41 AM, Scott Wood wrote:
>> On Tue, 2014-11-25 at 19:13 +0100, Wolfram Sang wrote:
>>> On Mon, Nov 17, 2014 at 07:28:03PM -0600, Scott Wood wrote:
>>>> On Fri, 2014-11-14 at 09:28 +0100, Wolfram Sang wrote:
>>>>>>>
>>>>>>> If we're going to change the device tree I'd rather just add a property
>>>>>>> to say what the prescaler is.
>>>>>>
>>>>>>  We would however, leave the boards' device trees that use things like
>>>>>> "fsl,mpc8543-i2c" as is and introduce the prescaler for the others requiring it.
>>>>>>
>>>>>>
>>>>>> Now the drawback is that the driver would require a change, to parse this
>>>>>> prescaler new prescaler property. Would this be OK from your point of view
>>>>>> Wolfram ? If yes, I will send the patches for it.
>>>>>
>>>>> I don't think it is OK.
>>>>
>>>> Why?
>>>
>>> Because I thought it could be deduced. Then, a seperate property would
>>> not be OK.
>>>
>>>>>  I'd think it can be deduced from the compatible property.
>>>>
>>>> For almost all existing device trees it cannot be.
>>>
>>> Pity :( If we do introduce a new property, it should probably be
>>> "clock-div". Grepping through binding documentation, that seems
>>> accepted. We should ask DT maintainers, too, to be safe.
>>>
>>>> If you want something that will work without changing device trees,
>>>> you'll need to use SVR to identify the SoC.
>>>
>>> The driver is doing that already, see mpc_i2c_get_sec_cfg_8xxx(). Dunno
>>> if it makes sense to add to it for consistency reasons?
>>
>> That's not SVR, but sure.  Better to avoid messing with existing device
>> trees.
>>
> 
> What is then the agreement here ? Add a clock-div to the device trees ? Or do
> something similar to  mpc_i2c_get_sec_cfg_8xxx() ?
> 
> I think the clock-div property is better according to Freescale's AN 2919
> section 3.1 Source clock. All the source clocks are fixed (with a clock-div of 2
> in case of mpc8536/43/45/47/48/67/68/72, plus p2020) except for the mpc8533/44
> where it can be 2 or 3, and that's what mpc_i2c_get_sec_cfg_8xxx() determines.
> 
> So mpc_i2c_get_sec_cfg_8xxx() should remain the exception and the other
> prescaler values should be derived from an additional clock-div that must be
> added in the respective device trees (at least for the qoriq devices, because
> for instance mpc8543 already has the correct prescaler thanks to
> mpc_i2c_data_8543 from i2c-mpc.c).
> 

Do you have an opinion on the above ?

Valentin
