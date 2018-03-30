Return-Path: <regressions@leemhuis.info>
Received: from wp227.webpack.hosteurope.de (wp227.webpack.hosteurope.de
 [IPv6:2a01:488:42:1000:50ed:84ea::])
 (using TLSv1 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40CRCw6gkrzF1wf
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 31 Mar 2018 03:00:27 +1100 (AEDT)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.16: Reported regressions as of Friday, 2018-03-30
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
References: <CA+55aFxpxHnWBeTXN+DKqwCMW_=T2cR8UxSBVk_6c8LL7Et5JQ@mail.gmail.com>
Message-ID: <e9425d62-0ca9-0de3-157f-9fd5310f5371@leemhuis.info>
Date: Fri, 30 Mar 2018 18:00:20 +0200
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

Hi! Find below my seventh regression report for Linux 4.16; it's a "the
final release is getting closer" special release. It lists 7 regressions
I'm currently aware of. 1 was fixed since the report I sent on Tuesday;
1 is new.

Are you aware of any other regressions that got introduced this
development cycle? Then please let me know by mail (a simple bounce or
forward to the sender of this email address is enough!). And please tell
me if there is anything in the report that shouldn't be there.

Ciao, Thorsten

== Current regressions ==

Error updating SMART data during runtime and could not connect to lv
["Possible Regression"]
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
- Status: waiting for bisect
- Reported: 2018-03-13
https://bugzilla.kernel.org/show_bug.cgi?id=199101

ASUS XG-C100C 10G Network Adapter no longer working
- Status: got driver maintainer involved who asked reporter for more details
- Reported: 2018-03-22
https://bugzilla.kernel.org/show_bug.cgi?id=199177

multi_v7_defconfig fails to boot on many OMAP systems
- Status: patch available: "clk: ti: fix flag space conflict with
clkctrl clocks" https://marc.info/?l=linux-arm-kernel&m=152217288709609&w=2
- Cause:  https://git.kernel.org/torvalds/c/49159a9dc3da
- Reported: 2018-03-23
https://marc.info/?l=linux-clk&m=152198452423677&w=2
- Last known developer activity: 2018-03-27
https://marc.info/?l=linux-clk&m=152199237525182&w=2

hugetlbfs overflow checking regression on 32bit
- Status: patch was proposed, but has issues, too
- Cause:  https://git.kernel.org/torvalds/c/63489f8e8211
- Reported: 2018-03-29
https://marc.info/?l=linux-kernel&m=152229704211382&w=2
- Last known developer activity: 2018-03-29
https://marc.info/?l=linux-mm&m=152235614429445&w=2
- Other relevant links:
https://marc.info/?l=linux-kernel&m=152229710411390&w=2


== Waiting for clarification from reporter ==

Interrupt storm after suspend causes one busy kworker
- Status: Still waiting for data from reporter
- Reported: 2018-02-25
https://bugzilla.kernel.org/show_bug.cgi?id=198929


== Fixed since last report ==

Dell R640 does not boot due to SCSI/SATA failure
- Status: Fixed by 2f31115e940c 8b834bff1b73 adbe552349f2 c3506df85091
b5b6e8c8d3b4
- Cause:  https://git.kernel.org/torvalds/c/84676c1f21e8
- Reported: 2018-02-22
https://marc.info/?l=linux-kernel&m=151931128006031
- Note: Thx Artem and Dsterba for pointers
