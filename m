Return-Path: <regressions@leemhuis.info>
Received: from basicbox7.server-home.net (basicbox7.server-home.net
 [195.137.212.29])
 (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMFX81NY2zDvgG
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 02:09:58 +1100 (AEDT)
From: Thorsten Leemhuis <regressions@leemhuis.info>
Subject: Linux 4.9: Reported regressions as of Sunday, 2016-11-20
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, Jonathan Corbet <corbet@lwn.net>
Message-ID: <fde89288-e3bc-356f-8d64-6f9a1cf23c47@leemhuis.info>
Date: Sun, 20 Nov 2016 16:09:51 +0100
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

Hi! Here is my fourth regression report for Linux 4.9. It lists 10
regressions I'm aware of. 6 of them are new; 11 got fixed (wow!)
since the last report -- that was two weeks ago, because I 
didn't find any spare time to compile a report last Sunday :-/

As always: Are you aware of any other regressions? Then please let me
know (simply CC regressions@leemhuis.info). And please tell me if there
is anything in the report that shouldn't be there.

Ciao, Thorsten

== Current regressions ==

Desc: "irq 16: nobody cared (try booting with the ""irqpoll"" option) since t0b9e2988ab226 (ahci: use pci_alloc_irq_vectors)"
Repo: 16-11-19 https://bugzilla.kernel.org/show_bug.cgi?id=188181
Stat: n/a 
Note: new

Desc: [i.MX6 DRM IPUv3] Regression 4.9-rc5: greenish screen with YUV420 video
Repo: 16-11-17 https://www.spinics.net/lists/kernel/msg2385550.html
Stat: n/a 
Note: new

Desc: "oops due to 493b2ed3f760 (""crypto: algif_hash - Handle NULL hashes correctly"")"
Repo: 16-11-17 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1273867.html
Stat: 16-11-17 https://patchwork.kernel.org/patch/9434741/
Note: WIP, Patch available

Desc: MSI is no longer enabled for many/most Intel SATA controllers in 4.9
Repo: 16-11-16 https://bugzilla.kernel.org/show_bug.cgi?id=187821
Stat: 16-11-17 https://bugzilla.kernel.org/show_bug.cgi?id=187821#c3
Note: WIP, Patch available

Desc: "Failed boots bisected to 4cd13c21b207 ""softirq: Let ksoftirqd do its job"""
Repo: 16-11-16 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1273344.html
Stat: 16-11-18 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1275668.html
Note: WIP

Desc: qla2xxx: do not abort all commands in the adapter during EEH recovery
Repo: 16-11-14 https://www.mail-archive.com/linux-scsi@vger.kernel.org/msg55186.html
Stat: 16-11-14 https://www.mail-archive.com/linux-scsi@vger.kernel.org/msg55198.html
Note: Fix heading mainline

Desc: builddeb: fix cross-building to arm64 producing host-arch debs
Repo: 16-11-04 https://www.spinics.net/lists/linux-kbuild/msg13635.html
Stat: 16-11-10 https://www.spinics.net/lists/linux-kbuild/msg13676.html
Note: Looks stalled

Desc: "build regression: make.cross ARCH=mips fails with ""No rule to make target 'alchemy/devboards/'. """
Repo: 16-10-30 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1262410.html https://marc.info/?l=linux-kernel&m=147780880425626
Stat: n/a 
Note: nothing happened yet; BTW: Should build regressions be on this list at all?


== Stalled, waiting for feedback from reporter ==

Desc: 4.9-rc1 boot regression, ambiguous bisect result
Repo: 2016-10-19 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1253369.html
Stat: 16-10-21 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1255296.html
Note: Waiting for Dan or someone else to look into this

Desc: Skylake gen6 suspend/resume video regression
Repo: 16-10-16 https://bugzilla.kernel.org/show_bug.cgi?id=177731 https://bugs.freedesktop.org/show_bug.cgi?id=98517
Stat: 16-10-25 https://bugzilla.kernel.org/show_bug.cgi?id=177731#c3
Note: Stalled, poked bugzlla


== Going to be removed from the list ==

Desc: warning in intel_dp_aux_transfer: CPU: 0 PID: 4 at drivers/gpu/drm/i915/intel_dp.c:1062 intel_dp_aux_transfer+0x1ed/0x230#
Repo: 16-10-16 https://bugzilla.kernel.org/show_bug.cgi?id=177701
Stat: n/a 
Note: the warning seems to be fixed, but the problem that Martin saw might still be there; this will get a new entry in the regression list once confirmed

Desc: can't boot with root fs on md raid 0; mdadm: no devices listed in conf file were found. 
Repo: 2016-10-17 https://bugzilla.kernel.org/show_bug.cgi?id=178211
Stat: 16-11-03 https://bugzilla.kernel.org/show_bug.cgi?id=178211#c4
Note: sata adapters not detected, reporter is unable to debug and could need some help;


== Fixed since last report ==

Desc: """console: don't prefer first registered if DT specifies stdout-path"" breaks console on video outputs of various ARM boards; breaks some ppc machines as well"
Repo: 16-10-18 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1264523.html https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1253391.html https://www.linux-mips.org/archives/linux-mips/2016-10/msg00176.html
Fix:  https://git.kernel.org/torvalds/c/c6c7d83b9c9e6a8b3e6d84c820ac61fbffc9e396

Desc: thinkpad x60, T40p: overheat with v4.9-rc4 (was Re: v4.8-rc1: thinkpad x60: running at low frequency even during kernel build)
Repo: 16-11-05 https://www.mail-archive.com/ibm-acpi-devel@lists.sourceforge.net/msg03909.html https://bugzilla.kernel.org/show_bug.cgi?id=187311 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1264916.html
Fix:  https://git.kernel.org/torvalds/c/e2174b0c24caca170ca61eda2ae49c9561ff8896

Desc: mangled display since -rc1 (two systems: one with intel, one with nvidia gpu)
Repo: 16-10-31 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1261699.html
Fix:  https://git.kernel.org/torvalds/c/c4b8c570447a7bc171829532269878345b3ea9d0

Desc: tpm0: TPM self test failed & can't request region for resource
Repo: 16-10-28 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1259943.html https://bugzilla.kernel.org/show_bug.cgi?id=185631
Fix:  https://git.kernel.org/torvalds/c/befd99656c5eb765fe9d96045c4cba099fd938db

Desc: module loadling broken due to kbuild changes
Repo: 16-10-15 http://www.gossamer-threads.com/lists/linux/kernel/2544734
Stat: Fixes https://git.kernel.org/torvalds/c/4efca4ed05cbdfd13ec3e8cb623fb77d6e4ab187 https://git.kernel.org/torvalds/c/4efca4ed05cbdfd13ec3e8cb623fb77d6e4ab187
Note: 

Desc: unable to handle kernel NULL pointer dereference at fuse_setattr
Repo: 16-10-17 https://bugzilla.kernel.org/show_bug.cgi?id=177801
Fix:  https://git.kernel.org/torvalds/c/0ce267ff95a0302cf6fb2a552833abbfb7861a43

Desc: Radeon Oops on shutdown / Panic on shutdown in routine radeon_connector_unregister()
Repo: 16-10-19 https://bugzilla.kernel.org/show_bug.cgi?id=178421 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1261699.html
Fix:  https://git.kernel.org/torvalds/c/0a6e21056eaa859353945c4b164f3ef574d84271

Desc: boot failure of Intel Mobile Internet Devices due to a change in the PCI subsystem that appeared in v4.9-rc1.
Repo: 16-10-23 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1255643.html
Fix:  https://git.kernel.org/torvalds/c/e8a6123e9ead1b0d40349809e51de9341312fe08

Desc: amdgpu, topaz: powerplay initialization failed
Repo: 16-10-31 https://bugzilla.kernel.org/show_bug.cgi?id=185681 https://bugs.freedesktop.org/show_bug.cgi?id=98357
Fix:  https://git.kernel.org/torvalds/c/0f12f73c5175d39445fa10cdca4481f80efdef49

Desc: test failures of sendfile(2) and splice(2) 
Repo: 16-11-01 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1262400.html
Fix:  https://git.kernel.org/torvalds/c/6d6d36bc6e77f8b1f86d81884ad5149931bb4acd

Desc: """Failed to find cpu0 device node"" in dmesg"
Repo: 2016-10-16 https://bugzilla.kernel.org/show_bug.cgi?id=177681 https://bugzilla.kernel.org/show_bug.cgi?id=180031
Stat: 16-10-28 https://www.mail-archive.com/linux-kernel@vger.kernel.org/msg1260133.html
Note: Seems to be fixed, but I don't know where (https://bugzilla.kernel.org/show_bug.cgi?id=177681#c4 )
