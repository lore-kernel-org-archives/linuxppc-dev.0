Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40QLgN73GdzF1sD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Apr 2018 20:13:36 +1000 (AEST)
In-Reply-To: <20180416143905.2716-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: aik@ozlabs.ru, paulus@samba.org
Subject: Re: [1/5] powerpc/lib: Fix off-by-one in alternate feature patching
Message-Id: <40QLgN4xPVz9s19@ozlabs.org>
Date: Tue, 17 Apr 2018 20:13:36 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-04-16 at 14:39:01 UTC, Michael Ellerman wrote:
> When we patch an alternate feature section, we have to adjust any
> relative branches that branch out of the alternate section.
> 
> But currently we have a bug if we have a branch that points to past
> the last instruction of the alternate section, eg:
> 
>   FTR_SECTION_ELSE
>   1:     b       2f
>          or      6,6,6
>   2:
>   ALT_FTR_SECTION_END(...)
>          nop
> 
> This will result in a relative branch at 1 with a target that equals
> the end of the alternate section.
> 
> That branch does not need adjusting when it's moved to the non-else
> location. Currently we do adjust it, resulting in a branch that goes
> off into the link-time location of the else section, which is junk.
> 
> The fix is to not patch branches that have a target == end of the
> alternate section.
> 
> Fixes: d20fe50a7b3c ("KVM: PPC: Book3S HV: Branch inside feature section")
> Fixes: 9b1a735de64c ("powerpc: Add logic to patch alternative feature sections")
> Cc: stable@vger.kernel.org # v2.6.27+
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/b8858581febb050688e276b956796b

cheers
