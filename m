Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zN93h5xffzF0yr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Jan 2018 16:53:20 +1100 (AEDT)
Date: Fri, 19 Jan 2018 16:53:19 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Nicholas Piggin
 <npiggin@gmail.com>
Subject: linux-next: build failure after merge of the powerpc tree
Message-ID: <20180119165319.524cf2ff@canb.auug.org.au>
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

Hi all,

After merging the powerpc tree, today's linux-next build (powerpc64
allnoconfig) failed like this:

arch/powerpc/kernel/mce_power.o: In function `.mce_handle_error':
mce_power.c:(.text+0x5a8): undefined reference to `.hash__tlbiel_all'
mce_power.c:(.text+0x6b8): undefined reference to `.hash__tlbiel_all'
arch/powerpc/mm/hash_utils_64.o: In function `.hash__early_init_mmu':
hash_utils_64.c:(.init.text+0x9d0): undefined reference to `.hash__tlbiel_all'

Caused by commit

  d4748276ae14 ("powerpc/64s: Improve local TLB flush for boot and MCE on POWER9")

The definition of hash__tlbiel_all() is in
arch/powerpc/mm/hash_native_64.c which is only built if CONFIG_PPC_NATIVE
is set, which it is not for this build.

I applied a supplied fix patch.

-- 
Cheers,
Stephen Rothwell
