Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 27DF71A03DF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 09:21:19 +1100 (AEDT)
In-Reply-To: <1454988763-5580-2-git-send-email-david@gibson.dropbear.id.au>
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org,
 benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [1/4] powerpc/mm: Clean up error handling for htab_remove_mapping
Message-Id: <20160301222118.F3D371402C4@ozlabs.org>
Date: Wed,  2 Mar 2016 09:21:18 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-09-02 at 03:32:40 UTC, David Gibson wrote:
> Currently, the only error that htab_remove_mapping() can report is -EINVAL,
> if removal of bolted HPTEs isn't implemeted for this platform.  We make
> a few clean ups to the handling of this:
> 
>  * EINVAL isn't really the right code - there's nothing wrong with the
>    function's arguments - use ENODEV instead
>  * We were also printing a warning message, but that's a decision better
>    left up to the callers, so remove it
>  * One caller is vmemmap_remove_mapping(), which will just BUG_ON() on
>    error, making the warning message redundant, so no change is needed
>    there.
>  * The other caller is remove_section_mapping().  This is called in the
>    memory hot remove path at a point after vmemmap_remove_mapping() so
>    if hpte_removebolted isn't implemented, we'd expect to have already
>    BUG()ed anyway.  Put a WARN_ON() here, in lieu of a printk() since this
>    really shouldn't be happening.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/abd0a0e7914a1137973119ac3b

cheers
