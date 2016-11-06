Return-Path: <regressions@leemhuis.info>
Received: from basicbox7.server-home.net (basicbox7.server-home.net
 [195.137.212.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tBdYp3NwtzDt2x
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  7 Nov 2016 01:41:32 +1100 (AEDT)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.9: Reported regressions as of Sunday, 2016-11-06
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <cbe3e7b7-812d-04fe-97a9-56f5296e0b1f@leemhuis.info>
Date: Sun, 6 Nov 2016 15:41:27 +0100
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

Hi! Here is my third regression report for Linux 4.9. It lists 17
regressions I'm aware of. 6 of them are new; 3 got fixed since
last weeks report (a fourth looks fixed as well). The console
problem ("console: don't prefer first registered [...]") got
reported to me multiple times, but the revert to finally get
this fixed is in -mm already.

As always: Are you aware of any other regressions? Then please let me
know (simply CC regressions@leemhuis.info). And please tell me if there
is anything in the report that shouldn't be there.

Ciao, Thorsten

== Current regressions ==

Desc: thinkpad x60: BIOS limit stops working,
Repo: 16-11-05 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1264916.html
Stat: n/a 
Note: WIP

Desc: thinkpad x60:  thermal passive cooling can not prevent the system from overheating, when there is no BIOS limit.
Repo: 16-11-05 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1264916.html
Stat: n/a 
Note: WIP

Desc: test failures of sendfile(2) and splice(2) 
Repo: 16-11-01 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1262400.html
Stat: 16-11-01 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1262648.html
Note: WIP, patch available

Desc: amdgpu, topaz: powerplay initialization failed
Repo: 16-10-31 https://bugzilla.kernel.org/show_bug.cgi?id=185681 https://bugs.freedesktop.org/show_bug.cgi?id=98357#
Stat: 16-11-04 https://bugzilla.kernel.org/show_bug.cgi?id=185681#c7
Note: WIP

Desc: mangled display since -rc1 (two systems: one with intel, one with nvidia gpu)
Repo: 16-10-31 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1261699.html
Stat: n/a https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1262493.html
Note: root cause unknown, proper bisec needed (would be good if somebody could help the reporter)

Desc: "build regression: make.cross ARCH=mips fails with ""No rule to make target 'alchemy/devboards/'. """
Repo: 16-10-30 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1262410.html https://marc.info/?l=linux-kernel&m=147780880425626
Stat: n/a 
Note: nothing happened yet; BTW: Should build regressions be on this list at all?

Desc: tpm0: TPM self test failed & can't request region for resource
Repo: 16-10-28 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1259943.html https://bugzilla.kernel.org/show_bug.cgi?id=185631
Stat: 16-11-03 https://www.mail-archive.com/tpmdd-devel@lists.sourceforge.net/msg02010.html
Note: Partly fixed by https://git.kernel.org/torvalds/c/befd99656c5eb765fe9d96045c4cba099fd938db , but it seems more fixes are needed (and available!)

Desc: boot failure of Intel Mobile Internet Devices due to a change in the PCI subsystem that appeared in v4.9-rc1.
Repo: 16-10-23 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1255643.html
Stat: 16-10-26 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1258579.html
Note: Poked list, as it looks like the proposed fix got forgotten

Desc: Radeon Oops on shutdown / Panic on shutdown in routine radeon_connector_unregister()
Repo: 16-10-19 https://bugzilla.kernel.org/show_bug.cgi?id=178421 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1261699.html
Stat: 16-10-30 https://bugzilla.kernel.org/show_bug.cgi?id=178421#c6
Note: Patch available

Desc: ""console: don't prefer first registered if DT specifies stdout-path"" breaks console on video outputs of various ARM boards; breaks some ppc machines as well
Repo: 16-10-18 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1264523.html https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1253391.html https://www.linux-mips.org/archives/linux-mips/16-10/msg00176.html
Stat: 16-11-06 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1265059.html https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1264422.html
Note: revert discussed and also in -mm; Side note: this seems to be a regression that annoys quite a lot of people

Desc: unable to handle kernel NULL pointer dereference at fuse_setattr
Repo: 16-10-17 https://bugzilla.kernel.org/show_bug.cgi?id=177801
Stat: 16-10-18 https://bugzilla.kernel.org/show_bug.cgi?id=177801#c5
Note: poked Miklos, as the fix is not yet upstream afaics

Desc: Skylake gen6 suspend/resume video regression
Repo: 16-10-16 https://bugzilla.kernel.org/show_bug.cgi?id=177731 https://bugs.freedesktop.org/show_bug.cgi?id=98517
Stat: 16-10-25 https://bugzilla.kernel.org/show_bug.cgi?id=177731#c3
Note: WIP

Desc: warning in intel_dp_aux_transfer: CPU: 0 PID: 4 at drivers/gpu/drm/i915/intel_dp.c:1062 intel_dp_aux_transfer+0x1ed/0x230#
Repo: 16-10-16 https://bugzilla.kernel.org/show_bug.cgi?id=177701
Stat: 16-10-27 https://bugs.freedesktop.org/show_bug.cgi?id=97344
Note: Poked Janni a week ago to give a status update, but didn't hear anything yet

Desc: module loadling broken due to kbuild changes
Repo: 16-10-15 http://www.gossamer-threads.com/lists/linux/kernel/2544734
Stat: 16-10-27 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1259418.html
Note: Fix available (for more than a week now), waiting for Michal to get back from vacation; wondering if those will fix https://bugzilla.kernel.org/show_bug.cgi?id=185581 and https://lkml.org/lkml/2016/10/27/471 and https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1250105.html as well


== Stalled, waiting for feedback from reporter ==

Desc: 4.9-rc1 boot regression, ambiguous bisect result
Repo: 16-10-19 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1253369.html
Stat: 16-10-21 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1255296.html
Note: Waiting for Dan or someone else to look into this

Desc: can't boot with root fs on md raid 0; mdadm: no devices listed in conf file were found. 
Repo: 16-10-17 https://bugzilla.kernel.org/show_bug.cgi?id=178211
Stat: 16-11-03 https://bugzilla.kernel.org/show_bug.cgi?id=178211#c4
Note: sata adapters not detected, reporter is unable to debug and could need some help

Desc: """Failed to find cpu0 device node"" in dmesg"
Repo: 16-10-16 https://bugzilla.kernel.org/show_bug.cgi?id=177681 https://bugzilla.kernel.org/show_bug.cgi?id=180031
Stat: 16-10-28 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1260133.html
Note: Seems to be fixed (https://bugzilla.kernel.org/show_bug.cgi?id=177681#c4 )


== Fixed since last report ==

Desc: "Nokia N900 (omap3-n900) with ""VDD1: ramp_delay not set"" string in printk frequently"
Repo: 16-10-19 https://bugzilla.kernel.org/show_bug.cgi?id=178371
Fix:  https://git.kernel.org/torvalds/c/ba14fa1a57c07cca9d520ceded8d3da5beb6175f

Desc: radeon performance drop from 4.8 to 4.9-rc1 in Shadow of Mordor
Repo: 16-10-14 https://bugzilla.kernel.org/show_bug.cgi?id=178221 https://lists.freedesktop.org/archives/dri-devel/16-October/120693.html
Fix:  https://git.kernel.org/linus/bdb520845b5700284f34437fadb920000c306466

Desc: pci: artpec-6: imprecise external abort
Repo: 16-10-14 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1249646.html
Fix:  https://git.kernel.org/torvalds/c/416379f9ebded501eda882e6af0a7aafc1866700
