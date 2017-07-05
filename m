Return-Path: <clg@kaod.org>
Received: from 12.mo3.mail-out.ovh.net (12.mo3.mail-out.ovh.net
 [188.165.41.191])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2l3W621TzDqhn
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 01:22:15 +1000 (AEST)
Received: from player158.ha.ovh.net (b6.ovh.net [213.186.33.56])
 by mo3.mail-out.ovh.net (Postfix) with ESMTP id BCB46FCE6B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jul 2017 17:13:14 +0200 (CEST)
Subject: Re: [RFC PATCH 1/2] powerpc/xive: guest exploitation of the XIVE
 interrupt controller
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>
References: <1498123757-18427-1-git-send-email-clg@kaod.org>
 <1498123757-18427-2-git-send-email-clg@kaod.org>
 <20170703035552.GQ13989@umbus.fritz.box>
 <1499055599.16202.23.camel@kernel.crashing.org>
 <18d0c283-3527-d599-36d8-4397a0a4d6db@kaod.org>
 <20170705110702.GO2180@umbus.fritz.box>
 <1499265500.16202.70.camel@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>,
 Paul Mackerras <paulus@samba.org>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <dde2e0d9-e142-abba-8b3a-5946480ab1c3@kaod.org>
Date: Wed, 5 Jul 2017 17:13:06 +0200
MIME-Version: 1.0
In-Reply-To: <1499265500.16202.70.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/05/2017 04:38 PM, Benjamin Herrenschmidt wrote:
> On Wed, 2017-07-05 at 21:07 +1000, David Gibson wrote:
>> I don't know if it helps, but we do have the ability to trigger a full
>> system reset from CAS, so possibly we can do the XICS/XIVE
>> instantiation in the reset path.
>>
>> I don't think we use that CAS reset ability yet - we just adjust the
>> device tree and continue the boot.  But it's there if we need it.
>>
>> Worst comes to worst, we might have to instantiate both XICS and XIVE
>> objects, with some flags in each indicating which is active.

we have the CAS option for that. Well, that is what I have started
using in the QEMU prototype for the sPAPR XIVE support.

> That could be a problem with the kernel interrupt controller. We can't
> really instantiate both there I think... well, actually ... maybe we
> could, though it's a bit messy...

Well, It would much cleaner to reset completely the guest, no ICP
and no ICS objects, until we reach the end of the CAS negotiation, 
and then instantiate what we need. 

The only issue I have spotted for the moment is that the device tree 
is populated with IRQ numbers allocated from an interrupt source, 
which is way before CAS has even started. So, to work around that, 
we could imagine using a bitmap to allocate these IRQ numbers and 
then instantiate the interrupt source object of the correct type
with this bitmap as a constructor parameter. Just an idea.    
 
The interrupt presenter objects could be allocated later in the boot 
process. I think. May be on demand, when a CPU is first notified ? 
I haven't looked at the gory details: migration, hotplug. 

But we are starting the discussion on the wrong mailing list ! 
Let me complete the QEMU patchset. I am currently splitting it in 
little chunks for a first RFC. The last one being an hideous hack 
to activate XIVE in the guest.

Cheers,

C.
