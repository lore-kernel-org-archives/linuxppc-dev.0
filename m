Return-Path: <cody@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 63EB52C009C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Feb 2014 06:33:37 +1100 (EST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Thu, 27 Feb 2014 12:33:34 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 7C2D51FF0043
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 12:33:31 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1RJX5Us10224004
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 20:33:05 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s1RJawbE022122
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Feb 2014 12:36:59 -0700
Message-ID: <530F9307.40400@linux.vnet.ibm.com>
Date: Thu, 27 Feb 2014 11:33:27 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 02/11] perf core: export swevent hrtimer helpers
References: <1392415338-16288-3-git-send-email-cody@linux.vnet.ibm.com>
 <20140225033326.7BB942C0228@ozlabs.org>
 <20140225102008.GI9987@twins.programming.kicks-ass.net>
 <530D0D57.4030704@linux.vnet.ibm.com>
 <20140226082943.GC18404@twins.programming.kicks-ass.net>
In-Reply-To: <20140226082943.GC18404@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/26/2014 12:29 AM, Peter Zijlstra wrote:
> On Tue, Feb 25, 2014 at 01:38:31PM -0800, Cody P Schafer wrote:
>> On 02/25/2014 02:20 AM, Peter Zijlstra wrote:
>>> On Tue, Feb 25, 2014 at 02:33:26PM +1100, Michael Ellerman wrote:
>>>> On Fri, 2014-14-02 at 22:02:06 UTC, Cody P Schafer wrote:
>>>>> Export the swevent hrtimer helpers currently only used in events/core.c
>>>>> to allow the addition of architecture specific sw-like pmus.
>>>>
>>>> Peter, Ingo, can we get your ACK on this please?
>>>
>>> How are they used? I saw some usage in patch 9 or so; but its not
>>> explained anywhere. All patches have non-existent Changelogs and the few
>>> comments that are there are pretty hardware specific.
>>>
>>> So please do tell; what do you need this for?
>>
>>  From this patch's change log:
>>
>>> Export the swevent hrtimer helpers currently only used in events/core.c to allow the addition of architecture specific sw-like pmus.
>>
>> The key part here is "architecture specific sw-like pmus", where the
>> announcement explains why these pmus are sw-like:
>
> I don't read announcements for crucial patch details; announcements are
> lost and therefore unimportant.

And I'll be sure to elaborate further in the changelog next time (if I 
don't drop this change entirely).
This is the first comment I've got on this particular patch.

>>> The counters supplied by these interfaces are continually counting and never
>>> need to be (and cannot be) disabled or enabled. They additionally do not
>>> generate any interrupts. This makes them in some regards similar to software
>>> counters, and as a result their implimentation shares some common code (which
>>> an initial patch exposes) with the sw counters.
>>
>> Essentially, these pmus just provide access to a big array of counters which
>> don't generate interrupts, and are all 64bit (and assumed to never
>> overflow). Rather than duplicate the code that we already have for managing
>> timing when reading from counters that don't have interrupts (the functions
>> that are exposed by this patch), I've reused it.
>
> So note that all the software counters generate interrupts in their own
> measuring domain. The hrtimer ones measure time and generate time based
> interrupts, the event based ones generate 'interrupts' on their events.
>
> What you have here is a hw pmu without interrupt capability. That's
> fine, they don't get to generate interrupt. We have plenty of those
> already.
>
> But what you propose to do is add interrupt in another domain entirely.
> That's not fine. Don't do that.

Ok, so it looks like I misunderstood the need for an interrupt. The 
intention in using the swevent_hrtimer code was to enable setting up the 
events as frequency sampled. After taking another look at the gpci and 
24x7 pmus, I'm forbidding sampling events anyhow in event init, so the 
timer code isn't even taken advantage of. I'll drop this patch in the 
next set.

>
> You also try and conceal this information; so you suck.
>
