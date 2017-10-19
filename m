Return-Path: <clg@kaod.org>
Received: from 3.mo5.mail-out.ovh.net (3.mo5.mail-out.ovh.net [46.105.40.108])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHqR74z82zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Oct 2017 00:24:50 +1100 (AEDT)
Received: from player786.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo5.mail-out.ovh.net (Postfix) with ESMTP id BE965145E7A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 15:09:17 +0200 (CEST)
Subject: Re: [PATCH] powerpc/xmon: check before calling xive functions
To: benh@au1.ibm.com, Michael Ellerman <mpe@ellerman.id.au>,
 Breno Leitao <leitao@debian.org>, linuxppc-dev@lists.ozlabs.org
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>
References: <1508264418-13448-1-git-send-email-leitao@debian.org>
 <87vajchamw.fsf@concordia.ellerman.id.au>
 <1508397046.25065.313.camel@au1.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <0118c6e2-b589-3280-c9c9-9bf906d78f5e@kaod.org>
Date: Thu, 19 Oct 2017 15:09:12 +0200
MIME-Version: 1.0
In-Reply-To: <1508397046.25065.313.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/19/2017 09:10 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2017-10-19 at 00:02 +1100, Michael Ellerman wrote:
>> Breno Leitao <leitao@debian.org> writes:
>>
>>> Currently xmon could call XIVE functions from OPAL even if the XIVE is
>>> disabled or does not exist in the system, as in POWER8 machines.  This
>>> causes the following exception:
>>>
>>>  1:mon> dx
>>>  cpu 0x1: Vector: 700 (Program Check) at [c000000423c93450]
>>>      pc: c00000000009cfa4: opal_xive_dump+0x50/0x68
>>>      lr: c0000000000997b8: opal_return+0x0/0x50
>>>
>>> This patch simply checks if XIVE is enabled before calling XIVE
>>> functions.
>>
>> Thanks. I'll merge this.
>>
>> But we should also fix it in skiboot.
> 
> No that's wrong. xive_enabled() is only set if Linux is using native
> xive mode but some of those xmon functions dump the emulated state.
> 
> We should fix the actual cause of the crash.

which should be in the OPAL XIVE dump routines then ? 

Cheers 
C. 

> 
> Cheers,
> Ben.
> 
>> cheers
>>
>>> Suggested-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>
>>> Signed-off-by: Breno Leitao <leitao@debian.org>
>>> ---
>>>  arch/powerpc/xmon/xmon.c | 6 ++++++
>>>  1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
>>> index 4679aeb84767..b34976c4a6ba 100644
>>> --- a/arch/powerpc/xmon/xmon.c
>>> +++ b/arch/powerpc/xmon/xmon.c
>>> @@ -2508,6 +2508,12 @@ static void dump_xives(void)
>>>  	unsigned long num;
>>>  	int c;
>>>  
>>> +	if (!xive_enabled()) {
>>> +		printf("Xive disabled on this system\n");
>>> +
>>> +		return;
>>> +	}
>>> +
>>>  	c = inchar();
>>>  	if (c == 'a') {
>>>  		dump_all_xives();
>>> -- 
>>> 2.14.2
> 
