Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>,
	<cbe-oss-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 07 Feb 2007 15:50:50 +1100
Subject: [PATCH 0/3] spufs: don't need struct page for SPEs
Message-Id: <1170823850.450936.293648942401.qpush@grosgo>
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This serie of patches removes the dependency of spufs on having
struct page for the SPE local stores and register spaces. That
means it technically also removes the need for sparsemem for
native Cell setups though Kconfig still forces it enabled when
CONFIG_NUMA is set (might be fixable separately).

The first patch is from Nick Piggin, it's part of his serie reworking
the nopage handling, though it's also perfectly useable standalone.

The second patch adds a NOPFN_REFAULT return option from ->nopfn()
equivalent to the NOPAGE_REFAULT I added a while ago for ->nopage() so
I can use nopfn instead of nopage and thus use VM_PFNMAP for my VMAs

The third patch converts the spufs code to not use struct page and
removes the code in the cell platform that creates them

I have no firm feeling on wether those should be in 2.6.21 or not,
they are pre-requisite for some other work I'm doing with spufs but
which won't be in 2.6.21 (well, I don't think it will be ready in time
and it doesn't really matter) so I'm mostly posting this here for
review/comment/backup :-) I would appreciate testing too, I did some
tests here and they seem to pass but heh, the more the better.

Ben.
