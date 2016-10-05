Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3spfzt0NTkzDqQq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2016 13:36:26 +1100 (AEDT)
In-Reply-To: <1470111037-18531-2-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: paulus@samba.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [1/9] powerpc/powernv: Pass CPU-endian PE number to
 opal_pci_eeh_freeze_clear()
Message-Id: <3spfzs4nsnz9sCg@ozlabs.org>
Date: Wed,  5 Oct 2016 13:36:25 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-02-08 at 04:10:29 UTC, Gavin Shan wrote:
> The PE number (@frozen_pe_no), filled by opal_pci_next_error() is in
> big-endian format. It should be converted to CPU-dian before it is
> passed to opal_pci_eeh_freeze_clear() when clearing the frozen state
> if the PE is invalid one. As Michael Ellerman pointed out, the issue
> is also detected by sparse:
> 
>   gwshan@gwshan:~/sandbox/l$ make C=2 CF=-D__CHECK_ENDIAN__ \
>                     arch/powerpc/platforms/powernv/eeh-powernv.o
>       :
>   arch/powerpc/platforms/powernv/eeh-powernv.c:1541:41: \
>   warning: incorrect type in argument 2 (different base types)
>   arch/powerpc/platforms/powernv/eeh-powernv.c:1541:41: \
>   expected unsigned long long [unsigned] [usertype] pe_number
>   arch/powerpc/platforms/powernv/eeh-powernv.c:1541:41: \
>   got restricted __be64 [addressable] [usertype] frozen_pe_no
> 
> This passes CPU-endian PE number to opal_pci_eeh_freeze_clear() and
> it should be part of commit <0f36db77643b> ("powerpc/eeh: Fix wrong
> printed PE number"), which was merged to 4.3 kernel.
> 
> Fixes: 71b540adffd9 ("powerpc/powernv: Don't escalate non-existing frozen PE")
> Cc: stable@vger.kernel.org # v4.3+
> Suggested-by: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/d63e51b31e0b655ed0f581b8a8fd4c

cheers
