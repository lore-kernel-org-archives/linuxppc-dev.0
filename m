Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y92vx2HDNzDqG2
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  8 Oct 2017 23:37:47 +1100 (AEDT)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.14: Reported regressions as of Sunday, 2017-10-08
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <270748cf-5a97-f446-d572-9df05f8141fc@leemhuis.info>
Date: Sun, 8 Oct 2017 14:37:41 +0200
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

Hi! Find below my second regression report for Linux 4.14. It lists 8
regressions I'm currently aware of. One regression was fixed since last
weeks report. One was in there that shouldn't have been there.

As always: Are you aware of any other regressions? Then please let me
know by mail (a simple bounce in my direction is enough!). For details
see http://bit.ly/lnxregtrackid And please tell me if there is anything
in the report that shouldn't be there.

Ciao, Thorsten

P.S.: Thx to Adam and Igor for pointing me at two regressions they face.
And thx to Yanko for pointing out a stupidity I did in last weeks report.

== Current regressions ==

"hangs when building e.g. perf" & "Random insta-reboots on AMD Phenom II"
Status: "Mr. Luto better revert the new lazy TLB flushing fun'n'games"
-> "Yeah, working on it.  It's not a straightforward revert."
Note: TWIMC: Workaround: wrmsr -a 0xc0010015 0x1000018
Reported: 2017-09-05
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1484723.html
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1501379.html
https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1501570.html
Cause: 94b1b03b519b81c494900cb112aa00ed205cc2d9

New default s2idle does not work on Dell XPS 13 9360
Status: works fine on several other owners of this laptop; maybe
specific to the variant or the particular machine the reporter owns;
looks related to the storage device used
Reported: 2017-09-11
https://bugzilla.kernel.org/show_bug.cgi?id=196907
Cause: e870c6c87cf9484090d28f2a68aa29e008960c93 (assumed)

CIFS SMB2+ combined with pythons xattr.listxattr leads to "IOError:
[Errno 61
Status: no reaction from developers yet; reporter needs to reverify and
poke list
Note: Disclaimer: A regression the regression tracker reported
Reported: 2017-09-26
https://marc.info/?l=linux-cifs&m=150644485708526
Cause: 8dc5b3a6cb2f (assumed)

Ath10k disconnects
Status: WIP, recently got bisected
Note: Only happens with some wifi routers; Disclaimer: A regression the
regression tracker reported
Reported: 2017-10-01
http://lists.infradead.org/pipermail/ath10k/2017-October/010189.html
Cause: c9353bf483d3724c116a9d502c0ead9cec54a61a

Oops in nouveau_fbcon_set_suspend_work during boot or resume on some
machines
Status: No reaction from developers;  ask reporter for bisection
Note: Something specific to  ThinkPad W530 and W531?
Reported: 2017-10-02
https://bugzilla.kernel.org/show_bug.cgi?id=197103
https://bugs.freedesktop.org/show_bug.cgi?id=102381

networking doesn't work in opensuse 42.2 due to apparmor: add base
infastructure for socket mediation
Status: there was a debate if this is a regression or not that faded out
Reported: 2017-10-03
https://lkml.kernel.org/r/1507003338.3174.4.camel@HansenPartnership.com
Cause: 651e28c5537abb39076d3949fb7618536f1d242e

nftables oops with 4.14.0-rc3 on arm64 (Rock64 board)
Status: Tested fix: http://patchwork.ozlabs.org/patch/821334/
Reported: 2017-10-04
https://bugzilla.kernel.org/show_bug.cgi?id=197123
Cause: 9f08ea848117

WiFi stopped working with 4.14
Status: told reporters they better should bringt this to netdev
Note: maybe these are two different issues; one with rtl8723bs an one
where with 8265 that is related to switching BT on and off
Reported: 2017-10-05
https://bugzilla.kernel.org/show_bug.cgi?id=197137


== Fixed since last report ==

stalls, short lived or long lived lockups very shortly after boot.
Status: got reverted weeks ago and I missed it when compiling last weeks
report (sorry!)
Reported: 2017-09-19
https://marc.info/?l=linux-kernel&m=150583434416295
Cause: 74def747bcd0

Module removal-related regression
Status: Fixed: 6878e7de6af726de47f9f3bec649c3f49e786586
Reported: 2017-09-09
https://marc.info/?l=linux-kernel&m=150497889508778
Cause: 1455cf8dbfd06aa7651dcfccbadb7a093944ca65
