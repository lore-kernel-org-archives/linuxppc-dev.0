Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8DD6E2C00B7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 23:27:56 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 18 Mar 2013 17:53:19 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id C3370125805E
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 17:58:52 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r2ICRgo76160678
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 17:57:42 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r2ICRieE009991
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2013 23:27:44 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michel Lespinasse <walken@google.com>
Subject: Re: [patch 2/2] mm: use vm_unmapped_area() on powerpc architecture
In-Reply-To: <CANN689H_Q8RBmyuF6hqOB+prZciHTUPudfhs_+y0p2peHwTdTw@mail.gmail.com>
References: <20130221230558.C201931C1B7@corp2gmr1-1.hot.corp.google.com>
 <87d2ux2c7w.fsf@linux.vnet.ibm.com>
 <CANN689H_Q8RBmyuF6hqOB+prZciHTUPudfhs_+y0p2peHwTdTw@mail.gmail.com>
Date: Mon, 18 Mar 2013 17:57:44 +0530
Message-ID: <87a9q03nb3.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: akpm@linux-foundation.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michel Lespinasse <walken@google.com> writes:

> On Mon, Mar 18, 2013 at 4:12 AM, Aneesh Kumar K.V
> <aneesh.kumar@linux.vnet.ibm.com> wrote:
>> how about  ?
>>
>> static bool slice_scan_available(unsigned long addr,
>>                                  struct slice_mask available,
>>                                  int end,
>>                                  unsigned long *boundary_addr)
>> {
>>         unsigned long slice;
>>         if (addr < SLICE_LOW_TOP) {
>>                 slice = GET_LOW_SLICE_INDEX(addr);
>>                 *boundary_addr = (slice + end) << SLICE_LOW_SHIFT;
>>                 return !!(available.low_slices & (1u << slice));
>>         } else {
>>                 slice = GET_HIGH_SLICE_INDEX(addr);
>
>>                 if ((slice + end) >= SLICE_NUM_HIGH)
>>                         /* loop back in the high slice */
>>                         *boundary_addr = SLICE_LOW_TOP;
>>                 else
>>                         *boundary_addr = (slice + end) << SLICE_HIGH_SHIFT;
>
> I don't mind having this section as an if..else rather than ?:
> statement. However, the condition would need to be if (slice == 0 &&
> end == 0) or if (slice + end == 0)
>
> This is because the beginning of high slice 0 is at SLICE_LOW_TOP and not at 0,
> and the end of high slice 63 is at 64TB not at SLICE_LOW_TOP.
>

aha, I missed the fact that it was to handle slice = 0 && end == 0
case. I was looking it as looping back to start slice in high slice
range once we reached 0xffffffff. Above slice 63 in high slice, we
should have available always unset, so beyond that we can ideally
loop back to SLICE_LOW_TOP right ?

-aneesh
