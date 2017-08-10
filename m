Return-Path: <clg@kaod.org>
Received: from 1.mo179.mail-out.ovh.net (1.mo179.mail-out.ovh.net
 [178.33.111.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSh2W0kGpzDqrx
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 18:22:26 +1000 (AEST)
Received: from player168.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 4DABD5B5A5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 09:04:18 +0200 (CEST)
Subject: Re: [PATCH 02/10] powerpc/xive: guest exploitation of the XIVE
 interrupt controller
To: David Gibson <david@gibson.dropbear.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
 <1502182579-990-3-git-send-email-clg@kaod.org>
 <20170809035306.GC13670@umbus.fritz.box>
 <f82c1111-3dd3-f378-0ff6-222bffc07a35@kaod.org>
 <20170810042849.GU13670@umbus.fritz.box>
 <1502340360.2563.53.camel@kernel.crashing.org>
 <20170810055426.GV13670@umbus.fritz.box>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <9d32d18a-5147-4a90-aa5e-44739a481715@kaod.org>
Date: Thu, 10 Aug 2017 09:04:12 +0200
MIME-Version: 1.0
In-Reply-To: <20170810055426.GV13670@umbus.fritz.box>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2017 07:54 AM, David Gibson wrote:
> On Thu, Aug 10, 2017 at 02:46:00PM +1000, Benjamin Herrenschmidt wrote:
>> On Thu, 2017-08-10 at 14:28 +1000, David Gibson wrote:
>>>
>>> Also, will POWER9 always have doorbells?  In which case you could
>>> reduce it to 3 options.
>>
>> The problem with doorbells on POWER9 guests is that they may have
>> to trap and be emulated by the hypervisor, since the guest threads
>> on P9 don't have to match the HW threads of the core.
>>
>> Thus it's quite possible that using XIVE for IPIs is actually faster
>> than doorbells in that case.
> 
> Ok, well unless there's a compelling reason to use doorbells you can
> instead make it 3 cases with POWER9 never using doorbells.

yes I suppose we could improve things for XIVE. For XICS, there are 
another 3 backends behind icp_ops->cause_ipi. I need to take a look.

Thanks,

C. 
