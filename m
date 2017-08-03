Return-Path: <clg@kaod.org>
Received: from 13.mo1.mail-out.ovh.net (13.mo1.mail-out.ovh.net
 [178.33.253.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNcnj1V4nzDq7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 03:42:10 +1000 (AEST)
Received: from player795.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id 9BC4189FAB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 14:55:54 +0200 (CEST)
Subject: Re: [PATCH] powerpc/xive: fix the fuzz value in xive_pick_irq_target()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
References: <1501692230-20789-1-git-send-email-clg@kaod.org>
 <1501711052.2664.7.camel@kernel.crashing.org>
 <62a8ad99-137f-765c-aa1b-ad5ba22231d0@kaod.org>
 <1501747359.2664.41.camel@kernel.crashing.org>
 <87efstq8qd.fsf@concordia.ellerman.id.au>
 <1501761126.2664.42.camel@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <b7d2a634-9e8c-bb36-e23b-bc45db49d46d@kaod.org>
Date: Thu, 3 Aug 2017 14:55:43 +0200
MIME-Version: 1.0
In-Reply-To: <1501761126.2664.42.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/03/2017 01:52 PM, Benjamin Herrenschmidt wrote:
> On Thu, 2017-08-03 at 19:52 +1000, Michael Ellerman wrote:
>> What if num is 0?
>>
>> Which it would be in the fallback case, if the affinity mask is empty,
>> AFAICS.
> 
> How can the mask be empty though ? But yes, as I noted there is a
> problem if the value is 0. Not sure what to do if we are given an empty
> mask though.

I am seeing different problems. 

The fuzz value was one but that was due to the fact that the spapr 
backend did not set the chip_id of the xive_irq_data. I should have 
fix that now. But in some other situations, the weight of the 
'affinity' mask is 2048 (and 'nr_cpu_ids') and that also breaks 
the 'first' calculation. 

I am currently tracking this with the xive support for spapr. I will 
send a fix with the patchset.

Thanks,

C.   
