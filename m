Return-Path: <gpiccoli@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s7dSy3r3gzDqCb
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Aug 2016 12:26:42 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3s7dSy07Yqz9sf9
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Aug 2016 12:26:41 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u792O5x8108889
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 22:26:40 -0400
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24n8typ8y9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Mon, 08 Aug 2016 22:26:39 -0400
Received: from localhost
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gpiccoli@linux.vnet.ibm.com>;
 Mon, 8 Aug 2016 23:26:37 -0300
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp02.br.ibm.com (Postfix) with ESMTP id 8D0361DC0051
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Aug 2016 22:26:25 -0400 (EDT)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u792QYWo22479314
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 23:26:34 -0300
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u792QYsQ029152
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Aug 2016 23:26:34 -0300
Subject: Re: [PATCH] powerpc/pci: Only do fixed PHB numbering on powernv
To: Michael Ellerman <mpe@ellerman.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1470379256-24266-1-git-send-email-mpe@ellerman.id.au>
 <20160807234824.GA4628@gwshan> <57A88661.2000606@linux.vnet.ibm.com>
 <87bn12srx8.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, chzigotzky@xenosoft.de
From: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Date: Mon, 8 Aug 2016 23:26:33 -0300
MIME-Version: 1.0
In-Reply-To: <87bn12srx8.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <57A93F59.5030204@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/08/2016 09:32 PM, Michael Ellerman wrote:
> "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com> writes:
>
>> On 08/07/2016 08:48 PM, Gavin Shan wrote:
>>> On Fri, Aug 05, 2016 at 04:40:56PM +1000, Michael Ellerman wrote:
>>>> The recent commit 63a72284b159 ("powerpc/pci: Assign fixed PHB number
>>>> based on device-tree properties"), added code to read a 64-bit property
>>> >from the device tree, and if not found read a 32-bit property (reg).
>>>>
>>>> There was a bug in the 32-bit case, on big endian machines, due to the
>>>> use of the 64-bit value to read the 32-bit property. The cast of &prop
>>>> means we end up writing to the high 32-bit of prop, leaving the low
>>>> 32-bits containing whatever junk was on the stack.
>>>>
>>>> If that junk value was non-zero, and < MAX_PHBS, we would end up using
>>>> it as the PHB id.
>>>>
>>>> This exposed a second problem, which is that Xorg can't cope with a
>>>> domain number > 256.
>>>>
>>>> So for now drop the fallback to reg, and only use "ibm,opal-phbid" for
>>>> PHB numbering.
>>>>
>>>> Fixes: 63a72284b159 ("powerpc/pci: Assign fixed PHB number based on device-tree properties")
>>>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>>>> ---
>>>> arch/powerpc/kernel/pci-common.c | 24 +++++++++---------------
>>>> 1 file changed, 9 insertions(+), 15 deletions(-)
>>>>
>>>>
>>>> This is my bad. Guilherme limited the reg case to pseries only, but I made it
>>>> generic. I tested it on G5, Cell etc. which all booted - but that's not really
>>>> a good enough test.
>>
>> Michael and Gavin, thanks very much for fixing and commenting on the
>> issue. I'm sorry about the bug on Big Endian machines, my mistake! I'll
>> fix it in a future patch, but right now I have 2 questions so I can
>> investigate better the issue found on Xorg:
>>
>> (i) What is the specific issue? Do you have some logs or at least a
>> "high-level" description of the problem in Xorg? I took a look in its
>> code and PCI domain is coded as u16, which is correct/expected. So it
>> seems a subtle bug we should investigate and hopefully fix.
>
> It was reported here:
>
>    https://lists.ozlabs.org/pipermail/linuxppc-dev/2016-August/147062.html
>
> It seems xorg just has a hard coded limit of 256 domains.

Thanks for the link Michael. I guess Xorg _had_ this limit in the 
"past", since the function that was logged on error - xf86MapLegacyIO() 
- was removed by a commit of 2014:

https://lists.x.org/archives/xorg-devel/2014-July/043224.html


>> (ii) Why is it related to the absence of pseries check?! You said this
>> was your bad, but as far as I understand, Xorg runs in pSeries too so
>> the issue should also be there heheh
>
> Well yes I guess it would, if anyone had tested Xorg on pseries :)

We use to test Xorg on pSeries regularly; in fact, I made a quick test 
today:

http://imgur.com/a/l1lP8

I forced the domain to be 0xffff as in the above image, and everything 
worked fine.


>> The bug was reported/found in another platform?
>
> Yeah pasemi, see the email above.
>
> On closer inspection I also see it on my G5, ie. the domain numbers are
> random, but the machine doesn't mind (because I don't run xorg).
>
>> As Gavin pointed, the important/interesting part of the patch is related
>> to pSeries, in which we have PHB hotplug and so the patch allows network
>> adapters to work well in PHB hotplug scenario, even if using predictable
>> naming. For now, I guess this fix is pretty good, but would be really
>> important to have this feature on pSeries too - I'll put some effort in
>> solving the Xorg bug.
>
> I think for now I'm going to apply this, and we'll work out something
> else later.
>

OK, I guess your solution is fine and solves the pasemi issue quickly, 
but we should really consider performing fixed assignment of domains on 
pSeries later, since the PHB hotplug operation then can work fine with 
predictable naming of network interfaces.

I'll work in a fix for the endian issue and will test more the patch 
with Xorg, specially in "old" distros still supported in pSeries.

Cheers,


Guilherme
> cheers
>
