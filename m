Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 347EDDE0E3
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 13:48:23 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so2005203yxb.39
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 20:48:21 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <9e4733910905261744j3589ace8wd427ef8a5998eccf@mail.gmail.com>
References: <20090527002530.16740.62502.stgit@terra>
	<ed82fe3e0905261738u655f6f5at2351341a0a5e50d5@mail.gmail.com>
	<9e4733910905261744j3589ace8wd427ef8a5998eccf@mail.gmail.com>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Tue, 26 May 2009 21:48:01 -0600
Message-ID: <fa686aa40905262048ma2d5e12s907c489974343280@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] Modify mpc5200 AC97 driver to use V9 of
	spin_event_timeout()
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	Timur Tabi <timur@freescale.com>, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 26, 2009 at 6:44 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> On Tue, May 26, 2009 at 8:38 PM, Timur Tabi <timur@freescale.com> wrote:
>> On Tue, May 26, 2009 at 7:25 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
>>
>>> - =A0 =A0 =A0 spin_event_timeout(0, 10, 0, rc);
>>> + =A0 =A0 =A0 spin_event_timeout(0, 10, 0);
>>> =A0 =A0 =A0 =A0out_8(&regs->op0, MPC52xx_PSC_OP_RES);
>>> - =A0 =A0 =A0 spin_event_timeout(0, 50, 0, rc);
>>> + =A0 =A0 =A0 spin_event_timeout(0, 50, 0);
>>
>> Jon, I'm still hoping you'll explain why you're not using udelay() here.
>
> Because Grant didn't want me doing udelay(50) just to delay things in
> order to give the AC97 controller time to initialize. Your function
> lets me loop on cpu_relax() for 50us.

No, you misunderstand.  My issue is that udelay is far too coarse
grained for what you want.  ie. If your are using udelay(1) in your
loop, and your event changes state in 1.01us, then you're still going
to burn a full 2us of time.  If you can loop over cpu_relax() instead,
then less time will get burned.

For a hard 50us delay, with no early exit condition, udelay() is the
correct function.

HOWEVER; I'm distrustful of *any* spins, and would rather see sleeps
instead of spins wherever possible.  There are two reasons for this:

First, udelay just burns time, and if the delay is too large, then the
it is wasting time that could be used for something else.  That being
said, it needs to be balanced with the context switch overhead.  If
the udelay() is less than double the context switch time, then the
overhead is greater than the time spent spinning.

Second, udelay() with IRQs disabled cause unbounded latencies.  Even
if it is less efficient, I'd rather see mutexes+msleep() than
spin_lock_irqsave()+udelay().  Of course, this only works in
non-atomic contexts.  If the code is atomic, then you have no choice.

There is no blanket rule here; but as the time delay requirement gets
larger, the greater the benefit to overall system responsiveness by
using sleep instead of delay.  I'm not going to make a hard statement
about how it should be done right now.  It's a fiddly area and it can
be tweaked after the driver is merged.

However, Timur is absolutely right.  A spin without an early exit
condition should simply be a udelay().

> I have to delay 50us because ALSA tries to access the hardware
> immediately after the function returns.

Does the code run in atomic context?

g.

--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
