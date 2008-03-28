Return-Path: <pbadari@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 261A8DE60A
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Mar 2008 03:52:36 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2SGqX83028919
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 12:52:33 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2SGqXta192482
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 10:52:33 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2SGqWxC020794
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 10:52:33 -0600
Message-ID: <47ED2249.3070602@us.ibm.com>
Date: Fri, 28 Mar 2008 09:52:25 -0700
From: Badari Pulavarty <pbadari@us.ibm.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/5] [PPC] update lmb for hotplug memory add/remove
References: <1206664406.19368.2.camel@dyn9047017100.beaverton.ibm.com>
	<1206664759.19368.11.camel@dyn9047017100.beaverton.ibm.com>
	<EA08C942-E156-410D-8ADA-7A4812B20221@kernel.crashing.org>
In-Reply-To: <EA08C942-E156-410D-8ADA-7A4812B20221@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulus@samba.org, lkml <linux-kernel@vger.kernel.org>,
	Yasunori Goto <y-goto@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>
> On Mar 27, 2008, at 7:39 PM, Badari Pulavarty wrote:
>> ppc kernel maintains information about logical memory blocks in
>> lmb.memory structure at the boot time. Its not updated for
>> hotplug memory add/remove. hotplug memory notifier for memory
>> add/remove now updates lmb.memory.
>>
>> This information is useful for eHEA driver to find out the memory
>> layout and holes.
>>
>> NOTE: No special locking is needed for lmb_add() and lmb_remove().
>> Calls to these are serialized by caller. (pSeries_reconfig_chain).
>>
>> Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
>> ---
>> arch/powerpc/platforms/pseries/hotplug-memory.c |   43 +++++++++++++++
>> include/linux/lmb.h                             |    3 -
>> lib/lmb.c                                       |   66 
>> ++++++++++++++++++++----
>> 3 files changed, 102 insertions(+), 10 deletions(-)
>
> How is lmb_remove different than lmb_alloc?
>
> - k
lmb_remove() can be used to punch a hole in to the existing memory block.
lmb_alloc() tries to allocate for a given alignment, I don't think it can
adjust the current entries. Isn't it ?

Thanks,
Badari
