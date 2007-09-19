Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18161.6241.799343.110963@cargo.ozlabs.ibm.com>
Date: Wed, 19 Sep 2007 22:38:57 +1000
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

to get three more bug-fixes for powerpc, as listed below.

Thanks,
Paul.

 arch/powerpc/kernel/time.c                |    8 +++++---
 arch/powerpc/kernel/vdso.c                |   12 ++++++++++++
 arch/powerpc/platforms/cell/spufs/sched.c |    4 ++--
 include/asm-powerpc/time.h                |    5 +++++
 4 files changed, 24 insertions(+), 5 deletions(-)

commit c27da339698145a9383e052c1070a950d30da478
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Wed Sep 19 14:21:56 2007 +1000

    [POWERPC] Fix timekeeping on PowerPC 601
    
    Recent changes to the timekeeping code broke support for the PowerPC 601
    processor which doesn't have the usual timebase facility but a slightly
    different thing called (yuck) the RTC.
    
    This fixes it, boot tested on an old 601 based PowerMac 7200.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit 7b5acbaac3f94ab810a977c0ec4e5fcabbf51bed
Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date:   Wed Sep 19 14:21:56 2007 +1000

    [POWERPC] Don't expose clock vDSO functions when CPU has no timebase
    
    We forgot to remove the clock_gettime, clock_getres and get_tbfreq vDSO
    calls on CPUs that have no timebase such as 601 or 403 (old CPUs that have
    different mechanisms and for which the vDSO code will not work properly).
    This fixes it.
    
    Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>

commit c0e7b4aa1c09ea992808ea8c079141bc8dd0f5bc
Author: Christoph Hellwig <hch@lst.de>
Date:   Wed Sep 19 14:38:12 2007 +1000

    [POWERPC] spusched: Fix null pointer dereference in find_victim
    
    find_victim can dereference a NULL pointer when iterating over the list
    of victim spus because list_mutex only guarantees spu->ct to be stable,
    but of course not to be non-NULL.
    
    Also fix find_victim to not call spu_unbind_context without list_mutex
    because that violates the above guarantee.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
    Signed-off-by: Jeremy Kerr <jk@ozlabs.org>
    Signed-off-by: Paul Mackerras <paulus@samba.org>
