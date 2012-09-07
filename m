Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp05.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id CB78B2C0094
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Sep 2012 21:55:01 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 7 Sep 2012 21:54:05 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q87BjtOY26935328
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Sep 2012 21:45:56 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q87Bsubu023504
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Sep 2012 21:54:57 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH -V8 0/11] arch/powerpc: Add 64TB support to ppc64
In-Reply-To: <1346982235.2385.33.camel@pasglop>
References: <1346945351-7672-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1346982235.2385.33.camel@pasglop>
Date: Fri, 07 Sep 2012 17:24:52 +0530
Message-ID: <87fw6uoxo3.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Thu, 2012-09-06 at 20:59 +0530, Aneesh Kumar K.V wrote:
>> Hi,
>> 
>> This patchset include patches for supporting 64TB with ppc64. I haven't booted
>> this on hardware with 64TB memory yet. But they boot fine on real hardware with
>> less memory. Changes extend VSID bits to 38 bits for a 256MB segment
>> and 26 bits for 1TB segments.
>
> Your series breaks the embedded 64-bit build. You seem to be hard wiring
> dependencies on slice stuff all over 64-bit stuff regardless of the MMU
> type or the value of CONFIG_MM_SLICES.
>
> Also all these:
>
>> +/* 4 bits per slice and we have one slice per 1TB */
>> +#if 0 /* We can't directly include pgtable.h hence this hack */
>> +#define SLICE_ARRAY_SIZE  (PGTABLE_RANGE >> 41)
>> +#else
>> +/* Right now we only support 64TB */
>> +#define SLICE_ARRAY_SIZE  32
>> +#endif
>
> Things are just too horrible. Find a different way of doing it, if
> necessary create a new range define somewhere, whatever but don't leave
> that crap as-is, it's too wrong.
>
> Dropping the series for now.
>

You can drop the patch [PATCH -V8 07/11] arch/powerpc: Make some of the PGTABLE_RANGE dependency explicit
from the series. The above two problems are introduced by that patch and
as such can be looked up as a cleanup. I can rework the patch later. You
should be able to apply series without any conflicts even if you drop
that patch.

-aneesh
