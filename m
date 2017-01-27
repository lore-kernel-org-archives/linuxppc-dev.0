Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8jFl5z3RzDq8B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 13:21:15 +1100 (AEDT)
Date: Fri, 27 Jan 2017 13:21:06 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] KVM: PPC: Book3S: Change interrupt call to reduce
 scratch space use on HV
Message-ID: <20170127022106.24mq6yjmi7pjqro7@oak.ozlabs.ibm.com>
References: <20161221182927.24562-1-npiggin@gmail.com>
 <20161221182927.24562-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161221182927.24562-2-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Dec 22, 2016 at 04:29:25AM +1000, Nicholas Piggin wrote:
> Change the calling convention to put the trap number together with
> CR in two halves of r12, which frees up HSTATE_SCRATCH2 in the HV
> handler.
> 
> The 64-bit PR handler entry translates the calling convention back
> to match the previous call convention (i.e., shared with 32-bit), for
> simplicity.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Paul Mackerras <paulus@ozlabs.org>

I notice that I forgot to add the code to save CFAR to the
__KVM_HANDLER_SKIP macro.  We should fix that.

Paul.
