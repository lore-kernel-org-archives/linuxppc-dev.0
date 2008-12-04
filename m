Return-Path: <miltonm@bga.com>
Received: from mercury.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 67495DDDEC
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Dec 2008 04:11:26 +1100 (EST)
In-Reply-To: <20081203174340.GA6958@localdomain>
References: <20081203174340.GA6958@localdomain>
	<1228278723-1153-1-git-send-email-galak@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0ff42e9c3d9aabbda3102f25bc7bfa2c@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] powerpc: Remove modpost warning with start_secondary
	(Modified by Milton Miller)
Date: Thu, 4 Dec 2008 11:16:22 -0600
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>, Nathan Lynch <ntl@pobox.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[oops forgot to cc the list]

Nathan Lynch wrote at 2008-12-03 17:43:40:
> Kumar Gala wrote:
>> On Dec 2, 2008, at 11:31 PM, Nathan Lynch wrote:
>>> Kumar Gala wrote:
>>>> WARNING: vmlinux.o(.text+0x2aa): Section mismatch in reference from
>>>> the variable __secondary_start to the function
>>>> .devinit.text:start_secondary()
>>>> The function __secondary_start() references
>>>> the function __devinit start_secondary().
>>>>
>>>> start_secondary gets called by __secondary_start which is in asm
>>>> code so its
>>>> not marked as __devinit.  Its easier to just remove the __devinit
>>>> from
>>>> start_secondary than try and deal with __secondary_start.
>>>
>>> Which just gets another mismatch warning here:
>>>
>>> WARNING: arch/powerpc/kernel/built-in.o(.text+0x23cc4): Section
>>> mismatch in reference from the function .start_secondary() to the
>>> function .devinit.text:.smp_store_cpu_info()
>>> The function .start_secondary() references
>>> the function __devinit .smp_store_cpu_info().
>>> This is often because .start_secondary lacks a __devinit
>>> annotation or the annotation of .smp_store_cpu_info is wrong.

And other architectures want this to be cpuinit, the patch is held up 
because of powerpc:

http://ozlabs.org/pipermail/linuxppc-dev/2008-November/064897.html


>>> Isn't there a better way to address this?  It doesn't seem right to
>>> increase the kernel's memory usage to get rid of a modpost warning.

I agree.  And its easy: move the asm code to the right section with the 
nifty macros in linux/init.h.

We can use the whitelist of .text.head and also use use cpuinit.

I had a patch last July that went in this direction, but it was tangled 
with the relocatable kernel patches and badly timed.

http://ozlabs.org/pipermail/linuxppc-dev/2008-July/059717.html

hmm, I don't see 1/3 that cleaned up the function entry macro repition.

I'll try to revive them and bring them up to the current tree.

>>
>> Fair.. what defconfig did you build?
>
> Try ppc64_defconfig with HOTPLUG_CPU=n.

milton
