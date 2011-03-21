Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7291DB6F01
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Mar 2011 12:47:29 +1100 (EST)
Subject: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 Mar 2011 12:46:41 +1100
Message-ID: <1300672001.2402.203.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Linus

Here's a fix for the regression introduced by
b5d937de0367d26f65b9af1aef5f2c34c1939be0 along with a bug fix from Mike
Wolf for a nasty BUG_ON() that shoudn't be there for some odd case of
threaded core dumps, and 3 patches from Meador Inge that I plain forgot
to include before.

Cheers,
Ben.

The following changes since commit a952baa034ae7c2e4a66932005cbc7ebbccfe28d:

  Merge branch 'for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/dtor/input (2011-03-19 22:27:06 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Benjamin Herrenschmidt (1):
      powerpc/pci: Fix crash in PCI code on ppc64 when matching device nodes

Meador Inge (3):
      powerpc: Document the Open PIC device tree binding
      powerpc: Make MPIC honor the "pic-no-reset" device tree property
      powerpc: Factoring mpic cpu id fetching into a function

Mike Wolf (1):
      powerpc/ptrace: Remove BUG_ON when full register set not available

 Documentation/devicetree/bindings/open-pic.txt |   98 ++++++++++++++++++++++++
 arch/powerpc/include/asm/mpic.h                |    4 +
 arch/powerpc/include/asm/ptrace.h              |    2 +
 arch/powerpc/kernel/pci_dn.c                   |    7 +-
 arch/powerpc/kernel/ptrace.c                   |   15 +++-
 arch/powerpc/sysdev/mpic.c                     |   85 +++++++++++++++-----
 6 files changed, 184 insertions(+), 27 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/open-pic.txt
