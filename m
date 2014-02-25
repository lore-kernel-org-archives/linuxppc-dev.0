Return-Path: <cody@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5D6472C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 08:38:52 +1100 (EST)
Received: from /spool/local
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 14:38:49 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 61C4B3E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 14:38:46 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1PJa5LU11665742
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 20:36:05 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s1PLgDwr028129
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 14:42:13 -0700
Message-ID: <530D0D57.4030704@linux.vnet.ibm.com>
Date: Tue, 25 Feb 2014 13:38:31 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Peter Zijlstra <peterz@infradead.org>,
 Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v2 02/11] perf core: export swevent hrtimer helpers
References: <1392415338-16288-3-git-send-email-cody@linux.vnet.ibm.com>
 <20140225033326.7BB942C0228@ozlabs.org>
 <20140225102008.GI9987@twins.programming.kicks-ass.net>
In-Reply-To: <20140225102008.GI9987@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, Ingo Molnar <mingo@redhat.com>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/25/2014 02:20 AM, Peter Zijlstra wrote:
> On Tue, Feb 25, 2014 at 02:33:26PM +1100, Michael Ellerman wrote:
>> On Fri, 2014-14-02 at 22:02:06 UTC, Cody P Schafer wrote:
>>> Export the swevent hrtimer helpers currently only used in events/core.c
>>> to allow the addition of architecture specific sw-like pmus.
>>
>> Peter, Ingo, can we get your ACK on this please?
>
> How are they used? I saw some usage in patch 9 or so; but its not
> explained anywhere. All patches have non-existent Changelogs and the few
> comments that are there are pretty hardware specific.
>
> So please do tell; what do you need this for?

 From this patch's change log:

> Export the swevent hrtimer helpers currently only used in events/core.c to allow the addition of architecture specific sw-like pmus.

The key part here is "architecture specific sw-like pmus", where the 
announcement explains why these pmus are sw-like:

> The counters supplied by these interfaces are continually counting and never
> need to be (and cannot be) disabled or enabled. They additionally do not
> generate any interrupts. This makes them in some regards similar to software
> counters, and as a result their implimentation shares some common code (which
> an initial patch exposes) with the sw counters.

Essentially, these pmus just provide access to a big array of counters 
which don't generate interrupts, and are all 64bit (and assumed to never 
overflow). Rather than duplicate the code that we already have for 
managing timing when reading from counters that don't have interrupts 
(the functions that are exposed by this patch), I've reused it.
