Return-Path: <schmitzmic@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 412s5M0FbjzDr3y
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jun 2018 17:55:17 +1000 (AEST)
Received: by mail-pl0-x243.google.com with SMTP id w17-v6so9526373pll.9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 09 Jun 2018 00:55:17 -0700 (PDT)
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
To: Andreas Schwab <schwab@linux-m68k.org>
References: <cover.1528423341.git.fthain@telegraphics.com.au>
 <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
 <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com>
 <m2h8mc4ejw.fsf@linux-m68k.org>
Cc: Finn Thain <fthain@telegraphics.com.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
From: Michael Schmitz <schmitzmic@gmail.com>
Message-ID: <e1006b0a-a429-4744-7525-203cb91f1d5f@gmail.com>
Date: Sat, 9 Jun 2018 19:55:05 +1200
MIME-Version: 1.0
In-Reply-To: <m2h8mc4ejw.fsf@linux-m68k.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Andreas,

Am 09.06.2018 um 19:14 schrieb Andreas Schwab:
> On Jun 09 2018, Michael Schmitz <schmitzmic@gmail.com> wrote:
>
>> Hi Finn,
>>
>> Am 08.06.2018 um 14:24 schrieb Finn Thain:
>>> Don't load the via-pmu68k driver on early PowerBooks. The M50753 PMU
>>> device found in those models was never supported by this driver.
>>> Attempting to load the driver usually causes a boot hang.
>>>
>>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>>> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>>> ---
>>>  arch/m68k/mac/misc.c           | 6 ++----
>>>  drivers/macintosh/via-pmu68k.c | 4 ----
>>>  include/uapi/linux/pmu.h       | 1 -
>>>  3 files changed, 2 insertions(+), 9 deletions(-)
>> ...
>>> diff --git a/include/uapi/linux/pmu.h b/include/uapi/linux/pmu.h
>>> index 89cb1acea93a..30f64d46f5db 100644
>>> --- a/include/uapi/linux/pmu.h
>>> +++ b/include/uapi/linux/pmu.h
>>> @@ -93,7 +93,6 @@ enum {
>>>  	PMU_HEATHROW_BASED,	/* PowerBook G3 series */
>>>  	PMU_PADDINGTON_BASED,	/* 1999 PowerBook G3 */
>>>  	PMU_KEYLARGO_BASED,	/* Core99 motherboard (PMU99) */
>>> -	PMU_68K_V1,		/* 68K PMU, version 1 */
>>>  	PMU_68K_V2, 		/* 68K PMU, version 2 */
>>>  };
>>
>> Is this enum used by any user space code? If so, perhaps rather leave the
>> PMU_68K_V1 in there to avoid upsetting that?
>
> It also changes the value of PMU_68K_V2, which is an ABI break.

Yes, that's what I worry about - but do we know of any users of that 
particular interface?

Cheers,

	Michael

>
> Andreas.
>
