Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D07D51A006D
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 31 Jan 2016 19:37:38 +1100 (AEDT)
In-Reply-To: <1454086969-21074-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, bobby.prani@gmail.com
Subject: Re: powerpc/book3s_32: Fix build error with checkpoint restart
Message-Id: <20160131083738.AA047140C40@ozlabs.org>
Date: Sun, 31 Jan 2016 19:37:38 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-29-01 at 17:02:49 UTC, "Aneesh Kumar K.V" wrote:
> In file included from mm/vmscan.c:54:0:
> include/linux/swapops.h: In function ‘pte_to_swp_entry’:
> include/linux/swapops.h:69:2: error: implicit declaration of function ‘pte_swp_soft_dirty’ [-Werror=implicit-function-declaration]
>   if (pte_swp_soft_dirty(pte))
>   ^
> include/linux/swapops.h:70:3: error: implicit declaration of function ‘pte_swp_clear_soft_dirty’ [-Werror=implicit-function-declaration]
>    pte = pte_swp_clear_soft_dirty(pte);
> 
> We support soft dirty tracking only with book3s 64 for now.
> So change the Kconfig dependency accordingly. Also CHECKPOINT_RESTORE
> feature is not really dependent on SOFT_DIRTY. We track the dependency
> between MEM_SOFT_DIRTY and ARCH_SOFT_DIRTY through headers
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/19f97c98307115f5a6b0bbf848

cheers
