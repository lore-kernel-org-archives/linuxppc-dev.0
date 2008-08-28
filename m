Return-Path: <kevdig@hypersurf.com>
Received: from smtpauth.hypersurf.com (smtpauth.hypersurf.com [209.237.0.8])
	by ozlabs.org (Postfix) with ESMTP id 81117DE060
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 02:36:10 +1000 (EST)
Message-ID: <48B6D382.6010204@hypersurf.com>
Date: Thu, 28 Aug 2008 09:34:11 -0700
From: Kevin Diggs <kevdig@hypersurf.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 2/4] Add cpufreq driver for the IBM PowerPC 750GX
References: <48B28F23.1000906@hypersurf.com> <200808271334.16712.arnd@arndb.de>
	<48B5C0AD.9040006@hypersurf.com> <200808280946.10077.arnd@arndb.de>
In-Reply-To: <200808280946.10077.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Wednesday 27 August 2008, Kevin Diggs wrote:
> 
>>Arnd Bergmann wrote:
>>
>>>I think the module_exit() function should leave the frequency in a
>>>well-defined state, so the easiest way to get there is probably
>>>to delete the timer, and then manually set the frequency.
>>>
>>
>>I really don't follow you here? If I let the timer fire then the cpu
>>(and the cpufreq sub-system) will be left in a well-defined state. I
>>don't understand why you want me to delete the timer and then
>>basically do manually what it was going to do anyway. There are two
>>calls to cpufreq_notify_transition(). One just before the modify_PLL()
>>call, with CPUFREQ_PRECHANGE as an argument, and one in the
>>pll_switch_cb() routine, with CPUFREQ_POSTCHANGE as an argument. I
>>would need to make sure that these are matched up.
>>
>>Even without the HRTimer stuff being used the timer fires in less than
>>4 ms (@ 250 HZ). So I can't see the user actually trying to interrupt
>>a frequency change. With HRTimers it is 100 us.
>>
>>Can we please, please leave this part as is?
> 
> 
> I'm still not convinced that it's actually correct if you call complete()
> from the other places as well. You have three locations in your code where
> you call complete() but only one for INIT_COMPLETION. The part that I don't
> understand (and therefore don't expect other readers to understand) is how
> the driver guarantees that only one complete() will be called on the
> completion variable after it has been initialized.
> 
> What I meant with the well-defined state is that after unloading the module,
> the CPU frequency should be the same as before loading the module, typically
> the maximum frequency, but not the one that was set last.
> 
As you point out, there are three calls to complete().

The first is in the switch callback, in the idle_pll_off disabled branch.
This callback is triggered from the pll switch routine in pll_if. So that
means the call to _modify_PLL() in _target worked. So the complete() call
in _target will NOT be called. The complete() call in the lock callback
is only called in the idle_pll_off enabled branch.

As just mentioned, the second complete() call in the lock callback is
only called when idle_pll_off is enabled.

The final complete() call is in the unlock exit path in _target(). This
is an error path, where for one reason or another, there was no successful
call to _modify_PLL(). Thus there will be triggering of either callback.

There is another initialization of the completion:  the DECLARE_COMPLETION().
I think I will deadlock if I get unloaded before _target() is ever called.
This can happen. I may add a test_bit(...changing_pll_bit) condition on the
wait_for_completion() call.
> 
> 	Arnd <><
> 
Thanks for taking the time to review and for the comments!

kevin
