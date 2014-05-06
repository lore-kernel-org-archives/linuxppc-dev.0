Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C3C601401FB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 May 2014 02:18:14 +1000 (EST)
Message-ID: <53690B42.1090707@suse.de>
Date: Tue, 06 May 2014 18:18:10 +0200
From: Alexander Graf <agraf@suse.de>
MIME-Version: 1.0
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] KVM: PPC: BOOK3S: HV: THP support for guest
References: <1399224616-25142-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <5368A78D.4070509@suse.de> <1399368400.18906.9.camel@pasglop>
 <5368ADE3.1050503@suse.de> <87oazbq73t.fsf@linux.vnet.ibm.com>
 <5368FE66.5040809@suse.de> <87ha52ritd.fsf@linux.vnet.ibm.com>
In-Reply-To: <87ha52ritd.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, kvm-ppc@vger.kernel.org,
 kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/06/2014 06:08 PM, Aneesh Kumar K.V wrote:
> Alexander Graf <agraf@suse.de> writes:
>
>> On 05/06/2014 05:06 PM, Aneesh Kumar K.V wrote:
>>> Alexander Graf <agraf@suse.de> writes:
>>>
>>>> On 05/06/2014 11:26 AM, Benjamin Herrenschmidt wrote:
>>>>> On Tue, 2014-05-06 at 11:12 +0200, Alexander Graf wrote:
>>>>>
>>> .....
>>>
>>>
>>> I updated the commit message as below. Let me know if this is ok.
>>>
>>>       KVM: PPC: BOOK3S: HV: THP support for guest
>> This has nothing to do with THP.
> THP support in guest depend on KVM advertising MPSS feature. We already
> have rest of the changes needed to support transparent huge pages
> upstream. (We do support THP with PowerVM LPAR already). The primary
> motivation of this patch is to enable THP in powerkvm guest.

But KVM doesn't care. KVM cares about MPSS. It's like saying "Support 
fork()" in a subject line while your patch implements page faults.

>
>>>       
>>>       On recent IBM Power CPUs, while the hashed page table is looked up using
>>>       the page size from the segmentation hardware (i.e. the SLB), it is
>>>       possible to have the HPT entry indicate a larger page size.  Thus for
>>>       example it is possible to put a 16MB page in a 64kB segment, but since
>>>       the hash lookup is done using a 64kB page size, it may be necessary to
>>>       put multiple entries in the HPT for a single 16MB page.  This
>>>       capability is called mixed page-size segment (MPSS).  With MPSS,
>>>       there are two relevant page sizes: the base page size, which is the
>>>       size used in searching the HPT, and the actual page size, which is the
>>>       size indicated in the HPT entry. [ Note that the actual page size is
>>>       always >= base page size ].
>>>       
>>>       We advertise MPSS feature to guest only if the host CPU supports the
>>>       same. We use "ibm,segment-page-sizes" device tree node to advertise
>>>       the MPSS support. The penc encoding indicate whether we support
>>>       a specific combination of base page size and actual page size
>>>       in the same segment. It is also the value used in the L|LP encoding
>>>       of HPTE entry.
>>>       
>>>       In-order to support MPSS in guest, KVM need to handle the below details
>>>       * advertise MPSS via ibm,segment-page-sizes
>>>       * Decode the base and actual page size correctly from the HPTE entry
>>>         so that we know what we are dealing with in H_ENTER and and can do
>> Which code path exactly changes for H_ENTER?
> There is no real code path changes. Any code path that use
> hpte_page_size() is impacted. We return actual page size there.

Ah, I see :).

>
>>>         the appropriate TLB invalidation in H_REMOVE and evictions.
>> Apart from the grammar (which is pretty broken for the part that is not
>> copied from Paul) and the subject line this sounds quite reasonable.
>>
> Wll try to fix.

Awesome. Thanks a lot!


Alex
