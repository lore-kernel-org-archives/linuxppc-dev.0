Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x231.google.com (mail-ua0-x231.google.com
 [IPv6:2607:f8b0:400c:c08::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bXD74KpmzF2SD
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 18:55:19 +1000 (AEST)
Received: by mail-ua0-x231.google.com with SMTP id a2so8520931uak.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 May 2018 01:55:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180502183846.73287b06@roar.ozlabs.ibm.com>
References: <20180501022216.1420-1-npiggin@gmail.com>
 <dcda2a1bb4dc3b2c6066186cffbb356d2ff61ec8.camel@gmail.com>
 <20180502183846.73287b06@roar.ozlabs.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 2 May 2018 18:55:15 +1000
Message-ID: <CAKTCnz=YVPGPEO21nP6Mmt8shF8FkPMe9yWU+3GLad_ynTNwFQ@mail.gmail.com>
Subject: Re: [PATCH] powerpc/watchdog: provide more data in watchdog messages
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 2, 2018 at 6:38 PM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Tue, 01 May 2018 23:07:28 +1000
> Balbir Singh <bsingharora@gmail.com> wrote:
>
>> On Tue, 2018-05-01 at 12:22 +1000, Nicholas Piggin wrote:
>> > Provide timebase and timebase of last heartbeat in watchdog lockup
>> > messages. Also provide a stack trace of when a CPU becomes un-stuck,
>> > which can be useful -- it could be where irqs are re-enabled, so it
>> > may be the end of the critical section which is responsible for the
>> > latency.
>> >
>> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> > ---
>> >
>> > A lockup + unstuck event now looks like this (with irqtrace enabled):
>> >
>> > watchdog: CPU 1 self-detected hard LOCKUP @ udelay+0x40/0x60
>> > watchdog: CPU 1 TB:82611697355, last heartbeat TB:75431975757
>>
>> Can we divide TB with tb_ticks_per_sec, TB itself is not very useful, the
>> delta maybe, but it needs more work on behalf of the person looking
>> at the output.
>
> I kind of prefer being able to examine register values and compare
> directly with these logs, e.g., in mambo or xmon.
>
> But maybe end user prefers something friendlier. What about like
>
> watchdog: CPU 1 self-detected hard LOCKUP @ udelay+0x40/0x60
> watchdog: CPU 1 no heartbeat for 14.02s (TB:82611697355, last TB:75431975757)
>
> ?

That's better, if you really need the TB values, assuming we've
handled overflows, which should practically never happen right? :)

>
>> > @@ -245,8 +260,6 @@ void soft_nmi_interrupt(struct pt_regs *regs)
>> >
>> >     tb = get_tb();
>> >     if (tb - per_cpu(wd_timer_tb, cpu) >= wd_panic_timeout_tb) {
>> > -           per_cpu(wd_timer_tb, cpu) = tb;
>> > -
>>
>> Is this related to the print improvements? It looks like you don't want
>> to reset the tb, but I would split it out
>
>
> Yeah there isn't any real reason to reset it since we get marked as
> stuck which prevents further messages, and it clobbrs our last heartbeat
> value. I'll put it into its own change.
>

Sounds good!
Balbir Singh.
