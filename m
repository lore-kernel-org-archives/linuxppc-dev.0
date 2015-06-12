Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f176.google.com (mail-pd0-f176.google.com
 [209.85.192.176])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B88511A08B0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 13 Jun 2015 02:48:06 +1000 (AEST)
Received: by pdjm12 with SMTP id m12so27874809pdj.3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 Jun 2015 09:48:04 -0700 (PDT)
Message-ID: <557B0D3C.6040100@ozlabs.ru>
Date: Sat, 13 Jun 2015 02:47:56 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
CC: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda2: Add devices only from buses
 which belong to PE
References: <1434089957-27135-1-git-send-email-aik@ozlabs.ru>
 <20150612064703.GA17776@gwshan> <20150612150643.GA55122@linux.vnet.ibm.com>
In-Reply-To: <20150612150643.GA55122@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/13/2015 01:06 AM, Nishanth Aravamudan wrote:
> On 12.06.2015 [16:47:03 +1000], Gavin Shan wrote:
>> On Fri, Jun 12, 2015 at 04:19:17PM +1000, Alexey Kardashevskiy wrote:
>>> The existing code puts all devices from a root PE to the same IOMMU group.
>>> However it is a possible situation when subordinate buses belong to
>>> separate PEs, in this case devices from these subordinate buses
>>> should be added to lower level PE rather to the root PE.
>>>
>>> This limits pnv_ioda_setup_bus_dma() invocation to only PEs which own
>>> all subordinate buses.
>>>
>>> Suggested-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>
>> Alexey, I think it's good candidate for stable.
>
> Why? This commit message doesn't imply there is a serious bug just a
> "possible" (does that mean theoretical?) situtation and the following:
>
>>> This would be nice to have together with the DDW patchset.
>>> This does not fix anything DDW patchset did, it fixes IOMMU
>>> groups management which is essential for the whole feature to work.
>
> implies it is both related and independent of DDW?


DDW is for fast devices and I just got my hands on a "firestone" machine 
(p8 + nvidia tesla = very fast machine) where this bug appeared first time.


-- 
Alexey
