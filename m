Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A73FA1A0DCE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Jul 2015 16:55:06 +1000 (AEST)
In-Reply-To: <1436483065-9202-1-git-send-email-dja@axtens.net>
To: Daniel Axtens <dja@axtens.net>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, Daniel Axtens <dja@axtens.net>, imunsie@au.ibm.com
Subject: Re: cxl: Check if afu is not null in cxl_slbia
Message-Id: <20150710065506.72FE41402D6@ozlabs.org>
Date: Fri, 10 Jul 2015 16:55:06 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-09-07 at 23:04:25 UTC, Daniel Axtens wrote:
> The pointer to an AFU in the adapter's list of AFUs can be null
> if we're in the process of removing AFUs. The afu_list_lock
> doesn't guard against this.
> 
> Say we have 2 slices, and we're in the process of removing cxl.
>  - We remove the AFUs in order (see cxl_remove). In cxl_remove_afu
>    for AFU 0, we take the lock, set adapter->afu[0] = NULL, and
>    release the lock.
>  - Then we get an slbia. In cxl_slbia we take the lock, and set
>    afu = adapter->afu[0], which is NULL.
>  - Therefore our attempt to check afu->enabled will blow up.
> 
> Therefore, check if afu is a null pointer before dereferencing it.
>
Cc: stable@vger.kernel.org
> Signed-off-by: Daniel Axtens <dja@axtens.net>
> Acked-by: Michael Neuling <mikey@neuling.org>
> Acked-by: Ian Munsie <imunsie@au1.ibm.com>

Applied to powerpc fixes, thanks.

https://git.kernel.org/powerpc/c/2c069a118fe1d80c47dc

cheers
