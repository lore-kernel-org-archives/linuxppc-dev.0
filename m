Return-Path: <aik@ozlabs.ru>
Received: from mail-pb0-x22d.google.com (mail-pb0-x22d.google.com
 [IPv6:2607:f8b0:400e:c01::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 83EB02C0413
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jun 2013 18:25:55 +1000 (EST)
Received: by mail-pb0-f45.google.com with SMTP id mc8so8833696pbc.32
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 22 Jun 2013 01:25:51 -0700 (PDT)
Message-ID: <51C55F87.8080702@ozlabs.ru>
Date: Sat, 22 Jun 2013 18:25:43 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 3/4] KVM: PPC: Add support for IOMMU in-kernel handling
References: <1371422343.21896.143.camel@pasglop>
 <1371438800.22681.38.camel@ul30vt.home> <1371441361.21896.152.camel@pasglop>
 <1371522772.22681.140.camel@ul30vt.home> <87txkun568.fsf@rustcorp.com.au>
 <1371617970.21896.232.camel@pasglop>
 <E63966E3-336F-4CB8-96EC-24D2C1644E62@suse.de>
 <1371653443.21896.291.camel@pasglop> <1371656989.22659.98.camel@ul30vt.home>
 <51C28BEA.8050501@ozlabs.ru> <20130620052822.GB3140@voom.redhat.com>
 <1371714449.3944.14.camel@pasglop> <51C2C1CC.9000003@ozlabs.ru>
 <1371740113.32709.22.camel@ul30vt.home>
In-Reply-To: <1371740113.32709.22.camel@ul30vt.home>
Content-Type: text/plain; charset=KOI8-R
Cc: "kvm@vger.kernel.org mailing list" <kvm@vger.kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Rusty Russell <rusty@rustcorp.com.au>,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
 open list <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/21/2013 12:55 AM, Alex Williamson wrote:
> On Thu, 2013-06-20 at 18:48 +1000, Alexey Kardashevskiy wrote:
>> On 06/20/2013 05:47 PM, Benjamin Herrenschmidt wrote:
>>> On Thu, 2013-06-20 at 15:28 +1000, David Gibson wrote:
>>>>> Just out of curiosity - would not get_file() and fput_atomic() on a
>>>> group's
>>>>> file* do the right job instead of vfio_group_add_external_user() and
>>>>> vfio_group_del_external_user()?
>>>>
>>>> I was thinking that too.  Grabbing a file reference would certainly be
>>>> the usual way of handling this sort of thing.
>>>
>>> But that wouldn't prevent the group ownership to be returned to
>>> the kernel or another user would it ?
>>
>>
>> Holding the file pointer does not let the group->container_users counter go
>> to zero
> 
> How so?  Holding the file pointer means the file won't go away, which
> means the group release function won't be called.  That means the group
> won't go away, but that doesn't mean it's attached to an IOMMU.  A user
> could call UNSET_CONTAINER.
> 
>>  and this is exactly what vfio_group_add_external_user() and
>> vfio_group_del_external_user() do. The difference is only in absolute value
>> - 2 vs. 3.
>>
>> No change in behaviour whether I use new vfio API or simply hold file* till
>> KVM closes fd created when IOMMU was connected to LIOBN.
> 
> By that notion you could open(/dev/vfio/$GROUP) and you're safe, right?
> But what about SET_CONTAINER & SET_IOMMU?  All that you guarantee
> holding the file pointer is that the vfio_group exists.
> 
>> And while this counter is not zero, QEMU cannot take ownership over the group.
>>
>> I am definitely still missing the bigger picture...
> 
> The bigger picture is that the group needs to exist AND it needs to be
> setup and maintained to have IOMMU protection.  Actually, my first stab
> at add_external_user doesn't look sufficient, it needs to look more like
> vfio_group_get_device_fd, checking group->container->iommu and
> group_viable().


This makes sense. If you did this, that would be great. Without it, I
really cannot see how the proposed inc/dec of container_users is better
than simple holding file*. Thanks.


> As written it would allow an external user after
> SET_CONTAINER without SET_IOMMU.  It should also be part of the API that
> the external user must hold the file reference between add_external_use
> and del_external_user and do cleanup on any exit paths.  Thanks,


-- 
Alexey
