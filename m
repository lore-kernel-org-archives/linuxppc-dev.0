Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFLz90mFRzDrFD
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 15 Oct 2017 23:55:30 +1100 (AEDT)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.14: Reported regressions as of Sunday, 2017-10-15
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <4c4f5dc2-78d1-f7bd-6905-360d1633fc18@leemhuis.info>
Date: Sun, 15 Oct 2017 14:55:24 +0200
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

Hi! Find below my third regression report for Linux 4.14. It lists 9
regressions I'm currently aware of. Two regressions got fixed since last
weeks report.

As always: Are you aware of any other regressions? Then please let me
know by mail (a simple bounce or forward in my direction is enough!).
For details see http://bit.ly/lnxregtrackid And please tell me if there
is anything in the report that shouldn't be there.

Ciao, Thorsten

== Current regressions ==

New default s2idle does not work on Dell XPS 13 9360 with hynix 512GB
Status: works fine on several other owners of this laptop;  appears to
be related to NVMe(and specifically to the particular Hynix 512G NVMe
SSD in that machine)
Note: this seems to be a regression in 4.13 that is exposed by a change
in 4.14; judge yourself if this should be in the list or not
Reported: 2017-09-11
https://bugzilla.kernel.org/show_bug.cgi?id=196907
https://lkml.kernel.org/r/3347223.tL9VK2VkP3@aspire.rjw.lan
Cause: e870c6c87cf9484090d28f2a68aa29e008960c93 (assumed)

CIFS SMB2+ combined with pythons xattr.listxattr leads to "IOError:
[Errno 61
Status: no reaction from developers yet; reporter too lazy, he still
needs to reverify and poke list
Note: Disclaimer: A regression the regression tracker reported
Reported: 2017-09-26
https://marc.info/?l=linux-cifs&m=150644485708526
Cause: 8dc5b3a6cb2f (assumed)

Ath10k disconnects
Status: no progress in the last week; will poke on Monday
Note: Only happens with some wifi routers; Disclaimer: A regression the
regression tracker reported
Reported: 2017-10-01
http://lists.infradead.org/pipermail/ath10k/2017-October/010189.html
Cause: c9353bf483d3724c116a9d502c0ead9cec54a61a

Oops in nouveau_fbcon_set_suspend_work during boot or resume on some
machines
Status: Three people see this now; one is considering a bisection
Reported: 2017-10-02
https://bugzilla.kernel.org/show_bug.cgi?id=197103
https://bugs.freedesktop.org/show_bug.cgi?id=102381

networking doesn't work in opensuse 42.2 due to apparmor: add base
infastructure for socket mediation
Status: stalled: after the reported by James there was a debate if this
is a regression or not that in the end faded out
Note: Maybe this should be removed from the list
Reported: 2017-10-03
https://lkml.kernel.org/r/1507003338.3174.4.camel@HansenPartnership.com
Cause: 651e28c5537abb39076d3949fb7618536f1d242e

WiFi stopped working with 4.14 (two report: a staging driver and iwlwifi)
Status: told reporters a week ago they better should bring this to
netdev; didn't happen afaics
Note: maybe these are two different issues; one with rtl8723bs
(Staging!) and one where with 8265 that is related to switching BT on
and off
Reported: 2017-10-05
https://bugzilla.kernel.org/show_bug.cgi?id=197137

Dramatic lockdep slowdown in 4.14
Status: WIP
Note: "Now since it's lockdep I guess this can't really be considered a
regression if these changes did improve lockdep correctness, but still,
this dramatic slow down essentially forces me to disable PROVE_LOCKING
by default on this system."
Reported: 2017-10-13
https://lkml.kernel.org/r/20171013090333.GA17356@localhost
Cause: 28a903f63ec0

Hikey620: it's easy to trigger a panic with "rcu_preempt detected stalls
on CPUs/tasks"
https://lkml.kernel.org/r/20171010142725.GA24797@leoy-linaro
Status: WIP
Cause: e3067861ba66

On first generation i486 processors it immediately resets the system
after the "Booting the kernel" message.
Status: brand new
https://lkml.kernel.org/r/CAP8WD_a-6DpEzHrsQ4YrKkKmypkXW1WOBxcHj0OJcRvjmSC29A@mail.gmail.com
Cause: 87e81786b13b267c4355e0d23e33c7e4c08fa63f


== Fixed since last report ==

"hangs when building e.g. perf" & "Random insta-reboots on AMD Phenom II"
Status: Fixed by https://git.kernel.org/torvalds/c/67bb8e999e0a
Reported: 2017-09-05
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1484723.html
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1501379.html
https://lkml.kernel.org/r/cover.1508000261.git.luto@kernel.org
Cause: 94b1b03b519b81c494900cb112aa00ed205cc2d9

nftables oops with 4.14.0-rc3 on arm64 (Rock64 board)
Status: Fixed by https://git.kernel.org/torvalds/c/5f9bfe0ef622
Reported: 2017-10-04
https://bugzilla.kernel.org/show_bug.cgi?id=197123
Cause: 9f08ea848117
