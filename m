Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 84EA21A09A7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 17:26:38 +1100 (AEDT)
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B45FD141434
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2015 17:26:37 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Fri, 13 Nov 2015 01:26:35 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D649338C803B
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2015 01:26:32 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAD6QWFD57802848
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2015 06:26:32 GMT
Received: from d01av01.pok.ibm.com (localhost [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAD6QV3Z016528
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2015 01:26:32 -0500
Message-ID: <5645828E.1030609@linux.vnet.ibm.com>
Date: Fri, 13 Nov 2015 11:56:22 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: kvm@vger.kernel.org, michaele@au1.ibm.com, mahesh@linux.vnet.ibm.com,
 agraf@suse.de, kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] KVM: PPC: Exit guest upon fatal machine check exception
References: <20151111165845.3721.98296.stgit@aravindap>
 <876118ymy4.fsf@gamma.ozlabs.ibm.com> <20151112033816.GJ5852@voom.redhat.com>
 <5644164A.40706@linux.vnet.ibm.com> <20151112044316.GA4886@voom.redhat.com>
 <5644D1DD.1020201@linux.vnet.ibm.com> <20151113015015.GI4886@voom.redhat.com>
In-Reply-To: <20151113015015.GI4886@voom.redhat.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 13 November 2015 07:20 AM, David Gibson wrote:
> On Thu, Nov 12, 2015 at 11:22:29PM +0530, Aravinda Prasad wrote:

[...]

>>
>> I overlooked it. I think I need to take into consideration whether guest
>> issued "ibm, nmi-register". If the guest has issued "ibm, nmi-register"
>> then we should not jump to 0x200 upon UE. With the old kernel and old
>> QEMU this is broken as we always jump to 0x200.
>>
>> However, if the guest has not issued "ibm, nmi-register" then upon UE we
>> should jump to 0x200. If new kernel is used with old QEMU this
>> functionality breaks as it causes guest to terminate with unhandled NMI
>> exit.
>>
>> So thinking whether qemu should explicitly enable the new NMI
>> behavior.
> 
> So, I think the reasoning above tends towards having qemu control the
> MC behaviour.  If qemu does nothing, MCs are delivered direct to
> 0x200, if it enables the new handling, they cause a KVM exit and qemu
> will deliver the MC.

This essentially requires qemu to control how KVM behaves as KVM does
the actual redirection of MC either to guest's 0x200 vector or to exit
guest. So, if we are running new qemu, then KVM should exit guest and if
we are running old qemu, KVM should redirect MC to 0x200. Is there any
way to communicate this to KVM? ioctl?

However, this should not be a problem (in terms of breaking existing
functionality) with old KVM as it always redirects MC to 0x200
irrespective of old or new qemu.

> 
> Then I'd expect qemu to switch on the new-style handling from
> ibm,nmi-register.
> 
>>

-- 
Regards,
Aravinda
