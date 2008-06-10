Return-Path: <shaggy@linux.vnet.ibm.com>
Date: Tue, 10 Jun 2008 18:00:55 -0400
From: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
To: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
Message-Id: <20080610220055.10257.84465.sendpatchset@norville.austin.ibm.com>
Subject: [RFC:PATCH 00/06] Strong Access Ordering page attributes for POWER7
Cc: linux-mm <linux-mm@kvack.org>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

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

Patches built against 2.6.26-rc5.

Any and all suggestions, complaints, flames, insults, etc. are appreciated.

Thanks,
Shaggy
