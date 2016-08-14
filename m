Return-Path: <fedora@leemhuis.info>
Received: from basicbox7.server-home.net (basicbox7.server-home.net
 [195.137.212.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sC2RL0y9DzDqQ5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Aug 2016 01:22:03 +1000 (AEST)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.7: Reported regressions as of Sunday, 2016-08-14
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <b3824dd6-dad9-6df7-d518-78a6706d491a@leemhuis.info>
Date: Sun, 14 Aug 2016 17:21:57 +0200
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

Hi! Here is my eight regression report for Linux 4.7. It lists 13
regressions I'm currently aware of. 6 of them are new; none were fixed.

As usual: Please let me know about any regressions missing on the list
or if it contains something which shouldn't be there. Since the release
of 4.7 there were quite a few new bugs filed on bugzilla.kernel.org
that mentioned 4.7; I briefly looked at them, but it looks like most of
them are not regressions.

Ciao, Thorsten

== Current regressions ==

Desc: System hang when plug/un-plug USB 3.1 key via thunderbolt port on Dell XPS 13
Repo: 2016-06-14 https://bugzilla.kernel.org/show_bug.cgi?id=120241
Stat: 2016-08-12 https://bugzilla.kernel.org/show_bug.cgi?id=120241#c41
Note: wip (slowly)

Desc: regression in 8250 uart driver
Repo: 2016-06-14 http://thread.gmane.org/gmane.linux.kernel/2243130/focus=2243653
Stat: 2016-07-02 https://lkml.org/lkml/2016/7/2/94
Note: need to poke andy for a status update

Desc: ath9k/ ar5008 Oopses on v4.7-rc7+
Repo: 2016-07-17 https://marc.info/?l=linux-wireless&m=146878954223067&w=2
Stat: 2016-08-04 https://marc.info/?l=linux-wireless&m=147029189600658&w=2
Note: https://patchwork.kernel.org/patch/9262875/; not yet in mainline

Desc: Regression: commit 12549e2 clocksource/drivers/time-armada-370-xp: Convert init function to return error
Repo: 2016-07-28 https://bugzilla.kernel.org/show_bug.cgi?id=150571
Stat: 2016-08-06 https://lkml.org/lkml/2016/8/6/65
Note: proper developers now in the loop

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

Desc: ext4 error in dx_probe (due to the new parallel dir lookup code?)
Repo: 2016-07-18 https://lkml.org/lkml/2016/7/18/191
Stat: 2016-08-09 https://lkml.org/lkml/2016/8/7/105 https://lkml.org/lkml/2016/8/9/86
Note: looks like its fixed in mainline by b47820edd

Desc: Display lost on Kirkwood/OpenRD Client
Repo: 2016-08-11 http://www.spinics.net/lists/kernel/msg2318358.html
Stat: 2016-08-11 http://www.spinics.net/lists/kernel/msg2319139.html
Note: proper patch in the works

Desc: [AR9285] WiFi LED stops working after suspend/hibernate cycle
Repo: 2016-08-08 https://bugzilla.kernel.org/show_bug.cgi?id=151711
Stat: n/a 
Note: 

Desc: Updating from 4.6.4 to 4.7 breaks pptp pass through
Repo: 2016-08-12 https://bugzilla.kernel.org/show_bug.cgi?id=152101
Stat: n/a 
Note: 

Desc: e1000e Failed to restore TIMINCA clock rate delta: -22
Repo: 2016-08-12 https://bugzilla.kernel.org/show_bug.cgi?id=152131
Stat: n/a 
Note: 

Desc: iwlmvm warnings on 4.7.0 (7265D firmwares 16 and 21)
Repo: 2016-08-14 https://bugzilla.kernel.org/show_bug.cgi?id=153061
Stat: n/a 
Note: 

== Stalled, waiting for feedback from reporter ==

Desc: 795ae7a0de: pixz.throughput -9.1% regression
Repo: 2016-06-02 http://thread.gmane.org/gmane.linux.kernel/2233056/
Stat: 2016-06-22 https://lkml.org/lkml/2016/6/22/754
Note: stalled; hannes could not reproduce and asked reporter for further feedback weeks ago

Desc: kmemcheck: Caught 64-bit read from uninitialized memory; iptables/nf_register_net_hooks
Repo: 2016-06-19 https://bugzilla.kernel.org/show_bug.cgi?id=120651
Stat: 2016-07-17 https://bugzilla.kernel.org/show_bug.cgi?id=120651#c8
Note: waiting for reporter to check a proposed fix
