Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vwwRK6blBzDqGx
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Apr 2017 23:03:56 +1000 (AEST)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.11: Reported regressions as of Tuesday, 2017-04-02
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <24b2c68a-0b0c-3ea4-5e47-6040b9342a15@leemhuis.info>
Date: Sun, 2 Apr 2017 15:03:51 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi! Find below my second regression report for Linux 4.11. It lists 13
regressions I'm currently aware of. It lists 6 fixed regressions. Some
of them where in the first report from three weeks ago; a few were 
supposed to go into a second report I prepared last week, but wasn't 
able to finish :-/

As always: Are you aware of any other regressions? Then please let me
know (simply CC regressions@leemhuis.info). And please tell me if there
is anything in the report that shouldn't be there.

Ciao, Thorsten

P.S.: Thx to all those that CCed me on regression reports, that makes
compiling these reports a whole lot easier!

== Current regressions ==

Desc: malta_defconfig regressions
Repo: 2017-03-31 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1367470.html
Stat: n/a 
Note: some patched already heading mainline

Desc: Commit d8514d8edb5b ("ovl: copy up regular file using O_TMPFILE") breaks ubifs
Repo: 2017-03-28 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1363879.html
Stat: 2017-03-30 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1366190.html https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1366208.html
Note: patches being tested; tests looking good so far

Desc: 07ec51480b5e  ("virtio_pci: use shared interrupts for virtqueues") causes some kworker grief in -rt too
Repo: 2017-03-27 https://www.mail-archive.com/search?l=mid&q=1490605644.14634.50.camel@gmx.de
Stat: 2017-03-31 https://www.mail-archive.com/search?l=mid&q=20170331082049.GA4485@lst.de
Note: hch is looking into this

Desc: HP 820 G3 becomes unstable after resume from suspend
Repo: 2017-03-25 https://bugzilla.kernel.org/show_bug.cgi?id=195041
Stat: 2017-03-26 
Note: might be a duplicate of https://bugzilla.kernel.org/show_bug.cgi?id=194801 ; revert for that bug is heading upstream via davem (see https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1361534.html )

Desc: NVMe APST? Samsung PM951 NVMe sudden controller death
Repo: 2017-03-25 https://bugzilla.kernel.org/show_bug.cgi?id=195039
Stat: 2017-03-29 
Note: Got luto and axboe into the loop, investigation ongoing, maybe a blacklist update is needed; issue might be the same to https://bugzilla.kernel.org/show_bug.cgi?id=194921 (see below)

Desc: NVMe APST? NVMe resets leads to capacity change to 0, leading to panics; Samsung SSD as well
Repo: 2017-03-18 https://bugzilla.kernel.org/show_bug.cgi?id=194921
Stat: 2017-03-28 
Note: Got luto and axboe into the loop, investigation ongoing; maybe a blacklist update is needed;  issue might be related to https://bugzilla.kernel.org/show_bug.cgi?id=195039 (see above)

Desc: Perf regression after enabling nvme APST
Repo: 2017-03-17 https://lkml.org/lkml/2017/3/17/177
Stat: 2017-03-20 https://lkml.org/lkml/2017/3/20/998
Note: luto: lying disk?

Desc: i915 gpu hangs under load
Repo: 2017-03-22 https://www.mail-archive.com/intel-gfx@lists.freedesktop.org/msg116227.html https://bugs.freedesktop.org/show_bug.cgi?id=100181
Stat: 2017-04-02 https://www.mail-archive.com/intel-gfx@lists.freedesktop.org/msg117315.html
Note: Reporter: "there's a fix out there. I don't know if it's in rc5 though."

Desc: 4.10/4.11: mmc: core: HS DDR switch, don't change timing before checking status, as it might lead to boot problems
Repo: 2017-03-10 https://patchwork.kernel.org/patch/9617489/
Stat: 2017-03-24 
Note: looks like the real root cause was found, but then the discussion stalled afaics

Desc: Synaptics RMI4 touchpad regression in 4.11-rc1: pointer jumps
Repo: 2017-03-11 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1351561.html
Stat: 2017-03-31 https://www.mail-archive.com/search?l=mid&q=20170331085751.GF22683@mail.corp.redhat.com
Note: two patches to improve the situation available; discussion which to use

Desc: Synaptics RMI4 touchpad regression in 4.11-rc1: palm detection
Repo: 2017-03-11 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1351561.html
Stat: 2017-03-19 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1356832.html
Note: discussion stalled; asked for an update

Desc: e1000e: __pci_enable_msi_range fails before/after resume
Repo: 2017-03-06 https://bugzilla.kernel.org/show_bug.cgi?id=194801
Stat: 2017-03-14 https://bugzilla.kernel.org/show_bug.cgi?id=194801#c1
Note: revert for that bug is heading upstream via davem (see https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1361534.html )

Desc: thinkpad x220: GPU hang
Repo: 2017-03-05 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1345689.html
Stat: 2017-03-25 https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg180860.html
Note: Ignored by DRI people? Pavel wrote: "We know where the bug is, but there's no fix for it. There was one patch, but it was quickly withdrawn."


== Stalled, waiting for feedback from reporter ==

Desc: pine64 defconfig: WARNING: CPU: 0 PID: 86 at drivers/base/dd.c:349 driver_probe_device+0x258/0x2c0
Repo: 2017-03-25 https://bugzilla.kernel.org/show_bug.cgi?id=195037
Stat: 2017-03-28 https://bugzilla.kernel.org/show_bug.cgi?id=195037#c2
Note: poked reporter to clarify if this is a regression in 4.11; might not be one

Desc: kvm: workqueue lockup
Repo: 2017-03-14 https://bugzilla.kernel.org/show_bug.cgi?id=194883
Stat: 2017-03-27 https://bugzilla.kernel.org/show_bug.cgi?id=194883#c1
Note: asked reporter if issue still present in RC4, no reply yet

Desc: general protection fault: inet6_fill_ifaddr+0x6c/0x230
Repo: 2017-03-11 https://bugzilla.kernel.org/show_bug.cgi?id=194849
Stat: 2017-03-13 https://bugzilla.kernel.org/show_bug.cgi?id=194849#c1
Note: poked bug for status, didn't get one; might need to get forwarded to network people if still present


== Going to be removed from the list ==

Desc: ACPI errors on Macbook IVB: "ACPI Error: Needed type [Reference], found [Integer]"; 
Repo: 2017-02-28 https://lkml.org/lkml/2017/2/27/596
Stat: n/a 
Note: Removed: Only error messages, no real problem known. Side note: Reporter summarized non-public discussion "Intel devs have determined that root cause is an Apple bios bug (that happens to work in Windows due to buggy interpreter) and are not sure how to fix it."

Desc: DRM BUG while initializing cape verde (2nd card)
Repo: 2017-03-13 https://bugzilla.kernel.org/show_bug.cgi?id=194867
Stat: n/a 
Note: problem was in 4.10 already & reporter closed issue

Desc: Two batteries is detected on DEXP Ursus 7W tablet instead of one
Repo: 2017-03-07 https://bugzilla.kernel.org/show_bug.cgi?id=194811
Stat: 2017-03-12 https://bugzilla.kernel.org/show_bug.cgi?id=194811#c8
Note: not a regression in 4.11, but fixed in 4.12


== Fixed since last report ==

Desc: Problem with commit e8a9c58fcd9a ("drm/i915: Unify active context tracking between legacy/execlists/guc")
Repo: 2017-03-23 https://www.mail-archive.com/intel-gfx@lists.freedesktop.org/msg116509.html
Stat: n/a https://git.kernel.org/torvalds/c/0abfe7e2570d7c729a7662e82c09a23f00f29346
Note: 

Desc: commit c2febafc6773 ("mm: convert generic code to 5-level paging") blocks some ARM64 platforms from properly booting
Repo: 2017-03-18 https://bugzilla.kernel.org/show_bug.cgi?id=194915
Stat: n/a gone with RC4
Note: 

Desc: "virtio_pci: use shared interrupts for virtqueues" (5c34d002dcc7) leads to random crashes on a CentOS7 host
Repo: 2017-03-17 https://bugzilla.kernel.org/show_bug.cgi?id=194911
Stat: n/a https://git.kernel.org/torvalds/c/de85ec8b07f82c8c84de7687f769e74bf4c26a1e
Note: Fixed; a related problem is still discussed: https://www.mail-archive.com/search?l=mid&q=20170331032231.GA2471@redhat.com

Desc: VM with virtio-scsi drive often crashes during boot with kernel 4.11rc1
Repo: 2017-03-09 https://bugzilla.kernel.org/show_bug.cgi?id=194837
Stat: n/a https://git.kernel.org/torvalds/c/df23de55615fa7a190a85f49a950ccecdd9102f3 (among others)
Note: 

Desc: [lkp-robot] [f2fs] 4ac912427c: -33.7% aim7.jobs-per-min regression
Repo: 2017-03-08 https://www.spinics.net/lists/kernel/msg2459239.html
Stat: n/a https://git.kernel.org/torvalds/c/4ac912427c4214d8031d9ad6fbc3bc75e71512df https://git.kernel.org/torvalds/c/c0e39d642e41be12937f4532721fc2538182e264
Note: 

Desc: PowerPC crashes on boot, bisected to commit 5657933dbb6e
Repo: 2017-03-02 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1343553.html
Stat: n/a 
Note: Sorry, due to a real life race condition I had missed that the patch fixing this issue was already merged between starting to prepare and publishing my last report :-/
