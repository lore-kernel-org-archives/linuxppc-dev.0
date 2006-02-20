Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17401.23749.905383.876251@cargo.ozlabs.ibm.com>
Date: Mon, 20 Feb 2006 17:08:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc-merge.git
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

Please do a pull from

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc-merge.git

There are 6 commits there with some bug fixes that should go in
2.6.16, including a fix for the xtime vs gettimeofday drift that uses
the current_tick_length() function that was recently added.

Thanks,
Paul.

Michael Ellerman:
      powerpc: Don't start secondary CPUs in a UP && KEXEC kernel
      powerpc: Make UP -> SMP kexec work again
      powerpc: Fix bug in spinup of renumbered secondary threads

Olaf Hering:
      powerpc: remove duplicate exports

Olof Johansson:
      powerpc: Fix OOPS in lparcfg on G5

Paul Mackerras:
      powerpc: Keep xtime and gettimeofday in sync

 arch/powerpc/kernel/head_64.S        |    4 
 arch/powerpc/kernel/lparcfg.c        |    6 -
 arch/powerpc/kernel/ppc_ksyms.c      |   16 --
 arch/powerpc/kernel/setup_64.c       |    4 
 arch/powerpc/kernel/sys_ppc32.c      |    4 
 arch/powerpc/kernel/time.c           |  282 ++++++++++++----------------------
 arch/powerpc/platforms/pseries/smp.c |    2 
 arch/ppc/kernel/ppc_ksyms.c          |    8 -
 arch/ppc/xmon/start.c                |   15 --
 include/asm-ppc/machdep.h            |   13 --
 10 files changed, 108 insertions(+), 246 deletions(-)
