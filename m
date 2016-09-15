Return-Path: <afleming@gmail.com>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sZWBP13ZszDsWc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 18:03:24 +1000 (AEST)
Received: by mail-wm0-x241.google.com with SMTP id b184so5892012wma.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Sep 2016 01:03:24 -0700 (PDT)
Content-Type: text/plain;
	charset=us-ascii
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH 2/3] corenet: Support gpio power/reset for corenet
From: Andy Fleming <afleming@gmail.com>
In-Reply-To: <DB5PR0401MB192850140BF39D4BA322BD6991FF0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
Date: Thu, 15 Sep 2016 09:03:17 +0100
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "aperez@alexperez.com" <aperez@alexperez.com>
Message-Id: <1F518F22-C205-4106-BABF-2917C22E80FB@gmail.com>
References: <1473189119-29458-1-git-send-email-afleming@gmail.com>
 <1473189119-29458-3-git-send-email-afleming@gmail.com>
 <DB5PR0401MB192878019FFA33204D6A3EBD91F90@DB5PR0401MB1928.eurprd04.prod.outlook.com>
 <CAKWjMd4PLus4rDr+SXTPewYRy6E8HBKowyqhiv5rqK+JpayMog@mail.gmail.com>
 <DB5PR0401MB192850140BF39D4BA322BD6991FF0@DB5PR0401MB1928.eurprd04.prod.outlook.com>
To: Scott Wood <scott.wood@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> On Sep 12, 2016, at 23:47, Scott Wood <scott.wood@nxp.com> wrote:
>=20
>> On 09/10/2016 05:05 PM, Andy Fleming wrote:
>>=20
>>=20
>> On Tuesday, September 6, 2016, Scott Wood <scott.wood@nxp.com
>> <mailto:scott.wood@nxp.com>> wrote:
>>=20
>>>    On 09/06/2016 02:12 PM, Andy Fleming wrote:
>>> Boards can implement power and reset functionality over gpio using
>>> these drivers:
>>>  drivers/power/reset/gpio-poweroff.c
>>>  drivers/power/reset/gpio-restart.c
>>>=20
>>> While not all corenet boards use gpio for power/reset, this
>>> support can be added without interfering with boards that do not
>>> use this functionality.
>>>=20
>>> If a board's device tree has the related nodes, they are now probed.
>>> Also, gpio-poweroff uses the global pm_power_off callback to implement
>>> the shutdown. However, pm_power_off was not invoked when the kernel
>>> halted, although that is usually the desired behavior. If the board
>>> provides gpio power and reset support, it is reasonable to assume that
>>> halting should also power down the system, unless it has chosen to
>>> pass those calls on to hypervisor.
>>=20
>>    Halt and poweroff are not the same thing.  If userspace requests a
>>    poweroff, then kernel_power_off() will call machine_power_off() which
>>    will call pm_power_off().
>>=20
>>    Why do we need anything corenet-specific here?
>>=20
>>=20
>>=20
>>    We don't, but then the board will halt instead of power off when you
>>    type shutdown -h now.
>=20
> Isn't that what it's supposed to do?  If you want poweroff then ask for
> poweroff.
>=20
>>    Or if you type poweroff without a high enough
>>    run level, apparently.
>=20
> Hmm?
>=20
> In any case, run levels have nothing to do with the kernel.  The kernel
> implements LINUX_REBOOT_CMD_HALT and LINUX_REBOOT_CMD_POWER_OFF, and
> they should do what they're advertised to do.
>=20
>>    I'm amenable to removing the halt code, but
>>    there are concerns that this will cause the systems to behave
>>    unintentionally as intended, in that most systems that users
>>    interact with shut down when you call shutdown -h now. There may be
>>    scripts that depend on that behavior (or at least assume it).
>=20
> When did the behavior you're seeking ever exist?

Well, for one, on that Servergy board. I agree that halt and power off mean a=
nd have always meant different things to the kernel. The problem is that mos=
t desktop systems, having halted, pass control to the BIOS which--usually--s=
huts off the power. Am I wrong about this? I've been using shutdown -h now t=
o turn off my Linux systems for nearly 2 decades now, but I admit that I don=
't do it often, and I tend to stick with whatever works.


>=20
>>    I don't see any other platforms doing this.  How do the nodes get prob=
ed
>>    for them?
>>=20
>>=20
>>    The answer is I don't know, but this is a common issue with adding
>>    new devices to the device tree in embedded powerpc. The only other
>>    platforms which have gpio-poweroff nodes in their trees are in
>>    arch/arm, and none of those platforms call the probing
>>    function of_platform_bus_probe. I suspect they either probe every
>>    root node, or they somehow construct the match_id. As noted in the
>>    above-referenced commit, putting the nodes under the gpio bus does
>>    not cause them to get probed. This seemed like the best way under
>>    the current corenet code.
>=20
> Well, let's figure out what it is that PPC should be doing to have
> things work the way it does on ARM.

For all of the devices? Or just these two?

Andy
