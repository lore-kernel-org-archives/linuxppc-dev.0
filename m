Return-Path: <akpm@linux-foundation.org>
Date: Fri, 20 Jul 2007 11:44:21 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Jeremy Kerr <jk@ozlabs.org>
Subject: Re: [PATCH 04/14] spufs: add spu stats in sysfs and ctx stat file
	in spufs
Message-Id: <20070720114421.0760cc5b.akpm@linux-foundation.org>
In-Reply-To: <11849088851210-git-send-email-jk@ozlabs.org>
References: <1184908885751-git-send-email-jk@ozlabs.org>
	<11849088851210-git-send-email-jk@ozlabs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Andre Detsch <adetsch@br.ibm.com>, paulus@samba.org, cbe-oss-dev@ozlabs.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 20 Jul 2007 15:21:15 +1000
Jeremy Kerr <jk@ozlabs.org> wrote:

> This patch exports per-context statistics in spufs as long as spu
> statistics in sysfs.
> 
> It was formed by merging:
> "spufs: add spu stats in sysfs"   From: Christoph Hellwig
> "spufs: add stat file to spufs"   From: Christoph Hellwig
> "spufs: fix libassist accounting" From: Jeremy Kerr
> "spusched: fix spu utilization statistics" From: Luke Browning
> And some adjustments by myself, after suggestions on cbe-oss-dev.
> 
> Having separate patches was making the review process harder
> than it should, as we end up integrating spus and ctx statistics
> accounting much more than it was on the first implementation.

I hit some rejects here due to Maynard Johnson and Bob Nelson's oprofile
patches.  It was relatively simple to fix up, but there may of course be
clashes in intent as well, so please check it all over carefully when it
lands in mainline.

I'll get all the ps3/spufs/etc stuff into Linus later today.


And what's up with all these powerpc people sending out patchbombs after
the merge window has opened?  Formally, _all_ of this:

oprofile-enable-spu-switch-notification-to-detect-currently-active-spu-tasks.patch
oprofile-add-support-to-oprofile-for-profiling-cell-be-spus.patch
ps3-disk-storage-driver.patch
ps3-disk-storage-driver-use-correct-bio-vector-size.patch
ps3-disk-storage-driver-updates-after-final-review.patch
ps3-bd-dvd-cd-rom-storage-driver.patch
ps3-bd-dvd-cd-rom-storage-driver-updates-after-final-review.patch
ps3-flash-rom-storage-driver.patch
ps3-flash-rom-storage-driver-updates-after-final-review.patch
ps3-fix-build-with-32-bit-toolchains.patch
ps3fb-enable-vt_hw_console_binding-for-proper-kexec.patch
ps3fb-shrink-default-virtual-frame-buffer-size-from-18-to-9-mib.patch
ps3fb-set-fbinfo_reads_fast-to-speed-up-text-console-scrolling.patch
spufs-avoid-unexpectedly-restaring-mfc-during-context-save.patch
spufs-make-signal-notification-files-readonly-for-nosched-contexts.patch
spufs-remove-spurious-warn_on-for-spu_deactivate-for-nosched-contexts.patch
spufs-add-spu-stats-in-sysfs-and-ctx-stat-file-in-spufs.patch
spufs-make-sure-context-are-scheduled-again-after-spu_acquire_saved.patch
spufs-fix-array-size-of-channel-index.patch
spufs-remove-needless-context-save-restore-code.patch
spufs-fix-decr_status-meanings.patch
spufs-fix-read-and-write-for-decr_status-file.patch
spufs-limit-saving-mfc_cntl-bits.patch
spufs-dont-halt-decrementer-at-restore-step-47.patch
spufs-change-decrementer-restore-timing.patch
spufs-remove-unused-file-argument-from-spufs_run_spu.patch
spufs-use-find_first_bit-instead-of-sched_find_first_bit.patch

should be pushed back into 2.6.24 because it all arrived too late.

I guess you're all doing that to Paul on a regular basis.  Bad.
