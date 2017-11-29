Return-Path: <shuahkh@osg.samsung.com>
Received: from osg.samsung.com (osg.samsung.com [64.30.133.232])
 by lists.ozlabs.org (Postfix) with ESMTP id 3yn5wh2QkXzDrns
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Nov 2017 03:44:35 +1100 (AEDT)
Subject: Re: [PATCH kernel] vfio/spapr: Add trace points for map/unmap
To: Alex Williamson <alex.williamson@redhat.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: linuxppc-dev@lists.ozlabs.org, David Gibson
 <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, kvm@vger.kernel.org,
 iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
 Shuah Khan <shuahkh@osg.samsung.com>
References: <20171027030008.17200-1-aik@ozlabs.ru>
 <8c58fcaa-dedc-e6be-44bf-2cb349ef9e38@ozlabs.ru>
 <20171116171301.6552869b@t450s.home>
 <52a19cfb-431f-522b-11de-c1c47f09a4c8@ozlabs.ru>
 <d367b17a-6efa-26a8-821b-42080c90e16e@ozlabs.ru>
 <20171129093244.0849fd7c@t450s.home>
From: Shuah Khan <shuahkh@osg.samsung.com>
Message-ID: <a009f8a2-d107-e121-6184-ad80591e45de@osg.samsung.com>
Date: Wed, 29 Nov 2017 09:44:13 -0700
MIME-Version: 1.0
In-Reply-To: <20171129093244.0849fd7c@t450s.home>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/29/2017 09:32 AM, Alex Williamson wrote:
> On Thu, 23 Nov 2017 15:13:37 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> 
>> On 17/11/17 17:58, Alexey Kardashevskiy wrote:
>>> On 17/11/17 11:13, Alex Williamson wrote:  
>>>> On Tue, 14 Nov 2017 10:47:12 +1100
>>>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>>>  
>>>>> On 27/10/17 14:00, Alexey Kardashevskiy wrote:  
>>>>>> This adds trace_map/trace_unmap tracepoints to spapr driver. Type1 already
>>>>>> uses these via the IOMMU API (iommu_map/__iommu_unmap).
>>>>>>
>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>    
>>>>
>>>> Is this really legitimate to include tracepoints from a different  
>>>> subsystem?>  The vfio type1 backend gets these trace points by virtue of  
>>>> it actually using the IOMMU API, it doesn't call them itself.  I'm kind
>>>> of surprised these are actually available to be called from a module.  
>>>
>>> They are explicitly exported:
>>>
>>> EXPORT_TRACEPOINT_SYMBOL_GPL(map);
>>> EXPORT_TRACEPOINT_SYMBOL_GPL(unmap);

Tracepoints need to be exported as per the tracepoint sub-system
requirements.

>>>
>>> I would think this is for things like drivers/vfio/vfio_iommu_spapr_tce.c ,
>>> why else?...
>>>
>>>   
>>>> I suspect the way to do this is probably to define our own tracepoints
>>>> in the vfio/spapr backend or insert tracepoints into the IOMMU layers
>>>> that that code calls into rather than masquerading as tracepoints from
>>>> a different subsystem.  Right?  
>>>
>>> This makes sense too. But it is going to be just cut-n-paste and some
>>> confusion -
>>> /sys/kernel/debug/tracing/events/iommu/map will still be present but
>>> won't work and
>>> /sys/kernel/debug/tracing/events/vfio/vfio_iommu_spapr_tce/map will.
> 
> But iommu/map does work, it's just not called by the vfio spapr tce
> backend, which is absolutely correct.  In fact, that's part of my
> reservation about this approach is that it could be interpreted as
> implying a call path that doesn't exist on this arch.

These tracepoints are intended to be called after a iommo/map/unmap
calls from IOMMU API. It doesn't make any sense to call them from
random places. It is totally useless to do so and makes it difficult
to debug problems.

As an author of these tracepoints - that is my opinion.

thanks,
-- Shuah
