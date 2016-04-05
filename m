Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qfNxw5SpTzDq6T
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  5 Apr 2016 19:35:32 +1000 (AEST)
In-Reply-To: <20160404211112.66b0756f@kryten>
To: Paul Mackerras via Linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, Paul Mackerras <paulus@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <mikey@neuling.org>,
 David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: qemu-ppc@nongnu.org, linuxppc-dev@lists.ozlabs.org, qemu-devel@nongnu.org
Subject: Re: powerpc: Clear user CPU feature bits if TM is disabled at runtime
Message-Id: <3qfNxw4KcCz9sD5@ozlabs.org>
Date: Tue,  5 Apr 2016 19:35:32 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-04-04 at 11:11:12 UTC, Paul Mackerras via Linuxppc-dev wrote:
> In check_cpu_pa_features() we check a number of bits in the

Shouldn't we be clearing the user feature there too?

The ibm_pa_features array and the logic in scan_features() knows to flip the
cpu_user_features bits, it was just never updated to handle cpu_user_features2.

So it seems to me that's where the bug is.

> ibm,pa-features array and set and clear CPU features based on what
> we find. One of these bits is CPU_FTR_TM, the transactional memory
> feature bit.
> 
> If this does disable TM at runtime, then we need to tell userspace
> about it by clearing the user CPU feature bits.
> 
> Without this patch userspace processes will think they can execute
> TM instructions and get killed when they try.
> 
> Signed-off-by: Anton Blanchard <anton@samba.org>
> Cc: stable@vger.kernel.org
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
> ---
> 
> Michael I've added stable here because I'm seeing this on a number
> of distros and would like to get it backported, but I'll leave it up
> to you if it should go there.

Yeah it should definitely go to stable. Can we pinpoint which commit introduced
the bug, I guess whenever the TM support was merged.

cheers
