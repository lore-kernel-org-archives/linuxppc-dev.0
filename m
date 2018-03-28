Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40B8x93XP1zF2M4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 29 Mar 2018 01:13:17 +1100 (AEDT)
In-Reply-To: <20170216050339.GC19110@fergus.ozlabs.ibm.com>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: powerpc/64: Call H_REGISTER_PROC_TBL when running as a HPT guest
 on POWER9
Message-Id: <40B8x83bhNz9s0x@ozlabs.org>
Date: Thu, 29 Mar 2018 01:13:16 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2017-02-16 at 05:03:39 UTC, Paul Mackerras wrote:
> On POWER9, since commit cc3d2940133d ("powerpc/64: Enable use of radix
> MMU under hypervisor on POWER9", 2017-01-30), we set both the radix and
> HPT bits in the client-architecture-support (CAS) vector, which tells
> the hypervisor that we can do either radix or HPT.  According to PAPR,
> if we use this combination we are promising to do a H_REGISTER_PROC_TBL
> hcall later on to let the hypervisor know whether we are doing radix
> or HPT.  We currently do this call if we are doing radix but not if
> we are doing HPT.  If the hypervisor is able to support both radix
> and HPT guests, it would be entitled to defer allocation of the HPT
> until the H_REGISTER_PROC_TBL call, and to fail any attempts to create
> HPTEs until the H_REGISTER_PROC_TBL call.  Thus we need to do a
> H_REGISTER_PROC_TBL call when we are doing HPT; otherwise we may
> crash at boot time.
> 
> This adds the code to call H_REGISTER_PROC_TBL in this case, before
> we attempt to create any HPT entries using H_ENTER.
> 
> Fixes: cc3d2940133d ("powerpc/64: Enable use of radix MMU under hypervisor on POWER9")
> Signed-off-by: Paul Mackerras <paulus@ozlabs.org>
> Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/dbfcf3cb9c681aa0c5d0bb46068f98

cheers
