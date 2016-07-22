Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rwfrf6VSwzDqYB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Jul 2016 15:50:42 +1000 (AEST)
In-Reply-To: <1468903711-5869-1-git-send-email-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, <linuxppc-dev@ozlabs.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: duwe@lst.de, aneesh.kumar@linux.vnet.ibm.com,
 Anton Blanchard <anton@samba.org>
Subject: Re: [1/2] powerpc/ftrace: Separate the heuristics for checking call
 sites
Message-Id: <3rwfrf4yxkz9srZ@ozlabs.org>
Date: Fri, 22 Jul 2016 15:50:42 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-19-07 at 04:48:30 UTC, Michael Ellerman wrote:
> In __ftrace_make_nop() (the 64-bit version), we have code to deal with
> two ftrace ABIs. There is the original ABI, which looks mostly like a
> function call, and then the mprofile-kernel ABI which is just a branch.
> 
> The code tries to handle both cases, by looking for the presence of a
> load to restore the TOC pointer (PPC_INST_LD_TOC). If we detect the TOC
> load, we assume the call site is for an mcount() call using the old ABI.
> That means we patch the mcount() call with a b +8, to branch over the
> TOC load.
> 
> However if the kernel was built with mprofile-kernel, then there will
> never be a call site using the original ftrace ABI. If for some reason
> we do see a TOC load, then it's there for a good reason, and we should
> not jump over it.
> 
> So split the code, using the existing CC_USING_MPROFILE_KERNEL. Kernels
> built with mprofile-kernel will only look for, and expect, the new ABI,
> and similarly for the original ABI.
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/9d636109511a000882f8dff4ea

cheers
