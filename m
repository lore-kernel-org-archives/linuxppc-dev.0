Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1FF91A037B
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2015 09:26:22 +1000 (AEST)
Received: from /spool/local
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Fri, 18 Sep 2015 17:26:20 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id DA5A11FF0042
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 17:17:26 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t8INP9Jn41681056
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 16:25:09 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8INQGGf016424
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Sep 2015 17:26:17 -0600
Content-Type: text/plain; charset=windows-1252
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH v2 09/30] cxlflash: Fix to stop interrupt processing on
 remove
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <55FBFC8B.9060305@redhat.com>
Date: Fri, 18 Sep 2015 18:26:16 -0500
Cc: linux-scsi@vger.kernel.org, James.Bottomley@HansenPartnership.com,
 nab@linux-iscsi.org, brking@linux.vnet.ibm.com, imunsie@au1.ibm.com,
 dja@ozlabs.au.ibm.com, andrew.donnellan@au1.ibm.com, mikey@neuling.org,
 linuxppc-dev@lists.ozlabs.org, "Manoj N. Kumar" <manoj@linux.vnet.ibm.com>
Message-Id: <95497861-11B5-4A04-A35C-D6FE164543C4@linux.vnet.ibm.com>
References: <1442422399-41262-1-git-send-email-mrochs@linux.vnet.ibm.com>
 <55FAB43B.8050306@redhat.com>
 <97A059A7-2054-4DBD-B993-BBF47AC105E0@linux.vnet.ibm.com>
 <55FBFC8B.9060305@redhat.com>
To: Tomas Henzl <thenzl@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Sep 18, 2015, at 6:59 AM, Tomas Henzl <thenzl@redhat.com> wrote:
> On 17.9.2015 19:16, Matthew R. Ochs wrote:
>>> On Sep 17, 2015, at 7:38 AM, Tomas Henzl <thenzl@redhat.com> wrote:
>>>=20
>>> On 16.9.2015 18:53, Matthew R. Ochs wrote:
>>>> Interrupt processing can run in parallel to a remove operation. =
This
>>>> can lead to a condition where the interrupt handler is processing =
with
>>>> memory that has been freed.
>>>>=20
>>>> To avoid processing an interrupt while memory may be yanked, check =
for
>>>> removal while in the interrupt handler. Bail when removal is =
imminent.
>>>>=20
>>>> Signed-off-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
>>>> Signed-off-by: Manoj N. Kumar <manoj@linux.vnet.ibm.com>
>>>> ---
>>>> drivers/scsi/cxlflash/common.h |  2 ++
>>>> drivers/scsi/cxlflash/main.c   | 21 +++++++++++++++------
>>>> 2 files changed, 17 insertions(+), 6 deletions(-)
>>>>=20
>>>> diff --git a/drivers/scsi/cxlflash/common.h =
b/drivers/scsi/cxlflash/common.h
>>>> index 1abe4e0..03d2cc6 100644
>>>> --- a/drivers/scsi/cxlflash/common.h
>>>> +++ b/drivers/scsi/cxlflash/common.h
>>>> @@ -103,6 +103,8 @@ struct cxlflash_cfg {
>>>> 	enum cxlflash_lr_state lr_state;
>>>> 	int lr_port;
>>>>=20
>>>> +	atomic_t remove_active;
>>>> +
>>>> 	struct cxl_afu *cxl_afu;
>>>>=20
>>>> 	struct pci_pool *cxlflash_cmd_pool;
>>>> diff --git a/drivers/scsi/cxlflash/main.c =
b/drivers/scsi/cxlflash/main.c
>>>> index 6e85c77..89ee648 100644
>>>> --- a/drivers/scsi/cxlflash/main.c
>>>> +++ b/drivers/scsi/cxlflash/main.c
>>>> @@ -892,6 +892,7 @@ static void cxlflash_remove(struct pci_dev =
*pdev)
>>>> 	spin_unlock_irqrestore(&cfg->tmf_waitq.lock, lock_flags);
>>>>=20
>>>> 	cfg->state =3D STATE_FAILTERM;
>>>> +	atomic_inc(&cfg->remove_active);
>>> Hi Matthew,
>>> you could just call term_afu at this point, this way you don't
>>> need an additional check in all irq functions.
>>> Cheers,
>>> Tomas
>> Hi Tomas,
>>=20
>> We actually do call term_afu() a few lines down from here. I don't =
follow
>> how moving it here would help things.
>=20
> When you disable ints sooner (that is what term_afu does ?) you'll get =
no
> more ints later isn't this what you want?

Correct, that's what we want.

>> The reason for the atomic was to provide something lightweight that =
we
>> could check _inside_ the processing loop for the read-response queue
>> handler. A check outside that loop doesn't really provide much in =
terms
>> of closing or narrowing down the window of when freed memory can be
>> accessed.
>>=20
>> As David Laight correctly pointed out, this approach does not =
completely
>> close the window. We'd need something heavier to fully protect (e.g. =
a lock
>> to wrap around the entire loop). I will look into adding this in a =
future cycle
>> when I can adequately test.
>=20
> term_afu calls free_irq and this function
> does not return until any executing interrupts for have completed.
> This is the sync mechanism you need, it's lightweight
> (does not add an additional check to your irq functions)
> and closes the race window completely.

Thanks for clarifying!

I looked at this closer and you are correct, free_irq() guarantees not
to return until the interrupt handler has completed. The current =
location
of term_afu() is appropriate as the memory that the handler touches is
not freed until the very end [by free_mem() and scsi_host_put()] of the
remove. Thus we can simply ignore this patch (I'll remove it in a v3).


-matt
