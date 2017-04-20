Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w7ng33sVHzDq9B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Apr 2017 15:36:47 +1000 (AEST)
Date: Thu, 20 Apr 2017 15:36:47 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel
 Mailing List <linux-kernel@vger.kernel.org>, Michael Ellerman
 <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: linux-next: build failure after merge of the rcu tree
Message-ID: <20170420153647.1a93652b@canb.auug.org.au>
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

Hi Paul,

[Also reported by Michael elsewhere]

After merging the rcu tree, today's linux-next build (powerpc
pseries_le_defconfig) failed like this:

arch/powerpc/kvm/book3s_hv_rmhandlers.S: Assembler messages:
arch/powerpc/kvm/book3s_hv_rmhandlers.S:587: Error: operand out of range (0x0000000000009ff8 is not between 0xffffffffffff8000 and 0x0000000000007fff)
arch/powerpc/kvm/book3s_hv_rmhandlers.S:617: Error: operand out of range (0x0000000000009d88 is not between 0xffffffffffff8000 and 0x0000000000007fff)
arch/powerpc/kvm/book3s_hv_rmhandlers.S:619: Error: operand out of range (0x0000000000009dc0 is not between 0xffffffffffff8000 and 0x0000000000007ffc)
arch/powerpc/kvm/book3s_hv_rmhandlers.S:643: Error: operand out of range (0x0000000000009df8 is not between 0xffffffffffff8000 and 0x0000000000007fff)
arch/powerpc/kvm/book3s_hv_rmhandlers.S:650: Error: operand out of range (0x0000000000009d8c is not between 0xffffffffffff8000 and 0x0000000000007fff)
arch/powerpc/kvm/book3s_hv_rmhandlers.S:1353: Error: operand out of range (0x0000000000009ff8 is not between 0xffffffffffff8000 and 0x0000000000007fff)
arch/powerpc/kvm/book3s_hv_rmhandlers.S:1663: Error: operand out of range (0x0000000000009db0 is not between 0xffffffffffff8000 and 0x0000000000007fff)
arch/powerpc/kvm/book3s_hv_rmhandlers.S:1665: Error: operand out of range (0x0000000000009dc8 is not between 0xffffffffffff8000 and 0x0000000000007ffc)
arch/powerpc/kvm/book3s_hv_rmhandlers.S:1734: Error: operand out of range (0x0000000000009db8 is not between 0xffffffffffff8000 and 0x0000000000007ffc)
arch/powerpc/kvm/book3s_hv_rmhandlers.S:1782: Error: operand out of range (0x0000000000009ff8 is not between 0xffffffffffff8000 and 0x0000000000007fff)
arch/powerpc/kvm/book3s_hv_rmhandlers.S:1837: Error: operand out of range (0x0000000000009de0 is not between 0xffffffffffff8000 and 0x0000000000007ffc)
arch/powerpc/kvm/book3s_hv_rmhandlers.S:1877: Error: operand out of range (0x0000000000009ff8 is not between 0xffffffffffff8000 and 0x0000000000007fff)
arch/powerpc/kvm/book3s_hv_rmhandlers.S:1918: Error: operand out of range (0x0000000000009de0 is not between 0xffffffffffff8000 and 0x0000000000007ffc)
arch/powerpc/kvm/book3s_hv_rmhandlers.S:1943: Error: operand out of range (0x000000000000a048 is not between 0xffffffffffff8000 and 0x0000000000007ffc)

Caused by commit

  b2bb79507ba1 ("srcu: Parallelize callback handling")

I have left it broken for today.

-- 
Cheers,
Stephen Rothwell
