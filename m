Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wi0-x230.google.com (mail-wi0-x230.google.com
 [IPv6:2a00:1450:400c:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4C031A0E56
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 18:23:52 +1000 (AEST)
Received: by wijp15 with SMTP id p15so7646173wij.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2015 01:23:49 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Tue, 25 Aug 2015 10:23:47 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Kevin Hao <haokexin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Peter Zijlstra <peterz@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/6] powerpc: use jump label for {cpu,mmu}_has_feature()
Message-ID: <20150825082346.GB19914@gmail.com>
References: <1440415228-8006-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440415228-8006-1-git-send-email-haokexin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Kevin Hao <haokexin@gmail.com> wrote:

> Hi,
> 
> v2:
> Drop the following two patches as suggested by Ingo and Peter:
>     jump_label: no need to acquire the jump_label_mutex in jump_lable_init()
>     jump_label: introduce DEFINE_STATIC_KEY_{TRUE,FALSE}_ARRAY macros
> 
> v1:
> I have tried to change the {cpu,mmu}_has_feature() to use jump label two yeas
> ago [1]. But that codes seem a bit ugly. This is a reimplementation by moving the
> jump_label_init() much earlier so the jump label can be used in a very earlier
> stage. Boot test on p4080ds, t2080rdb and powermac (qemu). This patch series
> is against linux-next.
> 
> [1] https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-September/111026.html
> 
> Kevin Hao (6):
>   jump_label: make it possible for the archs to invoke jump_label_init()
>     much earlier
>   powerpc: invoke jump_label_init() in a much earlier stage
>   powerpc: kill mfvtb()
>   powerpc: move the cpu_has_feature to a separate file
>   powerpc: use the jump label for cpu_has_feature
>   powerpc: use jump label for mmu_has_feature
> 
>  arch/powerpc/include/asm/cacheflush.h   |  1 +
>  arch/powerpc/include/asm/cpufeatures.h  | 34 ++++++++++++++++++++++++++++++
>  arch/powerpc/include/asm/cputable.h     | 16 +++++++-------
>  arch/powerpc/include/asm/cputime.h      |  1 +
>  arch/powerpc/include/asm/dbell.h        |  1 +
>  arch/powerpc/include/asm/dcr-native.h   |  1 +
>  arch/powerpc/include/asm/mman.h         |  1 +
>  arch/powerpc/include/asm/mmu.h          | 29 ++++++++++++++++++++++++++
>  arch/powerpc/include/asm/reg.h          |  9 --------
>  arch/powerpc/include/asm/time.h         |  3 ++-
>  arch/powerpc/include/asm/xor.h          |  1 +
>  arch/powerpc/kernel/align.c             |  1 +
>  arch/powerpc/kernel/cputable.c          | 37 +++++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/irq.c               |  1 +
>  arch/powerpc/kernel/process.c           |  1 +
>  arch/powerpc/kernel/setup-common.c      |  1 +
>  arch/powerpc/kernel/setup_32.c          |  5 +++++
>  arch/powerpc/kernel/setup_64.c          |  4 ++++
>  arch/powerpc/kernel/smp.c               |  1 +
>  arch/powerpc/platforms/cell/pervasive.c |  1 +
>  arch/powerpc/xmon/ppc-dis.c             |  1 +
>  kernel/jump_label.c                     |  3 +++
>  22 files changed, 135 insertions(+), 18 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/cpufeatures.h

Looks good to me!

Thanks,

	Ingo
