Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hZlm17kCzF2CH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 00:06:44 +1000 (AEST)
In-Reply-To: <20180507130355.25115-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: anton@samba.org
Subject: Re: powerpc/pseries: hcall_exit tracepoint retval should be signed
Message-Id: <40hZlj2K0dz9s1b@ozlabs.org>
Date: Fri, 11 May 2018 00:06:40 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-05-07 at 13:03:55 UTC, Michael Ellerman wrote:
> The hcall_exit() tracepoint has retval defined as unsigned long. That
> leads to humours results like:
> 
>   bash-3686  [009] d..2   854.134094: hcall_entry: opcode=24
>   bash-3686  [009] d..2   854.134095: hcall_exit: opcode=24 retval=18446744073709551609
> 
> It's normal for some hcalls to return negative values, displaying them
> as unsigned isn't very helpful. So change it to signed.
> 
>   bash-3711  [001] d..2   471.691008: hcall_entry: opcode=24
>   bash-3711  [001] d..2   471.691008: hcall_exit: opcode=24 retval=-7
> 
> Which can be more easily compared to H_NOT_FOUND in hvcall.h
> 
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> Acked-by: Anton Blanchard <anton@samba.org>

Applied to powerpc next.

https://git.kernel.org/powerpc/c/8f2133cc0e1f9718f3e2d39b7587f4

cheers
