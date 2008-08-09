Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: please pull cell merge branch
Date: Sat, 9 Aug 2008 15:13:04 +0200
References: <1217620879.15667.145.camel@carll-linux-desktop>
	<200808081526.21405.arnd@arndb.de>
	<1218235184.6637.111.camel@carll-linux-desktop>
In-Reply-To: <1218235184.6637.111.camel@carll-linux-desktop>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808091513.05251.arnd@arndb.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	cel <cel@linux.vnet.ibm.com>, cbe-oss-dev@ozlabs.org,
	Carl Love <cel@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

I've fixed one last bug in Carl's update for cell-oprofile (int flags
instead of unsigned long flags) and made sure the comments fit the
usual style. This fixes a long-standing bug that prevented us from
using oprofile on SPUs in many real-world scenarios. Please
pull from

 master.kernel.org:/pub/scm/linux/kernel/git/arnd/cell-2.6.git merge

so we can get it fixed in 2.6.27-rc3. Sorry for the size of the patch
so late after the merge window, unfortunately it wasn't possible to
fix the problem in a simpler way.

	Arnd <><

---

 arch/powerpc/oprofile/cell/pr_util.h       |   13 +
 arch/powerpc/oprofile/cell/spu_profiler.c  |    4
 arch/powerpc/oprofile/cell/spu_task_sync.c |  236 ++++++++++++++++++++++++---
 drivers/oprofile/buffer_sync.c             |   24 ++
 drivers/oprofile/cpu_buffer.c              |   15 +
 drivers/oprofile/event_buffer.c            |    2
 drivers/oprofile/event_buffer.h            |    7
 include/linux/oprofile.h                   |   16 +
 drivers/oprofile/cpu_buffer.c              |    4
 9 files changed, 284 insertions(+), 37 deletions(-)

commit f90a87b5f5fa46dc6c556e9267a6f25a95fbef14
Author: Carl Love <cel@us.ibm.com>
Date:   Fri Aug 8 15:39:44 2008 -0700

    powerpc/cell/oprofile: avoid double free of profile buffer

    If an error occurs on opcontrol start, the event and per cpu buffers
    are released.  If later opcontrol shutdown is called then the free
    function will be called again to free buffers that no longer
    exist.  This results in a kernel oops.  The following changes
    prevent the call to delete buffers that don't exist.

    Signed-off-by: Carl Love <carll@us.ibm.com>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>

commit 70f546a7262c6f67b87e875a542f315f8b9a7c17
Author: Carl Love <cel@us.ibm.com>
Date:   Fri Aug 8 15:38:36 2008 -0700

    powerpc/cell/oprofile: fix mutex locking for spu-oprofile

    The issue is the SPU code is not holding the kernel mutex lock while
    adding samples to the kernel buffer.

    This patch creates per SPU buffers to hold the data.  Data
    is added to the buffers from in interrupt context.  The data
    is periodically pushed to the kernel buffer via a new Oprofile
    function oprofile_put_buff(). The oprofile_put_buff() function
    is called via a work queue enabling the funtion to acquire the
    mutex lock.

    The existing user controls for adjusting the per CPU buffer
    size is used to control the size of the per SPU buffers.
    Similarly, overflows of the SPU buffers are reported by
    incrementing the per CPU buffer stats.  This eliminates the
    need to have architecture specific controls for the per SPU
    buffers which is not acceptable to the OProfile user tool
    maintainer.

    The export of the oprofile add_event_entry() is removed as it
    is no longer needed given this patch.

    Note, this patch has not addressed the issue of indexing arrays
    by the spu number.  This still needs to be fixed as the spu
    numbering is not guarenteed to be 0 to max_num_spus-1.

    Signed-off-by: Carl Love <carll@us.ibm.com>
    Signed-off-by: Maynard Johnson <maynardj@us.ibm.com>
    Signed-off-by: Arnd Bergmann <arnd@arndb.de>
