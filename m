Return-Path: <clg@kaod.org>
Received: from 8.mo4.mail-out.ovh.net (8.mo4.mail-out.ovh.net [188.165.33.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5zq675SrzDqNm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Oct 2017 00:08:02 +1100 (AEDT)
Received: from player746.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo4.mail-out.ovh.net (Postfix) with ESMTP id 766AABD3C5
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 14:58:25 +0200 (CEST)
Subject: Re: [PATCH 0/2] powerpc/xive: fix CPU hot unplug
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20170923082656.27219-1-clg@kaod.org>
 <378a1945-6263-dca7-3912-b4a2c61794b8@kaod.org>
 <87poa4cw5x.fsf@concordia.ellerman.id.au>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <741baa16-163d-b269-b4ed-7218ef64a166@kaod.org>
Date: Tue, 3 Oct 2017 14:58:19 +0200
MIME-Version: 1.0
In-Reply-To: <87poa4cw5x.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael,

On 10/03/2017 01:23 PM, Michael Ellerman wrote:
> Cédric Le Goater <clg@kaod.org> writes:
> 
>> On 09/23/2017 10:26 AM, Cédric Le Goater wrote:
>>> Hi,
>>>
>>> Here are a couple of small fixes to support CPU hot unplug. There are
>>> still some issues to be investigated as, in some occasions, after a
>>> couple of plug and unplug, the cpu which was removed receives a 'lost'
>>> interrupt. This showed to be the decrementer under QEMU.
>>
>> So this seems to be a QEMU issue only which can be solved by 
>> removing the DEE bit from the LPCR on P9 processor when the CPU 
>> is stopped in rtas. PECE3 bit on P8 processors. 
>>
>> I think these patches are valuable fixes for 4.14. The first 
>> is trivial and the second touches the common xive part but it
>> is only called on the pseries platform.  
>>
>> Could you please take a look ? 
> 
> I can.
> 
> You didn't give me much indication in the change logs of what the
> failure mode is if I _don't_ have the fixes, which makes it hard for me
> to assess the severity.
Support for CPU removal came recently on PowerVM and was not
tested when the patchset was sent. A couple of cleanups of the 
XIVE internal structures are missing resulting in a kernel crash 
when the CPU is released. 

There are still some corner cases when stressing the lpar with 
plug/unplug loops. Investigation in progress.  

> Can you flesh out the ".. or else" case in the change logs?

OK. I will improve patch 2 changelog.

> And should both be tagged?
> 
>   Fixes: eac1e731b59e ("powerpc/xive: guest exploitation of the XIVE interrupt controller")
yes I think so. These patches are too small to be tagged as 
adding hotplug support.

Thanks,

C. 
