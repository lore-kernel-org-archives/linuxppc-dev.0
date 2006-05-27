Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17528.20838.119258.250876@cargo.ozlabs.ibm.com>
Date: Sat, 27 May 2006 23:17:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: torvalds@osdl.org
Subject: please pull powerpc.git 'merge' branch
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

Please do a pull from the "merge" branch of

git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git

There are 3 commits there: an update to MAINTAINERS, a fix for the
"Maple" PPC970FX evaluation boards, and a fix for the Freescale
embedded 8272 processor that is apparently needed for the console to
work on those chips.  These fixes won't affect any other platforms and
are safe to go in for 2.6.17 IMO.

Thanks,
Paul.

 MAINTAINERS                             |    4 +--
 arch/powerpc/kernel/prom_init.c         |   48 +++++++++++++++++++++++++++++--
 arch/ppc/platforms/mpc8272ads_setup.c   |   10 +++---
 arch/ppc/syslib/pq2_devices.c           |   16 +++++-----
 arch/ppc/syslib/pq2_sys.c               |    8 +++--
 drivers/serial/cpm_uart/cpm_uart_core.c |    8 +++--
 drivers/serial/cpm_uart/cpm_uart_cpm2.c |    2 +
 7 files changed, 70 insertions(+), 26 deletions(-)


commit 54f4ee183aea859eb09f141dad3fc3c6f4fe0446
Author: Hollis Blanchard <hollisb@us.ibm.com>
Date:   Thu May 25 16:36:53 2006 -0500

    [PATCH] powerpc: fix RTC/NVRAM accesses on Maple
    
    Due to a firmware device tree bug, RTC and NVRAM accesses (including
    halt/reboot) on Maple have been broken since January, when an untested
    build fix went in. This code patches the device tree in Linux.
    
    Signed-off-by: Hollis Blanchard <hollisb@us.ibm.com>
    Signed-off-by: Segher Boessenkool <segher@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 8e30a9a299ca30b6c4072c2182238d5f5dd1590d
Author: Vitaly Bordug <vbordug@ru.mvista.com>
Date:   Wed May 24 21:40:18 2006 +0400

    [PATCH] ppc32 CPM_UART: various fixes for pq2 uart users
    
    This fixes various odd things that missed update together with cpm_uart
    platform_device move. Unified resources names, restructurisation, etc.
    Also, addressed issue with recent phys/virt translation rework. Being
    cache-coherent, CPM2's do alloc_bootmem() for the console stuff, and it was
    used to treat console buffer descriptor mapping 1:1 (as in CPM1 case),
    which is definitely wrong.
    
    Signed-off-by: Vitaly Bordug <vbordug@ru.mvista.com>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 6d923f98fe0f31c174ace92f8b680d0d153663aa
Author: Arthur Othieno <apgo@patchbomb.org>
Date:   Fri May 19 06:22:23 2006 -0400

    [PATCH] powerpc: linuxppc64.org no more
    
    http://linuxppc64.org has long been a redirect to the canonical
    http://penguinppc.org/ppc64/ -- update all instances accordingly,
    as ACKed by Hollis:
    
    On Wed, Jan 18, 2006 at 09:48:08AM -0600, Hollis Blanchard wrote:
    > On Wed, 2006-01-18 at 13:07 +0100, Olaf Hering wrote:
    > > On Wed, Jan 18, Arthur Othieno wrote:
    > > >
    > > > What about the s/linuxppc64\.org/penguinppc\.org/g case? Or is
    > > > penguinppc64.org preferable? Or am I just taking it too far? ;)
    > >
    > > They are redirected on DNS or HTTP level.
    >
    > HTTP level, but that doesn't answer his question.
    >
    > As the maintainer of that site, I would prefer to remove the
    > linuxppc64.org reference.
    
    Signed-off-by: Arthur Othieno <apgo@patchbomb.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
