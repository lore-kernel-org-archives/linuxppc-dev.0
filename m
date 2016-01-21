Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2521E1A0018
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 16:34:08 +1100 (AEDT)
In-Reply-To: <1453077867-23873-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: amodra@gmail.com, rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
 quentin.casasnovas@oracle.com, paul.gortmaker@windriver.com,
 Anton Blanchard <anton@samba.org>
Subject: Re: powerpc: Simplify module TOC handling
Message-Id: <20160121053407.A6CEB140BF6@ozlabs.org>
Date: Thu, 21 Jan 2016 16:34:07 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-18-01 at 00:44:27 UTC, Michael Ellerman wrote:
> From: Alan Modra <amodra@gmail.com>
> 
> PowerPC64 uses the symbol .TOC. much as other targets use
> _GLOBAL_OFFSET_TABLE_. It identifies the value of the GOT pointer (or in
> powerpc parlance, the TOC pointer). Global offset tables are generally
> local to an executable or shared library, or in the kernel, module. Thus
> it does not make sense for a module to resolve a relocation against
> .TOC. to the kernel's .TOC. value. A module has its own .TOC., and
> indeed the powerpc64 module relocation processing ignores the kernel
> value of .TOC. and instead calculates a module-local value.
> 
> This patch removes code involved in exporting the kernel .TOC., tweaks
> modpost to ignore an undefined .TOC., and the module loader to twiddle
> the section symbol so that .TOC. isn't seen as undefined.
> 
> Note that if the kernel was compiled with -msingle-pic-base then ELFv2
> would not have function global entry code setting up r2. In that case
> the module call stubs would need to be modified to set up r2 using the
> kernel .TOC. value, requiring some of this code to be reinstated.
> 
> mpe: Furthermore a change in binutils master (not yet released) causes
> the current way we handle the TOC to no longer work when building with
> MODVERSIONS=y and RELOCATABLE=n. The symptom is that modules can not be
> loaded due to there being no version found for TOC.
> 
> Cc: stable@vger.kernel.org # 3.16+
> Signed-off-by: Alan Modra <amodra@gmail.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/c153693d7eb9eeb28478aa2dea

cheers
