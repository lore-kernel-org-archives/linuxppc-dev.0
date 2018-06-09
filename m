Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net
 [IPv6:2001:a60:0:28:0:1:25:1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 412rNM05h3zDr3y
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Jun 2018 17:23:14 +1000 (AEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Finn Thain <fthain@telegraphics.com.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v2 08/12] macintosh/via-pmu68k: Don't load driver on
 unsupported hardware
References: <cover.1528423341.git.fthain@telegraphics.com.au>
 <d9d626ca4e7ac9c7e81b24a34f5fbcae9d1d5046.1528423341.git.fthain@telegraphics.com.au>
 <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com>
Date: Sat, 09 Jun 2018 09:14:27 +0200
In-Reply-To: <9f015684-4d91-70e4-d2a4-89fe167ff8ab@gmail.com> (Michael
 Schmitz's message of "Sat, 9 Jun 2018 18:42:25 +1200")
Message-ID: <m2h8mc4ejw.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Jun 09 2018, Michael Schmitz <schmitzmic@gmail.com> wrote:

> Hi Finn,
>
> Am 08.06.2018 um 14:24 schrieb Finn Thain:
>> Don't load the via-pmu68k driver on early PowerBooks. The M50753 PMU
>> device found in those models was never supported by this driver.
>> Attempting to load the driver usually causes a boot hang.
>>
>> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
>> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
>> ---
>>  arch/m68k/mac/misc.c           | 6 ++----
>>  drivers/macintosh/via-pmu68k.c | 4 ----
>>  include/uapi/linux/pmu.h       | 1 -
>>  3 files changed, 2 insertions(+), 9 deletions(-)
> ...
>> diff --git a/include/uapi/linux/pmu.h b/include/uapi/linux/pmu.h
>> index 89cb1acea93a..30f64d46f5db 100644
>> --- a/include/uapi/linux/pmu.h
>> +++ b/include/uapi/linux/pmu.h
>> @@ -93,7 +93,6 @@ enum {
>>  	PMU_HEATHROW_BASED,	/* PowerBook G3 series */
>>  	PMU_PADDINGTON_BASED,	/* 1999 PowerBook G3 */
>>  	PMU_KEYLARGO_BASED,	/* Core99 motherboard (PMU99) */
>> -	PMU_68K_V1,		/* 68K PMU, version 1 */
>>  	PMU_68K_V2, 		/* 68K PMU, version 2 */
>>  };
>
> Is this enum used by any user space code? If so, perhaps rather leave the
> PMU_68K_V1 in there to avoid upsetting that?

It also changes the value of PMU_68K_V2, which is an ABI break.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 7578 EB47 D4E5 4D69 2510  2552 DF73 E780 A9DA AEC1
"And now for something completely different."
