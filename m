Return-Path: <fedora@leemhuis.info>
Received: from basicbox7.server-home.net (basicbox7.server-home.net
 [195.137.212.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sMdpf5N1rzDrfT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Aug 2016 01:23:37 +1000 (AEST)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.8: Reported regressions as of Sunday, 2016-08-28
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <3b3d733e-f193-b039-6113-6c0e5b44c4e7@leemhuis.info>
Date: Sun, 28 Aug 2016 17:23:30 +0200
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

Hi! Here is my second regression report for Linux 4.8. It lists 11
regressions. 5 of them are new; 5 mentioned in the last report two 
weeks ago got fixed.

FWIW: A small detail: I did not include "Regression - SATA disks behind 
USB ones on v4.8-rc1, breaking boot. [Re: Who reordered my disks]" 
(http://www.spinics.net/lists/linux-usb/msg144871.html ) in below list 
report. The discussion mentions that device names like /dev/sd? are not 
considered stable as they might change depending on various factors -- 
like the order in which modules are loaded or other timing issues (like 
in this case). That is how it is afaik (even if it's not well known), 
and that's why I didn't include the issue; let me know if you think it 
should be on the list.

OTOH I included "Commit cb4f71c429 deliberately changes order of 
network interfaces" (http://www.spinics.net/lists/kernel/msg2325600.html )
for now, as I think traditional network interface names (eth0, eth1, ...)
might be considered stable -- but I'm not sure, that's why I raise it
here.

Anyway, you know the drill: Are you aware of any other regressions?
Then please let me know. And tell me if there is anything in the
report that shouldn't be there.

Ciao, Thorsten

P.S.: Thanks to all those that Aaro Koskinen, Hans de Goede, Pavel 
Machek for CCing me when reporting regressions. Much appreciated! Ohh, 
and thx to all those that replied when I asked them for status updates
when things look stuck. 

P.P.S: Sorry, I did not manage to compile a report last weekend. I 
visited a FLOSS conference and there got hit by a flu that slowed be 
down all week :-/ That's why there won't be a regression report for 
4.7. I'll be travelling again next weekend, so there won't be a 
regression report next Sunday :-/

== Current regressions ==

Desc: irqdomain: Don't set type when mapping an IRQ breaks nexus7 gpio buttons
Repo: 2016-07-30 https://marc.info/?l=linux-kernel&m=146985356305280&w=2
Stat: 2016-08-12 https://marc.info/?l=linux-kernel&m=147093069326172&w=2
Note: fix found two weeks ago, not in mainline afaics; waiting for tglx to get back?

Desc: genirq: Flags mismatch irq 8, 00000088 (mmc0) vs. 00000080 (rtc0). mmc0: Failed to request irq 8: -16
Repo: 2016-08-01 https://bugzilla.kernel.org/show_bug.cgi?id=150881
Stat: 2016-08-19 https://bugzilla.kernel.org/show_bug.cgi?id=150881#c34
Note: reporter is bisecting the bug that got introduced by the main gpio merge for 4.8

Desc: Intermittent crash on reboot (acpi_ex_system_reset_event)
Repo: 2016-08-04 https://bugzilla.kernel.org/show_bug.cgi?id=151441
Stat: 2016-08-15 https://bugzilla.kernel.org/show_bug.cgi?id=151441#c7
Note: poked reporter, as nothing had happened after he was asked to test a revert

Desc: [lkp] [mm, page_alloc] e6cbd7f2ef: pixz.throughput -5.1% regression due to mm, page_alloc: remove fair zone allocation policy
Repo: 2016-08-08 https://marc.info/?l=linux-kernel&m=147064515210332&w=3
Stat: n/a 
Note: poked Mel, as nothing happened after the the report

Desc: [lkp] [xfs] 68a9f5e700: aim7.jobs-per-min -13.6% regression
Repo: 2016-08-09 http://www.spinics.net/lists/kernel/msg2317052.html
Stat: 2016-08-20 http://www.spinics.net/lists/kernel/msg2325437.html
Note: hmm, long discussion about potential issues, but no simple solution in sight and discussion ended about a week ago

Desc: imx-drm: Possible regression after update to atomic: black screen after Weston starts
Repo: 2016-08-13 http://www.spinics.net/lists/kernel/msg2320013.html
Stat: n/a 
Note: poked Dave, as nothing happened after the the report

Desc: DT/OCTEON driver probing broken
Repo: 2016-08-16 http://www.spinics.net/lists/devicetree/msg138990.html
Stat: 2016-08-28 
Note: proposed fix: https://patchwork.linux-mips.org/patch/14041/

Desc: gpio-leds broken on OCTEON
Repo: 2016-08-23 http://www.spinics.net/lists/devicetree/msg139863.html
Stat: 2016-08-25 http://www.spinics.net/lists/devicetree/msg140179.html
Note: wip

Desc: Commit cb4f71c429 deliberately changes order of network interfaces
Repo: 2016-08-21 http://www.spinics.net/lists/kernel/msg2325600.html
Stat: n/a 
Note: long, ongoing discussion if this is considered a regression

Desc: Bluetooth: Fix bt_sock_recvmsg when MSG_TRUNC is not set
Repo: 2016-08-25 http://www.spinics.net/lists/linux-bluetooth/msg68012.html
Stat: 2016-08-25 http://www.spinics.net/lists/linux-bluetooth/msg68049.html
Note: patch in bluetooth-stable tree

Desc: Skylake graphics regression: projector failure with 4.8-rc3
Repo: 2016-08-26 http://www.spinics.net/lists/intel-gfx/msg105478.html
Stat: n/a 
Note: brand new, more details expected

== Fixed since last report ==

Desc: Failed to create /dev/root: -14 after commit e6978e4bf1 (ARM: save and reset the address limit when entering an exception)
Repo: 2016-08-02 https://lkml.org/lkml/2016/8/2/2085
Fix:  https://git.kernel.org/torvalds/c/87eed3c74d7c65556f744230a90bf9556dd29146

Desc: wlcore: NULL pointer dereference in wlcore_op_get_expected_throughput
Repo: 2016-08-04 https://marc.info/?l=linux-kernel&m=147031427806879&w=2
Fix:  https://git.kernel.org/torvalds/c/2439ca0402091badb24415e1b073ba12b34ba423

Desc: Crashes in refresh_zone_stat_thresholds when some nodes have no memory
Repo: 2016-08-04 https://marc.info/?t=147029321800001&r=1&w=2
Fix:  https://git.kernel.org/torvalds/c/b4911ea2bcf52345bf3dc73292b8c4676f6192c6

Desc: 362899b (macvtap: switch to use skb array) causes oops during teardown
Repo: 2016-08-10 http://www.spinics.net/lists/netdev/msg389465.html
Fix:  https://git.kernel.org/torvalds/c/104a493390940e85fb7c840a9fd5214aba5cb3bd

Desc: mmc: Secure discard is broken
Repo: 2016-08-11 http://www.spinics.net/lists/linux-mmc/msg38481.html
Fix:  https://git.kernel.org/torvalds/c/7afafc8a44bf0ab841b17d450b02aedb3a138985
