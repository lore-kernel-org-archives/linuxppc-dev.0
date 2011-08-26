Return-Path: <B25806@freescale.com>
Received: from TX2EHSOBE007.bigfish.com (tx2ehsobe004.messaging.microsoft.com
	[65.55.88.14]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D010B6F9B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Aug 2011 18:43:01 +1000 (EST)
Content-Type: text/plain; charset="utf-8"; format=flowed; delsp=yes
To: Kyungmin Park <kmpark@infradead.org>, Chunhe Lan <Chunhe.Lan@freescale.com>
Subject: Re: [PATCH 2/2] mmc: Use mmc_delay() instead of mdelay() for time
	delay
References: <1314262479-32520-1-git-send-email-Chunhe.Lan@freescale.com>
	<CAH9JG2VUA_5c=3LPEvoVmTrYN9WibY87AgEkNgV3uFpAS0euQA@mail.gmail.com>
Date: Fri, 26 Aug 2011 16:45:53 +0800
MIME-Version: 1.0
From: Lan Chunhe <b25806@freescale.com>
Message-ID: <op.v0tbyr18z91x4h@localhost.localdomain>
In-Reply-To: <CAH9JG2VUA_5c=3LPEvoVmTrYN9WibY87AgEkNgV3uFpAS0euQA@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, kumar.gala@freescale.com,
	Chris Ball <cjb@laptop.org>, linux-mmc@vger.kernel.org,
	Shengzhou Liu <b36685@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 25 Aug 2011 18:23:35 +0800, Kyungmin Park <kmpark@infradead.org>  
wrote:

> On Thu, Aug 25, 2011 at 5:54 PM, Chunhe Lan <Chunhe.Lan@freescale.com>  
> wrote:
>> The mmc_delay() is a wrapper function for mdelay() and msleep().
>>
>>    o mdelay() -- block the system when busy-waiting.
>>    o msleep() -- suspend the currently running task to enable CPU
>>                  to process other tasks, so it is non-blocking
>>                  regarding the whole system.
>>
>> When the desired delay time is more than a period of timer interrupt,
>> just use msleep(). Change mdelay() to mmc_delay() to avoid chewing
>> CPU when busy wait.
>>
>> Signed-off-by: Shengzhou Liu <b36685@freescale.com>
>> Signed-off-by: Chunhe Lan <Chunhe.Lan@freescale.com>
>> Cc: Chris Ball <cjb@laptop.org>
>> ---
>>  drivers/mmc/host/sdhci.c |   11 ++++++-----
>>  1 files changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c
>> index 0e02cc1..0cb5dc1 100644
>> --- a/drivers/mmc/host/sdhci.c
>> +++ b/drivers/mmc/host/sdhci.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/mmc/host.h>
>>
>>  #include "sdhci.h"
>> +#include "../core/core.h"
>
> Doesn't better to move the mmc_delay() to "include/linux/mmc/core.h"?
> and include it.
> I think It's not proper include syntax using relative path.

    Yes, your suggestion is very good.
    I will move the mmc_delay() to "include/linux/mmc/core.h" .

    Thanks.

    -Jack Lan

> Thank you,
> Kyungmin Park
>>
>>  #define DRIVER_NAME "sdhci"
>>
