Return-Path: <linux@roeck-us.net>
Received: from bh-25.webhostbox.net (bh-25.webhostbox.net [208.91.199.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C33911A070E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 13:03:00 +1000 (EST)
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
 (envelope-from <linux@roeck-us.net>) id 1XZWfT-003O5y-2H
 for linuxppc-dev@lists.ozlabs.org; Thu, 02 Oct 2014 03:02:59 +0000
Message-ID: <542CBDB7.9010808@roeck-us.net>
Date: Wed, 01 Oct 2014 19:51:35 -0700
From: Guenter Roeck <linux@roeck-us.net>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 00/20] powerpc: Convert power off logic to pm_power_off
References: <1412170086-57971-1-git-send-email-agraf@suse.de>	
 <1412203153.13320.352.camel@snotra.buserror.net> <542C8C69.2010509@suse.de>
 <1412206127.13320.362.camel@snotra.buserror.net> <542C91D5.3030305@suse.de>
In-Reply-To: <542C91D5.3030305@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
 Alistair Popple <alistair@popple.id.au>, Anatolij Gustschin <agust@denx.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/01/2014 04:44 PM, Alexander Graf wrote:
>
>
> On 02.10.14 01:28, Scott Wood wrote:
>> On Thu, 2014-10-02 at 01:21 +0200, Alexander Graf wrote:
>>>
>>> On 02.10.14 00:39, Scott Wood wrote:
>>>> On Wed, 2014-10-01 at 15:27 +0200, Alexander Graf wrote:
>>>>> The generic Linux framework to power off the machine is a function pointer
>>>>> called pm_power_off. The trick about this pointer is that device drivers can
>>>>> potentially implement it rather than board files.
>>>>>
>>>>> Today on PowerPC we set pm_power_off to invoke our generic full machine power
>>>>> off logic which then calls ppc_md.power_off to invoke machine specific power
>>>>> off.
>>>>>
>>>>> However, when we want to add a power off GPIO via the "gpio-poweroff" driver,
>>>>> this card house falls apart. That driver only registers itself if pm_power_off
>>>>> is NULL to ensure it doesn't override board specific logic. However, since we
>>>>> always set pm_power_off to the generic power off logic (which will just not
>>>>> power off the machine if no ppc_md.power_off call is implemented), we can't
>>>>> implement power off via the generic GPIO power off driver.
>>>>>
>>>>> To fix this up, let's get rid of the ppc_md.power_off logic and just always use
>>>>> pm_power_off as was intended. Then individual drivers such as the GPIO power off
>>>>> driver can implement power off logic via that function pointer.
>>>>>
>>>>> With this patch set applied and a few patches on top of QEMU that implement a
>>>>> power off GPIO on the virt e500 machine, I can successfully turn off my virtual
>>>>> machine after halt.
>>>>
>>>> Are there any plans to handle restart similarly?
>>>
Guess I am missing some context here. Support for a restart handler call chain
will be added in 3.18. Currently its primary goal is to replace arm_pm_restart,
but it would be a one-liner to add support for it to powerpc (see below).

>>> I don't see an immediate need for it, as we do have access to reset via
>>> the guts device.
>>
>> The guts device is problematic from a hardware description perspective,
>> as we advertise a bunch of things to the guest that we don't implement.
>> E.g. the only reason we don't currently have a problem with Linux trying
>> to use guts to sync the timebase across cores is that by chance we
>> happen to expose a guts that corresponds to a single-cpu SoC.
>
> True, and it is slightly ugly to expose a specific SoC's guts in our
> generic pv machine type.
>
>>
>>> I also don't see any generic driver in Linux that would implement reset
>>> via a gpio controller device, so apparently it's not incredibly common
>>> to implement reset via gpio.
>>
Again, I may be missing something. How about drivers/power/reset/gpio-restart.c ?
It would be really simple make it work with powerpc; all you would have to do
is to add a call to do_kernel_restart() to the powerpc machine_restart() function.

>> There wasn't a generic gpio-power-off driver either until a couple years
>> ago...  Regardless of whether it's done via gpio, using ppc_md for it is
>> bad for the same reasons as for power-off.
>
> I agree. Today, only ARM has a comparable mechanism for drivers to hook
> a reset handler into the machine specific reset path.
>
Not anymore ...

> I'd say let's wait for Guenter to finish the power off rework and then
> tackle a generic reset call chain based approach next.
>
Please have a look into the restart handler; the code is in linux-next.
That should probably solve your restart related problems.
A branch on top of v3.17-rc2 is at
https://git.kernel.org/cgit/linux/kernel/git/groeck/linux-staging.git/log/?h=restart-handler

Thanks,
Guenter
