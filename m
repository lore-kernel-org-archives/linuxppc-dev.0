Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5CAB31A0060
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Feb 2016 07:24:08 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Tue, 2 Feb 2016 13:24:06 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id C7BEA3E40030
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Feb 2016 13:24:02 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u12KO2WK29950110
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Feb 2016 13:24:02 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u12KNuqb007396
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Feb 2016 13:23:59 -0700
Date: Tue, 2 Feb 2016 12:23:16 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] powerpc/perf/hv-24x7: Display change in counter values
Message-ID: <20160202202315.GA8240@us.ibm.com>
References: <20160130030710.GA7330@us.ibm.com>
 <20160130030744.GB7330@us.ibm.com>
 <56B0F2BD.4090007@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <56B0F2BD.4090007@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Madhavan Srinivasan [maddy@linux.vnet.ibm.com] wrote:
> 
> 
> On Saturday 30 January 2016 08:37 AM, Sukadev Bhattiprolu wrote:
> > From a1aa992fb25fb8e98a5c5724376ae8cc91463de3 Mon Sep 17 00:00:00 2001
> > From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> > Date: Mon, 25 Jan 2016 23:05:36 -0500
> > Subject: [PATCH 2/2] powerpc/perf/hv-24x7: Display change in counter values
> >
> > For 24x7 counters, perf displays the raw value of the 24x7 counter, which
> > is a monotonically increasing value.
> >
> > 	perf stat -C 0 -e \
> > 		'hv_24x7/HPM_0THRD_NON_IDLE_CCYC__PHYS_CORE,core=1/' \
> > 		sleep 1
> >
> >  Performance counter stats for 'CPU(s) 0':
> >
> >      9,105,403,170      hv_24x7/HPM_0THRD_NON_IDLE_CCYC__PHYS_CORE,core=1/
> >
> >        0.000425751 seconds time elapsed
> >
> > In the typical usage of 'perf stat' this counter value is not as useful
> > as the _change_ in the counter value over the duration of the application.
> 
> This may break application using this interface right? i.e, since
> for all this time, counter output was raw values and application
> may be post processing to calculate the difference, now with
> this patch, application may need some change? Also,
> should not this be documented somewhere?

Agree that it does change the behavior. I am checking to see if it
was explicitly documented that the values would be raw. But current
behavior seems counter-intuitive and inconsistent with 'perf stat'.

If we run something like:

	perf stat -C 0 -e <24x7-event> make

we see the large number (raw value of the counter) when the application
terminates. The raw value not very useful. To effectively use the counter
in this scenario, user would ahve to run:

	perf stat -C 0 -e <24x7-event> sleep 1
	#note raw value 1

	perf stat -C 0 -e <24x7-event> make
	# note raw value 2

	# compute diff of value2 and value1.

Reporting the change in value seems to be consistent with normal usage of
perf stat with events like cycles or instructions:

Thanks,

Sukadev
