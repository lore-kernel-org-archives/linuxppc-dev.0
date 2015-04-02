Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 56F691A03D3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 23:44:28 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Thu, 2 Apr 2015 06:44:26 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id DEB6F3E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Apr 2015 06:44:23 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t32CiBHt36044988
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 05:44:11 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t32CiMEf017424
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Apr 2015 06:44:23 -0600
Message-ID: <551D39A2.8020009@linux.vnet.ibm.com>
Date: Thu, 02 Apr 2015 18:14:18 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH V2] clockevents: Fix cpu down race for hrtimer based
 broadcasting
References: <20150330092410.24979.59887.stgit@preeti.in.ibm.com>
 <20150402104226.GB21105@gmail.com>
 <20150402120256.GV23123@twins.programming.kicks-ass.net>
 <20150402121247.GA18104@gmail.com>
In-Reply-To: <20150402121247.GA18104@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: nicolas.pitre@linaro.org, linuxppc-dev@lists.ozlabs.org, tglx@linutronix.de,
 rjw@rjwysocki.net, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/02/2015 05:42 PM, Ingo Molnar wrote:
> 
> * Peter Zijlstra <peterz@infradead.org> wrote:
> 
>> On Thu, Apr 02, 2015 at 12:42:27PM +0200, Ingo Molnar wrote:
>>> So why not use a suitable CPU_DOWN* notifier for this, instead of open 
>>> coding it all into a random place in the hotplug machinery?
>>
>> Because notifiers are crap? ;-) [...]
> 
> No doubt - but I didn't feel this poorly named random call into the 
> hotplug code, with no comments was any better.
> 
>> [...] Its entirely impossible to figure out what's happening to core 
>> code in hotplug. You need to go chase down and random order notifier 
>> things.
>>
>> I'm planning on taking out many of the core hotplug notifiers and 
>> hard coding their callbacks into the hotplug code.
> 
> That's very welcome news - but please also lets put in place a proper 
> namespace for all these callbacks, to make them easy to find and 
> change: hotplug_cpu__*() or so, which in this case would turn into 
> hotplug_cpu__tick_pull() or so?
> 
>> That way at least its clear wtf happens when.
> 
> Okay. I'll resurrect the fix with a hotplug_cpu__tick_pull() name - 
> agreed?

Sounds good to me. This needs to be marked to stable also.

Regards
Preeti U Murthy
