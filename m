Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zw71r3MgXzF0gk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2018 04:58:37 +1100 (AEDT)
Subject: Linux 4.16: Reported regressions as of Monday, 2018-03-05 (Was: Linux
 4.16-rc4)
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CA+55aFxXg8hi+T_DNCG_OrAotqSheyREw-Njf9XgUD1vXqAyHQ@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <dac7ba7c-f287-be1f-eaa4-8f2dda69f920@leemhuis.info>
Date: Mon, 5 Mar 2018 18:58:30 +0100
MIME-Version: 1.0
In-Reply-To: <CA+55aFxXg8hi+T_DNCG_OrAotqSheyREw-Njf9XgUD1vXqAyHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05.03.2018 00:15, Linus Torvalds wrote:
> Hmm. A reasonably calm week - the biggest change is to the 'kvm-stat'
> tool, not any actual kernel files.

Hi! Find below my third regression report for Linux 4.16. It lists 7
regressions I'm currently aware of. 3 were fixed since last weeks report.

To anyone reading this: Are you aware of any other regressions that got
introduced this development cycle? Then please let me know by mail (a
simple bounce or forward to the email address is enough!).

For details see http://bit.ly/lnxregtrackid And please tell me if there
is anything in the report that shouldn't be there.

Ciao, Thorsten

== Current regressions ==

Dell R640 does not boot due to SCSI/SATA failure
Status: Reporter looked into this and indicated the change might have
triggered a firmware bug on his machine
Reported: 2018-02-22 Last known developer activity:
https://marc.info/?l=linux-kernel&m=152026091325037
https://marc.info/?l=linux-kernel&m=151931128006031
Cause: 84676c1f21e8
Linux-Regression-ID: 15a115

[mm, mlock, vmscan]  9c4e6b1a70:  stress-ng.hdd.ops_per_sec -7.9% regression
Status: WIP; side note: lkp-robot warned about something else triggered
by the same commit:
https://lkml.kernel.org/r/20180302093940.GE25699@yexl-desktop is related
Note: performance regression found by lkp-robot
Reported: 2018-02-25
https://marc.info/?l=linux-kernel&m=151956997301994
Cause: 9c4e6b1a7027f102990c0395296015a812525f4d

aim7.jobs-per-min -18.0% regression
Status: some discussion last week, but no real solution yet
Note: performance regression found by lkp-robot
Reported: 2018-02-25
https://marc.info/?l=linux-kernel&m=151957120702272&w=2
Cause: c0cef30e4ff0dc025f4a1660b8f0ba43ed58426e

Interrupt storm after suspend causes one busy kworker
Status: stalled?
Reported: 2018-02-25
https://bugzilla.kernel.org/show_bug.cgi?id=198929
Linux-Regression-ID: 41c451

hci_bcm: Streamline runtime PM code change for 4.16 kernel breaks
bluetooth on ASUS T100TA
Status: poked reporters for a update if they reported it to the relevant
developers
Reported: 2018-03-01
https://bugzilla.kernel.org/show_bug.cgi?id=198953
Cause: 43fff768346810042836df325d736bd2c2a634a7


== Regressions with fixes heading mainline ==

selftests: memory-hotplug: fix emit_tests regression
https://marc.info/?l=linux-kernel&m=151993543423651


== Going to get removed from the report ==

Debian kernel package tool make-kpkg stalls indefinitely during kernel
build due to commit "kconfig: remove check_stdin()"
Status: stalled after some discussions; seems nobody really cares that much
Note: From the discussion: "Shouldn't be a problem to back this one out
either if it turns out to cause massive amounts of pain in practice I
guess, even if it's the Debian tools doing something weird."
Reported: 2018-02-12
https://marc.info/?l=linux-kernel&m=151846414807219
Cause: d2a04648a5dbc3d1d043b35257364f0197d4d868
Linux-Regression-ID: 2fd778


== Fixed since last report ==

Dell XPS 13 9360 keyboard no longer works
Status: https://git.kernel.org/torvalds/c/de9647efeaa9
Reported: 2018-02-22
https://marc.info/?l=linux-kernel&m=151927645427980
Cause: 30323fb6d552c41997baca5292bf7001366cab57

on Nokia N900:/dev/input/event6 aka AV Jack support disappeared
Status: https://git.kernel.org/torvalds/c/6662ae6af82d
https://git.kernel.org/torvalds/c/ce27fb2c56db
Reported: 2018-02-24
https://marc.info/?l=linux-omap&m=151950886524308&w=2
Cause: 14e3e295b2b9
Linux-Regression-ID: 4b650f

SD card reader stopped working
Status: Fixed in 4.16.0-rc3 according to reporter
Reported: 2018-02-24
https://bugzilla.kernel.org/show_bug.cgi?id=198917
Linux-Regression-ID: 9adeaf
