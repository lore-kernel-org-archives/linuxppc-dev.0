Return-Path: <schmitzmic@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 413VmY4HWCzDr30
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2018 19:13:00 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id a11-v6so8701354pff.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Jun 2018 02:13:00 -0700 (PDT)
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
To: Geert Uytterhoeven <geert@linux-m68k.org>,
 Finn Thain <fthain@telegraphics.com.au>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
 <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
 <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com>
 <m2h8mc4ejw.fsf@linux-m68k.org>
 <e1006b0a-a429-4744-7525-203cb91f1d5f@gmail.com>
 <alpine.LNX.2.21.1806092140410.26@nippy.intranet>
 <CAMuHMdUHnFKzhe3x3=bG63HwnM7psu7AA=nba8q+nTDnxBAryw@mail.gmail.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-m68k <linux-m68k@lists.linux-m68k.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <3187b544-e265-dfd9-e0e3-e2a742c190d5@gmail.com>
Date: Sun, 10 Jun 2018 21:12:50 +1200
MIME-Version: 1.0
In-Reply-To: <CAMuHMdUHnFKzhe3x3=bG63HwnM7psu7AA=nba8q+nTDnxBAryw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Geert,

Am 10.06.2018 um 20:29 schrieb Geert Uytterhoeven:
> Hi Finn,
>
> On Sat, Jun 9, 2018 at 2:20 PM Finn Thain <fthain@telegraphics.com.au> wrote:
>>>>> Is this enum used by any user space code? If so, perhaps rather
>>>>> leave the PMU_68K_V1 in there to avoid upsetting that?
>>>>
>>>> It also changes the value of PMU_68K_V2, which is an ABI break.
>>>
>>> Yes, that's what I worry about - but do we know of any users of that
>>> particular interface?
>>
>> There is no ABI issue AFAIK. The value of pmu_kind is visible to userland
>> only on powerpc. /dev/pmu and /proc/pmu/* do not exist on m68k. This patch
>> series will make these UAPIs available on m68k, and for that reason I've
>> chosen the value PMU_UNKNOWN for pmu_kind.
>
> While /dev/pmu and /proc/pmu/* may not exist on m68k, definitions in
> include/uapi/linux/pmu.h are part of the ABI, and cannot be changed or removed,
> unless we are 100% sure there are no users.
>
> If I would write a program interfacing with /dev/pmu and /proc/pmu/*, and
> needing to check the PMU type, it would have a switch() statement with
> all existing values defined in <linux/pmu.h>. So that would become broken
> by your change.
>
> Hence the enum is append-only.

The PMU type from pmu.h was never exposed to user space on m68k via 
/proc/pmu/*, and /dev/pmu is used for ioctls to the PMU driver on 
powerpc only (the 68k PMU driver doesn't have ioctl support). No way 
that I can see for user space to make use of the PMU type definition 
from pmu.h, so I suppose we can be sure there are no users.

The m68k PMU types cannot be said to be exposed on powerpc either (which 
has ioctl support to interrogate the PMU type), as these only return 
values up to PMU_KEYLARGO_BASED.

Applications like pbbuttonsd or pmud don't use the kernel PMU type at 
all, but go straight to the PMU via the ADB bus to interrogate the 
hardware type, so won't be affected either.

Is there any other way besides procfs and ioctl for user space to 
interrogate the PMU type that I'm missing here?

(I understand that breaking the ABI should not be done as a rule, but 
this may be a case where we can successfully argue the definitions were 
never in use, so the rules may be bent a little).

Cheers,

	Michael


>> New pmu_kind values can be defined as and when the need arises. But that
>> would imply a useful classification scheme for pre-PCI powerbooks, and I
>> don't know what that scheme will look like because at this stage there is
>> neither userland nor kernel code to support backlight, buttons and battery
>> for pre-PCI powerbooks.
>>
>> In anycase, the "v1" and "v2" scheme is obviously inadequate when you
>> consider the range of m68k powerbook models. Also, consider the
>
> New values can be added at the bottom.
>
>> out-of-tree adaptation of via-pmu by the Nubus-PMac project, which has
>> this ABI break:
>>
>> diff --git a/include/linux/pmu.h b/include/linux/pmu.h
>> index cafe98d9694..9882a185a52 100644
>> --- a/include/linux/pmu.h
>> +++ b/include/linux/pmu.h
>> @@ -90,6 +90,7 @@ enum {
>>          PMU_HEATHROW_BASED,     /* PowerBook G3 series */
>>          PMU_PADDINGTON_BASED,   /* 1999 PowerBook G3 */
>>          PMU_KEYLARGO_BASED,     /* Core99 motherboard (PMU99) */
>> +        PMU_NUBUS_BASED,        /* 1400, 2300, 5300 */
>>          PMU_68K_V1,             /* 68K PMU, version 1 */
>>          PMU_68K_V2,             /* 68K PMU, version 2 */
>>  };
>
> That's bad.  But as long as the NuBus-PMac project is out-of-tree, the
> enum values it uses are not part of the Linux ABI, IMHO.
> During upstreaming, PMU_NUBUS_BASED should be moved to the bottom.
>
> Gr{oetje,eeting}s,
>
>                         Geert
>
