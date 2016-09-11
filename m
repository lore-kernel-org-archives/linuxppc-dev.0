Return-Path: <fedora@leemhuis.info>
Received: from basicbox7.server-home.net (basicbox7.server-home.net
 [195.137.212.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sXCQp5ngtzDsGT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Sep 2016 00:06:10 +1000 (AEST)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.8: Reported regressions as of Sunday, 2016-09-11
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <b196cb0d-3945-2d46-601c-8e7b24978b17@leemhuis.info>
Date: Sun, 11 Sep 2016 15:57:31 +0200
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

Hi! Here is my third regression report for Linux 4.8. It lists 10
regressions I'm aware of. 6 of them are new; 3 mentioned in the last
report sent two weeks ago got fixed; 3 got removed for other reasons
(see below).

As always: Are you aware of any other regressions? Then please let me
know (simply CC regressions@leemhuis.info). And tell me if there is
anything in the report that shouldn't be there.

Ciao, Thorsten

P.S.: Sorry for not sending a report last week, I did not find the time
as I was travelling :-/


== Current regressions ==

Desc: genirq: Flags mismatch irq 8, 00000088 (mmc0) vs. 00000080 (rtc0). mmc0: Failed to request irq 8: -16
Repo: 2016-08-01 https://bugzilla.kernel.org/show_bug.cgi?id=150881
Stat: 2016-09-09 https://bugzilla.kernel.org/show_bug.cgi?id=150881#c34
Note: root cause somewhere in the main gpio merge for 4.8, but problematic commit still unknown

Desc: [lkp] [xfs] 68a9f5e700: aim7.jobs-per-min -13.6% regression
Repo: 2016-08-09 http://www.spinics.net/lists/kernel/msg2317052.html
Stat: 2016-09-09 https://marc.info/?t=147341519500003&r=1&w=2
Note: Mel working on it in his spare time, but "The progression of this series has been unsatisfactory."

Desc: DT/OCTEON driver probing broken
Repo: 2016-08-16 http://www.spinics.net/lists/devicetree/msg138990.html
Stat: 2016-08-30 http://www.spinics.net/lists/devicetree/msg140682.html
Note: stalled, poked Rob

Desc: gpio-leds broken on OCTEON
Repo: 2016-08-23 http://www.spinics.net/lists/devicetree/msg139863.html
Stat: 2016-08-25 http://www.spinics.net/lists/devicetree/msg140179.html
Note: stalled, poked list

Desc: Skylake graphics regression: projector failure with 4.8-rc3
Repo: 2016-08-26 http://www.spinics.net/lists/intel-gfx/msg105478.html
Stat: 2016-09-01 https://lkml.org/lkml/2016/8/31/946
Note: looks a bit stalled, but guess jejb still has not forgotten about it

Desc: lk 4.8 + !CONFIG_SHMEM + shmat() = oops
Repo: 2016-08-30 http://www.spinics.net/lists/linux-mm/msg112920.html
Stat: 2016-09-07 http://www.spinics.net/lists/linux-mm/msg113177.html
Note: patch "ipc/shm: fix crash if CONFIG_SHMEM is not set" is going to fix this

Desc: ath9k: bring back direction setting in ath9k_{start_stop}
Repo: 2016-09-01 https://marc.info/?l=linux-wireless&m=147292415030585&w=2
Stat: 2016-09-07 https://marc.info/?l=linux-wireless&m=147325468810927&w=2
Note: fix heading upstream

Desc: regression in re-read operation by iozone ~10%
Repo: 2016-09-02 https://bugzilla.kernel.org/show_bug.cgi?id=155821
Stat: n/a 
Note: told reporter he might be better of posting about the issue to some mailing list

Desc: Suspend fails & system is unusable after attempt (Dell XPS 13 9350 / Skylake)
Repo: 2016-09-08 https://bugzilla.kernel.org/show_bug.cgi?id=156361
Stat: n/a 
Note: quite new

Desc: CPU speed set very low
Repo: 2016-09-09 https://lkml.org/lkml/2016/9/9/608
Stat: n/a 
Note: quite new

== Going to be removed from the list ==

Desc: [lkp] [mm, page_alloc] e6cbd7f2ef: pixz.throughput -5.1% regression due to mm, page_alloc: remove fair zone allocation policy
Repo: 2016-08-08 https://marc.info/?l=linux-kernel&m=147064515210332&w=3
Stat: 2016-08-30 https://lkml.org/lkml/2016/8/30/176
Note: Quoting Mel: Drop it for the moment. My expectation is that it's a relatively minor hazard. […]

Desc: Intermittent crash on reboot (acpi_ex_system_reset_event)
Repo: 2016-08-04 https://bugzilla.kernel.org/show_bug.cgi?id=151441
Stat: 2016-08-15 https://bugzilla.kernel.org/show_bug.cgi?id=151441#c7
Note: reporter stopped seeing this crash

Desc: Commit cb4f71c429 deliberately changes order of network interfaces
Repo: 2016-08-21 http://www.spinics.net/lists/kernel/msg2325600.html
Stat: n/a 
Note: long discussion if this is considered a regression at all; mentioned it in the last report to make sure people are aware of the issue; nothing happened since then, so I assume people do not consider it a regression


== Fixed since last report ==

Desc: irqdomain: Don't set type when mapping an IRQ breaks nexus7 gpio buttons
Repo: 2016-07-30 https://marc.info/?l=linux-kernel&m=146985356305280&w=2
Fix:  https://git.kernel.org/torvalds/c/1e12c4a9393b75a744aada2c8115434572698bc3

Desc: imx-drm: Possible regression after update to atomic: black screen after Weston starts
Repo: 2016-08-13 http://www.spinics.net/lists/kernel/msg2320013.html
Fix:  https://git.kernel.org/torvalds/c/c6c1f9bc798bee7cfc2e172cd2c9b48187d801a7

Desc: Bluetooth: Fix bt_sock_recvmsg when MSG_TRUNC is not set
Repo: 2016-08-25 http://www.spinics.net/lists/linux-bluetooth/msg68012.html
Fix:  https://git.kernel.org/torvalds/c/90a56f72edb088c678083c32d05936c7c8d9a948
