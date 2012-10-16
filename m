Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D858C2C00A3
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2012 16:28:42 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 16 Oct 2012 15:24:53 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q9G5SbIX52887710
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2012 16:28:38 +1100
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q9G5Sa3v015862
 for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2012 16:28:37 +1100
Message-ID: <507CF098.9080703@linux.vnet.ibm.com>
Date: Tue, 16 Oct 2012 10:58:56 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Arun Sharma <asharma@fb.com>
Subject: Re: [RFC][PATCH] perf: Add a few generic stalled-cycles events
References: <20121012012839.GA15348@us.ibm.com>
 <20121015155534.GR8285@erda.amd.com> <507C467E.8010205@fb.com>
In-Reply-To: <507C467E.8010205@fb.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Robert Richter <robert.richter@amd.com>,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 eranian@google.com, acme@redhat.com, peterz@infradead.org, paulus@samba.org,
 mpjohn@us.ibm.com, Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>,
 mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/15/2012 10:53 PM, Arun Sharma wrote:
> On 10/15/12 8:55 AM, Robert Richter wrote:
> 
> [..]
>> Perf tool works then out-of-the-box with:
>>
>>   $ perf record -e cpu/stalled-cycles-fixed-point/ ...
>>
>> The event string can easily be reused by other architectures as a
>> quasi standard.
> 
> I like Robert's proposal better. It's hard to model all the stall events
> (eg: instruction decoder related stalls on x86) in a hardware
> independent way.
> 
> Another area to think about: software engineers are generally busy and
> have a limited amount of time to devote to hardware event based
> optimizations. The most common question I hear is: what is the expected
> perf gain if I fix this? It's hard to answer that with just the stall
> events.
> 

Hardware event based optimization is a very important aspect of real world application
tuning. CPI stack analysis is a good reason why perf should have stall events as generic
ones. But I am not clear on situations where we consider adding these new generic events
into linux/perf_event.h and the situations where we should go with the sys fs interface.
Could you please elaborate on this ?

Regards
Anshuman
