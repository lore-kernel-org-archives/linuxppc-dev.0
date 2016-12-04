Return-Path: <regressions@leemhuis.info>
Received: from basicbox7.server-home.net (basicbox7.server-home.net
 [195.137.212.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tWnDk0KNgzDvhP
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Dec 2016 23:26:12 +1100 (AEDT)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.9: Reported regressions as of Sunday, 2016-12-04
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <39bd6752-d30c-8994-1a09-ee6d225afd03@leemhuis.info>
Date: Sun, 4 Dec 2016 13:26:05 +0100
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

Hi! Here is my fifth regression report for Linux 4.9. It lists 11
regressions I'm aware of. 4 of them are new; 6 got fixed since 
the last report -- that was two weeks ago, because I yet again
didn't find any spare time to compile a report last Sunday :-/

As always: Are you aware of any other regressions? Then please let me
know (simply CC regressions@leemhuis.info). And please tell me if there
is anything in the report that shouldn't be there.

Ciao, Thorsten

== Current regressions ==

Desc: System hang up with call trace during doing S3/S4 stress
Repo: 16-12-01 https://bugzilla.kernel.org/show_bug.cgi?id=189421
Stat: n/a 
Note: Brand new

Desc: x86/unwind: Fix guess-unwinder regression // With frame pointers disabled, /proc/<pid>/stack is broken
Repo: 16-11-28 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1281244.html
Stat: n/a 
Note: Fix heading upstream

Desc: [lkp] [mremap] 5d1904204c: will-it-scale.per_thread_ops -13.1% regression
Repo: 16-11-27 https://www.spinics.net/lists/linux-mm/msg117307.html
Stat: n/a 
Note: Aaron could not reproduce the issue on two of his machines

Desc: sched: fix find_idlest_group for fork/performance regression in hackbench
Repo: 16-11-25 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1280514.html
Stat: 16-12-04 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1285936.html
Note: Report contains patch to fix this, testing ongoing

Desc: GPU hang on resume from hibernation
Repo: 16-10-16 https://bugs.freedesktop.org/show_bug.cgi?id=98288#c9 https://bugzilla.kernel.org/show_bug.cgi?id=177701
Stat: n/a 
Note: confusing bug, but seems the issue is still present

Desc: GPU hang on PlaneShift
Repo: 16-10-16 https://bugs.freedesktop.org/show_bug.cgi?id=98922 https://bugzilla.kernel.org/show_bug.cgi?id=177701
Stat: n/a 
Note: confusing bug, but the issue might still be present

Desc: [i.MX6 DRM IPUv3] Regression 4.9-rc5: greenish screen with YUV420 video
Repo: 16-11-17 https://www.spinics.net/lists/kernel/msg2385550.html
Stat: 16-12-02 https://www.spinics.net/lists/kernel/msg2396720.html
Note: "patch available: 3fd8b292ae6b (""drm/imx: ipuv3-plane: merge ipu_plane_atomic_set_base into atomic_update"")"

Desc: "Failed boots/Package drops bisected to 4cd13c21b207 ""softirq: Let ksoftirqd do its job""; "
Repo: 16-11-16 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1273344.html
Stat: 16-11-25 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1280379.html
Note: Stalled

Desc: builddeb: fix cross-building to arm64 producing host-arch debs
Repo: 16-11-04 https://www.spinics.net/lists/linux-kbuild/msg13635.html
Stat: 16-11-11 https://www.spinics.net/lists/linux-kbuild/msg13696.html
Note: Nothing happened when Adam pinged Michael in https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1276268.html


== Stalled, waiting for feedback from reporter ==

Desc: 4.9-rc1 boot regression, ambiguous bisect result
Repo: 2016-10-19 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1253369.html
Stat: 16-10-21 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1255296.html
Note: Waiting for Dan or someone else to look into this

Desc: Skylake gen6 suspend/resume video regression
Repo: 16-10-16 https://bugzilla.kernel.org/show_bug.cgi?id=177731 https://bugs.freedesktop.org/show_bug.cgi?id=98517
Stat: 16-10-31 https://bugzilla.kernel.org/show_bug.cgi?id=177731#c7
Note: Stalled

== Fixed since last report ==

Desc: module loadling broken due to kbuild changes
Repo: 16-10-15 http://www.gossamer-threads.com/lists/linux/kernel/2544734 and various other threads (https://lwn.net/Articles/707520/ )
Fix:  https://git.kernel.org/torvalds/c/cd3caefb4663e3811d37cc2afad3cce642d60061 https://git.kernel.org/torvalds/c/faaae2a581435f32781a105dda3501df388fddcb (among others)

Desc: "irq 16: nobody cared (try booting with the ""irqpoll"" option) since t0b9e2988ab226 (ahci: use pci_alloc_irq_vectors)"
Repo: 16-11-19 https://bugzilla.kernel.org/show_bug.cgi?id=188181
Stat: 16-12-03 https://bugzilla.kernel.org/show_bug.cgi?id=188181#c9
Note: Fixed according to reporter (might be thx to https://git.kernel.org/torvalds/c/6929ef385e09c0065b87fda3e7b872a5070ac783 )

Desc: "build regression: make.cross ARCH=mips fails with ""No rule to make target 'alchemy/devboards/'. """
Repo: 16-10-30 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1262410.html https://marc.info/?l=linux-kernel&m=147780880425626
Fix:  https://git.kernel.org/torvalds/c/818f38c5b7c4482abd71c64ac4d49911fbefaf9e

Desc: "oops due to 493b2ed3f760 (""crypto: algif_hash - Handle NULL hashes correctly"")"
Repo: 16-11-17 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1273867.html
Fix:  https://git.kernel.org/torvalds/c/a8348bca2944d397a528772f5c0ccb47a8b58af4

Desc: MSI is no longer enabled for many/most Intel SATA controllers in 4.9
Repo: 16-11-16 https://bugzilla.kernel.org/show_bug.cgi?id=187821
Fix:  https://git.kernel.org/torvalds/c/6929ef385e09c0065b87fda3e7b872a5070ac783

Desc: qla2xxx: do not abort all commands in the adapter during EEH recovery
Repo: 16-11-14 https://www.mail-archive.com/linux-scsi@vger.kernel.org/msg55186.html
Fix:  https://git.kernel.org/torvalds/c/c733ab3512431436a26e0381829b45794cb13fb0
