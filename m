Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYNvW05ZPzDsTx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 22:16:39 +1000 (AEST)
In-Reply-To: <1469520361-9035-1-git-send-email-wei.guo.simon@gmail.com>
To: Simon Guo <wei.guo.simon@gmail.com>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Michael Neuling <mikey@neuling.org>, Amanieu d'Antras <amanieu@gmail.com>,
 Simon Guo <wei.guo.simon@gmail.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Cyril Bur <cyrilbur@gmail.com>
Subject: Re: powerpc: set used_vsr/used_vr/used_spe in sigreturn path when MSR
 bits are active
Message-Id: <3sYNvV5Mb5z9svs@ozlabs.org>
Date: Tue, 13 Sep 2016 22:16:38 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-26-07 at 08:06:01 UTC, Simon Guo wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> Normally, when MSR[VSX/VR/SPE] bits = 1, the used_vsr/used_vr/used_spe
> bit have already been set. However signal frame locates at user space
> and it is controlled by user application. It is up to kernel to make
> sure used_vsr/used_vr/used_spe(in kernel)=1 and consistent with MSR
> bits.
> 
> For example, CRIU application, who utilizes sigreturn to restore
> checkpointed process, will lead to the case where MSR[VSX] bit is
> active in signal frame, but used_vsx bit is not set. (the same applies
> to VR/SPE).
> 
> This patch will reinforce this at kernel by always setting used_* bit
> when MSR related bits are active in signal frame and we are doing
> sigreturn.
> 
> This patch is based on Ben's Proposal.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Simon Guo <wei.guo.simon@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/e1c0d66fcb179a1737b3d5cc11

cheers
