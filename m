Return-Path: <monstr@monstr.eu>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by ozlabs.org (Postfix) with ESMTP id 20C65DDFB6
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 22:59:21 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id e21so390778fga.16
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 05:59:19 -0700 (PDT)
Message-ID: <49E87D25.8090001@monstr.eu>
Date: Fri, 17 Apr 2009 14:59:17 +0200
From: Michal Simek <monstr@monstr.eu>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Proposed prom parse fix + moving.
References: <49E81CED.1000704@monstr.eu>
	<fa686aa40904162344y67115e50lf48c174501120b30@mail.gmail.com>
In-Reply-To: <fa686aa40904162344y67115e50lf48c174501120b30@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: ilpo.jarvinen@helsinki.fi, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Arnd Bergmann <arnd@arndb.de>
Reply-To: monstr@monstr.eu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Fri, Apr 17, 2009 at 12:08 AM, Michal Simek <monstr@monstr.eu> wrote:
>> Hi All,
>>
>> I have got email from Ilpo about prom_parse file.
>> I take this file from powerpc. Who did write prom_parse file and take care about?
> 
> Posting to the linuxppc-dev list is sufficient to start.  There are
> several people who may be interested.
> 
>> BTW: What about to move prom_parse file to any generic location as we discussed in past?
>> Any volunteer?
> 
> I'm kind of working on it.  More specifically, I'm looking at
> factoring out fdt stuff into common code (drivers/of/of_fdt.c). But I
> haven't made a whole lot of progress yet.
> 
>> -------- Original Message --------
>> Subject: [RFC!] [PATCH] microblaze: fix bug in error handling
>> Date: Thu, 16 Apr 2009 23:05:53 +0300 (EEST)
>> From: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
>> To: monstr@monstr.eu
>> CC: microblaze-uclinux@itee.uq.edu.au
>>
>> While some version of the patches were on the lkml I read
>> some part of the code briefly through but my feedback got
>> stuck into postponed emails, so here's one correctness
>> related issue I might have found (the rest were just
>> cosmetic things).
>>
>> I'm not sure if the latter return needs the of_node_put or not
>> but it seems more likely than not.
> 
> Yes, it does.  This change is applicable to
> arch/powerpc/kernel/prom_parse.c too.

ok.
Ilpo: Can you create patch for both architectures?

Thanks,
Michal


> 
>> Not even compile tested.
>>
>> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@helsinki.fi>
>> ---
>>  arch/microblaze/kernel/prom_parse.c |   11 +++++++----
>>  1 files changed, 7 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/microblaze/kernel/prom_parse.c b/arch/microblaze/kernel/prom_parse.c
>> index ae0352e..d1174bc 100644
>> --- a/arch/microblaze/kernel/prom_parse.c
>> +++ b/arch/microblaze/kernel/prom_parse.c
>> @@ -927,20 +927,23 @@ int of_irq_map_one(struct device_node *device,
>>        /* Get size of interrupt specifier */
>>        tmp = of_get_property(p, "#interrupt-cells", NULL);
>>        if (tmp == NULL) {
>> -               of_node_put(p);
>> -               return -EINVAL;
>> +               res = -EINVAL;
>> +               goto out;
>>        }
>>        intsize = *tmp;
>>
>>        pr_debug(" intsize=%d intlen=%d\n", intsize, intlen);
>>
>>        /* Check index */
>> -       if ((index + 1) * intsize > intlen)
>> -               return -EINVAL;
>> +       if ((index + 1) * intsize > intlen) {
>> +               res = -EINVAL;
>> +               goto out;
>> +       }
>>
>>        /* Get new specifier and map it */
>>        res = of_irq_map_raw(p, intspec + index * intsize, intsize,
>>                                addr, out_irq);
>> +out:
>>        of_node_put(p);
>>        return res;
>>  }
>> --
>> 1.5.6.5
>>
>>
>> --
>> Michal Simek, Ing. (M.Eng)
>> w: www.monstr.eu p: +42-0-721842854
>>
> 
> 
> 


-- 
Michal Simek, Ing. (M.Eng)
w: www.monstr.eu p: +42-0-721842854
