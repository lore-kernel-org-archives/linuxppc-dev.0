Return-Path: <john.ogness@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wYy6F1qPPzDqSD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 May 2017 17:13:40 +1000 (AEST)
From: John Ogness <john.ogness@linutronix.de>
To: Nicolae Rosia <nicolae.rosia.oss@gmail.com>
Cc: linux-rt-users@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: timer_create affinity
References: <CAKP5S=3NMzfEDdLsd6_FCNTH6o7_Qz2D6qFwx1WOdc-x2Xi0rA@mail.gmail.com>
Date: Fri, 26 May 2017 09:13:35 +0200
In-Reply-To: <CAKP5S=3NMzfEDdLsd6_FCNTH6o7_Qz2D6qFwx1WOdc-x2Xi0rA@mail.gmail.com>
 (Nicolae Rosia's message of "Thu, 25 May 2017 17:57:03 +0300")
Message-ID: <87r2zcay5c.fsf@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2017-05-25, Nicolae Rosia <nicolae.rosia.oss@gmail.com> wrote:
> I'm working on a real-time application using POSIX timers running on a
> QorIQ PowerPC platform with a 4.1 PREEMPT RT kernel and I'm trying to
> understand whether the following can happen:
>
> 1. A thread with a core affinity #0 creates a timer which will invoke
> a callback.
> 2. The kernel will setup the timer using a local timer running on a
> different core, core #1
> 3. The ISR will fire, and could be dispatched by core #2
> 4. The scheduler will run the callback on core #3.
>
> Is there a way to make sure this whole chain will be executed on a
> single core, the core of the caller?

Avoid POSIX timers if you can. POSIX timers not only have the issue that
you mentioned, but also are generally bad for realtime applications.

The realtime wiki has an example[0] of running a cyclic task. With that
simple example you have complete control over the context of your
task. This is necessary to avoid things like priority inversion and
page-faults, and gives you control over things like affinity or cgroups.

John Ogness

[0] https://wiki.linuxfoundation.org/realtime/documentation/howto/applications/cyclic
