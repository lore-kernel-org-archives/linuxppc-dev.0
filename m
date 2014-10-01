Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B67231A06C9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Oct 2014 07:25:40 +1000 (EST)
Message-ID: <542C714C.4020009@suse.de>
Date: Wed, 01 Oct 2014 23:25:32 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 00/20] powerpc: Convert power off logic to pm_power_off
References: <1412170086-57971-1-git-send-email-agraf@suse.de>
 <CAMuHMdWEN+q+s6ENoqqD8d0hy=hcZSiWzW3poJFBs8uEBGVuGg@mail.gmail.com>
 <542C13FB.80608@suse.de> <20141001155434.GA11039@roeck-us.net>
In-Reply-To: <20141001155434.GA11039@roeck-us.net>
Content-Type: text/plain; charset=windows-1252
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
 Alistair Popple <alistair@popple.id.au>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Scott Wood <scottwood@freescale.com>, Anatolij Gustschin <agust@denx.de>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 01.10.14 17:54, Guenter Roeck wrote:
> On Wed, Oct 01, 2014 at 04:47:23PM +0200, Alexander Graf wrote:
>>
>>
>> On 01.10.14 16:33, Geert Uytterhoeven wrote:
>>> Hi Alex,
>>>
>>> On Wed, Oct 1, 2014 at 3:27 PM, Alexander Graf <agraf@suse.de> wrote:
>>>> The generic Linux framework to power off the machine is a function pointer
>>>> called pm_power_off. The trick about this pointer is that device drivers can
>>>> potentially implement it rather than board files.
>>>>
>>>> Today on PowerPC we set pm_power_off to invoke our generic full machine power
>>>> off logic which then calls ppc_md.power_off to invoke machine specific power
>>>> off.
>>>>
>>>> However, when we want to add a power off GPIO via the "gpio-poweroff" driver,
>>>> this card house falls apart. That driver only registers itself if pm_power_off
>>>> is NULL to ensure it doesn't override board specific logic. However, since we
>>>> always set pm_power_off to the generic power off logic (which will just not
>>>> power off the machine if no ppc_md.power_off call is implemented), we can't
>>>> implement power off via the generic GPIO power off driver.
>>>>
>>>> To fix this up, let's get rid of the ppc_md.power_off logic and just always use
>>>> pm_power_off as was intended. Then individual drivers such as the GPIO power off
>>>> driver can implement power off logic via that function pointer.
>>>>
>>>> With this patch set applied and a few patches on top of QEMU that implement a
>>>> power off GPIO on the virt e500 machine, I can successfully turn off my virtual
>>>> machine after halt.
>>>
>>> This is touching the same area as last night's
>>> "[RFC PATCH 00/16] kernel: Add support for poweroff handler call chain"
>>> https://lkml.org/lkml/2014/9/30/575
>>
>> I agree, and I think your patch set is walking into a reasonable
>> direction. However, I really think it should convert all users of
>> pm_power_off - at which point you'll probably get to the same conclusion
>> that ppc_md.power_off is a bad idea :).
>>
> Yes, that would be the ultimate goal.
> 
>> So in a way, this patch set is semantically a prerequisite to the full
>> conversion you'd probably like to do :).
>>
>> Also, in your cover letter you describe that some methods power off the
>> CPU power while others power off the system power. How do you
>> distinguish between them with a call chain? You probably won't get
>> around to trigger the system power off callback after the CPU power off
>> callback ran ;).
>>
> Those are examples. Don't get hung up on it. I may actually replace the
> CPU example with something better in the next version; it is not really
> a good example and may get people stuck on "why on earth would anyone want
> or need a means to turn off the CPU power" instead of focusing on the problem
> the patch set tries to solve.
> 
> The basic problem is that there can be different poweroff handlers,
> some of which may not be available on some systems, and some may not
> be as desirable as others for various reasons. The code registering
> those poweroff handlers does not specify the poweroff method, but its 
> priority. It would be up to the programmer (hopefully together with
> the board designer) to determine which method should have higher priority.
> Taking the above example, the callback to turn off CPU power would presumably
> be one of last resort, and have a very low priority.
> 
> A better example may actually be patch 15/16 of the series. The affected
> driver (drivers/power/reset/restart-poweroff.c) does not really power off
> the system, but restarts it instead. Obviously that would only be a poweroff
> handler of last resort, which should only be executed if no other means
> to power off the system is available.

Sounds like a good plan :). You probably want to have some global list
of priority numbers like "try this first" or "this is a non-optimal, but
working method" and "only ever do this as last resort".

Maybe you could as a first step convert every user of pm_power_off to
this new framework with a global notifier_block, similar to how
pm_power_off is a global today? Then we can at least get rid of
pm_power_off altogether and move to only notifiers, whereas new
notifiers can come before or after the old machine set implementations.

As a nice bonus this automatically converts every user of pm_power_off()
to instead call the notifier chain.


Alex
