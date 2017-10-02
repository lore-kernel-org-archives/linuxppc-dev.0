Return-Path: <clg@kaod.org>
Received: from 10.mo179.mail-out.ovh.net (10.mo179.mail-out.ovh.net
 [46.105.79.46])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y5VBh3QTxzDqhf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Oct 2017 04:53:15 +1100 (AEDT)
Received: from player168.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 7CF6D6CFBD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Oct 2017 19:53:12 +0200 (CEST)
Subject: Re: [PATCH 0/2] powerpc/xive: fix CPU hot unplug
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20170923082656.27219-1-clg@kaod.org>
 <378a1945-6263-dca7-3912-b4a2c61794b8@kaod.org>
 <1506963157.25065.48.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <1975733a-4c69-a35b-525e-eed1f0d4458c@kaod.org>
Date: Mon, 2 Oct 2017 19:53:06 +0200
MIME-Version: 1.0
In-Reply-To: <1506963157.25065.48.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/02/2017 06:52 PM, Benjamin Herrenschmidt wrote:
> On Mon, 2017-10-02 at 18:27 +0200, Cédric Le Goater wrote:
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
> 
> It should be the same bit no ?

yes and it is for the QEMU side of the world. 

C.
 
>> I think these patches are valuable fixes for 4.14. The first 
>> is trivial and the second touches the common xive part but it
>> is only called on the pseries platform.  
>>
>> Could you please take a look ? 
>>
>> Thanks,
>>
>> C. 
>>
>>> Nevertheless, these patches are required and provide a significant
>>> improvement to support CPU removal.
>>>
>>> Tested under a phyp and a XIVE QEMU model for pseries.
>>>
>>> Thanks,
>>>
>>> C.
>>>
>>> Cédric Le Goater (2):
>>>   powerpc/xive: fix IPI reset
>>>   powerpc/xive: fix cpu removal
>>>
>>>  arch/powerpc/sysdev/xive/common.c | 8 ++++++++
>>>  arch/powerpc/sysdev/xive/spapr.c  | 4 ++++
>>>  2 files changed, 12 insertions(+)
>>>
