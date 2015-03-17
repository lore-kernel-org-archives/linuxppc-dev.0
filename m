Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0B32A1A02D9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 19:57:09 +1100 (AEDT)
In-Reply-To: <1426565633-7415-1-git-send-email-shreyas@linux.vnet.ibm.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [RFC,
 v2] powerpc/powernv: Introduce kernel param to control fastsleep
 workaround behavior
Message-Id: <20150317085708.7102714017B@ozlabs.org>
Date: Tue, 17 Mar 2015 19:57:08 +1100 (AEDT)
Cc: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2015-17-03 at 04:13:53 UTC, "Shreyas B. Prabhu" wrote:
> Fastsleep is one of the idle state which cpuidle subsystem currently
> uses on power8 machines. In this state L2 cache is brought down to a
> threshold voltage. Therefore when the core is in fastsleep, the
> communication between L2 and L3 needs to be fenced. But there is a bug
> in the current power8 chips surrounding this fencing. OPAL provides an
> interface to workaround this bug, and in the current implementation,
> every time before a core enters fastsleep OPAL call is made to 'apply'
> the workarond and when the core wakes up from fastsleep OPAL call is
> made to 'undo' the workaround. These OPAL calls account for roughly
> 4000 cycles everytime the core has to enter or wakeup from fastsleep.

OK. The bit you don't explain is that while the workaround is applied there is
a risk ...

> The other alternative is to apply this workaround once at boot, and not
> undo it at all. While this would quicken fastsleep entry/wakeup path,
> downside is, any correctable error detected in L2 directory will result
> in a checkstop.

Of this happening.

Which is why we don't just always apply the workaround. Am I right?

> This patch adds a new kernel paramerter
> pnv_fastsleep_workaround_once, which can be used to override
> the default behavior and apply the workaround once at boot and not undo
> it.

So my first preference is that you just bite the bullet and decide to either
always apply the workaround, or just stick with the current behaviour. That's a
trade-off between (I think) better idle latency but a risk of checkstops, vs.
slower idle latency but less (how much less?) risk of checkstops.

I think the reason you're proposing a kernel parameter is because we aren't
willing to make that decision, ie. we're saying that users should decide. Is
that right?

I'm not a big fan of kernel parameters. They are a pain to use, and are often
just pushing a decision down one layer for no reason. What I mean is that
individual users are probably just going to accept whatever the default value
is from their distro.

But anyway, that's a bit of a rant.

As far as this patch is concerned, I don't think it actually needs to be a
kernel parameter.

>From what I can see below, the decision as to whether you apply the workaround
or not doesn't affect the list of idle states. So this could just as well be a
runtime parameter, ie. a sysfs file, which can then be set by the user whenever
they like? They might do it in a boot script, but that's up to them.

For simplicity I think it would also be fine to make it a write-once parameter,
ie. you don't need to handle undoing it.

I think the only complication that would add is that you'd need to be a little
careful about the order in which you nop out the calls vs applying the
workaround, in case some threads are idle when you're called.

cheers
