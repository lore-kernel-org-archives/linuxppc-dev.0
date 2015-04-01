Return-Path: <sowmini.varadhan@oracle.com>
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 694221A0729
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Apr 2015 12:08:28 +1100 (AEDT)
Message-ID: <551B4502.1020603@oracle.com>
Date: Tue, 31 Mar 2015 21:08:18 -0400
From: Sowmini Varadhan <sowmini.varadhan@oracle.com>
Reply-To: sowmini.varadhan@oracle.com
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v8 RFC 0/3] Generic IOMMU pooled allocator
References: <cover.1427761300.git.sowmini.varadhan@oracle.com>	
 <20150331180642.GA13314@oracle.com>
 <1427850091.20500.150.camel@kernel.crashing.org>
In-Reply-To: <1427850091.20500.150.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Cc: aik@au1.ibm.com, anton@au1.ibm.com, paulus@samba.org,
 sparclinux@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/31/2015 09:01 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2015-03-31 at 14:06 -0400, Sowmini Varadhan wrote:
>> Having bravely said that..
>>
>> the IB team informs me that they see a 10% degradation using
>> the spin_lock as opposed to the trylock.
>>
>> one path going forward is to continue processing this patch-set
>> as is. I can investigate this further, and later revise the spin_lock
>> to the trylock, after we are certain that it is good/necessary.
>
> Have they tried using more pools instead ?


we just tried 32 instead of 16, no change to perf.

Looks like their current bottleneck is the find_next_zero_bit (they
can get a 2X perf improvement with the lock fragmentation, but are
then hitting a new ceiling, even with the trylock version)


I'm starting to wonder if  some approximation of dma premapped
buffers may be needed. Doing a map/unmap on each packet is expensive.
