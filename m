Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17763.46950.961979.77987@cargo.ozlabs.ibm.com>
Date: Wed, 22 Nov 2006 13:35:18 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: Please pull powerpc.git 'merge' branch
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linus,

Since the mirroring on kernel.org is slow today, please do:

git pull \
master.kernel.org:/pub/scm/linux/kernel/git/paulus/powerpc.git merge

or, once the mirror catches up:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

It turns out that two commits that were merged post 2.6.18 were
incorrect and need to be reverted.  Also there is a fix for embedded
systems using the Freescale MPC83xx family processors.

Thanks,
Paul.

 arch/powerpc/kernel/time.c                |   42 -----------------------------
 arch/powerpc/platforms/83xx/mpc832x_mds.c |   19 +++++++++++++
 arch/powerpc/platforms/83xx/mpc834x_itx.c |    4 ---
 include/asm-powerpc/time.h                |    4 ---
 4 files changed, 19 insertions(+), 50 deletions(-)

commit 8746ed3dae14e87e9f7ad8e44649b72e22b33274
Author: Kim Phillips <kim.phillips@freescale.com>
Date:   Tue Nov 21 18:19:42 2006 -0600

    [POWERPC] Fix ucc_geth of_device discovery on mpc832x
    
    mpc832x, as in mpc8360, needs to explicitly find and create the
    platform device for ucc_geth in 2.6.19.  This code will likely be
    readapted to Benh's new of_ methods for 2.6.20.
    
    Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit df9c23095fc8652798c41dd860676d3dafb2f1dc
Author: Kim Phillips <kim.phillips@freescale.com>
Date:   Tue Nov 21 10:31:14 2006 -0600

    [POWERPC] Revert "[POWERPC] Add powerpc get/set_rtc_time interface to new generic rtc class"
    
    This reverts commit 7a69af63e788a324d162201a0b23df41bcf158dd.
    
    As advised by David Brownell:
    
    http://marc.theaimsgroup.com/?l=linux-kernel&m=116387226902131&w=2
    
    Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 6c12c18dfb0ccae21816de3e0c323b5250450d82
Author: Kim Phillips <kim.phillips@freescale.com>
Date:   Tue Nov 21 10:31:08 2006 -0600

    [POWERPC] Revert "[POWERPC] Enable generic rtc hook for the MPC8349 mITX"
    
    This reverts commit a8ed4f7ec3aa472134d7de6176f823b2667e450b.
    
    As advised by David Brownell:
    
    http://marc.theaimsgroup.com/?l=linux-kernel&m=116387226902131&w=2
    
    Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
