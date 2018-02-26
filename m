Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zqdHx0xBGzF1K3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2018 21:25:14 +1100 (AEDT)
Subject: Linux 4.16: Reported regressions as of Monday, 2018-02-26 (Was: Linux
 4.16-rc3)
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <CA+55aFxk5KBxL9DvRtBivP3hKT-aOAzvSA_B47L1+y0P2GLe_A@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <2cf45d87-066c-7368-3fbd-20675f2d74ae@leemhuis.info>
Date: Mon, 26 Feb 2018 11:25:09 +0100
MIME-Version: 1.0
In-Reply-To: <CA+55aFxk5KBxL9DvRtBivP3hKT-aOAzvSA_B47L1+y0P2GLe_A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26.02.2018 04:05, Linus Torvalds wrote:
> We're on the normal schedule for 4.16 and everything still looks very regular.

Hi! Find below my second regression report for Linux 4.16. It lists 8
regressions I'm currently aware of.

To anyone reading this: Are you aware of any other regressions that got
introduced this development cycle? Then please let me know by mail (a
simple bounce or forward to the email address is enough!).

For details see http://bit.ly/lnxregtrackid And please tell me if there
is anything in the report that shouldn't be there.

Ciao, Thorsten

== Current regressions ==

Debian kernel package tool make-kpkg stalls indefinitely during kernel
build due to commit "kconfig: remove check_stdin()"
Status: stalled after some discussions; seems nobody really cares deeply?
Note: From the discussion: "Shouldn't be a problem to back this one out
either if it turns out to cause massive amounts of pain in practice I
guess, even if it's the Debian tools doing something weird."
Reported: 2018-02-12
https://marc.info/?l=linux-kernel&m=151846414807219
Cause: d2a04648a5dbc3d1d043b35257364f0197d4d868
Linux-Regression-ID: 2fd778

Dell R640 does not boot due to SCSI/SATA failure
Reported: 2018-02-22
https://marc.info/?l=linux-kernel&m=151931128006031
Cause: 84676c1f21e8
Linux-Regression-ID: 15a115

On Nokia N900:/dev/input/event6 aka AV Jack support disappeared
Status: quite new
Reported: 2018-02-24
https://marc.info/?l=linux-omap&m=151950886524308&w=2
Cause: 14e3e295b2b9
Linux-Regression-ID: 4b650f

SD card reader stopped working
Status: quite new
Reported: 2018-02-24
https://bugzilla.kernel.org/show_bug.cgi?id=198917
Linux-Regression-ID: 9adeaf

[mm, mlock, vmscan]  9c4e6b1a70:  stress-ng.hdd.ops_per_sec -7.9% regression
Status: WIP
Note: performance regression found by lkp-robot
Reported: 2018-02-25
https://marc.info/?l=linux-kernel&m=151956997301994
Cause: 9c4e6b1a7027f102990c0395296015a812525f4d

aim7.jobs-per-min -18.0% regression
Status: WIP; bisection result is doubted, but was verified
Note: performance regression found by lkp-robot
Reported: 2018-02-25
https://marc.info/?l=linux-kernel&m=151957120702272&w=2
Cause: c0cef30e4ff0dc025f4a1660b8f0ba43ed58426e

Interrupt storm after suspend causes one busy kworker
Status: quite new
Reported: 2018-02-25
https://bugzilla.kernel.org/show_bug.cgi?id=198929
Linux-Regression-ID: 41c451


== Fix heading mainline ==

Dell XPS 13 9360 keyboard no longer works
Status: Fix in the platform tree from what I've heard
Reported: 2018-02-22
https://marc.info/?l=linux-kernel&m=151927645427980
Cause: 30323fb6d552c41997baca5292bf7001366cab57


== Fixed since last report ==

DM Regression: read() returns data when it shouldn't
Status: Was fixed already when last report was compiled
Reported: 2018-02-14
https://marc.info/?l=linux-kernel&m=151861337518109&w=2
Cause: 18a25da84354c6bb655320de6072c00eda6eb602
Linux-Regression-ID: 9e195f


== Fixed before it was properly added to the report ==

kconfig.h: Include compiler types to avoid missed struct attributes
https://git.kernel.org/torvalds/c/28128c61e08e

i2c-designware: sound and s2ram broken on Broadwell-U system since
commit ca382f5b38f367b6 (add i2c gpio recovery option)
https://git.kernel.org/torvalds/c/d1fa74520dcd
