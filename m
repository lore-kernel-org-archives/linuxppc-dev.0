Return-Path: <clg@kaod.org>
Received: from 9.mo179.mail-out.ovh.net (9.mo179.mail-out.ovh.net
 [46.105.76.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xSf2d1bFlzDqrP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 16:52:25 +1000 (AEST)
Received: from player168.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo179.mail-out.ovh.net (Postfix) with ESMTP id 6A1FC5B3A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Aug 2017 08:45:28 +0200 (CEST)
Subject: Re: [PATCH 02/10] powerpc/xive: guest exploitation of the XIVE
 interrupt controller
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
References: <1502182579-990-1-git-send-email-clg@kaod.org>
 <1502182579-990-3-git-send-email-clg@kaod.org>
 <20170809035306.GC13670@umbus.fritz.box>
 <f82c1111-3dd3-f378-0ff6-222bffc07a35@kaod.org>
 <20170810042849.GU13670@umbus.fritz.box>
 <1502340360.2563.53.camel@kernel.crashing.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <2306956d-c447-24af-a20c-5f2eec011164@kaod.org>
Date: Thu, 10 Aug 2017 08:45:21 +0200
MIME-Version: 1.0
In-Reply-To: <1502340360.2563.53.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/10/2017 06:46 AM, Benjamin Herrenschmidt wrote:
> On Thu, 2017-08-10 at 14:28 +1000, David Gibson wrote:
>>
>> Also, will POWER9 always have doorbells?  In which case you could
>> reduce it to 3 options.
> 
> The problem with doorbells on POWER9 guests is that they may have
> to trap and be emulated by the hypervisor, since the guest threads
> on P9 don't have to match the HW threads of the core.

Well, the pseries cause_ipi() handler does :

 	if (doorbell_try_core_ipi(cpu))
 		return;

to limit the doorbells to the same core. So we should be fine ? If not
I suppose we should check CPU_FTR_ARCH_300 and use IPIs only for XIVE.

> Thus it's quite possible that using XIVE for IPIs is actually faster
> than doorbells in that case.

How can we measure that ? ebizzy may be.

C.
