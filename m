Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 14DADDDF14
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 08:16:40 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: patches in powerpc.git
Date: Tue, 13 Feb 2007 22:16:14 +0100
References: <17874.8572.761026.618811@cargo.ozlabs.ibm.com>
In-Reply-To: <17874.8572.761026.618811@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702132216.15340.arnd@arndb.de>
Cc: Masato Noguchi <Masato.Noguchi@jp.sony.com>,
	Maynard Johnson <mpjohn@us.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Carl Love <carll@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 13 February 2007 21:37, Paul Mackerras wrote:
> These are the patches that are on the master branch of the powerpc.git
> repository on kernel.org.  I plan to ask Linus to pull them later
> today, along with whatever I get from Kumar's for_paulus branch, and
> probably David Gibson's "Use udbg_early_init() on ppc32" patch.

I have a few patches for spufs and a cleanup for cell oprofile
queued up. Please pull these in as well from

git+ssh://master.kernel.org/pub/scm/linux/kernel/git/arnd/cell-2.6.git/ cell-merge

I've sent the of_serial driver in a separate mail, if you don't mind
forwarding that (serial layer being unmaintained), please merge it
in as well.

	Arnd <><

---

 arch/powerpc/oprofile/op_model_cell.c       |  151 ++++++----
 arch/powerpc/platforms/cell/pmu.c           |   14 -
 arch/powerpc/platforms/cell/spufs/context.c |  125 ++++-----
 arch/powerpc/platforms/cell/spufs/file.c    |    7
 arch/powerpc/platforms/cell/spufs/run.c     |   16 -
 arch/powerpc/platforms/cell/spufs/sched.c   |  386 +++++++++++++++++++---------
 arch/powerpc/platforms/cell/spufs/spufs.h   |   48 ++-
 arch/powerpc/xmon/xmon.c                    |    1
 include/asm-powerpc/cell-pmu.h              |   15 -
 include/asm-powerpc/spu.h                   |    1
 10 files changed, 480 insertions(+), 284 deletions(-)

commit c7eb734766217b9ddac217cbccae3aedcfa67520
Author: Maynard Johnson <mpjohn@us.ibm.com>
Date:   Tue Feb 13 22:02:03 2007 +0100

    [POWERPC] cell: pm_rtas_activat_signals routine cleanup
    
    The code was setting up the debug bus for group 21 when profiling on the
    event PPU CYCLES.  The debug bus is not actually used by the hardware
    performance counters when counting PPU CYCLES.  Setting up the debug bus
    for PPU CYCLES causes signal routing conflicts on the debug bus when
    profiling PPU cycles and another PPU event.  This patch fixes the code to
    only setup the debug bus to route the performance signals for the non
    PPU CYCLE events.
    
    Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>
    Signed-off-by: Carl Love <carll@us.ibm.com>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit bcb63e25ed3c56ee40cca4d18fbaac1d2a40c1d6
Author: Carl Love <carll@us.ibm.com>
Date:   Tue Feb 13 22:02:02 2007 +0100

    [POWERPC] cell: PPU Oprofile cleanup patch
    
    This is a clean up patch that includes the following changes:
    
     -Some comments were added to clarify the code based on feedback
      from the community.
     -The write_pm_cntrl() and set_count_mode() were passed a
      structure element from a global variable.  The argument was
      removed so the functions now just operate on the global directly.
     -The set_pm_event() function call in the cell_virtual_cntr()
      routine was moved to a for-loop before the for_each_cpu loop
    
    Signed-off-by: Carl Love <carll@us.ibm.com>
    Signed-off-by: Maynard Johnson <mpjohn@us.ibm.com>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit 128b8546a83a9e37448bc126e1045dc1db291165
Author: Masato Noguchi <Masato.Noguchi@jp.sony.com>
Date:   Tue Feb 13 21:54:30 2007 +0100

    [POWERPC] spufs: avoid accessing kernel memory through mmapped /mem node
    
    I found an exploit in current kernel.
    Currently, there is no range check about mmapping "/mem" node in
    spufs. Thus, an application can access privilege memory region.
    
    In case this kernel already worked on a public server, I send this
    information only here.
    If there are such servers in somewhere, please replace it, ASAP.
    
    Signed-off-by: Masato Noguchi <Masato.Noguchi@jp.sony.com>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit 2eb1b12049844a8ebc670e0e4fc908bc3f8933d3
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Feb 13 21:54:29 2007 +0100

    [POWERPC] spu sched: static timeslicing for SCHED_RR contexts
    
    For SCHED_RR tasks we can do some really trivial timeslicing.  Basically
    we fire up a time for every scheduler tick that searches for a higher
    or same priority thread that is on the runqueue and if there is one
    context switches to it.  Because we can't lock spus from timer context
    we actually run this from a delayed runqueue instead of a timer.
    
    A nice optimization would be to skip the actual priority bitmap search
    when there are less contexts than physical spus available.  To implement
    this I need a so far unpublished patch from Andre, and it will be added
    after we have that patch in.
    
    Note that right now we only do the time slicing for SCHED_RR tasks.
    The code would work for SCHED_OTHER tasks aswell, but their prio
    value is defered from the one the PPU thread has at time of spu_run,
    and using this for spu scheduling decisions would make the code very
    unfair.  SCHED_OTHER support will be enabled once we the spu scheduler
    knows how to calculcate cpu_context.prio (very soon)
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit 72cb360839f88c02ccf38f1df214316e05886ff3
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Feb 13 21:54:28 2007 +0100

    [POWERPC] spu sched: use DECLARE_BITMAP
    
    use DECLARE_BITMAP in the spu scheduler instead of reimplementing it.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit 52f04fcf66a5d5d90790d6cfde52e391ecf2b882
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Feb 13 21:54:27 2007 +0100

    [POWERPC] spu sched: forced preemption at execution
    
    If we start a spu context with realtime priority we want it to run
    immediately and not wait until some other lower priority thread has
    finished.  Try to find a suitable victim and use it's spu in this
    case.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit ae7b4c5284d11d49ed9432c16505fcbeb8d3b8cf
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Feb 13 21:54:26 2007 +0100

    [POWERPC] spu sched: update some comments
    
    Give spu_yield a kerneldoc comment and remove the old comment
    documenting spu_activate, spu_deactive and spu_yield as all of them
    now have descriptive kerneldoc comments of their own.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit 678b2ff1e65ecccdb15cbfe97081572fc35944b7
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Feb 13 21:54:25 2007 +0100

    [POWERPC] spu sched: simplity spu_remove_from_active_list
    
    If we call spu_remove_from_active_list that spu is always guaranteed
    to be on the active list and in runnable state, so we can simply
    do a list_del to remove it and unconditionally take the was_active
    codepath.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit 26bec67386dbf6ef887254e815398842e182cdcd
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Feb 13 21:54:24 2007 +0100

    [POWERPC] spufs: optimize spu_run
    
    There is no need to directly wake up contexts in spu_activate when
    called from spu_run, so add a flag to surpress this wakeup.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit 079cdb61614c466c939ebf74c7ef6745667bc61e
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Feb 13 21:54:23 2007 +0100

    [POWERPC] spufs: runqueue simplification
    
    This is the biggest patch in this series, and it reworks the guts of
    the spu scheduler runqueue mechanism:
    
     - instead of embedding a waitqueue in the runqueue there is now a
       simple doubly-linked list, the actual wakeups happen by reusing
       the stop_wq in the spu context (maybe we should rename it one day)
     - spu_free and spu_prio_wakeup are merged into a single spu_reschedule
       function
     - various functionality is split out into small helpers, and kerneldoc
       comments are added in various places to document what's going on.
     - spu_activate is rewritten into a tight loop by removing test for
       various impossible conditions and using the infrastructure in this
       patch.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit 8389998ae9ea2888c86c446f7911ddced50052a1
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Feb 13 21:54:22 2007 +0100

    [POWERPC] spufs: move prio to spu_context
    
    It doesn't make any sense to have a priority field in the physical spu
    structure.  Move it into the spu context instead.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit 6a0641e51011def4e308fd07387047f5ee50647f
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Feb 13 21:54:21 2007 +0100

    [POWERPC] spufs: state_mutex cleanup
    
    Various cleanups in code surrounding the state semaphore:
    
     - inline spu_acquire/spu_release
     - cleanup spu_acquire_* and add kerneldoc comments to these functions
     - remove spu_release_exclusive and replace it with spu_release
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit 650f8b0291ecd0abdeadbd0ff3d70c3538e55405
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Feb 13 21:36:50 2007 +0100

    [POWERPC] spufs: simplify state_mutex
    
    The r/w semaphore to lock the spus was overkill and can be replaced
    with a mutex to make it faster, simpler and easier to debug.  It also
    helps to allow making most spufs interruptible in future patches.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit 202557d29eae528f464652e92085f3b19b05a0a7
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Feb 13 21:36:49 2007 +0100

    [POWERPC] spufs: sched.c cleanups
    
    Various cleanups to sched.c that don't change the global control flow:
    
     - add kerneldoc comments to various functions
     - add spu_ prefixes to various functions
     - add/remove context from the runqueue in bind/unbind_context as
       it's part of the logical operation
     - add a call to put_active_spu to spu_unbind_contex as it's logically
       part of the unbind operation
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit 81998bafe299b8b675157f0a4dfe8dad43215da9
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Feb 13 21:36:48 2007 +0100

    [POWERPC] spufs: bind_context sets SPU_STATE_RUNNABLE
    
    Only bind_context/unbind_context change the spu context state.  Thus
    we can move all assignents of SPU_STATE_RUNNABLE into bind_context,
    which parallels the unbind side aswell.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit aa56c16807ba7b8e801216cab012d2f498755ba5
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Feb 13 21:36:47 2007 +0100

    [POWERPC] spufs: remove superfluous SPU_STATE_SAVED assignments
    
    unbind_context already sets the context state to SPU_STATE_SAVED, thus
    the spu_deactivate callers don't need to do it again.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit 5cb23afc9e64841adb43d46160a5c63a80ebfd54
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Feb 13 21:36:46 2007 +0100

    [POWERPC] spufs: remove empty last line in run.c
    
    Remove the empty last line in arch/powerpc/platforms/cell/spufs/run.c.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>

commit 30a6c337dcefa7583fe9289fedb28783af980c0c
Author: Christoph Hellwig <hch@lst.de>
Date:   Tue Feb 13 21:36:45 2007 +0100

    [POWERPC] spufs: remove SPU_CONTEXT_PREEMPT
    
    Remove the SPU_CONTEXT_PREEMPT define.  It's unused and won't be used
    in this form after the scheduler rework.
    
    Signed-off-by: Christoph Hellwig <hch@lst.de>
    Signed-off-by: Arnd Bergmann <arnd.bergmann@de.ibm.com>
