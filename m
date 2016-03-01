Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A5DE41A03DF
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2016 09:21:19 +1100 (AEDT)
In-Reply-To: <1454988763-5580-3-git-send-email-david@gibson.dropbear.id.au>
To: David Gibson <david@gibson.dropbear.id.au>, paulus@samba.org,
 benh@kernel.crashing.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [2/4] powerpc/mm: Handle removing maybe-present bolted HPTEs
Message-Id: <20160301222119.7AD971402DE@ozlabs.org>
Date: Wed,  2 Mar 2016 09:21:19 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-09-02 at 03:32:41 UTC, David Gibson wrote:
> At the moment the hpte_removebolted callback in ppc_md returns void and
> will BUG_ON() if the hpte it's asked to remove doesn't exist in the first
> place.  This is awkward for the case of cleaning up a mapping which was
> partially made before failing.
> 
> So, we add a return value to hpte_removebolted, and have it return ENOENT
> in the case that the HPTE to remove didn't exist in the first place.
> 
> In the (sole) caller, we propagate errors in hpte_removebolted to its
> caller to handle.  However, we handle ENOENT specially, continuing to
> complete the unmapping over the specified range before returning the error
> to the caller.
> 
> This means that htab_remove_mapping() will work sanely on a partially
> present mapping, removing any HPTEs which are present, while also returning
> ENOENT to its caller in case it's important there.
> 
> There are two callers of htab_remove_mapping():
>    - In remove_section_mapping() we already WARN_ON() any error return,
>      which is reasonable - in this case the mapping should be fully
>      present
>    - In vmemmap_remove_mapping() we BUG_ON() any error.  We change that to
>      just a WARN_ON() in the case of ENOENT, since failing to remove a
>      mapping that wasn't there in the first place probably shouldn't be
>      fatal.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/27828f98a0522ad4a745a80407

cheers
