Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18048.58771.1270.408497@cargo.ozlabs.ibm.com>
Date: Tue, 26 Jun 2007 20:08:19 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@linux-foundation.org
Subject: Please pull powerpc.git merge branch
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

Please do:

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get two more bug fixes for powerpc, plus defconfig updates.

Thanks,
Paul.

 arch/powerpc/configs/cell_defconfig        |  243 ++++++---------
 arch/powerpc/configs/celleb_defconfig      |  169 +++-------
 arch/powerpc/configs/chrp32_defconfig      |  353 +++++++++++++--------
 arch/powerpc/configs/ebony_defconfig       |  138 +++-----
 arch/powerpc/configs/g5_defconfig          |  342 +++++++++++----------
 arch/powerpc/configs/holly_defconfig       |  125 ++------
 arch/powerpc/configs/iseries_defconfig     |   36 --
 arch/powerpc/configs/linkstation_defconfig |  384 ++++++++++-------------
 arch/powerpc/configs/lite5200_defconfig    |  182 +++++------
 arch/powerpc/configs/maple_defconfig       |  248 +++++++--------
 arch/powerpc/configs/pasemi_defconfig      |   58 ----
 arch/powerpc/configs/pmac32_defconfig      |  375 +++++++++++------------
 arch/powerpc/configs/ppc64_defconfig       |  460 +++++++++++++++++-----------
 arch/powerpc/configs/prpmc2800_defconfig   |   98 +-----
 arch/powerpc/configs/ps3_defconfig         |   79 +----
 arch/powerpc/configs/pseries_defconfig     |  387 ++++++++++++++----------
 arch/powerpc/kernel/signal_64.c            |   10 -
 arch/powerpc/kernel/vdso32/gettimeofday.S  |    4 
 arch/powerpc/kernel/vdso64/gettimeofday.S  |    7 
 19 files changed, 1748 insertions(+), 1950 deletions(-)

commit ae62fbb5f1f796d87cbdbe6701e13f2b52d5c0a7
Author: Paul Mackerras <paulus@samba.org>
Date:   Tue Jun 26 14:49:11 2007 +1000

    [POWERPC] Fix subtle FP state corruption bug in signal return on SMP
    
    This fixes a bug which can cause corruption of the floating-point state
    on return from a signal handler.  If we have a signal handler that has
    used the floating-point registers, and it happens to context-switch to
    another task while copying the interrupted floating-point state from the
    user stack into the thread struct (e.g. because of a page fault, or
    because it gets preempted), the context switch code will think that the
    FP registers contain valid FP state that needs to be copied into the
    thread_struct, and will thus overwrite the values that the signal return
    code has put into the thread_struct.
    
    This can occur because we clear the MSR bits that indicate the presence
    of valid FP state after copying the state into the thread_struct.  To fix
    this we just move the clearing of the MSR bits to before the copy.  A
    similar potential problem also occurs with the Altivec state, and this
    fixes that in the same way.
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 74609f4536f2b8fd6a48381bbbe3cd37da20a527
Author: Tony Breeds <tony@bakeyournoodle.com>
Date:   Tue Jun 26 09:50:32 2007 +1000

    [POWERPC] Fix VDSO gettimeofday() when called with NULL struct timeval
    
    Consider the prototype for gettimeofday():
    	int gettimofday(struct timeval *tv, struct timezone *tz);
    
    Although it is valid to call with /either/ tv or tz being NULL, and
    the C version of sys_gettimeofday() supports this, the current version
    of gettimeofday() in the VDSO will SEGV if called with a NULL tv.
    
    This adds a check for tv being NULL so that it doesn't SEGV.
    
    Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
    Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit ca74c013441200b162f6a384b23b833d1865a9e8
Author: Paul Mackerras <paulus@samba.org>
Date:   Tue Jun 26 14:19:35 2007 +1000

    [POWERPC] Update defconfigs
    
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit d30d6badd1769a00bc5a800b8af4e8b3f169c633
Author: will schmidt <will_schmidt@vnet.ibm.com>
Date:   Sat Jun 23 01:24:56 2007 +1000

    [POWERPC] Update g5_defconfig
    
    Update the g5_defconfig with default settings.
    This is to keep things up to date, and specifically to ensure that the
    CONFIG_MACINTOSH_DRIVERS option is enabled.  This also turns on
    CONFIG_MSI.
    
    Signed-off-by: Will Schmidt <will_schmidt@vnet.ibm.com>
    cc: Michael Ellerman <michael@ellerman.id.au>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
