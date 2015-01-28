Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 86D8C1A02B3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 17:11:08 +1100 (AEDT)
Message-ID: <1422425467.11009.2.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: Add trace point for tracking hash pte fault
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 28 Jan 2015 17:11:07 +1100
In-Reply-To: <87d268v7xm.fsf@linux.vnet.ibm.com>
References: <1421753750-17135-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1421809627.4900.1.camel@ellerman.id.au>
 <87d268v7xm.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2015-01-21 at 14:15 +0530, Aneesh Kumar K.V wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> 
> > On Tue, 2015-01-20 at 17:05 +0530, Aneesh Kumar K.V wrote:
> >> This enables us to understand how many hash fault we are taking
> >> when running benchmarks.
> >> 
> >> For ex:
> >> -bash-4.2# ./perf stat -e  powerpc:hash_fault -e page-faults /tmp/ebizzy.ppc64 -S 30  -P -n 1000
> >> ...
> >> 
> >>  Performance counter stats for '/tmp/ebizzy.ppc64 -S 30 -P -n 1000':
> >> 
> >>        1,10,04,075      powerpc:hash_fault
> >>        1,10,03,429      page-faults
> >> 
> >>       30.865978991 seconds time elapsed
> >
> > Looks good.
> >
> > Can you attach some test results that show it's not hurting performance when
> > it's disabled.
> 
> ebizzy with -S 30 -t 1 -P gave
> 13627 records/s -> Without patch
> 13546 records/s -> With patch with tracepoint disabled

OK. So that's about -0.6%. Are we happy with that? I'm not sure.

Can you do a few more runs and see if that's a stable result.

> random_access_bench gave:
> 1435.979 MB/s -> Without patch
> 1435.29  MB/s -> With patch with tracepoint disabled

That's more like -0.05% which is in the noise.

cheers
