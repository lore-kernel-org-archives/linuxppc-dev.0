Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC1001A0AF0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jan 2016 00:09:26 +1100 (AEDT)
In-Reply-To: <1452600863-6294-2-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: ulrich.weigand@de.ibm.com, Anton Blanchard <anton@samba.org>,
 rostedt@goodmis.org, amodra@gmail.com
Subject: Re: [2/2] powerpc/module: Handle R_PPC64_ENTRY relocations
Message-Id: <20160113130926.2805B140556@ozlabs.org>
Date: Thu, 14 Jan 2016 00:09:25 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-12-01 at 12:14:23 UTC, Michael Ellerman wrote:
> From: Ulrich Weigand <ulrich.weigand@de.ibm.com>
> 
> GCC 6 will include changes to generated code with -mcmodel=large,
> which is used to build kernel modules on powerpc64le.  This was
> necessary because the large model is supposed to allow arbitrary
> sizes and locations of the code and data sections, but the ELFv2
> global entry point prolog still made the unconditional assumption
> that the TOC associated with any particular function can be found
> within 2 GB of the function entry point:
> 
> func:
> 	addis r2,r12,(.TOC.-func)@ha
> 	addi  r2,r2,(.TOC.-func)@l
> 	.localentry func, .-func
> 
> To remove this assumption, GCC will now generate instead this global
> entry point prolog sequence when using -mcmodel=large:
> 
> 	.quad .TOC.-func
> func:
> 	.reloc ., R_PPC64_ENTRY
> 	ld    r2, -8(r12)
> 	add   r2, r2, r12
> 	.localentry func, .-func
> 
> The new .reloc triggers an optimization in the linker that will
> replace this new prolog with the original code (see above) if the
> linker determines that the distance between .TOC. and func is in
> range after all.
> 
> Since this new relocation is now present in module object files,
> the kernel module loader is required to handle them too.  This
> patch adds support for the new relocation and implements the
> same optimization done by the GNU linker.
> 
> Cc: stable@vger.kernel.org
> Signed-off-by: Ulrich Weigand <ulrich.weigand@de.ibm.com>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/a61674bdfc7c2bf909c4010699

cheers
