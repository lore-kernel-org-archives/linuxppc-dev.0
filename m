Return-Path: <regressions@leemhuis.info>
Received: from basicbox7.server-home.net (basicbox7.server-home.net
 [195.137.212.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3shm1d712GzDrPj
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Sep 2016 22:02:27 +1000 (AEST)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.8: Reported regressions as of Sunday, 2016-09-25
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <b2cc76d8-988d-96f7-b979-30212bdd52b4@leemhuis.info>
Date: Sun, 25 Sep 2016 14:02:19 +0200
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

Hi! Here is my fifth regression report for Linux 4.8. It lists 15
regressions I'm aware of. 5 of them are new (for many of those
there are patches available to fix the regression); 3 mentioned
in last weeks report got fixed; 1 is going to be removed. 

As always: Are you aware of any other regressions? Then please let me
know (simply CC regressions@leemhuis.info). And please tell me if there
is anything in the report that shouldn't be there.

Ciao, Thorsten

== Current regressions ==

Desc: genirq: Flags mismatch irq 8, 00000088 (mmc0) vs. 00000080 (rtc0). mmc0: Failed to request irq 8: -16
Repo: 2016-08-01 https://bugzilla.kernel.org/show_bug.cgi?id=150881
Stat: 2016-09-09 https://bugzilla.kernel.org/show_bug.cgi?id=150881#c34
Note: stalled; root cause somewhere in the main gpio merge for 4.8, but problematic commit still unknown

Desc: scsi host6: runtime PM trying to activate child device host6 but parent (2-2:1.0) is not active
Repo: 2016-08-15 https://bugzilla.kernel.org/show_bug.cgi?id=153171
Stat: 2016-09-14 https://bugzilla.kernel.org/show_bug.cgi?id=153171#c5
Note: "patch available; mkp ""I would like the change to get a bit of soak time before we backport it."""

Desc: DT/OCTEON driver probing broken
Repo: 2016-08-16 http://www.spinics.net/lists/devicetree/msg138990.html
Stat: 2016-08-30 http://www.spinics.net/lists/devicetree/msg140682.html
Note: stalled, poked Rob two weeks ago, got no reply

Desc: gpio-leds broken on OCTEON
Repo: 2016-08-23 http://www.spinics.net/lists/devicetree/msg139863.html
Stat: 2016-09-12 http://www.spinics.net/lists/devicetree/msg140179.html
Note: patch in Linux MIPS patchwork https://patchwork.linux-mips.org/patch/14091/

Desc: regression in re-read operation by iozone ~10%
Repo: 2016-09-02 https://bugzilla.kernel.org/show_bug.cgi?id=155821
Stat: n/a 
Note: stalled; told reporter he might be better of posting about the issue to some mailing list

Desc: brcmfmac is preventing suspend (Dell XPS 13 9350 / Skylake)/
Repo: 2016-09-13 https://bugzilla.kernel.org/show_bug.cgi?id=156631
Stat: n/a 
Note: stalled; told reporter he might be better of posting about the issue to some mailing list; this used to be https://bugzilla.kernel.org/show_bug.cgi?id=156361 in last weeks report

Desc: CPU speed set very low
Repo: 2016-09-09 https://lkml.org/lkml/2016/9/9/608
Stat: 2016-09-23 http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1238862.html
Note: "Larry: ""My debugging continues. […] I think the bug lies between commit 581e0cd (bad) and f7816ad (good). I will need to do a long test on commit 1b05cf6, which did not fail with a shorter run. """

Desc: pinctrl: qcom: Clear all function selection bits introduced a regression by not properly masking the calculated value.
Repo: 2016-09-12 http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1229055.html
Stat: n/a 
Note: stalled; patch available in initial report

Desc: it is now common that machine needs re-run of xrandr after resume
Repo: 2016-09-13 http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1230782.html
Stat: n/a http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1232834.html http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1231104.html
Note: stalled; seems Martin isn't seeing the problem anymore; Pavel's issue might be a different problem anyway; and he now has a userland-problem that complicates testing

Desc: usb: gadget: udc: atmel: fix endpoint name
Repo: 2016-09-15 http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1232309.html 
Stat: 2016-09-23 http://www.mail-archive.com/linux-usb@vger.kernel.org/msg80981.html
Note: "Patch available: Greg: ""It's Felipe's area, not mine"""

Desc: cifs mount regression in 4.8 and 4.4 stable
Repo: 2016-09-22 http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1237249.html
Stat: 2016-09-23 http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1238305.html
Note: root cause seems to be a6b5058 fs/cifs: make share unaccessible at root level mountable

Desc: i2c-core: acpi_i2c_get_info() touches non-existent devices
Repo: 2016-09-19 http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1234457.html
Stat: 2016-09-22 http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1236953.html
Note: "Wolfram added it a patch to his ""for-next"" branch: ""If someone wants it backported, it needs to be rewritten and re-tested."""

Desc: [media] solo6x10: avoid delayed register write
Repo: 2016-09-21 http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1236732.html
Stat: n/a 
Note: patch available in report

Desc: sched/fair: Do not decay new task load on first enqueue
Repo: 2016-09-23 http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1238302.html
Stat: 2016-09-23 http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1238499.html
Note: patch available in report

Desc: MIPS: smp-cps: Avoid BUG() when offlining pre-r6 CPUs
Repo: 2016-09-23 http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1237035.html
Stat: n/a 
Note: patch available in report


== Going to be removed from the list ==

Desc: [lkp] [xfs] 68a9f5e700: aim7.jobs-per-min -13.6% regression
Repo: 2016-08-09 http://www.spinics.net/lists/kernel/msg2317052.html
Stat: 2016-09-09 https://marc.info/?t=147341519500003&r=1&w=2
Note: Dave writes: The regression was an XFS sub-page write issue introduced by the new iomap infrastructure, and nobody has been able to reproduce it exactly outside of the reaim benchmark. We've reproduced other, similar issues, and the fixes for those are queued for the 4.9 window.


== Fixed since last report ==

Desc: lk 4.8 + !CONFIG_SHMEM + shmat() = oops
Repo: 2016-08-30 http://www.spinics.net/lists/linux-mm/msg112920.html
Fix:  https://git.kernel.org/torvalds/c/31b4beb473e3bdee1bf79db849502dcb24b5c202

Desc: WARN in vb2_dma_sg_alloc when makes dvbstream fail with with AverMedia Hybrid+FM
Repo: 2016-09-13 https://bugzilla.kernel.org/show_bug.cgi?id=156751
Fix:  https://git.kernel.org/linus/d8feef9bd447381952a33e6284241006f394c080

Desc: Skylake graphics regression: projector failure with 4.8-rc3
Repo: 2016-08-26 http://www.spinics.net/lists/intel-gfx/msg105478.html
Fix:  Commits not known
