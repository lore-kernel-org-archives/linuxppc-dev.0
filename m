Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CBB1B1A045E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 09:21:19 +1100 (AEDT)
In-Reply-To: <1454988763-5580-4-git-send-email-david@gibson.dropbear.id.au>
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org,
 benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [3/4] powerpc/mm: Clean up memory hotplug failure paths
Message-Id: <20160301222119.ABDE3140B0D@ozlabs.org>
Date: Wed,  2 Mar 2016 09:21:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-09-02 at 03:32:42 UTC, David Gibson wrote:
> This makes a number of cleanups to handling of mapping failures during
> memory hotplug on Power:
> 
> For errors creating the linear mapping for the hot-added region:
>   * This is now reported with EFAULT which is more appropriate than the
>     previous EINVAL (the failure is unlikely to be related to the
>     function's parameters)
>   * An error in this path now prints a warning message, rather than just
>     silently failing to add the extra memory.
>   * Previously a failure here could result in the region being partially
>     mapped.  We now clean up any partial mapping before failing.
> 
> For errors creating the vmemmap for the hot-added region:
>    * This is now reported with EFAULT instead of causing a BUG() - this
>      could happen for external reason (e.g. full hash table) so it's better
>      to handle this non-fatally
>    * An error message is also printed, so the failure won't be silent
>    * As above a failure could cause a partially mapped region, we now
>      clean this up.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Paul Mackerras <paulus@samba.org>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1dace6c665ec59bdc4eeafa4db

cheers
