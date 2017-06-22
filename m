Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtSWx1dm8zDrH4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jun 2017 13:59:41 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: victora <victora@linux.vnet.ibm.com>, alistair@popple.id.au, jk@ozlabs.org
Cc: victora@br.ibm.com, mauricfo@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org
Subject: Re: 1M hugepage size being registered on Linux
In-Reply-To: <322aa4a1a11ca79008a8c894c12a80d5@linux.vnet.ibm.com>
References: <322aa4a1a11ca79008a8c894c12a80d5@linux.vnet.ibm.com>
Date: Thu, 22 Jun 2017 13:59:40 +1000
Message-ID: <87o9tgsmdv.fsf@concordia.ellerman.id.au>
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

Hi Victor,

Someone refreshed my memory on this, coffee was involved ...

victora <victora@linux.vnet.ibm.com> writes:
> Hi Alistair/Jeremy,
>
> I am working on a bug related to 1M hugepage size being registered on 
> Linux (Power 8 Baremetal - Garrison).

On those machines the property in the device tree comes straight from
hostboot, and it includes 1M:

# lsprop ibm,segment-page-sizes 
ibm,segment-page-sizes
		 0000000c  00000000  00000003  0000000c
                 baseshift slbenc    lpnum     shift
		 00000000  00000010  00000007  00000018
                 penc      shift     penc      shift
		 00000038  00000010  00000110  00000002
                 penc      baseshift slbenc    lpnum
		 00000010  00000001  00000018  00000008
                 shift     penc      shift     penc
		 00000014  00000130  00000001  00000014	<--- 1MB = 2^0x14
                 baseshift slbenc    lpnum     shift
		 00000002  00000018  00000100  00000001
                 penc      baseshift slbenc    lpnum
		 00000018  00000000  00000022  00000120
                 shift     penc      baseshift slbenc
		 00000001  00000022  00000003
                 lpnum     shift     penc


> I was checking dmesg and it seems that 1M page size is coming from 
> firmware to Linux.
>
> [    0.000000] base_shift=20: shift=20, sllp=0x0130, avpnm=0x00000000, tlbiel=0, penc=2
> [    1.528867] HugeTLB registered 1 MB page size, pre-allocated 0 pages

Which is why you see that message.

> Should Linux support this page size? As afar as I know, this was an 
> unsupported page size in the past isn't it? If this should be supported 
> now, is there any specific reason for that?

It's unsupported in Linux because it doesn't match the page table
geometry.

We merged a patch from Aneesh to filter it out in 4.12-rc1:

  a525108cf1cc ("powerpc/mm/hugetlb: Filter out hugepage size not supported by page table layout")

I guess we should probably send that patch to stable et. al.

cheers
