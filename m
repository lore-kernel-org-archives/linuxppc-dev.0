Return-Path: <shaggy@linux.vnet.ibm.com>
Message-Id: <20080618223254.966080905@linux.vnet.ibm.com>
Date: Wed, 18 Jun 2008 17:32:54 -0500
From: shaggy@linux.vnet.ibm.com
To: Andrew Morton <akpm@linux-foundation.org>
Subject: [patch 0/6] Strong Access Ordering page attributes for POWER7
Cc: linux-mm@kvack.org, Paul Mackerras <paulus@au1.ibm.com>,
	Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew,

The first patch in this series hits architecture independent code, but the
rest is contained in the powerpc subtree.  Could you pick up the first
patch into -mm?  I can send the rest of them through the powerpc git tree.
The first patch and the rest of the set are independent and can be merged
in either order.

Changes since I posted on June 10:
- Fixed reversed logic in arch_validate_prot() in include/asm-powerpc/mman.h
- Replace binary & with logical && in arch_validate_prot()
- Got rid of HAVE_ARCH_PROT_BITS

Allow an application to enable Strong Access Ordering on specific pages of
memory on Power 7 hardware. Currently, power has a weaker memory model than
x86. Implementing a stronger memory model allows an emulator to more
efficiently translate x86 code into power code, resulting in faster code
execution.

On Power 7 hardware, storing 0b1110 in the WIMG bits of the hpte enables
strong access ordering mode for the memory page.  This patchset allows a
user to specify which pages are thus enabled by passing a new protection
bit through mmap() and mprotect().  I have tentatively defined this bit,
PROT_SAO, as 0x10.

In order to accomplish this, I had to modify the architecture-independent
code to allow the architecture to deal with additional protection bits.

Thanks,
Shaggy
-- 
