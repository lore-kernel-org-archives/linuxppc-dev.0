Return-Path: <thuth@redhat.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7CA901A0C3C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Nov 2015 18:38:16 +1100 (AEDT)
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E8C28141430
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Nov 2015 18:38:15 +1100 (AEDT)
Subject: Re: [PATCH] KVM: PPC: Exit guest upon fatal machine check exception
To: Aravinda Prasad <aravinda@linux.vnet.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>
References: <20151111165845.3721.98296.stgit@aravindap>
 <876118ymy4.fsf@gamma.ozlabs.ibm.com> <20151112033816.GJ5852@voom.redhat.com>
 <5644164A.40706@linux.vnet.ibm.com> <20151112044316.GA4886@voom.redhat.com>
 <5644D1DD.1020201@linux.vnet.ibm.com> <20151113015015.GI4886@voom.redhat.com>
 <5645828E.1030609@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, michaele@au1.ibm.com, mahesh@linux.vnet.ibm.com,
 agraf@suse.de, kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org,
 Daniel Axtens <dja@axtens.net>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <56459360.3090400@redhat.com>
Date: Fri, 13 Nov 2015 08:38:08 +0100
MIME-Version: 1.0
In-Reply-To: <5645828E.1030609@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13/11/15 07:26, Aravinda Prasad wrote:
> 
> On Friday 13 November 2015 07:20 AM, David Gibson wrote:
>> On Thu, Nov 12, 2015 at 11:22:29PM +0530, Aravinda Prasad wrote:
[...]
>>> So thinking whether qemu should explicitly enable the new NMI
>>> behavior.
>>
>> So, I think the reasoning above tends towards having qemu control the
>> MC behaviour.  If qemu does nothing, MCs are delivered direct to
>> 0x200, if it enables the new handling, they cause a KVM exit and qemu
>> will deliver the MC.
> 
> This essentially requires qemu to control how KVM behaves as KVM does
> the actual redirection of MC either to guest's 0x200 vector or to exit
> guest. So, if we are running new qemu, then KVM should exit guest and if
> we are running old qemu, KVM should redirect MC to 0x200. Is there any
> way to communicate this to KVM? ioctl?

Simply introduce a KVM capability that can be enabled by userspace.
See kvm_vcpu_ioctl_enable_cap() in arch/powerpc/kvm/powerpc.c.

 Thomas
