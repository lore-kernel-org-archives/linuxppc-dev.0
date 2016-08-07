Return-Path: <fedora@leemhuis.info>
Received: from basicbox7.server-home.net (basicbox7.server-home.net
 [195.137.212.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3s6hpB3CP8zDqYk
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Aug 2016 23:53:20 +1000 (AEST)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.7: Reported regressions as of Sunday, 2016-08-07
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <aecd3c94-e61a-946e-fb45-b5a4e1eb04db@leemhuis.info>
Date: Sun, 7 Aug 2016 15:53:13 +0200
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

Hi! Here is my seventh regression report for Linux 4.7. It lists 9
regressions I'm currently aware of. 4 of them are new; 2 are stalled
until the reporter provides more feedback.

The report also mentions 3 regressions that were fixed since the last
report. There is also 1 I plan to remove because it's just referring 
to new warnings from UBSAN (let me know if you think it should stay).

As usual: Please let me know about any regressions missing on the list
or if it contains something which shouldn't be there. Since the 
release of 4.7 there were quite a few new bugs filed on 
bugzilla.kernel.org that mentioned 4.7; I briefly looked at them, but
it looks like most of them are not regression (sometimes it's not 
pretty clear, but I currently lack the time to investigate further 
into each of those). 

I'll send the first regression report for 4.9 next week

HTH, CU, Thorsten

P.S.: Gmane, I miss you. A lot. 

== Current regressions ==

Desc: System hang when plug/un-plug USB 3.1 key via thunderbolt port on Dell XPS 13
Repo: 2016-06-14 https://bugzilla.kernel.org/show_bug.cgi?id=120241
Stat: 2016-08-05 https://bugzilla.kernel.org/show_bug.cgi?id=120241#c40
Note: wip

Desc: regression in 8250 uart driver
Repo: 2016-06-14 http://thread.gmane.org/gmane.linux.kernel/2243130/focus=2243653
Stat: 2016-07-02 https://lkml.org/lkml/2016/7/2/94
Note: need to poke andy for a status update

Desc: ath9k/ ar5008 Oopses on v4.7-rc7+
Repo: 2016-07-17 https://marc.info/?l=linux-wireless&m=146878954223067&w=2
Stat: 2016-08-04 https://marc.info/?l=linux-wireless&m=147029189600658&w=2
Note: fix ath9k-fix-accessing-gpio-warning.patch available

Desc: Regression: commit 12549e2 clocksource/drivers/time-armada-370-xp: Convert init function to return error
Repo: 2016-07-28 https://bugzilla.kernel.org/show_bug.cgi?id=150571
Stat: 2016-08-06 https://lkml.org/lkml/2016/8/6/65
Note: proper developer now in the loop

Desc: ath9k cpuidle warnings ath9k_beacon_config (No adverse effects are noticed but this must be from quite a recent commit.)
Repo: 2016-08-02 https://bugzilla.kernel.org/show_bug.cgi?id=151271
Stat: n/a 
Note: needs further investigation; seem I or somebody else need to help here

Desc: /dev/input/by-path links for PS/2 input devices are not created
Repo: 2016-08-02 https://bugzilla.kernel.org/show_bug.cgi?id=151331
Stat: n/a 
Note: needs further investigation; seem I or somebody else need to help here

Desc: performance degradation on Opteron 6272 related to COD technology
Repo: 2016-06-28 https://marc.info/?l=linux-kernel&m=146715574528055&w=2
Stat: 2016-07-28 https://marc.info/?l=linux-kernel&m=146974252111026&w=2
Note: wip


== Stalled, waiting for feedback from reporter ==

Desc: 795ae7a0de: pixz.throughput -9.1% regression
Repo: 2016-06-02 http://thread.gmane.org/gmane.linux.kernel/2233056/
Stat: 2016-06-22 https://lkml.org/lkml/2016/6/22/754
Note: stalled; hannes could not reproduce and asked reporter for further feedback weeks ago

Desc: kmemcheck: Caught 64-bit read from uninitialized memory; iptables/nf_register_net_hooks
Repo: 2016-06-19 https://bugzilla.kernel.org/show_bug.cgi?id=120651
Stat: 2016-07-17 https://bugzilla.kernel.org/show_bug.cgi?id=120651#c8
Note: waiting for reporter to check a proposed fix


== Going to be removed from the list ==

Desc: UBSAN splat in drivers/acpi/acpica/dsutils.c:641:16
Repo: 2016-06-15 https://bugzilla.kernel.org/show_bug.cgi?id=120351
Stat: 2016-06-22 https://bugzilla.kernel.org/show_bug.cgi?id=120411#c3
Note: this debugging feature found new problems, but it seems the bugs don't get much attention (like many ohters on bugzilla.kernel.org); if nobody complains I'll remove this regression from the report to spend time for more important bugs; related, similar bugs: https://bugzilla.kernel.org/show_bug.cgi?id=120411 https://bugzilla.kernel.org/show_bug.cgi?id=120391 https://bugzilla.kernel.org/show_bug.cgi?id=120371 https://bugzilla.kernel.org/show_bug.cgi?id=120361 Not sure which of them are regressions


== Fixed since last report ==

Desc: Multi-thread udp 4.7 regression, bisected to 71d8c47fc653; performance decreased or complete failure with a test
Repo: 2016-06-27 http://thread.gmane.org/gmane.linux.network/418861/focus=418908
Stat: 2016-07-12 http://thread.gmane.org/gmane.linux.network/418861/focus=63936
Note: fixed by https://git.kernel.org/torvalds/c/590b52e10d410e1439ae86be9fe19d75fdab628b

Desc: After commit f21a21983ef13a, the i915 display is turned off
Repo: 2016-06-16 https://bugs.freedesktop.org/show_bug.cgi?id=96675
Stat: 2016-07-15 http://thread.gmane.org/gmane.linux.kernel/2266539/focus=94597 https://bugs.freedesktop.org/show_bug.cgi?id=96675#c11
Note: fixed by https://git.kernel.org/torvalds/c/c71d4d58981bed3366769ef5cf1f20e588fe16d0

Desc: legacy gamma table updates are completely broken for Intel on Linux-4.7-rc7
Repo: 2016-07-12 http://thread.gmane.org/gmane.comp.video.dri.devel/159323/
Stat: 2016-07-14 http://thread.gmane.org/gmane.comp.video.dri.devel/159323/focus=159663
Note: fixed by https://git.kernel.org/torvalds/c/ed2eebbd61af8d378ca39ad7aef7017f29eed6f3
