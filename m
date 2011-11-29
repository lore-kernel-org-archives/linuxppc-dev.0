Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE003.bigfish.com (va3ehsobe003.messaging.microsoft.com
 [216.32.180.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id B22341007FA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2011 06:49:40 +1100 (EST)
Message-ID: <4ED53748.3060801@freescale.com>
Date: Tue, 29 Nov 2011 13:49:28 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Li Yang-R58472 <r58472@freescale.com>
Subject: Re: [PATCH][RFC] fsldma: fix performance degradation by optimizing
 spinlock use.
References: <1321937705-19587-1-git-send-email-b29237@freescale.com>
 <20111122185924.GA23323@ovro.caltech.edu>
 <DBB740589CE8814680DECFE34BE197AB148CDD@039-SN1MPN1-006.039d.mgd.msft.net>
 <20111128163814.GA10919@ovro.caltech.edu>
 <3F607A5180246847A760FD34122A1E052E07B7@039-SN1MPN1-003.039d.mgd.msft.net>
In-Reply-To: <3F607A5180246847A760FD34122A1E052E07B7@039-SN1MPN1-003.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Cc: "Ira W. Snyder" <iws@ovro.caltech.edu>,
 "vinod.koul@intel.com" <vinod.koul@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Shi Xuelin-B29237 <B29237@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/28/2011 09:19 PM, Li Yang-R58472 wrote:
>> Subject: Re: [PATCH][RFC] fsldma: fix performance degradation by optimizing
>> spinlock use.
>>
>> On Thu, Nov 24, 2011 at 08:12:25AM +0000, Shi Xuelin-B29237 wrote:
>>> Hi Ira,
>>>
>>> Thanks for your review.
>>>
>>> After second thought, I think your scenario may not occur.
>>> Because the cookie 20 we query must be returned by fsl_dma_tx_submit(...) in
>> practice.
>>> We never query a cookie not returned by fsl_dma_tx_submit(...).
>>>
>>
>> I agree about this part.
>>
>>> When we call fsl_tx_status(20), the chan->common.cookie is definitely wrote as
>> 20 and cpu2 could not read as 19.
>>>
>>
>> This is what I don't agree about. However, I'm not an expert on CPU cache vs.
>> memory accesses in an multi-processor system. The section titled "CACHE
>> COHERENCY" in Documentation/memory-barriers.txt leads me to believe that the
>> scenario I described is possible.
> 
> For Freescale PowerPC, the chip automatically takes care of cache coherency.  Even if this is a concern, spinlock can't address it.

Cache coherency is not the same thing as ordering -- and spinlocks do
address ordering, because there are memory barriers in the lock
implementation.

If you're relying on some non-universal ordering guarantee that all
chips with this device make, it needs to be documented explicitly what
you're assuming and why it's valid.

-Scott
