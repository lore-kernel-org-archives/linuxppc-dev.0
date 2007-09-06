Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 97F6DDDF3E
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 06:02:58 +1000 (EST)
Date: Thu, 6 Sep 2007 15:03:07 -0500
From: Olof Johansson <olof@lixom.net>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [RFC/PATCH 2/2] Generic clockevents and no-idle-HZ for PowerPC
Message-ID: <20070906200307.GA22683@lixom.net>
References: <18144.4702.673658.336384@cargo.ozlabs.ibm.com>
	<20070906191516.GA20090@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070906191516.GA20090@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi again,

On Thu, Sep 06, 2007 at 02:15:16PM -0500, Olof Johansson wrote:

> I don't think that set_dec() is needed any more. I get a very long
> delay during "Calibrating delay loop..." with it there.
> 
> Looks like decrementer_set_next_event() already sets a reasonable
> decementer value, it's called through the notify chain set off
> from register_decrementer_clockevent() -> ... -> tick_notify() ->
> tick_setup_periodic() -> clockevents_program_event().

One more problem for at least PA6T is that we'll keep taking decrementer
exceptions as long as DEC contains a negative value, and there seems
to be cases where this happens, i.e. it's not reset for other reasons.

I ended up adding a set_dec(DECREMENTER_MAX) at the start of
timer_interrupt() to avoid the case where none of the code paths through
timer_interrupt() resets the decrementer. I didn't have time to fully
dig down and figure out what paths causes this and why, so I suppose it's
more of a workaround than a solution.

I think 970 behaves the same, but I haven't verified.


-Olof
