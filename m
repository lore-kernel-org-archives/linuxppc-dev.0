Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9EF04B7167
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Sep 2010 11:55:44 +1000 (EST)
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
In-Reply-To: <1283234198.2151.15.camel@pasglop>
References: <1283234198.2151.15.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 02 Sep 2010 11:55:33 +1000
Message-ID: <1283392533.16240.4.camel@pasglop>
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

On Tue, 2010-08-31 at 15:56 +1000, Benjamin Herrenschmidt wrote:
> Hi Linus !
> 
> Here's a few small fixes, one is an important fix for a nasty regression
> breaking pseries machine running under hypervisor... oops !

I updated this with some embedded fixed from Kumar and a fix for a new
deadlock in the pseries dlpar code.

New log below.

Cheers,
Ben.

The following changes since commit 2bfc96a127bc1cc94d26bfaa40159966064f9c8c:
  Linus Torvalds (1):
        Linux 2.6.36-rc3

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git merge

Alexander Graf (1):
      powerpc/85xx: Fix compilation of mpc85xx_mds.c

Anton Vorontsov (1):
      powerpc/85xx: Add P1021 PCI IDs and quirks

Julia Lawall (2):
      arch/powerpc/platforms/83xx/mpc837x_mds.c: Add missing iounmap
      arch/powerpc/sysdev/qe_lib/qe.c: Add of_node_put to avoid memory leak

Kumar Gala (1):
      powerpc/85xx: Fix compile issue with p1022_ds due to lmb rename to memblock

Li Yang (1):
      fsl_rio: fix compile errors

Matthew McClintock (1):
      powerpc/kexec: Adds correct calling convention for kexec purgatory

Michael Neuling (1):
      powerpc: Don't use kernel stack with translation off

Nathan Fontenot (1):
      powerpc/pseries: Correct rtas_data_buf locking in dlpar code

Paul Mackerras (1):
      powerpc/perf_event: Reduce latency of calling perf_event_do_pending

 arch/powerpc/kernel/head_64.S             |   12 ++++++--
 arch/powerpc/kernel/misc_32.S             |    3 ++
 arch/powerpc/kernel/time.c                |   23 +++++++--------
 arch/powerpc/platforms/83xx/mpc837x_mds.c |    9 ++++--
 arch/powerpc/platforms/85xx/mpc85xx_mds.c |    1 +
 arch/powerpc/platforms/85xx/p1022_ds.c    |    4 +-
 arch/powerpc/platforms/pseries/dlpar.c    |   42 ++++++++++++++++++++---------
 arch/powerpc/sysdev/fsl_pci.c             |    2 +
 arch/powerpc/sysdev/fsl_rio.c             |    6 +++-
 arch/powerpc/sysdev/qe_lib/qe.c           |    1 +
 include/linux/pci_ids.h                   |    2 +
 11 files changed, 71 insertions(+), 34 deletions(-)
