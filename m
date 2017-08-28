Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgqds14N2zDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 21:43:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, mikey@neuling.org,
 stewart@linux.vnet.ibm.com, apopple@au1.ibm.com, hbabu@us.ibm.com,
 oohall@gmail.com, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 10/12] powerpc/vas: Define vas_win_close() interface
In-Reply-To: <20170828051446.GF12907@us.ibm.com>
References: <1503556688-15412-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1503556688-15412-11-git-send-email-sukadev@linux.vnet.ibm.com>
 <87valct177.fsf@concordia.ellerman.id.au> <20170828051446.GF12907@us.ibm.com>
Date: Mon, 28 Aug 2017 21:43:09 +1000
Message-ID: <87d17fvrxu.fsf@concordia.ellerman.id.au>
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

Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:

> Michael Ellerman [mpe@ellerman.id.au] wrote:
>> Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com> writes:
>> > diff --git a/arch/powerpc/platforms/powernv/vas-window.c b/arch/powerpc/platforms/powernv/vas-window.c
>> > index 2dd4b63..24288dd 100644
>> > --- a/arch/powerpc/platforms/powernv/vas-window.c
>> > +++ b/arch/powerpc/platforms/powernv/vas-window.c
>> > @@ -879,11 +887,92 @@ struct vas_window *vas_rx_win_open(int vasid, enum vas_cop_type cop,
>> >  }
>> >  EXPORT_SYMBOL_GPL(vas_rx_win_open);
>> >  
>> > -/* stub for now */
>> > +static void poll_window_busy_state(struct vas_window *window)
>> > +{
>> > +	int busy;
>> > +	uint64_t val;
>> > +
>> > +retry:
>> > +	/*
>> > +	 * Poll Window Busy flag
>> > +	 */
>> > +	val = read_hvwc_reg(window, VREG(WIN_STATUS));
>> > +	busy = GET_FIELD(VAS_WIN_BUSY, val);
>> > +	if (busy) {
>> > +		val = 0;
>> > +		schedule_timeout(2000);
>> 
>> What's 2000?
>> 
>> That's in jiffies, so it's not a fixed amount of time.
>> 
>> But on a typical config that will be 20 _seconds_ ?!
>
> Ok. Should I change to that just HZ and

Does the hardware give us any idea how long we need to wait?

HZ is better I guess but it's still a long time.

>> But you haven't set the task state, so AFAIK it will just return
>> instantly.
>
> call set_current_state(TASK_UNINTERRUPTIBLE) before the schedule_timeout()?

Yes.

>> > +	val = read_hvwc_reg(window, VREG(WIN_CTX_CACHING_CTL));
>> > +	cached = GET_FIELD(VAS_WIN_CACHE_STATUS, val);
>> > +	if (cached) {
>> > +		val = 0ULL;
>> > +		val = SET_FIELD(VAS_CASTOUT_REQ, val, 1);
>> > +		val = SET_FIELD(VAS_PUSH_TO_MEM, val, 0);
>> > +		write_hvwc_reg(window, VREG(WIN_CTX_CACHING_CTL), val);
>> 
>> Sigh, I still don't like that macro :)
>
> :-) For one thing, I have used it a lot now and secondly isn't it easier
> to know that VAS_CASTOUT_REQ bit is set to 1 without worrying about its
> bit position?

Yeah I guess it depends what you're doing. Are you comparing the code to
the spec, where seeing the name is probably what you want?

Or are you debugging the code running on hardware, where you have a dump
of register values or a trace etc. and you don't have any names just hex
values.

At least in my experience I spend more time doing the latter, so being
able to match the hex values in the code up with values I see in memory
or in registers is preferable.

But it's your code so I'll stop whining about that macro :)


cheers
