Return-Path: <aravinda@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A6F431A0287
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Nov 2015 15:32:20 +1100 (AEDT)
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 0F2EC141301
 for <linuxppc-dev@ozlabs.org>; Thu, 12 Nov 2015 15:32:19 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <aravinda@linux.vnet.ibm.com>;
 Wed, 11 Nov 2015 21:32:18 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id DC8EF19D8041
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2015 21:20:24 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAC4V5jb6816010
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2015 21:31:05 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAC4WFA2008070
 for <linuxppc-dev@ozlabs.org>; Wed, 11 Nov 2015 21:32:16 -0700
Message-ID: <5644164A.40706@linux.vnet.ibm.com>
Date: Thu, 12 Nov 2015 10:02:10 +0530
From: Aravinda Prasad <aravinda@linux.vnet.ibm.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: Daniel Axtens <dja@axtens.net>, kvm@vger.kernel.org, michaele@au1.ibm.com,
 mahesh@linux.vnet.ibm.com, agraf@suse.de, kvm-ppc@vger.kernel.org,
 linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] KVM: PPC: Exit guest upon fatal machine check exception
References: <20151111165845.3721.98296.stgit@aravindap>
 <876118ymy4.fsf@gamma.ozlabs.ibm.com> <20151112033816.GJ5852@voom.redhat.com>
In-Reply-To: <20151112033816.GJ5852@voom.redhat.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 12 November 2015 09:08 AM, David Gibson wrote:
> On Thu, Nov 12, 2015 at 01:24:19PM +1100, Daniel Axtens wrote:
>> Aravinda Prasad <aravinda@linux.vnet.ibm.com> writes:
>>
>>> This patch modifies KVM to cause a guest exit with
>>> KVM_EXIT_NMI instead of immediately delivering a 0x200
>>> interrupt to guest upon machine check exception in
>>> guest address. Exiting the guest enables QEMU to build
>>> error log and deliver machine check exception to guest
>>> OS (either via guest OS registered machine check
>>> handler or via 0x200 guest OS interrupt vector).
>>>
>>> This approach simplifies the delivering of machine
>>> check exception to guest OS compared to the earlier approach
>>> of KVM directly invoking 0x200 guest interrupt vector.
>>> In the earlier approach QEMU patched the 0x200 interrupt
>>> vector during boot. The patched code at 0x200 issued a
>>> private hcall to pass the control to QEMU to build the
>>> error log.
>>>
>>> This design/approach is based on the feedback for the
>>> QEMU patches to handle machine check exception. Details
>>> of earlier approach of handling machine check exception
>>> in QEMU and related discussions can be found at:
>>>
>>> https://lists.nongnu.org/archive/html/qemu-devel/2014-11/msg00813.html
>>
>> I've poked at the MCE code, but not the KVM MCE code, so I may be
>> mistaken here, but I'm not clear on how this handles errors that the
>> guest can recover without terminating.
>>
>> For example, a Linux guest can handle a UE in guest userspace by killing
>> the guest process. A hypthetical non-linux guest with a microkernel
>> could even survive UEs in drivers.
>>
>> It sounds from your patch like you're changing this behaviour. Is this
>> right?
> 
> So, IIUC.  Once the qemu pieces are in place as well it shouldn't
> change this behaviour: KVM will exit to qemu, qemu will log the error
> information (new), then reinject the MC to the guest which can still
> handle it as you describe above.

Yes. With KVM and QEMU both in place this will not change the behavior.
QEMU will inject the UE to guest and the guest handles the UE based on
where it occurred. For example if an UE happens in a guest process
address space, that process will be killed.

> 
> But, there could be a problem if you have a new kernel with an old
> qemu, in that case qemu might not understand the new exit type and
> treat it as a fatal error, even though the guest could actually cope
> with it.

In case of new kernel and old QEMU, the guest terminates as old QEMU
does not understand the NMI exit reason. However, this is the case with
old kernel and old QEMU as they do not handle UE belonging to guest. The
difference is that the guest kernel terminates with different error code.

old kernel and old QEMU -> guest panics [1] irrespective of where UE
                           happened in guest address space.
old kernel and new QEMU -> guest panics. same as above.
new kernel and old QEMU -> guest terminates with unhanded NMI error
                           irrespective of where UE happened in guest
new kernel and new QEMU -> guest handles UEs in process address space
                           by killing the process. guest terminates
                           for UEs in guest kernel address space.

[1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-June/118329.html

> 
> Aravinda, do we need to change this so that qemu has to explicitly
> enable the new NMI behaviour?  Or have I missed something that will
> make that case work already.

I think we don't need to explicitly enable the new behavior. With new
kernel and new QEMU this should just work. As mentioned above this is
already broken for old kernel/QEMU. Any thoughts?

Regards,
Aravinda

> 
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 

-- 
Regards,
Aravinda
