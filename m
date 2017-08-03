Return-Path: <clg@kaod.org>
Received: from 10.mo1.mail-out.ovh.net (10.mo1.mail-out.ovh.net
 [178.32.96.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNNMR1JNrzDqjf
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 18:22:10 +1000 (AEST)
Received: from player795.ha.ovh.net (b9.ovh.net [213.186.33.59])
 by mo1.mail-out.ovh.net (Postfix) with ESMTP id B65E18A12A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Aug 2017 09:46:03 +0200 (CEST)
Subject: Re: [PATCH] powerpc/xive: fix the fuzz value in xive_pick_irq_target()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
References: <1501692230-20789-1-git-send-email-clg@kaod.org>
 <1501711052.2664.7.camel@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <62a8ad99-137f-765c-aa1b-ad5ba22231d0@kaod.org>
Date: Thu, 3 Aug 2017 09:45:51 +0200
MIME-Version: 1.0
In-Reply-To: <1501711052.2664.7.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/02/2017 11:57 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2017-08-02 at 18:43 +0200, Cédric Le Goater wrote:
>> If xive_find_target_in_mask() fails to find a cpu, the fuzz value used
>> in xive_pick_irq_target() is decremented and reused in the last
>> returning call to xive_find_target_in_mask(). This can result in such
>> WARNINGs if the initial fuzz value is zero :
> 
> Ah indeed ... would have worked better if "fuzz" had been unsigned.

but 'fuzz' is unsigned ! 

With a -1, unsigned or not, the 'first' cpu  becomes out of range for
the calculation below :

	/* Pick up a starting point CPU in the mask based on  fuzz */
	num = cpumask_weight(mask);
	first = fuzz % num;

	/* Locate it */
	cpu = cpumask_first(mask);
	for (i = 0; i < first && cpu < nr_cpu_ids; i++)
		cpu = cpumask_next(cpu, mask);

May be there is a better fix ? 


Also, I am not sure of :

	num = cpumask_weight(mask);

shouldn't we be using : 

	num = nr_cpu_ids;

In that case, 'first' would have been in the cpu range.

Cheers,

C.
