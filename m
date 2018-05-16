Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40m9P62vyHzF14x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 May 2018 20:18:02 +1000 (AEST)
Subject: Re: [PATCH 00/17] Implement use of HW assistance on TLB table walk on
 8xx
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
 <87sh6yr8l2.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <d0cb28e9-29fe-f64b-0c9a-ba2eddead0ab@c-s.fr>
Date: Wed, 16 May 2018 12:17:57 +0200
MIME-Version: 1.0
In-Reply-To: <87sh6yr8l2.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 11/05/2018 à 08:48, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> The purpose of this serie is to implement hardware assistance for TLB table walk
>> on the 8xx.
>>
>> First part is to make L1 entries and L2 entries independant.
>> For that, we need to alter ioremap functions in order to handle GUARD attribute
>> at the PGD/PMD level.
>>
>> Last part is to try and reuse PTE fragment implemented on PPC64 in order to
>> not waste 16k Pages for page tables as only 4k are used. For the time being,
>> it doesn't work, but I include it in the serie anyway in order to get feedback.
>>
>> Tested successfully on 8xx up to the one before the last.
>>
>> Didn't have time to do compilation test on other configs, I send it anyway
>> before leaving for one week vacation in order to get feedback.
> 
> I replied to a few patches, here's some other build errors:
> 
> 
> arch/powerpc/mm/ioremap.c:135:15: error: '_PAGE_GUARDED' undeclared (first use in this function):
>    pseries_defconfig/powerpc
> 
> arch/powerpc/include/asm/book3s/32/pgtable.h:53:19: error: 'PKMAP_BASE' undeclared (first use in this function):
>    pmac32_defconfig/powerpc-5.3
> 
> include/linux/mm.h:533:41: error: 'PKMAP_BASE' undeclared (first use in this function):
>    pmac32_defconfig/powerpc
> 
> ERROR: "ioremap_bot" [net/netfilter/nf_conntrack.ko] undefined!:
>    linkstation_defconfig/powerpc
> 
> ERROR: "ioremap_bot" [fs/xfs/xfs.ko] undefined!:
>    linkstation_defconfig/powerpc
> 
> arch/powerpc/include/asm/nohash/32/pgtable.h:80:20: error: 'PKMAP_BASE' undeclared (first use in this function):
>    corenet32_smp_defconfig/powerpc-5.3
> 
> arch/powerpc/include/asm/nohash/32/pgalloc.h:64:43: error: '_PMD_GUARDED' undeclared (first use in this function):
>    ppc40x_defconfig/powerpc-5.3
> 
> ERROR: "ioremap_bot" [net/packet/af_packet.ko] undefined!:
>    storcenter_defconfig/powerpc
> 
> ERROR: "ioremap_bot" [drivers/usb/core/usbcore.ko] undefined!:
>    ppc44x_defconfig/powerpc
> 

Thanks for testing. I have now fixed all of them in v2.

For PKMAP_BASE, I had to move it from asm/highmem.h into the 
book3s/32/pgtable.h and nohash/32/pgtable.h because including 
asm/highmem.h in the pgtable.h files was introducing circular dependency.

Christophe
