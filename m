Return-Path: <aik@ozlabs.ru>
Received: from mail-ob0-f182.google.com (mail-ob0-f182.google.com
 [209.85.214.182])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A95D62C00C6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 19:07:52 +1000 (EST)
Received: by mail-ob0-f182.google.com with SMTP id va7so9732755obc.27
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 02:07:50 -0700 (PDT)
Message-ID: <51EE47DE.5020002@ozlabs.ru>
Date: Tue, 23 Jul 2013 19:07:42 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 03/10] vfio: add external user support
References: <1373936045-22653-1-git-send-email-aik@ozlabs.ru>
 <1373936045-22653-4-git-send-email-aik@ozlabs.ru>
 <1374546224.15429.8.camel@ul30vt.home>
In-Reply-To: <1374546224.15429.8.camel@ul30vt.home>
Content-Type: text/plain; charset=KOI8-R
Cc: kvm@vger.kernel.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2013 12:23 PM, Alex Williamson wrote:
> On Tue, 2013-07-16 at 10:53 +1000, Alexey Kardashevskiy wrote:
>> VFIO is designed to be used via ioctls on file descriptors
>> returned by VFIO.
>>
>> However in some situations support for an external user is required.
>> The first user is KVM on PPC64 (SPAPR TCE protocol) which is going to
>> use the existing VFIO groups for exclusive access in real/virtual mode
>> on a host to avoid passing map/unmap requests to the user space which
>> would made things pretty slow.
>>
>> The protocol includes:
>>
>> 1. do normal VFIO init operation:
>> 	- opening a new container;
>> 	- attaching group(s) to it;
>> 	- setting an IOMMU driver for a container.
>> When IOMMU is set for a container, all groups in it are
>> considered ready to use by an external user.
>>
>> 2. User space passes a group fd to an external user.
>> The external user calls vfio_group_get_external_user()
>> to verify that:
>> 	- the group is initialized;
>> 	- IOMMU is set for it.
>> If both checks passed, vfio_group_get_external_user()
>> increments the container user counter to prevent
>> the VFIO group from disposal before KVM exits.
>>
>> 3. The external user calls vfio_external_user_iommu_id()
>> to know an IOMMU ID. PPC64 KVM uses it to link logical bus
>> number (LIOBN) with IOMMU ID.
>>
>> 4. When the external KVM finishes, it calls
>> vfio_group_put_external_user() to release the VFIO group.
>> This call decrements the container user counter.
>> Everything gets released.
>>
>> The "vfio: Limit group opens" patch is also required for the consistency.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> This looks fine to me.  Is the plan to add this through the ppc tree
> again?  Thanks,


Nope, better to add this through your tree. And faster for sure :) Thanks!



-- 
Alexey
