Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xgs0m3KWkzDq8X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Aug 2017 22:44:38 +1000 (AEST)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.13: Reported regressions as of Monday, 2017-08-28
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <30a250c5-d0ab-fc1f-a0a3-d3661d3b30ff@leemhuis.info>
Date: Mon, 28 Aug 2017 14:44:31 +0200
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

Hi! Find below my fourth regression report for Linux 4.13. It lists 6
regressions I'm currently aware of. 1 of them is new, 5 got fixed since
the last report (that was two weeks ago; didn't find time for compiling
one last week; sorry). You can also find the report at
http://bit.ly/lnxregrep413 where I try to update it every now and then.
That didn't work to well in the past few weeks; but I'll try to update
it at then end oft the week as the 4.13 release gets closer.

As always: Are you aware of any other regressions? Then please let me
know. For details see http://bit.ly/lnxregtrackid And please tell me if
there is anything in the report that shouldn't be there.

Ciao, Thorsten

P.S.: Thx to all those that CCed me on regression reports or provided
other input, it makes compiling these reports a whole lot easier!

== Current regressions ==

[x86/mm/gup] e585513b76: will-it-scale.per_thread_ops -6.9% regression
Status: Asked on the list, but looks like issue gets ignored by everyone
Note: I'm a bit unsure if adding this issue to this list was a good
idea. Side note: Was reported against linux-next in May already
Reported: 2017-07-10 Developer activity: none known
http://lkml.kernel.org/r/20170710024020.GA26389@yexl-desktop
Cause: https://git.kernel.org/torvalds/c/e585513b76f7

[Dell xps13 9630] Could not be woken up from suspend-to-idle via usb
keyboard
Status: it's a tracking bug for an issue that seems to get handled by
Intel devs already
Note: suspend-to-idle is rare
Reported: 2017-07-24 Developer activity: 2017-07-24
https://bugzilla.kernel.org/show_bug.cgi?id=196459
Cause: https://git.kernel.org/torvalds/c/33e4f80ee69b
Linux-Regression-ID: lr#bd29ab

[lkp-robot] [Btrfs] 28785f70ef: xfstests.generic.273.fail
Status: Jeff: "We're not ignoring it. […] collection of bugs that
approximate a correct result, and we're addressing them individually.[…]"
Reported: 2017-07-26 Developer activity: 2017-08-10
https://lkml.kernel.org/r/20170726062352.GC4877@yexl-desktop
https://lkml.kernel.org/r/bcd49705-e63a-4439-1620-57cd16f5bc09@suse.com
Cause: https://git.kernel.org/torvalds/c/28785f70ef88
Linux-Regression-ID: lr#a7d273

CIFS mount error -112 due to "SMB3 by default for security reasons"
Status: Issue was raised on the mailing list, but ignore
Note: That's a security change, but one that IMHO at least could have
been handled a lot better by giving users a hint what's wrong (and not
"mount: […] Host is down"). I'm considering to submit a revert as RFC to
get a discussion going.
Reported: 2017-08-06 Developer activity: none known
https://bugzilla.kernel.org/show_bug.cgi?id=196599
https://www.spinics.net/lists/linux-cifs/msg12992.html
Cause: https://git.kernel.org/torvalds/c/eef914a9eb5e &
https://git.kernel.org/torvalds/c/908b852df1d5
Linux-Regression-ID: lr#60efe5

Build regression: cc1: error: '-march=r3000' requires '-mfp32'
Note: is there any way to query if this is still happening in 0-day?
Reported: 2017-08-13 Developer activity: none known
https://lkml.kernel.org/r/59901cdb.B0NdvWhnqacJCnUm%fengguang.wu@intel.com
Cause: https://git.kernel.org/torvalds/c/89a55278dee4

regression when ATI chipsets detected
Status: Fix proposed
Reported: 2017-08-23 Developer activity: 2017-08-24
https://lkml.kernel.org/r/1503485760-15146-1-git-send-email-Sandeep.Singh@amd.com
https://lkml.kernel.org/r/1503548835-27057-1-git-send-email-Sandeep.Singh@amd.com
Cause: https://git.kernel.org/torvalds/c/e788787ef4f9


== Going to get removed ==

SGI UV300/UV300: kernel BUG at arch/x86/mm/init_64.c:350! during boot
Status: not 100% sure if this is a regression; reported didn't provide
feedback
Note: related to https://bugzilla.kernel.org/show_bug.cgi?id=196565 ?
Reported: 2017-08-02 Developer activity: none known
https://bugzilla.kernel.org/show_bug.cgi?id=196561

ACPI/IORT: build regression without IOMMU
Note: Adding this was a mistake, as the causing commit was in linux-next
and not yet in mainline. Sorry for the noise.
Reported: 2017-08-10 Developer activity: none known
https://lkml.kernel.org/r/20170810121114.2509560-1-arnd@arndb.de


== Fixed since last report ==

Null dereference in rt5677_i2c_probe()
Status: Fixed in https://git.kernel.org/torvalds/c/9ce76511b67b
Reported: 2017-07-17 Developer activity: none known
https://bugzilla.kernel.org/show_bug.cgi?id=196397
Cause: https://git.kernel.org/torvalds/c/a36afb0ab648
Linux-Regression-ID: lr#96bd63

SCSI-MQ performance regression due to blk-mq scheduler
Status: Fixed in https://git.kernel.org/torvalds/c/cbe7dfa26eee
Reported: 2017-07-31 Developer activity: none known
https://lkml.kernel.org/r/20170731165111.11536-2-ming.lei@redhat.com
https://lkml.kernel.org/r/20170813174422.16197-1-hch@lst.de
Cause: https://git.kernel.org/torvalds/c/5c279bd9e406

Switching to MQ by default may generate some bug reports
Status: Fixed in https://git.kernel.org/torvalds/c/cbe7dfa26eee
Reported: 2017-08-03 Developer activity: none known
https://lkml.kernel.org/r/20170803085115.r2jfz2lofy5spfdb@techsingularity.net
https://lkml.kernel.org/r/20170813174422.16197-1-hch@lst.de
Cause: https://git.kernel.org/torvalds/c/5c279bd9e406

clang build regression in ext4
Status: Fixed by https://git.kernel.org/torvalds/c/b80b32b6d5e7
Reported: 2017-08-07 Developer activity: none known
https://lkml.kernel.org/r/20170807105701.3835991-1-arnd@arndb.de
Cause: https://git.kernel.org/torvalds/c/2df2c3402fc8

Lockdep: possible recursive locking detected
Status: https://git.kernel.org/torvalds/c/84393817db09
Reported: 2017-08-14 Developer activity: none known
https://lkml.kernel.org/r/0e25aebb-b501-b92b-3931-1646b009e8ef@lwfinger.net
https://lkml.kernel.org/r/alpine.DEB.2.20.1708140920250.1865@nanos
Cause: https://git.kernel.org/torvalds/c/fc8dffd379ca
