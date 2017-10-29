Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yQ13n0bPYzDqkH
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Oct 2017 01:59:30 +1100 (AEDT)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.14: Reported regressions as of Sunday, 2017-10-29
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <66b360d6-ce43-d71e-aa04-ddd036a66764@leemhuis.info>
Date: Sun, 29 Oct 2017 15:59:24 +0100
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

Hi! Find below my fourth regression report for Linux 4.14. It lists 6
regressions I'm currently aware of; for most of them fixes are in the
work. 4 regressions got fixed since last weeks report; 1 turned out to
not be a regression.

As always: Are you aware of any other regressions? Then please let me
know by mail (a simple bounce or forward in my direction is enough!).
For details see http://bit.ly/lnxregtrackid And please tell me if there
is anything in the report that shouldn't be there.

Ciao, Thorsten

P.S.: Sorry, was travelling to kernel summit, that's why there wasn't a
report last week

== Current regressions ==

New default s2idle does not work on Dell XPS 13 9360 with hynix 512GB
Status: Patch to blacklist the problematic machines up for testing
Note: appears to be related to NVMe (and specifically to the particular
Hynix 512G NVMe SSD in the reporter's machine); this seems to be a
regression in 4.13 that is exposed by a change in 4.14; judge yourself
if this should be in the list or not
Reported: 2017-09-11
https://bugzilla.kernel.org/show_bug.cgi?id=196907
Cause: e870c6c87cf9484090d28f2a68aa29e008960c93 (indirectly)

CIFS SMB2+ combined with pythons xattr.listxattr leads to "IOError:
[Errno 61]
Status: reporter was asked to provide additional details, but didn't
provide them yet (sorry, been busy)
Note: Disclaimer: A regression the regression tracker reported
Reported: 2017-09-26
https://marc.info/?l=linux-cifs&m=150644485708526
Cause: 8dc5b3a6cb2f (assumed)

Ath10k disconnects
Status: revert planned:
http://lists.infradead.org/pipermail/ath10k/2017-October/010368.html
Note: Only happens with some wifi routers; Disclaimer: A regression the
regression tracker reported
Reported: 2017-10-01
http://lists.infradead.org/pipermail/ath10k/2017-October/010189.html
Cause: c9353bf483d3724c116a9d502c0ead9cec54a61a

Oops in nouveau_fbcon_set_suspend_work during boot or resume on some
machines
Status: asked if https://git.kernel.org/torvalds/c/481376632537 fixes
this; if not then bisect needed
Reported: 2017-10-02
https://bugzilla.kernel.org/show_bug.cgi?id=197103
https://bugs.freedesktop.org/show_bug.cgi?id=102381

blk_partition_remap: fail for partition 3 on ARM board Odroid U3, with
root fs on eMMC
Status: told reporter to bring this to the list and CC the developers in
the suspected commit
Reported: 2017-10-17
https://bugzilla.kernel.org/show_bug.cgi?id=197303
Cause: 74d46992e0d9dee7f1f376de0d56d31614c8a17a (likey)

tun devices not working anymore in openvpn
Status: Fix in dave's tree already: 5c25f65fd1e42685f7ccd80e0621829c105785d9
Reported: 2017-10-28
https://lkml.kernel.org/r/ac1aaeab-b9f5-a034-56a8-4305494db468@eikelenboom.it
Cause: 0ad646c81b2182f7fa67ec0c8c825e0ee165696d


== Going to get removed ==

Hikey620: it's easy to trigger a panic with "rcu_preempt detected stalls
on CPUs/tasks"
Status: "[…] this issue is quite likely related with CA53 errata,
especialy ERRATA_A53_855873 is the relative one. So I changed to use
ARM-TF mainline code with ERRATA fixing, this issue can be dismissed. […]
https://lkml.kernel.org/r/20171010142725.GA24797@leoy-linaro
Cause: e3067861ba66


== Fixed since last report ==

networking doesn't work in opensuse 42.2 due to apparmor: add base
infastructure for socket mediation
Status: Fixed by a revert: https://git.kernel.org/torvalds/c/80c094a47dd4
Reported: 2017-10-03
https://lkml.kernel.org/r/1507003338.3174.4.camel@HansenPartnership.com
Cause: 651e28c5537abb39076d3949fb7618536f1d242e

WiFi stopped working with 4.14 (two report: a staging driver and iwlwifi)
Status: Fixed by a revert: https://git.kernel.org/torvalds/c/80c094a47dd4
Reported: 2017-10-05
https://bugzilla.kernel.org/show_bug.cgi?id=197137
Cause: 651e28c5537abb39076d3949fb7618536f1d242e

Dramatic lockdep slowdown in 4.14
Status: fixed by a revert: https://git.kernel.org/torvalds/c/b483cf3bc249
Reported: 2017-10-13
https://lkml.kernel.org/r/20171013090333.GA17356@localhost
Cause: 28a903f63ec0

On first generation i486 processors it immediately resets the system
after the "Booting the kernel" message.
Status: Fixed by https://git.kernel.org/torvalds/c/9c48c0965b97
https://lkml.kernel.org/r/CAP8WD_a-6DpEzHrsQ4YrKkKmypkXW1WOBxcHj0OJcRvjmSC29A@mail.gmail.com
Cause: 87e81786b13b267c4355e0d23e33c7e4c08fa63f
