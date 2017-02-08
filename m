Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vJ5Wv6mf6zDqBQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Feb 2017 13:59:07 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC] powerpc/pseries: Increase busy loop in pseries_cpu_die
In-Reply-To: <11711559.cvjM6Evb1C@morokweng>
References: <1486407496-12151-1-git-send-email-bauerman@linux.vnet.ibm.com>
 <20170207025645.GB22303@localhost.localdomain>
 <11711559.cvjM6Evb1C@morokweng>
Date: Wed, 08 Feb 2017 13:59:07 +1100
Message-ID: <87mvdx9ymc.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Am Dienstag, 7. Februar 2017, 08:26:45 BRST schrieb Balbir Singh:
>> On Mon, Feb 06, 2017 at 04:58:16PM -0200, Thiago Jung Bauermann wrote:
>> > [  447.714064] Querying DEAD? cpu 134 (134) shows 2
>> > cpu 0x86: Vector: 300 (Data Access) at [c000000007b0fd40]
>> > 
>> >     pc: 000000001ec3072c
>> >     lr: 000000001ec2fee0
>> >     sp: 1faf6bd0
>> >    
>> >    msr: 8000000102801000
>> >    dar: 212d6c1a2a20c
>> 
>> This looks like we accessed a bad address, but why?
>
> Am Dienstag, 7. Februar 2017, 13:10:22 BRST schrieb Michael Ellerman:
>> We shouldn't be crashing.
>> 
>> So we need to fix that.
>> 
>> We may also need to increase the timeout, though it's pretty gross TBH.
>> 
>> But step one is make sure we don't crash.
>
> I didn't analyze exactly what is causing the CPU to crash because the root 
> cause is the inconsistency between what the kernel thinks the CPU state is and 
> reality. But if we have to be able to handle that inconsistency I will keep 
> digging and try to fix that.

Please do.

It's obviously not a good situation, but it shouldn't crash the kernel.

I realise that may be easier said than done, but that should be the
goal. I see smp_ops->cpu_die() can't fail (returns void), which may be
part of the problem.

>> > --- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> > +++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
>> > @@ -206,7 +206,7 @@ static void pseries_cpu_die(unsigned int cpu)
>> > 
>> >  		}
>> >  	
>> >  	} else if (get_preferred_offline_state(cpu) == CPU_STATE_OFFLINE) {
>> > 
>> > -		for (tries = 0; tries < 25; tries++) {
>> > +		for (tries = 0; tries < 5000; tries++) {
>> 
>> This fixes some of the asymmetry between handling of CPU_STATE_INACTIVE
>> and CPU_STATE_OFFLINE, but I think we can probably move the cpu_relax()
>> to msleep(1).
>
> I didn't change it to msleep() because I thought it would introduce a 
> regression. commit b906cfa397fd ("powerpc/pseries: Fix cpu hotplug") changed a 
> msleep(200) that was there to a cpu_relax() with this explanation:
>
>     Currently, pseries_cpu_die() calls msleep() while polling RTAS for 
>     the status of the dying cpu.
>
>     However, if the cpu that is going down also happens to be the one 
>     doing the tick then we're hosed as the tick_do_timer_cpu 'baton' is
>     only passed later on in tick_shutdown() when _cpu_down() does the 
>     CPU_DEAD notification.  Therefore jiffies won't be updated anymore.
>
>     This replaces that msleep() with a cpu_relax() to make sure we're not 
>     going to schedule at that point.
>
>     With this patch my test box survives a 100k iterations hotplug stress
>     test on _all_ cpus, whereas without it, it quickly dies after ~50 
>     iterations.
>
> I can try to add it back and see what happens. Perhaps that situation won't 
> happen anymore with today's kernel.

The relative timing of the events may have changed. But the fundamental
problem still exists AFAIK.

So we'd need a pretty solid guarantee that the problem can't happy
anymore before I'd change it to msleep().

However it could/should at least use udelay(), which AFAIK is not
reliant on jiffies. That way the loop will actually take a set amount of
wall time, rather than just cycles.

cheers
