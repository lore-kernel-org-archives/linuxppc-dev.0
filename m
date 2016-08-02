Return-Path: <ruscur@russell.cc>
Received: from russell.cc (russell.cc [IPv6:2404:9400:2:0:216:3eff:fee0:3370])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s3Nc22h78zDrHl
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Aug 2016 14:33:06 +1000 (AEST)
Message-ID: <1470112385.13482.2.camel@russell.cc>
Subject: Re: [PATCH 2/9] powerpc/powernv: Use CPU-endian hub diag-data type
 in pnv_eeh_get_and_dump_hub_diag()
From: Russell Currey <ruscur@russell.cc>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org
Date: Tue, 02 Aug 2016 14:33:05 +1000
In-Reply-To: <1470111037-18531-3-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1470111037-18531-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1470111037-18531-3-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-08-02 at 14:10 +1000, Gavin Shan wrote:
> The hub diag-data type is filled with big-endian data by OPAL call
> opal_pci_get_hub_diag_data(). We need convert it to CPU-endian value
> before using it. The issue is reported by sparse as pointed by Michael
> Ellerman:
> 
>   gwshan@gwshan:~/sandbox/l$ make C=2 CF=-D__CHECK_ENDIAN__ \
>                         arch/powerpc/platforms/powernv/eeh-powernv.o
>        :
>   arch/powerpc/platforms/powernv/eeh-powernv.c:1309:21: \
>   warning: restricted __be16 degrades to integer
>   arch/powerpc/platforms/powernv/eeh-powernv.c:1309:21: \
>   warning: restricted __be16 degrades to integer
>   arch/powerpc/platforms/powernv/eeh-powernv.c:1309:21: \
>   warning: restricted __be16 degrades to integer
>   arch/powerpc/platforms/powernv/eeh-powernv.c:1309:21: \
>   warning: restricted __be16 degrades to integer
>   arch/powerpc/platforms/powernv/eeh-powernv.c:1309:21: \
>   warning: restricted __be16 degrades to integer
> 
> This converts hub diag-data type to CPU-endian before using it in
> pnv_eeh_get_and_dump_hub_diag().
> 
> Fixes: 2a485ad7c88d ("powerpc/powernv: Drop PHB operation next_error()")
> Cc: stable@vger.kernel.org # v4.1+
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---

Reviewed-by: Russell Currey <ruscur@russell.cc>
