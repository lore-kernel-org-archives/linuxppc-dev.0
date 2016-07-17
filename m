Return-Path: <fedora@leemhuis.info>
Received: from basicbox7.server-home.net (basicbox7.server-home.net
 [195.137.212.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rssmV2DQFzDqDX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2016 02:52:25 +1000 (AEST)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.7: Reported regressions as of Sunday, 2016-07-17
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <726912e8-35f6-2180-1b13-1a87c250ec7d@leemhuis.info>
Date: Sun, 17 Jul 2016 18:52:19 +0200
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

Hi! Here is my sixth regression report for Linux 4.7. It lists 8
regressions I'm currently aware of; 2 of them are new. 

The report also mentions 3 regressions that were fixed since the last
report(¹). There were a few ones that were reported to me in the past
week (many thx for that!) and fixed already, which I did not add to
the list.

As usual: Please let me know about any regression missing on the list 
or if it contains something which shouldn't be there. I'm afk next
weekend, so this likely will be the last regression report before 4.7
gets released. But I guess I'll write at least one or two more reports
after that to make sure regressions found after the release get
collected somewhere.

HTH, CU, Thorsten

(¹) previous reports can be found at
http://thread.gmane.org/gmane.linux.kernel/2241805
http://thread.gmane.org/gmane.linux.kernel/2247804
http://thread.gmane.org/gmane.linux.kernel/2253623
http://thread.gmane.org/gmane.linux.kernel/2258287
http://thread.gmane.org/gmane.linux.kernel/2262759


== Current regressions ==

Desc: 795ae7a0de: pixz.throughput -9.1% regression
Repo: 2016-06-02 http://thread.gmane.org/gmane.linux.kernel/2233056/
Stat: 2016-06-22 http://thread.gmane.org/gmane.linux.kernel/2233056/focus=2251134
Note: stalled; hannes can't reproduce and waits for reporter to post results from more tests

Desc: System hang when plug/un-plug USB 3.1 key via thunderbolt port on Dell XPS 13
Repo: 2016-06-14 https://bugzilla.kernel.org/show_bug.cgi?id=120241
Stat: 2016-07-16 https://bugzilla.kernel.org/show_bug.cgi?id=120241#c37
Note: wip, but root cause hard to track down

Desc: regression in 8250 uart driver
Repo: 2016-06-14 http://thread.gmane.org/gmane.linux.kernel/2243130/focus=2243653
Stat: 2016-07-02 http://thread.gmane.org/gmane.linux.kernel/2243130/focus=2258232
Note: andy has it still on his todo list, but something else has a higher priority

Desc: Multi-thread udp 4.7 regression, bisected to 71d8c47fc653; performance decreased or complete failure with a test
Repo: 2016-06-27 http://thread.gmane.org/gmane.linux.network/418861/focus=418908
Stat: 2016-07-12 http://thread.gmane.org/gmane.linux.network/418861/focus=63936
Note: patch "netfilter: conntrack: skip clash resolution if nat is in place" in the net tree fixes this

Desc: kmemcheck: Caught 64-bit read from uninitialized memory; iptables/nf_register_net_hooks
Repo: 2016-06-19 https://bugzilla.kernel.org/show_bug.cgi?id=120651
Stat: 2016-07-11 https://bugzilla.kernel.org/show_bug.cgi?id=120651#c2
Note: reporter wanted to recheck, nothing new since then

Desc: UBSAN splat in drivers/acpi/acpica/dsutils.c:641:16
Repo: 2016-06-15 https://bugzilla.kernel.org/show_bug.cgi?id=120351
Stat: 2016-06-22 https://bugzilla.kernel.org/show_bug.cgi?id=120411#c3
Note: wonder if this is important enough to investigate further; related, similar bugs: https://bugzilla.kernel.org/show_bug.cgi?id=120411 https://bugzilla.kernel.org/show_bug.cgi?id=120391 https://bugzilla.kernel.org/show_bug.cgi?id=120371 https://bugzilla.kernel.org/show_bug.cgi?id=120361 Not sure which of them are regressions

Desc: After commit f21a21983ef13a, the i915 display is turned off
Repo: 2016-06-16 https://bugs.freedesktop.org/show_bug.cgi?id=96675
Stat: 2016-07-15 http://thread.gmane.org/gmane.linux.kernel/2266539/focus=94597 https://bugs.freedesktop.org/show_bug.cgi?id=96675#c11
Note: fix in the works: https://bugs.freedesktop.org/show_bug.cgi?id=96675

Desc: legacy gamma table updates are completely broken for Intel on Linux-4.7-rc7
Repo: 2016-07-12 http://thread.gmane.org/gmane.comp.video.dri.devel/159323/
Stat: 2016-07-14 http://thread.gmane.org/gmane.comp.video.dri.devel/159323/focus=159663
Note: seems https://patchwork.freedesktop.org/patch/89111/ (drm/i915: add missing condition for committing planes on crtc) fixes this


== Fixed since last report ==

Desc: Bad flicker on skylake HQD due to code in the 4.7 merge window
Repo: 2016-05-30 http://thread.gmane.org/gmane.linux.kernel/2230377
Stat: 2016-07-08 http://thread.gmane.org/gmane.linux.kernel/2230377/focus=94140
Note: Fixed by http://thread.gmane.org/gmane.linux.kernel/2230377/focus=94140 vswing issue, maybe primary a Firmware problem; a few patches improved situation, but did not fix the problem

Desc: Kernel does not boot with 7ed18e2d1b6782989eb399ef79a8cc1a1b583b3c ( acpi-4.7-rc7 aka All of these fix recent regressions in ACPICA, in the ACPI PCI IRQ management code and in the ACPI AML debugger.)
Repo: 2016-07-08 https://bugzilla.kernel.org/show_bug.cgi?id=121701
Stat: 2016-07-10 http://thread.gmane.org/gmane.linux.kernel.pci/53279/focus=85652
Note: fixed by https://git.kernel.org/linus/f1b5e4fac164ff43b189d996e4f05f95cc57b984

Desc: ACPI EC problems/ ACPI / EC: Fix an order issue in ec_remove_handlers()
Repo: 2016-07-06 http://thread.gmane.org/gmane.linux.kernel/2260279/
Stat: 2016-07-08 http://thread.gmane.org/gmane.linux.kernel/2260279/focus=85583
Note: fixed by https://git.kernel.org/torvalds/c/fa5b4a509d7bbba5d45c8ea177bddfd0b618876a
