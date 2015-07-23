Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 956331A02B5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jul 2015 19:04:26 +1000 (AEST)
Message-ID: <1437642259.29271.1.camel@ellerman.id.au>
Subject: Re: [PATCH v5 6/7] powerpc/powernv: generic nest pmu event functions
From: Michael Ellerman <mpe@ellerman.id.au>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Daniel Axtens <dja@axtens.net>, linux-kernel@vger.kernel.org, Stephane
 Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>, Anton
 Blanchard <anton@samba.org>,  Sukadev Bhattiprolu
 <sukadev@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org, Anshuman
 Khandual <khandual@linux.vnet.ibm.com>
Date: Thu, 23 Jul 2015 19:04:19 +1000
In-Reply-To: <55B08D4C.7050104@linux.vnet.ibm.com>
References: <1437045206-7491-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1437045206-7491-7-git-send-email-maddy@linux.vnet.ibm.com>
 <1437540961.30906.39.camel@axtens.net>
 <55B08D4C.7050104@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-07-23 at 12:14 +0530, Madhavan Srinivasan wrote:
> 
> On Wednesday 22 July 2015 10:26 AM, Daniel Axtens wrote:
> >> +static void p8_nest_read_counter(struct perf_event *event)
> >> +{
> >> +	uint64_t *addr;
> >> +	u64 data = 0;
> > You've got a u64 and a uint64_t, and then...
> >> +
> >> +	addr = (u64 *)event->hw.event_base;
> > ... you cast to event_base to a u64 pointer, which you assign to a
> > uint64_t pointer.
> >> +	data = __be64_to_cpu(*addr);
> > And now you dereference the pointer.
> > Could you just have:
> >     data = __be64_to_cpu(*event->hw.event_base);
> >> +	local64_set(&event->hw.prev_count, data);
> >> +}
> >> +
> >> +static void p8_nest_perf_event_update(struct perf_event *event)
> >> +{
> >> +	u64 counter_prev, counter_new, final_count;
> >> +	uint64_t *addr;
> >> +
> >> +	addr = (uint64_t *)event->hw.event_base;
> > Here at least the cast type is the same as the type of addr, but again,
> > why do you need the different types, and why local variable?
> 
> Damn sorry, copy paste errors. When I added debug prints i messed
> the type case in both the functions. I will make them as uint64_t.

No please use u64/u32 etc. Most code in powerpc does and I prefer them.

cheers
