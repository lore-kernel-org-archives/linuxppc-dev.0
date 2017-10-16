Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com
 [IPv6:2607:f8b0:400c:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFnGZ5tHkzDrFw
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 16:40:22 +1100 (AEDT)
Received: by mail-vk0-x242.google.com with SMTP id d12so3658415vkf.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 22:40:22 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87infflkjm.fsf@concordia.ellerman.id.au>
References: <20170929042655.14570-1-bsingharora@gmail.com>
 <20170929042655.14570-6-bsingharora@gmail.com>
 <87infflkjm.fsf@concordia.ellerman.id.au>
From: Balbir Singh <bsingharora@gmail.com>
Date: Mon, 16 Oct 2017 16:40:19 +1100
Message-ID: <CAKTCnzkH=5i23F9v2t-VLZET2HV86NP8u=rx9gEswG5COTJ1kw@mail.gmail.com>
Subject: Re: [PATCH v4 5/5] powerpc/mce: hookup memory_failure for UE errors
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 16, 2017 at 4:38 PM, Michael Ellerman <mpe@ellerman.id.au> wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
>
>> If we are in user space and hit a UE error, we now have the
>> basic infrastructure to walk the page tables and find out
>> the effective address that was accessed, since the DAR
>> is not valid.
>>
>> We use a work_queue content to hookup the bad pfn, any
>> other context causes problems, since memory_failure itself
>> can call into schedule() via lru_drain_ bits.
>>
>> We could probably poison the struct page to avoid a race
>> between detection and taking corrective action.
>>
>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>>  arch/powerpc/kernel/mce.c | 70 +++++++++++++++++++++++++++++++++++++++++++++--
>>  1 file changed, 67 insertions(+), 3 deletions(-)
>
> I'm not sure why this is in mce.c but the rest was in mce_power.c ?

The way the code is organized is that save_mce_event is implemented here
and called from mce_power.c. save_mce_event() does the processing
of the event.

Balbir Singh.
