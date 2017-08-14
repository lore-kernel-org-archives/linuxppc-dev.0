Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xWHNy5bplzDqlG
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Aug 2017 00:02:25 +1000 (AEST)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.13: Reported regressions as of Monday, 2017-08-14
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <31dab2b1-575e-ef62-7abe-6db3b1e2427b@leemhuis.info>
Date: Mon, 14 Aug 2017 16:02:19 +0200
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

Hi! Find below my third regression report for Linux 4.13. It lists 11
regressions I'm currently aware of (or 10 if you count the two scsi-mq
regressions discussions as one). 4 regressions are new; 3 got fixed
since last weeks report (two others didn't even make it to the report,
as they were quickly fixed); 1 gets removed. You can also find the
report at http://bit.ly/lnxregrep413 where I try to update it every now
and then.

As always: Are you aware of any other regressions? Then please let me
know. For details see http://bit.ly/lnxregtrackid And please tell me if
there is anything in the report that shouldn't be there.

Ciao, Thorsten

P.S.: Thx to all those that CCed me on regression reports or provided
other input, it makes compiling these reports a whole lot easier!

P.P.S.: Sorry, I adjusted the report structure again because I added a
new field that shows the date when a proper kernel developer (normally:
one that is working in the affected subsystem) looked into issue. That
should hopefully make it easier to spot regressions that are getting
ignored or got stuck somehow.


== Current regressions ==

[x86/mm/gup] e585513b76: will-it-scale.per_thread_ops -6.9% regression
Status: Asked on the list, but looks like issue gets ignored by everyone
Note: I'm a bit unsure if adding this issue to this list was a good
idea. Side note: Was report against linux-next in May already
Reported: 2017-07-10 Developer activity: none
http://lkml.kernel.org/r/20170710024020.GA26389@yexl-desktop
Cause: https://git.kernel.org/torvalds/c/e585513b76

Null dereference in rt5677_i2c_probe()
Status: Patch is available in in asoc-next as commit ddc9e69b9dc2
Reported: 2017-07-17 Developer activity: 2017-07-27
https://bugzilla.kernel.org/show_bug.cgi?id=196397
https://bugzilla.kernel.org/show_bug.cgi?id=196397#c6
Cause: https://git.kernel.org/torvalds/c/a36afb0ab6
Linux-Regression-ID: lr#96bd63

[Dell xps13 9630] Could not be woken up from suspend-to-idle via usb
keyboard
Status: it's a tracking bug for an issue that seems to get handled by
Intel devs already
Note: suspend-to-idle is rare
Reported: 2017-07-24 Developer activity: 2017-07-24
https://bugzilla.kernel.org/show_bug.cgi?id=196459
Cause: https://git.kernel.org/torvalds/c/33e4f80ee6
Linux-Regression-ID: lr#bd29ab

[lkp-robot] [Btrfs] 28785f70ef: xfstests.generic.273.fail
Status: Jeff: "We're not ignoring it. […] collection of bugs that
approximate a correct result, and we're addressing them individually.[…]"
Reported: 2017-07-26 Developer activity: 2017-08-10
https://lkml.kernel.org/r/20170726062352.GC4877@yexl-desktop
https://lkml.kernel.org/r/bcd49705-e63a-4439-1620-57cd16f5bc09@suse.com
Cause: https://git.kernel.org/torvalds/c/28785f70ef
Linux-Regression-ID: lr#a7d273

SCSI-MQ performance regression due to blk-mq scheduler
Status: Revert planned
https://lkml.kernel.org/r/20170813174422.16197-1-hch@lst.de
Note: see also "Switching to MQ by default may generate some bug reports"
Reported: 2017-07-31 Developer activity: 2017-08-13
https://lkml.kernel.org/r/20170731165111.11536-2-ming.lei@redhat.com
https://lkml.kernel.org/r/20170813174422.16197-1-hch@lst.de
Cause: https://git.kernel.org/torvalds/c/5c279bd9e4

Switching to MQ by default may generate some bug reports
Status: Revert planned
https://lkml.kernel.org/r/20170813174422.16197-1-hch@lst.de
Note: see also "SCSI-MQ performance regression due to blk-mq scheduler"
Reported: 2017-08-03 Developer activity: 2017-08-13
https://lkml.kernel.org/r/20170803085115.r2jfz2lofy5spfdb@techsingularity.net
https://lkml.kernel.org/r/20170813174422.16197-1-hch@lst.de
Cause: https://git.kernel.org/torvalds/c/5c279bd9e4

CIFS mount error -112 due to "SMB3 by default for security reasons"
Status: Reminded people they need to get the issue to the mailing list
Note: Due to the changes in  908b852df1d5d27d289e915fea7bfc16d38b8a76
That's a security change, but one that IMHO at least could have been
handled a lot better by giving users a hint what's wrong
Reported: 2017-08-06 Developer activity: none
https://bugzilla.kernel.org/show_bug.cgi?id=196599
https://bugzilla.kernel.org/show_bug.cgi?id=196599#c6
Cause: https://git.kernel.org/torvalds/c/eef914a9eb
Linux-Regression-ID: lr#60efe5

clang build regression in ext4
Status: report contains patch to fix issue
Reported: 2017-08-07 Developer activity: 2017-08-12
https://lkml.kernel.org/r/20170807105701.3835991-1-arnd@arndb.de
Cause: https://git.kernel.org/torvalds/c/2df2c3402f

ACPI/IORT: fix build regression without IOMMU
Status: report contains patch to fix issue
Reported: 2017-08-10 Developer activity: 2017-08-10
https://lkml.kernel.org/r/20170810121114.2509560-1-arnd@arndb.de
Cause: https://git.kernel.org/torvalds/c/bc8648d49a

Build regression: cc1: error: '-march=r3000' requires '-mfp32'
Status: brand new
Reported: 2017-08-13 Developer activity: none
https://lkml.kernel.org/r/59901cdb.B0NdvWhnqacJCnUm%fengguang.wu@intel.com
Cause: https://git.kernel.org/torvalds/c/89a55278de

Lockdep: possible recursive locking detected
Status: tglx posted a patch to fix issue
Reported: 2017-08-14 Developer activity: 2017-08-14
https://lkml.kernel.org/r/0e25aebb-b501-b92b-3931-1646b009e8ef@lwfinger.net
https://lkml.kernel.org/r/alpine.DEB.2.20.1708140920250.1865@nanos
Cause: https://git.kernel.org/torvalds/c/fc8dffd379


== Waiting for clarification from reporter ==

SGI UV300/UV300: kernel BUG at arch/x86/mm/init_64.c:350! during boot
Status: not 100% sure if this is a regression
Note: related to https://bugzilla.kernel.org/show_bug.cgi?id=196565 ?
Reported: 2017-08-02 Developer activity: none
https://bugzilla.kernel.org/show_bug.cgi?id=196561


== Removed ==

[I945GM] Pasted text not shown after mouse middle-click
Status: Turns out it's an older problem that even shows up with 3.16
Reported: 2017-07-17 Developer activity: none
https://bugs.freedesktop.org/show_bug.cgi?id=101819
Linux-Regression-ID: lr#d672f3


== Fixed since last weeks report ==

NULL pointer deref in networking
Status: Fixed in rc4 (presumably thx to aae4e7a8bc)
https://bugzilla.kernel.org/show_bug.cgi?id=196529
Linux-Regression-ID: lr#084be9

Xen HVM guest with KASLR enabled wouldn't boot any longer
Status: part of
https://git.kernel.org/torvalds/c/043cd07c555f74ab51c9589d1f5baff4b29929ae
https://lkml.kernel.org/r/20170728102314.29100-1-jgross@suse.com

bio-integrity: Fix regression if profile verify_fn is NULL
Status: Fixed as part of
https://git.kernel.org/torvalds/c/e0d0e045b862da06f2a694696797b2c46ae8bc4f
https://lkml.kernel.org/r/20170802122750.12216-1-gmazyland@gmail.com
Linux-Regression-ID: lr#35498d
