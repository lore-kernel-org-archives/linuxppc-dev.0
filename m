Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcNCM0fjjzDqGr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 15:56:31 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id f27so15553593pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 22:56:30 -0700 (PDT)
Date: Tue, 30 May 2017 15:56:12 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] powernv:idle: Correctly initialize core_idle_state_ptr
Message-ID: <20170530155612.701ca6fc@roar.ozlabs.ibm.com>
In-Reply-To: <f6c49fcf42b78c0b8bdad17d6e659679c0288cd9.1494585671.git.ego@linux.vnet.ibm.com>
References: <cover.1494585671.git.ego@linux.vnet.ibm.com>
 <f6c49fcf42b78c0b8bdad17d6e659679c0288cd9.1494585671.git.ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 16 May 2017 14:19:43 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> The lower 8 bits of core_idle_state_ptr tracks the number of non-idle
> threads in the core. This is supposed to be initialized to bit-map
> corresponding to the threads_per_core. However, currently it is
> initialized to PNV_CORE_IDLE_THREAD_BITS (0xFF). This is correct for
> POWER8 which has 8 threads per core, but not for POWER9 which has 4
> threads per core.
> 
> As a result, on POWER9, core_idle_state_ptr gets initialized to
> 0xFF. In case when all the threads of the core are idle, the bits
> corresponding tracking the idle-threads are non-zero. As a result, the
> idle entry/exit code fails to save/restore per-core hypervisor state
> since it assumes that there are threads in the cores which are still
> active.
> 
> Fix this by correctly initializing the lower bits of the
> core_idle_state_ptr on the basis of threads_per_core.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

This looks good to me.

Until this patch series, we can't enable HV state loss idle modes
on POWER9, is that correct? And after your series does it work?

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
