Return-Path: <sukadev@linux.vnet.ibm.com>
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e7.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BCCF82C007E
 for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2013 05:58:05 +1100 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <sukadev@linux.vnet.ibm.com>;
 Wed, 23 Jan 2013 13:58:03 -0500
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 36AC938C801C
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2013 13:58:01 -0500 (EST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0NIvuCu42664020
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2013 13:57:57 -0500
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0NIvXUZ020531
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2013 11:57:34 -0700
Date: Wed, 23 Jan 2013 10:57:33 -0800
From: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] perf: Fix compile warnings in tests/attr.c
Message-ID: <20130123185733.GA22906@us.ibm.com>
References: <20130119013052.GA24693@us.ibm.com>
 <20130121135906.GD1995@krava.brq.redhat.com>
 <20130121213823.GA4774@us.ibm.com>
 <1358898333.29791.14.camel@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1358898333.29791.14.camel@concordia>
Cc: Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, paulus@samba.org, acme@ghostprotocols.net,
 mingo <mingo@elte.hu>, Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman [michael@ellerman.id.au] wrote:
| > | make: *** [tests/attr.o] Error 1
| > | 
| > | i386 compiles fine
| > 
| > __u64 is 'unsigned long long' on x86 and PRIu64 is 'llu' which is fine.
| > 
| > __u64 is 'unsigned long' on Power and PRIu64 is 'lu' which is again fine.
| > 
| > But __u64 is 'unsigned long long' on x86_64, but PRIu64 is '%lu' bc __WORDSIZE
| > is 64.
| 
| 
| This is a bit of a mess, but let me see if I can help explain it.

Yes it is :-) thanks for explaining it.

| 
| The root of the problem is that you're mixing up the kernel type __u64,
| with the userspace format specifier PRIu64.

struct perf_event_attr is shared with user space and is using __u64. Should
it use uint64_t instead ?

| 
| PRIu64 is the format specifier for printing a uint64_t, it _may_ also be
| the right specifier for a __u64, but there's no guarantee of that - as
| you have discovered.
| 
| Inside the kernel both x86 and powerpc use unsigned long long always, in
| 32-bit and 64-bit code. That means in the kernel we can always use %llu.
| 
| On x86 that definition is also exported to userspace, so on x86 __u64 is
| always unsigned long long. As you noticed this potentially differs from
| uint64_t, which can be confusing. However it means in x86 userspace code
| you can always print a __u64 with %llu.
| 
| On powerpc we default to using definitions that match userspace, so
| __u64 changes depending on your wordsize, and so you must use PRIu64
| etc. to print them.

Well, using __u64 and PRIu64 seems breaks x86-64...

| 
| There is however support in recent powerpc kernels to switch to using
| unsigned long long even on 64-bit. See commit 2c9c6ce.
| 
| You need to define __SANE_USERSPACE_TYPES__ before including types.h.
| Then you can always use %llu to print __u64.

but __SANE_USERSPACE_TYPES__ with __u64 and %llu seems to work on x86,
x86-64, powerpc.

Will modify my patch to add __SANE_USERSPACE_TYPES__ but leave the %llu
as is.

Sukadev
