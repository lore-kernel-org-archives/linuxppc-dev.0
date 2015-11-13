Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC63E1A09D6
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 22:25:39 +1100 (AEDT)
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 1CB7414142A
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2015 22:25:38 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Fri, 13 Nov 2015 04:25:37 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 463313E4003B
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2015 04:25:34 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tADBPYwE9437648
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2015 04:25:34 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tADBPXL8021441
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2015 04:25:34 -0700
Message-ID: <5645C8A6.4070808@linux.vnet.ibm.com>
Date: Fri, 13 Nov 2015 16:55:26 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Thomas Huth <thuth@redhat.com>
CC: David Gibson <david@gibson.dropbear.id.au>, kvm@vger.kernel.org,
 michaele@au1.ibm.com, mahesh@linux.vnet.ibm.com, agraf@suse.de,
 kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] KVM: PPC: Exit guest upon fatal machine check exception
References: <20151111165845.3721.98296.stgit@aravindap>
 <876118ymy4.fsf@gamma.ozlabs.ibm.com> <20151112033816.GJ5852@voom.redhat.com>
 <5644164A.40706@linux.vnet.ibm.com> <20151112044316.GA4886@voom.redhat.com>
 <5644D1DD.1020201@linux.vnet.ibm.com> <20151113015015.GI4886@voom.redhat.com>
 <5645828E.1030609@linux.vnet.ibm.com> <56459360.3090400@redhat.com>
In-Reply-To: <56459360.3090400@redhat.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 13 November 2015 01:08 PM, Thomas Huth wrote:
> On 13/11/15 07:26, Aravinda Prasad wrote:
>>
>> On Friday 13 November 2015 07:20 AM, David Gibson wrote:
>>> On Thu, Nov 12, 2015 at 11:22:29PM +0530, Aravinda Prasad wrote:
> [...]
>>>> So thinking whether qemu should explicitly enable the new NMI
>>>> behavior.
>>>
>>> So, I think the reasoning above tends towards having qemu control the
>>> MC behaviour.  If qemu does nothing, MCs are delivered direct to
>>> 0x200, if it enables the new handling, they cause a KVM exit and qemu
>>> will deliver the MC.
>>
>> This essentially requires qemu to control how KVM behaves as KVM does
>> the actual redirection of MC either to guest's 0x200 vector or to exit
>> guest. So, if we are running new qemu, then KVM should exit guest and if
>> we are running old qemu, KVM should redirect MC to 0x200. Is there any
>> way to communicate this to KVM? ioctl?
> 
> Simply introduce a KVM capability that can be enabled by userspace.
> See kvm_vcpu_ioctl_enable_cap() in arch/powerpc/kvm/powerpc.c.

Thanks. I will look at it.

Regards,
Aravinda

> 
>  Thomas
> 

-- 
Regards,
Aravinda
