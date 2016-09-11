Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXY9b3LdkzDsMB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 13:25:55 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id x24so7405932pfa.3
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Sep 2016 20:25:55 -0700 (PDT)
Date: Sun, 11 Sep 2016 21:58:57 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Cyril Bur <cyrilbur@gmail.com>, Michael Neuling <mikey@neuling.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Amanieu d'Antras <amanieu@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: set used_vsr/used_vr/used_spe in sigreturn path
 when MSR bits are active
Message-ID: <20160911135857.GA1137@simonLocalRHEL7.x64>
References: <1469520361-9035-1-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469520361-9035-1-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 26, 2016 at 04:06:01PM +0800, wei.guo.simon@gmail.com wrote:
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
Hi Michael,

Just a ping for this patch. 
The history locates at:
http://linuxppc.10917.n7.nabble.com/PATCH-v4-powerpc-Export-thread-struct-used-vr-used-vsr-to-user-space-td110147.html#a110161

If any addtional work required, please let me know.

Thanks,
- Simon
