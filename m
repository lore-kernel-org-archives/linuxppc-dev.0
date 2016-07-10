Return-Path: <fedora@leemhuis.info>
Received: from basicbox7.server-home.net (basicbox7.server-home.net
 [195.137.212.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rnX0j21gqzDqwH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jul 2016 01:17:55 +1000 (AEST)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.7: Reported regressions as of Sunday, 2016-07-10
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <f899a767-aed3-2b25-16ec-96d81d258ecd@leemhuis.info>
Date: Sun, 10 Jul 2016 17:17:48 +0200
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

Hi! Here is my fifth regression report for Linux 4.7. It lists 10
regressions I'm currently aware of; 2 of them are new; 1 of those 
seems to be a a side effect of a fix for another regression.

The report also mentions 3 regression that I removed from the list, as
it looks like those issues are no regressions.

Find also details on 4 regressions that were fixed since the last
report(¹)

As usual: Please let me know about any regression missing on the list  
or if it contains something which shouldn't be there.

HTH, CU, Thorsten

(¹) previous reports can be found at
http://thread.gmane.org/gmane.linux.kernel/2241805
http://thread.gmane.org/gmane.linux.kernel/2247804
http://thread.gmane.org/gmane.linux.kernel/2253623
http://thread.gmane.org/gmane.linux.kernel/2258287

== Current regressions ==

Desc: Bad flicker on skylake HQD due to code in the 4.7 merge window
Repo: 2016-05-30 http://thread.gmane.org/gmane.linux.kernel/2230377
Stat: 2016-07-08 http://thread.gmane.org/gmane.linux.kernel/2230377/focus=94140
Note: vswing issue, maybe primary a Firmware problem; a few patches improved situation, but did not fix the problem

Desc: 795ae7a0de: pixz.throughput -9.1% regression
Repo: 2016-06-02 http://thread.gmane.org/gmane.linux.kernel/2233056/
Stat: 2016-06-22 http://thread.gmane.org/gmane.linux.kernel/2233056/focus=2251134
Note: hannes still can't reproduce; stalled until reporter posts results from more tests

Desc: System hang when plug/un-plug USB 3.1 key via thunderbolt port on Dell XPS 13
Repo: 2016-06-14 https://bugzilla.kernel.org/show_bug.cgi?id=120241
Stat: 2016-07-08 https://bugzilla.kernel.org/show_bug.cgi?id=120241#c7
Note: there was wip, but root cause hard to track down; responsible developer now afk till early August

Desc: regression in 8250 uart driver
Repo: 2016-06-14 http://thread.gmane.org/gmane.linux.kernel/2243130/focus=2243653
Stat: 2016-07-02 http://thread.gmane.org/gmane.linux.kernel/2243130/focus=2258232
Note: andy has it still on his todo list, but something else has a higher priority

Desc: Multi-thread udp 4.7 regression, bisected to 71d8c47fc653; performance decreased or complete failure with a test
Repo: 2016-06-27 http://thread.gmane.org/gmane.linux.network/418861/focus=418908
Stat: 2016-07-05 http://thread.gmane.org/gmane.linux.network/418861/focus=63936
Note: waiting for feedback from reporter

Desc: kmemcheck: Caught 64-bit read from uninitialized memory; iptables/nf_register_net_hooks
Repo: 2016-06-19 https://bugzilla.kernel.org/show_bug.cgi?id=120651
Stat: 2016-07-02 
Note: afaics stalled, after I told reporter a week ago how to contact the relevant developers

Desc: UBSAN splat in drivers/acpi/acpica/dsutils.c:641:16
Repo: 2016-06-15 https://bugzilla.kernel.org/show_bug.cgi?id=120351
Stat: 2016-06-22 https://bugzilla.kernel.org/show_bug.cgi?id=120411#c3
Note: wonder if this is important enough to investigate further; related, similar bugs: https://bugzilla.kernel.org/show_bug.cgi?id=120411 https://bugzilla.kernel.org/show_bug.cgi?id=120391 https://bugzilla.kernel.org/show_bug.cgi?id=120371 https://bugzilla.kernel.org/show_bug.cgi?id=120361 Not sure which of them are regressions

Desc: Kernel does not boot with 7ed18e2d1b6782989eb399ef79a8cc1a1b583b3c ( acpi-4.7-rc7 aka All of these fix recent regressions in ACPICA, in the ACPI PCI IRQ management code and in the ACPI AML debugger.)
Repo: 2016-07-08 https://bugzilla.kernel.org/show_bug.cgi?id=121701
Stat: 2016-07-10 http://thread.gmane.org/gmane.linux.kernel.pci/53279/focus=85652
Note: pointed Rafael to bugzilla on LKML

Desc: ACPI EC problems/ ACPI / EC: Fix an order issue in ec_remove_handlers()
Repo: 2016-07-06 http://thread.gmane.org/gmane.linux.kernel/2260279/
Stat: 2016-07-08 http://thread.gmane.org/gmane.linux.kernel/2260279/focus=85583
Note: patch under discussion


== Going to me removed from the list ==

Desc: RadeonSI get a huge performance dip with used with the nine state tracker
Repo: 2016-06-04 https://bugzilla.kernel.org/show_bug.cgi?id=119631
Stat: 2016-07-04 https://bugzilla.kernel.org/show_bug.cgi?id=119631#c14
Note: not a regression according to one of the AMD graphic driver developers; otoh it looks like one to me; yes, the real bug is in the gallium nine, wine side, but afaics it only showed up after a kernel change introduced a new feature

Desc: performance drop on SFC interface around 30 %
Repo: 2016-06-17 https://bugzilla.kernel.org/show_bug.cgi?id=120461
Stat: 2016-07-06 https://bugzilla.kernel.org/show_bug.cgi?id=120461#c20
Note: reporter and developer agree: not a regression in 4.7

Desc: Rename file corruption due to VFS-Changes?
Repo: 2016-06-16 http://thread.gmane.org/gmane.linux.kernel/2245402/
Stat: 2016-06-22 http://thread.gmane.org/gmane.linux.kernel/2245402/focus=2250254
Note: issue likely fixed in mainline by 9f541801 + e7d6ef979; see also: http://thread.gmane.org/gmane.linux.kernel/2231928/focus=76124


== Fixed since last report ==

Desc: BUG: unable to handle kernel NULL pointer dereference […] qla24xx_process_response_queue+0x49/0x4b0 [qla2xxx]
Repo: 2016-06-14 https://bugzilla.kernel.org/show_bug.cgi?id=120201
Stat: 2016-07-08 https://git.kernel.org/torvalds/c/262e2bfd7d1e1f1ee48b870e5dfabb87c06b975e
Note: Fixed

Desc: Performance drop 30-40% for SPECjbb2005 and SPECjvm2008 benchmarks
Repo: 2016-06-16 https://bugzilla.kernel.org/show_bug.cgi?id=120481
Stat: 2016-07-08 https://git.kernel.org/torvalds/c/7dd4912594daf769a46744848b05bd5bc6d62469 https://git.kernel.org/torvalds/c/ea1dc6fc6242f991656e35e2ed3d90ec1cd13418
Note: Fixed

Desc: lk 4.7 regression: EDAC, amd64_edac: Drop pci_register_driver() use
Repo: 2016-06-15 http://thread.gmane.org/gmane.linux.kernel/2245115/
Stat: 2016-07-08 https://git.kernel.org/torvalds/c/1ead852dd88779eda12cb09cc894a03d9abfe1ec
Note: Fixed

Desc: sound disappeared, ACPI/PCI/IRQ related
Repo: 2016-06-20 http://thread.gmane.org/gmane.linux.kernel/2247930/ http://thread.gmane.org/gmane.linux.acpi.devel/85281/focus=20097
Stat: 2016-07-07 https://git.kernel.org/linus/7ed18e2d1b6782989eb399ef79a8cc1a1b583b3c
Note: fixed
