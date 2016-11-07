Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tC5N3587pzDsrM
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 19:34:43 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Paolo Bonzini <pbonzini@redhat.com>, alex.williamson@redhat.com
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 aik@ozlabs.ru, gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH] vfio: Fix build break when SPAPR_TCE_IOMMU=n
In-Reply-To: <81900126-f1aa-b480-c2fa-f0fa04d625c1@redhat.com>
References: <1478238521-32203-1-git-send-email-mpe@ellerman.id.au>
 <81900126-f1aa-b480-c2fa-f0fa04d625c1@redhat.com>
Date: Mon, 07 Nov 2016 19:34:42 +1100
Message-ID: <87zilblmcd.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paolo Bonzini <pbonzini@redhat.com> writes:
> On 04/11/2016 06:48, Michael Ellerman wrote:
>> diff --git a/drivers/vfio/Kconfig b/drivers/vfio/Kconfig
>> index da6e2ce77495..6b51a4ebed8a 100644
>> --- a/drivers/vfio/Kconfig
>> +++ b/drivers/vfio/Kconfig
>> @@ -6,12 +6,12 @@ config VFIO_IOMMU_TYPE1
>>  config VFIO_IOMMU_SPAPR_TCE
>>  	tristate
>>  	depends on VFIO && SPAPR_TCE_IOMMU
>> -	default n
>> +	default VFIO
>
> No need to depend on VFIO since you already have it in "default".

True, I can take that out.

> (I assume you cannot use "default y" because "depends on" doesn't downgrade
> "y" to "m" when VFIO is a module.

Correct.

> A shorthand is
>
> 	def_tristate VFIO && SPAPR_TCE_IOMMU

Yep. My experience though is that a lot of folks don't really know what
that means. So I prefer to spell it out with an explicit type, depends
and default.

But I'll respin it that way if Alex prefers the shorter style.

cheers
