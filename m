Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzt3bcJzDrKS
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:26 +1100 (AEDT)
In-Reply-To: <1470111037-18531-3-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [2/9] powerpc/powernv: Use CPU-endian hub diag-data type in
 pnv_eeh_get_and_dump_hub_diag()
Message-Id: <3spfzt0GFDz9sD5@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:25 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-08 at 04:10:30 UTC, Gavin Shan wrote:
> The hub diag-data type is filled with big-endian data by OPAL call
> opal_pci_get_hub_diag_data(). We need convert it to CPU-endian value
> before using it. The issue is reported by sparse as pointed by Michael
> Ellerman:
> 
>   gwshan@gwshan:~/sandbox/l$ make C=2 CF=-D__CHECK_ENDIAN__ \
>                         arch/powerpc/platforms/powernv/eeh-powernv.o
>        :
>   arch/powerpc/platforms/powernv/eeh-powernv.c:1309:21: \
>   warning: restricted __be16 degrades to integer
>   arch/powerpc/platforms/powernv/eeh-powernv.c:1309:21: \
>   warning: restricted __be16 degrades to integer
>   arch/powerpc/platforms/powernv/eeh-powernv.c:1309:21: \
>   warning: restricted __be16 degrades to integer
>   arch/powerpc/platforms/powernv/eeh-powernv.c:1309:21: \
>   warning: restricted __be16 degrades to integer
>   arch/powerpc/platforms/powernv/eeh-powernv.c:1309:21: \
>   warning: restricted __be16 degrades to integer
> 
> This converts hub diag-data type to CPU-endian before using it in
> pnv_eeh_get_and_dump_hub_diag().
> 
> Fixes: 2a485ad7c88d ("powerpc/powernv: Drop PHB operation next_error()")
> Cc: stable@vger.kernel.org # v4.1+
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a7032132d7560a8434e1f54b71efd7

cheers
