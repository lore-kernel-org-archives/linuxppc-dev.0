Return-Path: <shreyasbp@gmail.com>
Received: from mail-qk0-x234.google.com (mail-qk0-x234.google.com
 [IPv6:2607:f8b0:400d:c09::234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t8Zs90yJjzDt1l
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Nov 2016 17:32:45 +1100 (AEDT)
Received: by mail-qk0-x234.google.com with SMTP id x190so43909532qkb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 23:32:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20161103171751.44798270@roar.ozlabs.ibm.com>
References: <20161013021714.6624-1-npiggin@gmail.com>
 <79d229aa-2b4e-67b7-157b-b839bc390cbf@linux.vnet.ibm.com>
 <20161102175701.2ae8d1d3@roar.ozlabs.ibm.com>
 <20161102082433.GA17365@in.ibm.com>
 <20161102193624.7f0cbfee@roar.ozlabs.ibm.com>
 <20161102084548.GD17909@in.ibm.com>
 <20161103162100.1b50777e@roar.ozlabs.ibm.com>
 <CAAVMmb5Zj4oKVF6f3Ag0mEHOUrAYro65JyuULMO7+abRs4D=OQ@mail.gmail.com>
 <20161103171751.44798270@roar.ozlabs.ibm.com>
From: "Shreyas B. Prabhu" <shreyasbp@gmail.com>
Date: Thu, 3 Nov 2016 02:32:39 -0400
Message-ID: <CAAVMmb7wmgYY6AFLb2kqJsgOJwQK_vYaJtxmeouF9ZXezWtEDA@mail.gmail.com>
Subject: Re: [PATCH] powerpc/64s: relocation, register save fixes for system
 reset interrupt
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 3, 2016 at 2:17 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> On Thu, 3 Nov 2016 01:56:46 -0400
> "Shreyas B. Prabhu" <shreyasbp@gmail.com> wrote:
>
>> On Thu, Nov 3, 2016 at 1:21 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
>> > On Wed, 2 Nov 2016 14:15:48 +0530
>> > Gautham R Shenoy <ego@linux.vnet.ibm.com> wrote:
>> >
>> >> Hi Nick,
>> >>
>> >> On Wed, Nov 02, 2016 at 07:36:24PM +1100, Nicholas Piggin wrote:
>> >> >
>> >> > Okay, I'll work with that. What's the best way to make a P8 do
>> >> > winkle sleeps?
>> >>
>> >> From the userspace, offlining the CPUs of the core will put them to
>> >> winkle.
>> >
>> > Thanks for this. Hum, that r13 manipulation throughout the idle
>> > and exception code is a bit interesting. I'll do the minimal patch
>> > for 4.9, but what's the reason not to just use the winkle state
>> > in the PACA rather than storing it into HSPRG0 bit, can you (or
>> > Shreyas) explain?
>> >
>> Hi Nick,
>>
>> Before deep winkle, checking SRR1's wakeup bits (Bits 46:47) was enough to
>> figure out which idle state we are waking up from. But in P8, SRR1's wakeup
>> bits aren't enough since bits 46:47 are 0b11 for both fast sleep and
>> deep winkle.
>> So to distinguish bw fastsleep and deep winkle, we use the current HSPRG0/PORE
>> trick. We program the PORE engine (which is used for state restore when waking
>> up from deep winkle) to restore HSPRG0 with the last bit set (we do this in
>> pnv_save_sprs_for_winkle()). R13 bit manipulation in pnv_restore_hyp_resource
>> is related to this.
>
> Right, I didn't realize how that exactly worked until I had to go read
> the code just now. It's a neat little trick. I'm wondering can we use PACA_THREAD_IDLE_STATE==PNV_THREAD_WINKLE for this instead? It would just
> make the early PACA usage in the exception handlers able to use more common
> code.
>

PACA_THREAD_IDLE_STATE will have what was 'requested'. It may not be the
state we are waking up from. For example, if 7 threads of the core execute
winkle instruction while 1 thread of the same core executes sleep. Here
the core only enters sleep whereas PACA_THREAD_IDLE_STATE for the 7 threads
will have PNV_THREAD_WINKLE.

Thanks,
Shreyas
