Return-Path: <SRS0=2rUD=Q5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0276C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:32:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 538362081B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 10:32:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 538362081B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445SMT5jcXzDqN2
	for <linuxppc-dev@archiver.kernel.org>; Fri, 22 Feb 2019 21:32:21 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445RNK3Y8qzDqLJ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Feb 2019 20:48:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 445RNJ6PJzz9sNj; Fri, 22 Feb 2019 20:48:00 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 445RNJ37n7z9sNH; Fri, 22 Feb 2019 20:47:59 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: ca6d5149d2ad0a8d2f9c28cbe379802260a0a5e0
X-Patchwork-Hint: ignore
In-Reply-To: <20190215061400.20302-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/ptrace: Simplify vr_get/set() to avoid GCC warning
Message-Id: <445RNJ37n7z9sNH@ozlabs.org>
Date: Fri, 22 Feb 2019 20:47:59 +1100 (AEDT)
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: malat@debian.org, mroos@linux.ee
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 2019-02-15 at 06:14:00 UTC, Michael Ellerman wrote:
> GCC 8 warns about the logic in vr_get/set(), which with -Werror breaks
> the build:
> 
>   In function âuser_regset_copyinâ,
>       inlined from âvr_setâ at arch/powerpc/kernel/ptrace.c:628:9:
>   include/linux/regset.h:295:4: error: âmemcpyâ offset [-527, -529] is
>   out of the bounds [0, 16] of object âvrsaveâ with type âunion
>   <anonymous>â [-Werror=array-bounds]
>   arch/powerpc/kernel/ptrace.c: In function âvr_setâ:
>   arch/powerpc/kernel/ptrace.c:623:5: note: âvrsaveâ declared here
>      } vrsave;
> 
> This has been identified as a regression in GCC, see GCC bug 88273.
> 
> However we can avoid the warning and also simplify the logic and make
> it more robust.
> 
> Currently we pass -1 as end_pos to user_regset_copyout(). This says
> "copy up to the end of the regset".
> 
> The definition of the regset is:
> 	[REGSET_VMX] = {
> 		.core_note_type = NT_PPC_VMX, .n = 34,
> 		.size = sizeof(vector128), .align = sizeof(vector128),
> 		.active = vr_active, .get = vr_get, .set = vr_set
> 	},
> 
> The end is calculated as (n * size), ie. 34 * sizeof(vector128).
> 
> In vr_get/set() we pass start_pos as 33 * sizeof(vector128), meaning
> we can copy up to sizeof(vector128) into/out-of vrsave.
> 
> The on-stack vrsave is defined as:
>   union {
> 	  elf_vrreg_t reg;
> 	  u32 word;
>   } vrsave;
> 
> And elf_vrreg_t is:
>   typedef __vector128 elf_vrreg_t;
> 
> So there is no bug, but we rely on all those sizes lining up,
> otherwise we would have a kernel stack exposure/overwrite on our
> hands.
> 
> Rather than relying on that we can pass an explict end_pos based on
> the sizeof(vrsave). The result should be exactly the same but it's
> more obviously not over-reading/writing the stack and it avoids the
> compiler warning.
> 
> Reported-by: Meelis Roos <mroos@linux.ee>
> Reported-by: Mathieu Malaterre <malat@debian.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Tested-by: Mathieu Malaterre <malat@debian.org>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/ca6d5149d2ad0a8d2f9c28cbe3798022

cheers
