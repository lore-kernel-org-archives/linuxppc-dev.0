Return-Path: <regressions@leemhuis.info>
Received: from basicbox7.server-home.net (basicbox7.server-home.net
 [195.137.212.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3scVCQ14ZpzDsbC
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Sep 2016 23:26:10 +1000 (AEST)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.8: Reported regressions as of Sunday, 2016-09-18
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <724a8e1c-0141-d663-cda3-8fc0310989ea@leemhuis.info>
Date: Sun, 18 Sep 2016 15:20:53 +0200
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

Hi! Here is my fourth regression report for Linux 4.8. It lists 14
regressions I'm aware of. 5 of them are new; 1 mentioned in last 
weeks report got fixed.

As always: Are you aware of any other regressions? Then please let me
know (simply CC regressions@leemhuis.info). And pls tell me if there
is anything in the report that shouldn't be there.

Ciao, Thorsten

== Current regressions ==

Desc: genirq: Flags mismatch irq 8, 00000088 (mmc0) vs. 00000080 (rtc0). mmc0: Failed to request irq 8: -16
Repo: 2016-08-01 https://bugzilla.kernel.org/show_bug.cgi?id=150881
Stat: 2016-09-09 https://bugzilla.kernel.org/show_bug.cgi?id=150881#c34
Note: stalled; root cause somewhere in the main gpio merge for 4.8, but problematic commit still unknown

Desc: [lkp] [xfs] 68a9f5e700: aim7.jobs-per-min -13.6% regression
Repo: 2016-08-09 http://www.spinics.net/lists/kernel/msg2317052.html
Stat: 2016-09-09 https://marc.info/?t=147341519500003&r=1&w=2
Note: looks like post-4.8 material at this point: Mel working on it in his spare time, but "The progression of this series has been unsatisfactory."

Desc: scsi host6: runtime PM trying to activate child device host6 but parent (2-2:1.0) is not active
Repo: 2016-08-15 https://bugzilla.kernel.org/show_bug.cgi?id=153171
Stat: 2016-09-14 https://bugzilla.kernel.org/show_bug.cgi?id=153171#c5
Note: patch available; mkp "I would like the change to get a bit of soak time before we backport it."

Desc: DT/OCTEON driver probing broken
Repo: 2016-08-16 http://www.spinics.net/lists/devicetree/msg138990.html
Stat: 2016-08-30 http://www.spinics.net/lists/devicetree/msg140682.html
Note: stalled, poked Rob a week ago, got no reply

Desc: gpio-leds broken on OCTEON
Repo: 2016-08-23 http://www.spinics.net/lists/devicetree/msg139863.html
Stat: 2016-09-12 http://www.spinics.net/lists/devicetree/msg140179.html
Note: patch in Linux MIPS patchwork https://patchwork.linux-mips.org/patch/14091/

Desc: Skylake graphics regression: projector failure with 4.8-rc3
Repo: 2016-08-26 http://www.spinics.net/lists/intel-gfx/msg105478.html
Stat: 2016-09-01 https://lkml.org/lkml/2016/8/31/946
Note: stalled, poked lists

Desc: lk 4.8 + !CONFIG_SHMEM + shmat() = oops
Repo: 2016-08-30 http://www.spinics.net/lists/linux-mm/msg112920.html
Stat: 2016-09-07 http://www.spinics.net/lists/linux-mm/msg113177.html
Note: just like last week: patch "ipc/shm: fix crash if CONFIG_SHMEM is not set" is going to fix this, but has not hit mainline yet

Desc: regression in re-read operation by iozone ~10%
Repo: 2016-09-02 https://bugzilla.kernel.org/show_bug.cgi?id=155821
Stat: n/a 
Note: stalled; told reporter he might be better of posting about the issue to some mailing list

Desc: brcmfmac is preventing suspend (Dell XPS 13 9350 / Skylake)/
Repo: 2016-09-13 https://bugzilla.kernel.org/show_bug.cgi?id=156631
Stat: n/a 
Note: used to be https://bugzilla.kernel.org/show_bug.cgi?id=156361 in last weeks report

Desc: CPU speed set very low
Repo: 2016-09-09 https://lkml.org/lkml/2016/9/9/608
Stat: 2016-09-14 https://lkml.org/lkml/2016/9/14/588
Note: Larry: "Testing continues."

Desc: pinctrl: qcom: Clear all function selection bits introduced a regression by not properly masking the calculated value.
Repo: 2016-09-12 http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1229055.html
Stat: n/a 
Note: Patch available in initial report

Desc: WARN in vb2_dma_sg_alloc when makes dvbstream fail with with AverMedia Hybrid+FM
Repo: 2016-09-13 https://bugzilla.kernel.org/show_bug.cgi?id=156751
Stat: n/a 
Note: told reporter he might be better of posting the issue to linux-media

Desc: it is now common that machine needs re-run of xrandr after resume
Repo: 2016-09-13 http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1230782.html
Stat: 2016-09-15 http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1232834.html http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1231104.html
Note: Seems Martin isn't seeing the problem anymore; Pavel's issue might be a different problem anyway; and he now has a userland-problem that complicates testing

Desc: usb: gadget: udc: atmel: fix endpoint name
Repo: 2016-09-15 http://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1232309.html http://www.mail-archive.com/linux-usb@vger.kernel.org/msg80645.html 
Stat: n/a 
Note: Patch available: "Felipe, Greg,It is clearly a regression and material for 4.8-fixes."

== Fixed since last report ==

Desc: ath9k: bring back direction setting in ath9k_{start_stop}
Repo: 2016-09-01 https://marc.info/?l=linux-wireless&m=147292415030585&w=2
Fix:  https://git.kernel.org/torvalds/c/e34f2ff40e0339f6a379e1ecf49e8f2759056453
