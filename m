Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 757B41A119F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 15:08:27 +1100 (AEDT)
In-Reply-To: <20151203223106.47b2be5b@kryten>
To: Anton Blanchard <anton@samba.org>, benh@kernel.crashing.org,
 paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: powerpc/vdso: Remove sys_ni_syscall and sys_call_table prototypes
Message-Id: <20151217040827.47D8714030D@ozlabs.org>
Date: Thu, 17 Dec 2015 15:08:27 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-03-12 at 11:31:06 UTC, Anton Blanchard wrote:
> Prototypes for sys_ni_syscall and sys_call_table are available
> in header files, so remove the prototypes in c code.
> 
> This was noticed when building with -flto, because the prototype for
> sys_ni_syscall doesn't match the function and we get a compiler error.

Doesn't build for me:

arch/powerpc/kernel/vdso.c:675:27: error: comparison between pointer and integer [-Werror]
   if (sys_call_table[i*2] != sys_ni_syscall)
                           ^

etc.

cheers
