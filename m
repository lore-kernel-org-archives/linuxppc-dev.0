Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whnPF1PCYzDqLS
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 20:05:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@ozlabs.org, anton@samba.org, nish.aravamudan@gmail.com
Subject: Re: [PATCH] powerpc/numa: Fix percpu allocations to be NUMA aware
In-Reply-To: <20170602225016.06415f8f@roar.ozlabs.ibm.com>
References: <1496380487-21699-1-git-send-email-mpe@ellerman.id.au>
 <20170602153004.62fd05d1@roar.ozlabs.ibm.com>
 <87y3ta1zqf.fsf@concordia.ellerman.id.au>
 <20170602225016.06415f8f@roar.ozlabs.ibm.com>
Date: Tue, 06 Jun 2017 20:05:19 +1000
Message-ID: <8737bdqvmo.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> On Fri, 02 Jun 2017 19:54:32 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> >> @@ -672,10 +672,19 @@ static void __init pcpu_fc_free(void *ptr, size_t size)
>> >>  
>> >>  static int pcpu_cpu_distance(unsigned int from, unsigned int to)
>> >>  {
>> >> -	if (cpu_to_node(from) == cpu_to_node(to))
>> >> -		return LOCAL_DISTANCE;
>> >> -	else
>> >> -		return REMOTE_DISTANCE;
>> >> +#ifndef CONFIG_NUMA
>> >> +	return LOCAL_DISTANCE;
>> >> +#else
>> >> +	int from_nid, to_nid;
>> >> +
>> >> +	from_nid = early_cpu_to_node(from);
>> >> +	to_nid   = early_cpu_to_node(to);
>> >> +
>> >> +	if (from_nid == -1 || to_nid == -1)
>> >> +		return LOCAL_DISTANCE;	/* Or assume remote? */
>> >> +
>> >> +	return node_distance(from_nid, to_nid);  
>> >
>> > If you made node_distance() return LOCAL_NODE for !NUMA, this
>> > should fall out and not require the ifdef?  
>> 
>> Maybe yeah. This is designed to be minimal for backporting though.
>
> Okay fair enough. Is it expected to get back -1 from this ever? I think
> all we need is local vs not local to direct whether to pack CPUs into
> the same chunks or not so I wonder if the equality test is simpler.

Yeah you're right, I'll do a v2.

I think I was worried about the fact that our node_distance() does
complicated stuff for multi-level NUMA, but that doesn't actually matter
for the per-cpu calculation as you say so it's probably better to keep
it simple.

cheers
