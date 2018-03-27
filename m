Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409gfF3cgFzF2GB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Mar 2018 06:13:38 +1100 (AEDT)
Subject: Linux 4.16: Reported regressions as of Tuesday, 2018-03-27 (Was:
 Linux 4.16-rc7)
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
References: <CA+55aFxpxHnWBeTXN+DKqwCMW_=T2cR8UxSBVk_6c8LL7Et5JQ@mail.gmail.com>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Message-ID: <d1f5b976-f293-5767-9faf-c4f569f8ba55@leemhuis.info>
Date: Tue, 27 Mar 2018 21:13:32 +0200
MIME-Version: 1.0
In-Reply-To: <CA+55aFxpxHnWBeTXN+DKqwCMW_=T2cR8UxSBVk_6c8LL7Et5JQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 26.03.2018 01:37, Linus Torvalds wrote:
> […] Anyway. Go out and test. And let's hope next week is nice and calm and
> I can release the final 4.16 next Sunday without any extra  rc's.
> 
>                Linus

Hi! Find below my sixth regression report for Linux 4.16. It lists 7
regressions I'm currently aware of. 2 were fixed since last weeks
report; 2 are new.

Are you aware of any other regressions that got introduced this
development cycle? Then please let me know by mail (a simple bounce or
forward to the sender of this email address is enough!). And please tell
me if there is anything in the report that shouldn't be there.

Ciao, Thorsten

== Current regressions ==

Dell R640 does not boot due to SCSI/SATA failure
- Status: Afaics still unfixed; lost track, ask reporter for an update
on Monday morning, no reply yet
- Cause:  https://git.kernel.org/torvalds/c/84676c1f21e8
- Reported: 2018-02-22
https://marc.info/?l=linux-kernel&m=151931128006031
- Note: Issue understood and even (kind of accidentally) fixed by a
patch series that was proposed for 4.17 (see links)
- Last known developer activity: 2018-03-14
https://marc.info/?l=linux-block&m=152102086831636&w=2
- Other relevant links:
https://marc.info/?l=linux-block&m=152051511802229&w=2
https://marc.info/?l=linux-kernel&m=152026091325037

Error updating SMART data during runtime and could not connect to lv
- Status: Stalled afaics
- Reported: 2018-03-11
https://marc.info/?l=linux-kernel&m=152075643627082
https://bugzilla.kernel.org/show_bug.cgi?id=199077
- Note: Two issues discussed in that thread; only one is a regression
(latency issues in the MU03 version of the firmware, triggered by
polling SMART data, which causes lvmetad to timeout in some cases)
- Last known developer activity: 2018-03-19
https://marc.info/?l=linux-kernel&m=152145306610330
- Other relevant links:
https://marc.info/?l=linux-kernel&m=152146297613525
https://marc.info/?l=linux-scsi&m=152095303312164&w=2

15% longer running times on lvm2 test suite
- Status: Stalled afaics
- Cause:  https://git.kernel.org/torvalds/c/44c02a2c3dc5
- Reported: 2018-03-11
https://marc.info/?l=linux-kernel&m=152077333230274
- Note: Seems the real problem is in the way the test scripts interact
with the kernel
- Last known developer activity: 2018-03-13
https://marc.info/?l=linux-kernel&m=152097761921525

AMDGPU Fury X random screen flicker on Linux kernel 4.16rc5
- Status: might be stalled
- Reported: 2018-03-13
https://bugzilla.kernel.org/show_bug.cgi?id=199101

ASUS XG-C100C 10G Network Adapter no longer working
- Status: told reporter to bring it to netdev; looks like he needs help
debugging
- Reported: 2018-03-22
https://bugzilla.kernel.org/show_bug.cgi?id=199177

multi_v7_defconfig fails to boot on many OMAP systems
- Status: quite new, but patch is being prepared
- Cause:  https://git.kernel.org/torvalds/c/c083dc5f3738
- Reported: 2018-03-23
https://marc.info/?l=linux-clk&m=152198452423677&w=2
- Last known developer activity: 2018-03-27
https://marc.info/?l=linux-clk&m=152199237525182&w=2


== Waiting for clarification from reporter ==

Interrupt storm after suspend causes one busy kworker
- Status: Still waiting for data from reporter
- Reported: 2018-02-25
https://bugzilla.kernel.org/show_bug.cgi?id=198929


== Fixed since last report ==

hci_bcm: Streamline runtime PM code change for 4.16 kernel breaks
bluetooth on ASUS T100TA
- Status: Fixed by https://git.kernel.org/torvalds/c/b09c61522c81
- Cause:  https://git.kernel.org/torvalds/c/43fff7683468
- Reported: 2018-03-01
https://bugzilla.kernel.org/show_bug.cgi?id=198953

sdhci-acpi not recognizing eMMC
- Status: Fixed by https://git.kernel.org/torvalds/c/d58ac803cfbb
- Cause:  https://git.kernel.org/torvalds/c/1b7ba57ecc86
- Reported: 2018-03-13
https://bugzilla.kernel.org/show_bug.cgi?id=199105
