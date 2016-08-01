Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s2x2W5jmMzDqQ9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Aug 2016 20:50:59 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: paulus@samba.org, benh@kernel.crashing.org, ruscur@russell.cc,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc/powernv: Fix BE PE number to
 opal_pci_eeh_freeze_clear()
In-Reply-To: <1470034990-18860-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1470034990-18860-1-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Mon, 01 Aug 2016 20:50:58 +1000
Message-ID: <87k2g0oj8t.fsf@concordia.ellerman.id.au>
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

Gavin Shan <gwshan@linux.vnet.ibm.com> writes:

> The PE number (@frozen_pe_no), filled by opal_pci_next_error() is
> in big-endian format. Frozen PE number in CPU-endian should be passed
> to opal_pci_eeh_freeze_clear() when clearing the frozen state if the
> PE is invalid one.
>
> This passes CPU-endian PE number to opal_pci_eeh_freeze_clear() and
> it should be part of commit <0f36db77643b> ("powerpc/eeh: Fix wrong
> printed PE number").

Which commit added the broken usage?

Looks like 2a485ad7c88d ("powerpc/powernv: Drop PHB operation
next_error()") ?

> Cc: stable@vger.kernel.org # v4.3+
> Suggested-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/eeh-powernv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/powerpc/platforms/powernv/eeh-powernv.c b/arch/powerpc/platforms/powernv/eeh-powernv.c
> index 86544ea..75363d9 100644
> --- a/arch/powerpc/platforms/powernv/eeh-powernv.c
> +++ b/arch/powerpc/platforms/powernv/eeh-powernv.c
> @@ -1538,7 +1538,7 @@ static int pnv_eeh_next_error(struct eeh_pe **pe)
>  
>  				/* Try best to clear it */
>  				opal_pci_eeh_freeze_clear(phb->opal_id,
> -					frozen_pe_no,
> +					be64_to_cpu(frozen_pe_no),

Sparse knew about this:

  arch/powerpc/platforms/powernv/eeh-powernv.c:1541:41: warning: incorrect type in argument 2 (different base types)
  arch/powerpc/platforms/powernv/eeh-powernv.c:1541:41:    expected unsigned long long [unsigned] [usertype] pe_number
  arch/powerpc/platforms/powernv/eeh-powernv.c:1541:41:    got restricted __be64 [addressable] [usertype] frozen_pe_no

And finds some other problems in that file:

  arch/powerpc/platforms/powernv/eeh-powernv.c:875:23: warning: constant 0x8000000000000000 is so big it is unsigned long
  arch/powerpc/platforms/powernv/eeh-powernv.c:1309:21: warning: restricted __be16 degrades to integer

cheers
