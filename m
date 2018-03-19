Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 404ZNf33jQzF1bT
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Mar 2018 22:59:11 +1100 (AEDT)
Subject: Linux 4.16: Reported regressions as of , 2018-03-19 (Was: Re: Linux
 4.16-rc6)
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <CA+55aFzV1nffUeriZLksK90noD49T+w+WmgBsYMAO13rTbn3Pg@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <ebb2770b-af24-5df4-6844-9aa7ffcccdb1@leemhuis.info>
Date: Mon, 19 Mar 2018 12:59:05 +0100
MIME-Version: 1.0
In-Reply-To: <CA+55aFzV1nffUeriZLksK90noD49T+w+WmgBsYMAO13rTbn3Pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19.03.2018 02:14, Linus Torvalds wrote:
> This has been a nice quiet week, so rc6 is pretty tiny. Everything
> looks like we're on a usual schedule - I'll make an rc7, but hopefully
> that will be it.

Hi! Find below my fifth regression report for Linux 4.16. It lists 7
regressions I'm currently aware of. 2 were fixed since last weeks
report; 1 is new; 2 are going to be removed (see below for details).

Are you aware of any other regressions that got introduced this
development cycle? Then please let me know by mail (a simple bounce or
forward to the sender of this email address is enough!). And please tell
me if there is anything in the report that shouldn't be there.

Ciao, Thorsten

== Current regressions ==

Dell R640 does not boot due to SCSI/SATA failure
- Status: WIP; some other changes developed for 4.17 solve this
regression, but there is a discussion for a proper fix
- Cause:  https://git.kernel.org/torvalds/c/84676c1f21e8
- Reported: 2018-02-22
https://marc.info/?l=linux-kernel&m=151931128006031
- Last known developer activity: 2018-03-14
https://marc.info/?l=linux-block&m=152102086831636&w=2
- Other relevant links:
https://marc.info/?l=linux-block&m=152051511802229&w=2
https://marc.info/?l=linux-kernel&m=152026091325037

hci_bcm: Streamline runtime PM code change for 4.16 kernel breaks
bluetooth on ASUS T100TA
- Status: Hans is working on it, lot's of activity in bugzilla
- Cause:  https://git.kernel.org/torvalds/c/43fff7683468
- Reported: 2018-03-01
https://bugzilla.kernel.org/show_bug.cgi?id=198953

Error updating SMART data during runtime and could not connect to lv
["Possible Regression"]
- Status: Two issues discussed here; not much progress yet on the
regression (latency issues in the MU03 version of the firmware,
triggered by polling SMART data, which causes lvmetad to timeout in some
cases)
- Reported: 2018-03-11
https://marc.info/?l=linux-kernel&m=152075643627082
https://bugzilla.kernel.org/show_bug.cgi?id=199077
- Last known developer activity: 2018-03-19
https://marc.info/?l=linux-kernel&m=152145306610330
- Other relevant links:
https://www.mail-archive.com/linux-block@vger.kernel.org/msg18338.html
https://marc.info/?l=linux-scsi&m=152095303312164&w=2

15% longer running times on lvm2 test suite
- Status: Seems the real problem is in the way the test scripts interact
with the kernel
- Cause:  https://git.kernel.org/torvalds/c/44c02a2c3dc5
- Reported: 2018-03-11
https://marc.info/?l=linux-kernel&m=152077333230274
- Last known developer activity: 2018-03-13
https://marc.info/?l=linux-kernel&m=152097761921525

sdhci-acpi not recognizing eMMC
- Status: Told reporter to contact developers an ML by mail
- Cause:  https://git.kernel.org/torvalds/c/1b7ba57ecc86
- Reported: 2018-03-13
https://bugzilla.kernel.org/show_bug.cgi?id=199105


== Waiting for clarification from reporter ==

Interrupt storm after suspend causes one busy kworker
- Status: Still waiting for data from reporter
- Reported: 2018-02-25
https://bugzilla.kernel.org/show_bug.cgi?id=198929

AMDGPU Fury X random screen flicker on Linux kernel 4.16rc5
- Status: New, but data missing; unclear if this really is a regression
in 4.16, but looks a lot like one
- Reported: 2018-03-13
https://bugzilla.kernel.org/show_bug.cgi?id=199101


== Going to get removed from the report ==

aim7.jobs-per-min -18.0% regression
- Status: not an issue; looks like something weird happen when compiling
the kernel which lead to bogus results
- Cause:  https://git.kernel.org/torvalds/c/c0cef30e4ff0
- Reported: 2018-02-25
https://marc.info/?l=linux-kernel&m=151957120702272&w=2
- Last known developer activity:
https://marc.info/?l=linux-kernel&m=152113601602820

[mm, mlock, vmscan]  9c4e6b1a70:  stress-ng.hdd.ops_per_sec -7.9% regression
- Status: looks stalled, seems nobody cares; side note: lkp-robot warned
about something else triggered by the same commit:
https://lkml.kernel.org/r/20180302093940.GE25699@yexl-desktop is related
- Cause:  https://git.kernel.org/torvalds/c/9c4e6b1a7027
- Reported: 2018-02-25
https://marc.info/?l=linux-kernel&m=151956997301994
- Note: performance regression found by lkp-robot


== Fixed since last report ==

Regression from efi: call get_event_log before ExitBootServices
- Status: Fixed by https://git.kernel.org/torvalds/c/79832f0b5f71
- Cause:  https://git.kernel.org/torvalds/c/33b6d03469b2
- Reported: 2018-03-06
https://marc.info/?l=linux-kernel&m=152035206220237&w=2

[amdgpu CARRIZO] disabled backlight after S3 resume
- Status: Fixed by https://git.kernel.org/torvalds/c/b5e324131697
- Cause:  https://git.kernel.org/torvalds/c/4ec6ecf48c64
- Reported: 2018-03-07
https://bugzilla.kernel.org/show_bug.cgi?id=199047
