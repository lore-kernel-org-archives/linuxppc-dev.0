Return-Path: <fedora@leemhuis.info>
Received: from basicbox7.server-home.net (basicbox7.server-home.net
 [195.137.212.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rhkYP6QKvzDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  3 Jul 2016 05:56:09 +1000 (AEST)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.7: Reported regressions as of Saturday, 2016-07-02
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org
Message-ID: <098e9823-c83e-2c82-5fcf-fb562eb80158@leemhuis.info>
Date: Sat, 2 Jul 2016 21:47:34 +0200
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

Hi! Here is my fourth regression report for Linux 4.7; a day earlier then usual.
It has 14 entries;
 * 2 of them are new
 * 9 regressions (not included here) were fixed since the last report(¹)
 * 1 made it to the list after last Sunday (thx for telling me about it Kalle!),
   but was fixed before I compiled this one
 * 2 turned out to not be regressions at all
 * 1 was a duplicate

Fixes for 4 of the regression in this report are heading towards mainline. 
One of the remaining regressions is likely fixed already. 

Please let me know if a regression is missing in the list; or if
there is something on the list which shouldn't be there.

HTH, CU, Thorsten

(¹) previous reports can be found at
http://thread.gmane.org/gmane.linux.kernel/2241805
http://thread.gmane.org/gmane.linux.kernel/2247804
http://thread.gmane.org/gmane.linux.kernel/2253623

----
Desc: Bad flicker on skylake HQD due to code in the 4.7 merge window
Repo: 2016-05-30 http://thread.gmane.org/gmane.linux.kernel/2230377
Stat: 2016-06-23 http://thread.gmane.org/gmane.linux.kernel/2230377/focus=158274
Note: vswing issue, maybe primary a Firmware problem; nevertheless a regression; nothing happened for a week, so poked list

Desc: 795ae7a0de: pixz.throughput -9.1% regression
Repo: 2016-06-02 http://thread.gmane.org/gmane.linux.kernel/2233056/
Stat: 2016-06-22 http://thread.gmane.org/gmane.linux.kernel/2233056/focus=2251134
Note: hannes still can't reproduce; stalled, until reporter posts results from more tests

Desc: RadeonSI get a huge performance dip with used with the nine state tracker
Repo: 2016-06-04 https://bugzilla.kernel.org/show_bug.cgi?id=119631
Stat: 2016-06-20 https://bugzilla.kernel.org/show_bug.cgi?id=119631#c14
Note: poked bugzilla, as it looked stalled

Desc: BUG: unable to handle kernel NULL pointer dereference […] qla24xx_process_response_queue+0x49/0x4b0 [qla2xxx]
Repo: 2016-06-14 https://bugzilla.kernel.org/show_bug.cgi?id=120201
Stat: 2016-06-30 http://thread.gmane.org/gmane.linux.kernel/2257008/focus=2257139 http://thread.gmane.org/gmane.linux.kernel/2247804/focus=2252004 http://thread.gmane.org/gmane.linux.kernel/2257008/focus=2257139
Note: Patch which fixes the problem (at least afaics) was posted on 2016-06-30

Desc: Performance drop 30-40% for SPECjbb2005 and SPECjvm2008 benchmarks
Repo: 2016-06-16 https://bugzilla.kernel.org/show_bug.cgi?id=120481
Stat: 2016-06-25 https://bugzilla.kernel.org/show_bug.cgi?id=120481#c15 http://thread.gmane.org/gmane.linux.kernel/2245977/focus=2253079
Note: solution heading upstream (made it from sched/urgent to tip 7dd4912594daf769a46744848b05bd5bc6d62469 ea1dc6fc6242f991656e35e2ed3d90ec1cd13418 )

Desc: performance drop on SFC interface around 30 %
Repo: 2016-06-17 https://bugzilla.kernel.org/show_bug.cgi?id=120461
Stat: 2016-07-01 https://bugzilla.kernel.org/show_bug.cgi?id=120461#c12
Note: poked bugzilla, as it looked stalled

Desc: System hang when plug/un-plug USB 3.1 key via thunderbolt port on Dell XPS 13
Repo: 2016-06-14 https://bugzilla.kernel.org/show_bug.cgi?id=120241
Stat: 2016-07-02 https://bugzilla.kernel.org/show_bug.cgi?id=120241#c7
Note: wip

Desc: lk 4.7 regression: EDAC, amd64_edac: Drop pci_register_driver() use
Repo: 2016-06-15 http://thread.gmane.org/gmane.linux.kernel/2245115/
Stat: 2016-07-01 (private mail) http://thread.gmane.org/gmane.linux.kernel/2246008/focus=2246009
Note: solution heading upstream (solution in tip: 1ead852dd88779eda12cb09cc894a03d9abfe1ec )

Desc: regression in 8250 uart driver
Repo: 2016-06-14 http://thread.gmane.org/gmane.linux.kernel/2243130/focus=2243653
Stat: 2016-07-02 http://thread.gmane.org/gmane.linux.kernel/2243130/focus=2258232
Note: andy has it still on his todo list, but something else has a higher priority

Desc: sound disappeared, ACPI/PCI/IRQ related
Repo: 2016-06-20 http://thread.gmane.org/gmane.linux.kernel/2247930/
Stat: 2016-06-30 http://thread.gmane.org/gmane.linux.kernel/2247930/focus=2256773 http://thread.gmane.org/gmane.linux.acpi.devel/85281/focus=20097
Note: Rafael queued fix

Desc: Multi-thread udp 4.7 regression, bisected to 71d8c47fc653; performance decreased or complete failure with a test
Repo: 2016-06-27 http://thread.gmane.org/gmane.linux.network/418861/focus=418908
Stat: 2016-06-27 http://thread.gmane.org/gmane.linux.network/418861/focus=418908
Note: poke someone on Monday, looks it fel of the radar

Desc: kmemcheck: Caught 64-bit read from uninitialized memory; iptables/nf_register_net_hooks
Repo: 2016-06-19 https://bugzilla.kernel.org/show_bug.cgi?id=120651
Stat: 2016-07-02 
Note: told reporter how to contact the relevant developers

Desc: Rename file corruption due to VFS-Changes?
Repo: 2016-06-16 http://thread.gmane.org/gmane.linux.kernel/2245402/
Stat: 2016-06-22 http://thread.gmane.org/gmane.linux.kernel/2245402/focus=2250254
Note: issue likely fixed in mainline by 9f541801 + e7d6ef979; see also: http://thread.gmane.org/gmane.linux.kernel/2231928/focus=76124

Desc: UBSAN splat in drivers/acpi/acpica/dsutils.c:641:16
Repo: 2016-06-15 https://bugzilla.kernel.org/show_bug.cgi?id=120351
Stat: 2016-06-22 https://bugzilla.kernel.org/show_bug.cgi?id=120411#c3
Note: wonder if this is important enough to investigate further; related, similar bugs: https://bugzilla.kernel.org/show_bug.cgi?id=120411 https://bugzilla.kernel.org/show_bug.cgi?id=120391 https://bugzilla.kernel.org/show_bug.cgi?id=120371 https://bugzilla.kernel.org/show_bug.cgi?id=120361 Not sure which of them are regressions
