Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F24611A0793
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 22:35:13 +1100 (EST)
Message-ID: <5433CFEB.9040104@suse.de>
Date: Tue, 07 Oct 2014 13:35:07 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 00/20] powerpc: Convert power off logic to pm_power_off
References: <1412170086-57971-1-git-send-email-agraf@suse.de>	
 <1412311350.2783.4.camel@concordia> <54326850.1030801@suse.de>
 <1412663147.10747.1.camel@concordia>
In-Reply-To: <1412663147.10747.1.camel@concordia>
Content-Type: text/plain; charset=utf-8
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
 Alistair Popple <alistair@popple.id.au>, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 Guenter Roeck <linux@roeck-us.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 07.10.14 08:25, Michael Ellerman wrote:
> On Mon, 2014-10-06 at 12:00 +0200, Alexander Graf wrote:
>>
>> On 03.10.14 06:42, Michael Ellerman wrote:
>>> On Wed, 2014-10-01 at 15:27 +0200, Alexander Graf wrote:
>>>> The generic Linux framework to power off the machine is a function pointer
>>>> called pm_power_off. The trick about this pointer is that device drivers can
>>>> potentially implement it rather than board files.
>>>>
>>>> Today on PowerPC we set pm_power_off to invoke our generic full machine power
>>>> off logic which then calls ppc_md.power_off to invoke machine specific power
>>>> off.
>>>>
>>>> To fix this up, let's get rid of the ppc_md.power_off logic and just always use
>>>> pm_power_off as was intended. Then individual drivers such as the GPIO power off
>>>> driver can implement power off logic via that function pointer.
>>>
>>> This looks OK to me with one caveat.
>>>
>>> In several of the patches you're replacing a static initialisation with a
>>> runtime one, and you're doing the runtime initialisation in xxx_setup_arch().
>>> That's reasonably late, so I'd prefer you did it in xxx_probe().
>>
>> Heh, I had it in xxx_probe() originally and then realized that
>>
>>   a) the power off function is basically a driver. Driver initialization
>> happens in xxx_setup_arch() and
>>
>>   b) the maple target already does overwrite its power_off callback in
>> xxx_setup_arch and
>>
>>   c) on all targets xxx_probe() is very slim and doesn't do much
>>
>> but I'll happily change it back to put the bits in xxx_probe() instead.
> 
> Thanks.
> 
> That way you shouldn't be changing behaviour.
> 
> It may still be the case that some power off routines don't actually work until
> later, but that's an existing problem. Some power off routines *do* work before
> setup_arch(), so they will continue to work.

Ok, works for me :). Just wanted to make sure you're aware of the
reasoning why I didn't do it in probe().

> Also, how does your series interact with Guenter's that removes pm_power_off ?
> It seems at the moment they are unaware of each other.

Guenters patches convert users of pm_power_off to his new scheme. We're
not even at that stage at all yet in the powerpc tree. Converting
everything to pm_power_off is basically a first step. His patch set
maintains pm_power_off, so there shouldn't be nasty conflicts.

Once we converted from ppc_md tables to actual code, we can just run a
simple coccinelle patch to convert from pm_power_off to his new scheme
later.


Alex
