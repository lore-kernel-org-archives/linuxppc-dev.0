Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E156FDDEA3
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jun 2007 13:55:54 +1000 (EST)
Date: Tue, 19 Jun 2007 22:55:47 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Please pull from 'for_linus' branch
Message-ID: <Pine.LNX.4.64.0706192241550.13170@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Please pull from 'for_linus' branch at

	master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git for_linus

To get a fix for 2.6.22 to the rheap allocator that was causing multiple
instances of the UCC ethernet driver to fail because it was running out of
memory due to wasting space for aligned requests.

Thanks,
Kumar.

 arch/powerpc/lib/rheap.c |   48 ++++++++++++++++++++++++++++-------------------
 1 file changed, 29 insertions(+), 19 deletions(-)

commit 7c8545e98468c53809fc06788a3b9a34dff05240
Author: Li Yang <leoli@freescale.com>
Date:   Mon Jun 18 19:29:21 2007 +0800

    [POWERPC] rheap - eliminates internal fragments caused by alignment

    The patch adds fragments caused by rh_alloc_align() back to free list, instead
    of allocating the whole chunk of memory.  This will greatly improve memory
    utilization managed by rheap.

    It solves MURAM not enough problem with 3 UCCs enabled on MPC8323.

    Signed-off-by: Li Yang <leoli@freescale.com>
    Acked-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
    Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
