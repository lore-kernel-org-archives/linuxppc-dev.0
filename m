Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w1Kht0FmRzDqHK
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Apr 2017 03:15:56 +1000 (AEST)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.11: Reported regressions as of Sunday, 2017-04-09
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <14254185-456f-4940-6a67-bc75d1eeb123@leemhuis.info>
Date: Sun, 9 Apr 2017 19:15:49 +0200
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

Hi! Find below my third regression report for Linux 4.11. It lists 15
regressions I'm currently aware of. 5 regressions mentioned in last
weeks report got fixed.

As always: Are you aware of any other regressions? Then please let me
know (simply CC regressions@leemhuis.info). And please tell me if there
is anything in the report that shouldn't be there.

Ciao, Thorsten

P.S.: Thx to all those that CCed me on regression reports or provided
other input, as that makes compiling these reports a whole lot easier!

== Current regressions ==

Desc: Problems since 5b52330bbfe6 "audit: fix auditd/kernel connection state tracking"
Repo: 2017-04-09 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1373243.html
Stat: 2017-04-09 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1373315.html
Note: solution discussed

Desc: "Synaptics Touch Digitizer V04" no longer working
Repo: 2017-04-08 https://bugzilla.kernel.org/show_bug.cgi?id=195287
Stat: n/a 
Note: brand new

Desc: crash since 617f01211baf ("8139too: use napi_complete_done()")
Repo: 2017-04-07 https://www.mail-archive.com/netdev@vger.kernel.org/msg162162.html
Stat: 2017-04-08 https://www.mail-archive.com/netdev@vger.kernel.org/msg162285.html
Note: quite new, people are looking into it

Desc: Warning since RC4: sed_opal:OPAL: Error on step function: 0 with error -95: Unknown Error
Repo: 2017-04-07 https://bugzilla.kernel.org/show_bug.cgi?id=195277
Stat: 2017-04-07 https://bugzilla.kernel.org/show_bug.cgi?id=195277#c1
Note: patch submitted

Desc: networking/softirq performance regression due to a part of 374ad05ab64d
Repo: 2017-03-29 https://lkml.org/lkml/2017/3/29/758
Stat: 2017-04-05 https://lkml.org/lkml/2017/4/5/553
Note: might be stalled

Desc: 4.11 PowerMac G5 970MP: [drm:.r600_ring_test [radeon]] *ERROR* radeon: ring 0 test failed (scratch(0x8504)=0xCAFEDEAD
Repo: 2017-03-24  https://bugs.freedesktop.org/show_bug.cgi?id=99851#c26
Stat: n/a 
Note: looks like reporter (who does not see the problem in 4.10) could need some help bisecting

Desc: Commit d8514d8edb5b ("ovl: copy up regular file using O_TMPFILE") breaks ubifs
Repo: 2017-03-28 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1363879.html
Stat: 2017-03-30 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1366190.html https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1366208.html
Note: looks stalled after patches to fix issue seemed to do well in tests

Desc: 07ec51480b5e  ("virtio_pci: use shared interrupts for virtqueues") causes some kworker grief in -rt too
Repo: 2017-03-27 https://www.mail-archive.com/search?l=mid&q=1490605644.14634.50.camel@gmx.de
Stat: 2017-04-07 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1372848.html
Note: WIP

Desc: pine64 defconfig: WARNING: CPU: 0 PID: 86 at drivers/base/dd.c:349 driver_probe_device+0x258/0x2c0
Repo: 2017-03-25 https://bugzilla.kernel.org/show_bug.cgi?id=195037 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1368488.html
Stat: 2017-03-28 https://bugzilla.kernel.org/show_bug.cgi?id=195037#c2
Note: André doesnt have a clue and needs someone with insights devm and devres

Desc: NVMe APST? Samsung PM951 NVMe sudden controller death
Repo: 2017-03-25 https://bugzilla.kernel.org/show_bug.cgi?id=195039
Stat: 2017-03-29 
Note: Poked luto, as it looked stalled; maybe a blacklist update is needed;  issue might be related to https://bugzilla.kernel.org/show_bug.cgi?id=194921 (see below)

Desc: NVMe APST? NVMe resets leads to capacity change to 0, leading to panics; Samsung SSD as well
Repo: 2017-03-18 https://bugzilla.kernel.org/show_bug.cgi?id=194921
Stat: 2017-03-28 
Note: Poked luto, as it looked stalled; maybe a blacklist update is needed;  issue might be related to https://bugzilla.kernel.org/show_bug.cgi?id=195039 (see above)

Desc: Perf regression after enabling nvme APST
Repo: 2017-03-17 https://lkml.org/lkml/2017/3/17/177
Stat: 2017-03-20 https://lkml.org/lkml/2017/3/20/998
Note: stalled

Desc: i915 gpu hangs under load
Repo: 2017-03-22 https://www.mail-archive.com/intel-gfx@lists.freedesktop.org/msg116227.html https://bugs.freedesktop.org/show_bug.cgi?id=100181 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1372182.html
Stat: 2017-04-07 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1372182.html
Note: A few patches from Andrea (who's seeing problems as well) are being discussed

Desc: Synaptics RMI4 touchpad regression in 4.11-rc1: pointer jumps
Repo: 2017-03-11 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1351561.html
Stat: 2017-03-31 https://www.mail-archive.com/search?l=mid&q=20170331085751.GF22683@mail.corp.redhat.com
Note: stalled; two patched to improve the situation available;

Desc: Synaptics RMI4 touchpad regression in 4.11-rc1: palm detection
Repo: 2017-03-11 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1351561.html
Stat: 2017-03-19 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1356832.html
Note: stalled; asked for an update, did not get one


== Stalled, waiting for feedback from reporter ==

Desc: kvm: workqueue lockup
Repo: 2017-03-14 https://bugzilla.kernel.org/show_bug.cgi?id=194883
Stat: 2017-03-27 https://bugzilla.kernel.org/show_bug.cgi?id=194883#c1
Note: asked reporter if issue still present in RC4

Desc: general protection fault: inet6_fill_ifaddr+0x6c/0x230
Repo: 2017-03-11 https://bugzilla.kernel.org/show_bug.cgi?id=194849
Stat: 2017-03-13 https://bugzilla.kernel.org/show_bug.cgi?id=194849#c1
Note: Cong Wang asked reporter for details, didn't get any reply yet


== Going to be removed from the list ==

Desc: thinkpad x220: GPU hang
Repo: 2017-03-05 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1345689.html
Stat: 2017-04-09 https://www.mail-archive.com/dri-devel@lists.freedesktop.org/msg182505.html
Note: Pavel writes: "4.11-rc5 is actually usable on the hardware (unlike -rc1), not sure what changed."


== Fixed since last report ==

Desc: 4.10/4.11: mmc: core: HS DDR switch, don't change timing before checking status, as it might lead to boot problems
Repo: 2017-03-10 https://patchwork.kernel.org/patch/9617489/
Stat: 2017-03-31 https://git.kernel.org/torvalds/c/d0918764c17b94c30bbb2619929b1719ff52707a
Note: Thx Nicolas for the pointer!

Desc: e1000e: __pci_enable_msi_range fails before/after resume
Repo: 2017-03-06 https://bugzilla.kernel.org/show_bug.cgi?id=194801
Fix:  https://git.kernel.org/torvalds/c/9f47a48e6eb97d793db85373e3ef4c55d876d334

Desc: HP 820 G3 becomes unstable after resume from suspend
Repo: 2017-03-25 https://bugzilla.kernel.org/show_bug.cgi?id=195041
Fix:  https://git.kernel.org/torvalds/c/9f47a48e6eb97d793db85373e3ef4c55d876d334

Desc: DRM BUG while initializing cape verde (2nd card)
Repo: 2017-03-13 https://bugzilla.kernel.org/show_bug.cgi?id=194867
Stat: 2017-04-06 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1372242.html
Note: Michael clarified (thx!): two issued discussed in bug report; only one was a regression and it was fixed

Desc: malta_defconfig regressions
Repo: 2017-03-31 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1367470.html
Fix:  https://git.kernel.org/torvalds/c/42969893b45a7a1864192f5634a8d2626e546a7b
