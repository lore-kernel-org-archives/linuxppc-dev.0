Mime-Version: 1.0
Message-Id: <p05100301b7a5c073cc62@[10.0.0.42]>
In-Reply-To: <200108191559.RAA01163@piglet.grunz.lu>
References: <200108191559.RAA01163@piglet.grunz.lu>
Date: Sun, 19 Aug 2001 12:51:31 -0700
To: mlan@cpu.lu, hozer@drgw.net
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: About TAU (and ICTC)
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel,

I'd have to agree.  ICTC policy should really be userspace, as should
all policy.

The exception would be when it's desired to use the feature for its
original intended purpose, reduction of die temperature when that
temperature reaches a critical threshold.  That would also mean using
the TAU the way it was intended: you set the upper and lower TAU
thresholds as desired, and the TAU ISR turns ICTC on when the high
threshold is passed and off when it moves past the lower.

Even in that scenario, userspace should enable/disable thermal
throttling and its thresholds, probably via /proc entries.


I'm actually not sure it makes sense to use ICTC as a powersave
feature.  The way it works is simply by making use of the dynamic
powersave feature built into the CPU -- functional units that aren't
being used aren't clocked.  Decrease the frequency of use and you
decrease the rate of power consumption.

But if you think about it, it probably doesn't reduce the total power
needed to do a given task.  It just spreads the power use over a
longer period of time.  So you'll use roughly the same amount of
energy to do one kernel compile no matter what the ICTC setting is;
it'll just get done slower with ICTC on.

In fact, because programs will generally take longer to run with ICTC
on, I suspect that ICTC is *less* power efficient than going all-out.
Only part of the CPU's power use is dynamic (and therefore subject to
regulation via ICTC).  There's dielectric leakage current, which is
constant no matter what you do, and, more importantly, plenty of
clocked circuits which are not shut down by the dynamic power save
circuitry.  From this one can conclude that power use per unit of
computation done is likely higher when using ICTC.

Could you test this?  I.e. run a continuous kernel compile and record
not only how long the battery lasts but how many compiles got done
before the end.

(It's probably for this reason that Apple uses variable clock speed
rather than ICTC to save power on their recent portables.  For
example the new model iBook normally runs at 500 MHz, but can switch
down to 400 MHz while on battery power.)
--
Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
