Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yVq341SWDzDrJw
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Nov 2017 21:45:36 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, Jonas Pfefferle1 <JPF@zurich.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH kernel] powerpc/powernv/ioda: Relax max DMA window size
 check
In-Reply-To: <fd1a289f-6698-0b84-eab8-d4c67290bea8@ozlabs.ru>
References: <20171031040427.10909-1-aik@ozlabs.ru>
 <fd1a289f-6698-0b84-eab8-d4c67290bea8@ozlabs.ru>
Date: Mon, 06 Nov 2017 21:45:34 +1100
Message-ID: <877ev3bs8h.fsf@concordia.ellerman.id.au>
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

Alexey Kardashevskiy <aik@ozlabs.ru> writes:

> On 31/10/17 15:04, Alexey Kardashevskiy wrote:
>> DMA windows can only have a size of power of two on IODA2 hardware and
>> using memory_hotplug_max() to determine the upper limit won't work
>> correcly if it returns not power of two value.
>> 
>> This relaxes the check by rounding up the value returned by
>> memory_hotplug_max().
>> 
>> It is expected to impact DPDK on machines with non-power-of-two RAM size,
>> mostly. KVM guests are less likely to be affected as usually guests get
>> less than half of hosts RAM.
>
>
> It was pointed out that this check is quite useless anyway as the vm_locked
> memory limit should hit first, and if that is not set or the user got the
> root privilege level, then there are easier ways to crash the host so I am
> thinking of:
>
>
> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c
> b/arch/powerpc/platforms/powernv/pci-ioda.c
> index 269f119e4b3c..a47e4cf343b2 100644
> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
> @@ -2769,7 +2769,7 @@ static long pnv_pci_ioda2_table_alloc_pages(int nid,
> __u64 bus_offset,
>         if (!levels || (levels > POWERNV_IOMMU_MAX_LEVELS))
>                 return -EINVAL;
>
> -       if ((window_size > memory_hotplug_max()) ||
> !is_power_of_2(window_size))
> +       if (!is_power_of_2(window_size))
>                 return -EINVAL;
>
>
>
> Makes sense?

Sounds reasonable.

Execpt where is the vm_locked check? I think it's in the VFIO driver? If
so I guess the only concern is that this code might be called via some
other path that doesn't do that check.

cheers
