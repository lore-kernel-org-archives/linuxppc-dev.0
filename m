Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x243.google.com (mail-ua0-x243.google.com
 [IPv6:2607:f8b0:400c:c08::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yyCGQ1mRNzDrbG
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 23:16:29 +1100 (AEDT)
Received: by mail-ua0-x243.google.com with SMTP id p33so3765727uag.9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Dec 2017 04:16:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20171214115137.5603f77d@roar.ozlabs.ibm.com>
References: <20171213080828.2800-1-bsingharora@gmail.com>
 <20171213080828.2800-2-bsingharora@gmail.com>
 <20171213205101.2cc0c830@roar.ozlabs.ibm.com>
 <20171214111213.07ba99a4@gmail.com>
 <20171214115137.5603f77d@roar.ozlabs.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 14 Dec 2017 23:16:26 +1100
Message-ID: <CAKTCnzkF0ntwaXs3STmCT0tNz-LZyyPnSMHh8rTG=oFQw7fL=w@mail.gmail.com>
Subject: Re: [PATCH 2/2] powernv/kdump: Fix cases where the kdump kernel can
 get HMI's
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 14, 2017 at 12:51 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Thu, 14 Dec 2017 11:12:13 +1100
> Balbir Singh <bsingharora@gmail.com> wrote:
>
>> On Wed, 13 Dec 2017 20:51:01 +1000
>> Nicholas Piggin <npiggin@gmail.com> wrote:
>>
>> > This is looking pretty nice now...
>> >
>> > On Wed, 13 Dec 2017 19:08:28 +1100
>> > Balbir Singh <bsingharora@gmail.com> wrote:
>> >
>> > > @@ -543,7 +543,25 @@ void smp_send_debugger_break(void)
>> > >  #ifdef CONFIG_KEXEC_CORE
>> > >  void crash_send_ipi(void (*crash_ipi_callback)(struct pt_regs *))
>> > >  {
>> > > + int cpu;
>> > > +
>> > >   smp_send_nmi_ipi(NMI_IPI_ALL_OTHERS, crash_ipi_callback, 1000000);
>> > > + if (kdump_in_progress() && crash_wake_offline) {
>> > > +         for_each_present_cpu(cpu) {
>> > > +                 if (cpu_online(cpu))
>> > > +                         continue;
>> > > +                 /*
>> > > +                  * crash_ipi_callback will wait for
>> > > +                  * all cpus, including offline CPUs.
>> > > +                  * We don't care about nmi_ipi_function.
>> > > +                  * Offline cpus will jump straight into
>> > > +                  * crash_ipi_callback, we can skip the
>> > > +                  * entire NMI dance and waiting for
>> > > +                  * cpus to clear pending mask, etc.
>> > > +                  */
>> > > +                 do_smp_send_nmi_ipi(cpu);
>> >
>> > Still a little bit concerned about using NMI IPI for this.
>> >
>>
>> OK -- for offline CPUs you mean?
>
> Yes.
>
>> > If you take an NMI IPI from stop, the idle code should do the
>> > right thing and we would just return the system reset wakeup
>> > reason in SRR1 here (which does not need to be cleared).
>> >
>> > If you take the system reset anywhere else in the loop, it's
>> > going to go out via system_reset_exception. I guess that
>> > would end up doing the right thing, it probably gets to
>> > crash_ipi_callback from crash_kexec_secondary?
>>
>> You mean like if we are online at the time of NMI'ing? If so
>> the original loop will NMI us back into crash_ipi_callback
>> anyway. We don't expect this to occur for offline CPUs
>
> No, if the offline CPU is executing any instruction except for
> stop when the crash occurs.
>

OK, yeah

>>
>> >
>> > It's just going to be a very untested code path :( What we
>> > gain I suppose is better ability to handle a CPU that's locked
>> > up somewhere in the cpu offline path. Assuming the uncommon
>> > case works...
>> >
>> > Actually, if you *always* go via the system reset exception
>> > handler, then code paths will be shared. That might be the
>> > way to go. So I would check for system reset wakeup SRR1 reason
>> > and call replay_system_reset() for it. What do you think?
>> >
>>
>> We could do that, but that would call pnv_system_reset_exception
>> and try to call the NMI function, but we've not used that path
>> to initiate the NMI, so it should call the stale nmi_ipi_function
>> which is crash_ipi_callback and not go via the crash_kexec path.
>
> It shouldn't, if the CPU is not set in the NMI bitmask, I think
> it should go back out and do the rest of the system_reset_exception
> handler.
>
> Anyway we have to get this case right, because it can already hit
> as I said if the offline CPU takes the NMI when it is not stopped.
> This is why I want to try to use a unified code path.
>

OK

>> I can't call smp_send_nmi_ipi due to the nmi_ipi_busy_count and
>> I'm worried about calling a stale nmi_ipi_function via the
>> system_reset_exception path, if we are OK with it, I can revisit
>> the code path
>
> You shouldn't get a stale one, that would also be a bug -- we
> have to cope with NMIs coming in at any time that are triggered
> externally (not by smp_send_nmi_ipi), so if you see any bugs
> there those need to be fixed separately.
>

Yes, I think it's a bug, nothing clears nmi_ipi_function (from what
I can see), so when the next NMI comes in and goes into
pnv_system_reset_exception
it'll execute the stale handler. I'll respin things based on the
suggestion above
and deal with any bugs as well.

Balbir Singh.
