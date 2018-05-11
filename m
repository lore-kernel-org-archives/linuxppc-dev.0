Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40j0zt1d8SzF2Cj
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 16:48:42 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 00/17] Implement use of HW assistance on TLB table walk on
 8xx
In-Reply-To: <cover.1525435203.git.christophe.leroy@c-s.fr>
References: <cover.1525435203.git.christophe.leroy@c-s.fr>
Date: Fri, 11 May 2018 16:48:41 +1000
Message-ID: <87sh6yr8l2.fsf@concordia.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> The purpose of this serie is to implement hardware assistance for TLB table walk
> on the 8xx.
>
> First part is to make L1 entries and L2 entries independant.
> For that, we need to alter ioremap functions in order to handle GUARD attribute
> at the PGD/PMD level.
>
> Last part is to try and reuse PTE fragment implemented on PPC64 in order to
> not waste 16k Pages for page tables as only 4k are used. For the time being,
> it doesn't work, but I include it in the serie anyway in order to get feedback.
>
> Tested successfully on 8xx up to the one before the last.
>
> Didn't have time to do compilation test on other configs, I send it anyway
> before leaving for one week vacation in order to get feedback.

I replied to a few patches, here's some other build errors:


arch/powerpc/mm/ioremap.c:135:15: error: '_PAGE_GUARDED' undeclared (first use in this function):
  pseries_defconfig/powerpc

arch/powerpc/include/asm/book3s/32/pgtable.h:53:19: error: 'PKMAP_BASE' undeclared (first use in this function):
  pmac32_defconfig/powerpc-5.3

include/linux/mm.h:533:41: error: 'PKMAP_BASE' undeclared (first use in this function):
  pmac32_defconfig/powerpc

ERROR: "ioremap_bot" [net/netfilter/nf_conntrack.ko] undefined!:
  linkstation_defconfig/powerpc

ERROR: "ioremap_bot" [fs/xfs/xfs.ko] undefined!:
  linkstation_defconfig/powerpc

arch/powerpc/include/asm/nohash/32/pgtable.h:80:20: error: 'PKMAP_BASE' undeclared (first use in this function):
  corenet32_smp_defconfig/powerpc-5.3

arch/powerpc/include/asm/nohash/32/pgalloc.h:64:43: error: '_PMD_GUARDED' undeclared (first use in this function):
  ppc40x_defconfig/powerpc-5.3

ERROR: "ioremap_bot" [net/packet/af_packet.ko] undefined!:
  storcenter_defconfig/powerpc

ERROR: "ioremap_bot" [drivers/usb/core/usbcore.ko] undefined!:
  ppc44x_defconfig/powerpc

cheers
