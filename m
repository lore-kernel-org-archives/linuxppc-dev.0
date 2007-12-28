Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18292.49574.906807.484581@cargo.ozlabs.ibm.com>
Date: Fri, 28 Dec 2007 20:28:06 +1100
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

Please do

git pull \
git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge

to get two more bug-fixes that the Cell guys would like to see in
2.6.24 (and which only affect Cell).  The changes are less than the
diffstat might indicate since a couple of functions got moved from one
file to another by the second commit listed below.

Thanks,
Paul.

 arch/powerpc/platforms/cell/Kconfig          |    5 ++
 arch/powerpc/platforms/cell/Makefile         |    1 
 arch/powerpc/platforms/cell/spu_notify.c     |   67 ++++++++++++++++++++++++++
 arch/powerpc/platforms/cell/spu_syscalls.c   |   14 +++++
 arch/powerpc/platforms/cell/spufs/context.c  |   16 ------
 arch/powerpc/platforms/cell/spufs/sched.c    |   29 +++--------
 arch/powerpc/platforms/cell/spufs/syscalls.c |    1 
 arch/powerpc/platforms/ps3/os-area.c         |   40 ++++++++++++----
 include/asm-powerpc/spu.h                    |    4 ++
 9 files changed, 129 insertions(+), 48 deletions(-)
 create mode 100644 arch/powerpc/platforms/cell/spu_notify.c

commit ec5d2dfe72cf4808ae4ecee03454a4d91dfcbe0c
Author: Geoff Levand <geoffrey.levand@am.sony.com>
Date:   Mon Dec 24 04:41:01 2007 +1100

    [POWERPC] PS3: Fix printing of os-area magic numbers
    
    Fix a bug in the printing of the os-area magic numbers which assumed
    that magic numbers were zero terminated strings.  The magic numbers
    are represented in memory as integers.  If the os-area sections are
    not initialized correctly they could contained random data that would
    be printed to the display.  Also unify the handling of header and db
    magic numbers and make both of type array of u8.
    
    Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit aed3a8c9bb1a8623a618232087c5ff62718e3b9a
Author: Bob Nelson <rrnelson@linux.vnet.ibm.com>
Date:   Sat Dec 15 01:27:30 2007 +1100

    [POWERPC] Oprofile: Remove dependency on spufs module
    
    This removes an OProfile dependency on the spufs module.  This
    dependency was causing a problem for multiplatform systems that are
    built with support for Oprofile on Cell but try to load the oprofile
    module on a non-Cell system.
    
    Signed-off-by: Bob Nelson <rrnelson@us.ibm.com>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Acked-by: Jeremy Kerr <jk@ozlabs.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
