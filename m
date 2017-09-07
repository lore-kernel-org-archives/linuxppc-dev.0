Return-Path: <srs0=+wik=ai=gmail.com=bsingharora@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnk3R0HTFzDrVm
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 11:52:19 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3xnk3Q6hWFz8shS
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 11:52:18 +1000 (AEST)
Received: from mail-ua0-x242.google.com (mail-ua0-x242.google.com
 [IPv6:2607:f8b0:400c:c08::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3xnk3Q183Xz9s8J
 for <linuxppc-dev@ozlabs.org>; Thu,  7 Sep 2017 11:52:17 +1000 (AEST)
Received: by mail-ua0-x242.google.com with SMTP id q29so2696176uaf.4
 for <linuxppc-dev@ozlabs.org>; Wed, 06 Sep 2017 18:52:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1504738572.2371.3.camel@au1.ibm.com>
References: <20170905041555.27696-1-bsingharora@gmail.com>
 <20170905041555.27696-3-bsingharora@gmail.com>
 <1504738572.2371.3.camel@au1.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Thu, 7 Sep 2017 11:52:14 +1000
Message-ID: <CAKTCnzkiRDQmtKJ1htDh9m7JoHcbHHTm5W-8GbfSa-cWv6m55A@mail.gmail.com>
Subject: Re: [rfc 2/3] powerpc/mce: Extract physical_address for UE errors
To: Benjamin Herrenschmidt <benh@au1.ibm.com>
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Alistair Popple <alistair@popple.id.au>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 7, 2017 at 8:56 AM, Benjamin Herrenschmidt <benh@au1.ibm.com> wrote:
> On Tue, 2017-09-05 at 14:15 +1000, Balbir Singh wrote:
>>  void save_mce_event(struct pt_regs *regs, long handled,
>>                     struct mce_error_info *mce_err,
>> -                   uint64_t nip, uint64_t addr)
>> +                   uint64_t nip, uint64_t addr, uint64_t phys_addr)
>>  {
>>         int index = __this_cpu_inc_return(mce_nest_count) - 1;
>>         struct machine_check_event *mce = this_cpu_ptr(&mce_event[index]);
>> @@ -140,6 +140,10 @@ void save_mce_event(struct pt_regs *regs, long handled,
>>         } else if (mce->error_type == MCE_ERROR_TYPE_UE) {
>>                 mce->u.ue_error.effective_address_provided = true;
>>                 mce->u.ue_error.effective_address = addr;
>> +               if (phys_addr != ULONG_MAX) {
>> +                       mce->u.ue_error.physical_address_provided = true;
>> +                       mce->u.ue_error.physical_address = phys_addr;
>> +               }
>>         }
>>         return;
>
> Where is "addr" coming from ? Keep in mind that on P9 at least, a UE
> will *not* give you an EA in DAR in most cases.

The EA is derived in mce_handle_derror() via page table walk and
analyse_instr(), its the best
we can do FWIK

Balbir Singh.
