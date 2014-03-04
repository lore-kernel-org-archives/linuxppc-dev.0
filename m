Return-Path: <cody@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5CF5C2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2014 18:01:46 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cody@linux.vnet.ibm.com>;
 Tue, 4 Mar 2014 00:01:42 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 7B8A019D804C
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Mar 2014 00:01:37 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp07028.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s24713N69306618
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Mar 2014 08:01:03 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 s24758Wj001244
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Mar 2014 00:05:09 -0700
Message-ID: <53157A45.4080600@linux.vnet.ibm.com>
Date: Mon, 03 Mar 2014 23:01:25 -0800
From: Cody P Schafer <cody@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: [PATCH v3 03/11] perf: provide a common perf_event_nop_0() for
 use with .event_idx
References: <20140304051936.97CBF2C020A@ozlabs.org>
In-Reply-To: <20140304051936.97CBF2C020A@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Peter Zijlstra <peterz@infradead.org>, scottwood@freescale.com,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/03/2014 09:19 PM, Michael Ellerman wrote:
> On Thu, 2014-27-02 at 21:04:56 UTC, Cody P Schafer wrote:
>> Rather an having every pmu that needs a function that just returns 0 for
>> .event_idx define their own copy, reuse the one in kernel/events/core.c.
>>
>> Rename from perf_swevent_event_idx() because we're no longer using it
>> for just software events. Naming is based on the perf_pmu_nop_*()
>> functions.
>
> You could just use perf_pmu_nop_int() directly.

No, .event_idx needs something that takes a (struct perf_event *), 
perf_pmu_nop_int() takes a (struct pmu *).
