Return-Path: <rjwysocki@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r9YQ25bBYzDqDv
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 May 2016 00:30:34 +1000 (AEST)
Received: from mail-wm0-x22c.google.com (mail-wm0-x22c.google.com
 [IPv6:2a00:1450:400c:c09::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3r9YQ16l44z9t3h
 for <linuxppc-dev@ozlabs.org>; Fri, 20 May 2016 00:30:33 +1000 (AEST)
Received: by mail-wm0-x22c.google.com with SMTP id n129so233555648wmn.1
 for <linuxppc-dev@ozlabs.org>; Thu, 19 May 2016 07:30:33 -0700 (PDT)
MIME-Version: 1.0
Sender: rjwysocki@gmail.com
In-Reply-To: <20160519114029.GW3193@twins.programming.kicks-ass.net>
References: <1463576020-18597-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <CAJZ5v0jv+fD-ZKjLBepL9Fkn1JFROO3nGHX_3-=PuzGSAALB5g@mail.gmail.com>
 <20160519114029.GW3193@twins.programming.kicks-ass.net>
Date: Thu, 19 May 2016 16:30:31 +0200
Message-ID: <CAJZ5v0h+vb1+9urzfOWsCKy8eziVGpVvSiB84i7nwbktOS+EaA@mail.gmail.com>
Subject: Re: [RFC PATCH] Increase in idle power with schedutil
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>,
 "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>,
 shreyas@linux.vnet.ibm.com, akshay.adiga@linux.vnet.ibm.com,
 linuxppc-dev@ozlabs.org, Steve Muckle <steve.muckle@linaro.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, May 19, 2016 at 1:40 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> On Wed, May 18, 2016 at 11:11:51PM +0200, Rafael J. Wysocki wrote:
>> On Wed, May 18, 2016 at 2:53 PM, Shilpasri G Bhat
>> <shilpa.bhat@linux.vnet.ibm.com> wrote:
>> > This patch adds driver callback for fast_switch and below observations
>> > on schedutil governor are done with this patch.
>> >
>> > In POWER8 there is a regression observed with schedutil compared to
>> > ondemand. With schedutil the frequency is not ramping down and is
>> > mostly stuck at max frequency during idle . This is because of the
>> > watchdog timer, an RT task which is fired every 4 seconds which
>> > results in requesting max frequency.
>>
>> Well, yes, that would be problematic.
>>
>
> Right; we need to come up with something for RT tasks;

I think we need the hints thing for that to be able to distinguish
between RT and the rest.

Also in this particular case it looks like an RT task is the only task
that wakes up often enough and we don't drop the frequency when going
idle.  Do we need a hook somewhere in the idle path?
