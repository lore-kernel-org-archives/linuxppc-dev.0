Return-Path: <linuxppc-dev+bounces-18725-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31D28F54ADC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:58:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fgGT55FZCz2yng;
	Wed, 25 Mar 2026 03:58:33 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=198.175.65.13
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774371513;
	cv=none; b=SgPzxWlIokDPAyZSRGrG8OySpQ3kXssvf15I53QtMRy563DIEUecywvWFRZjYjED2d8DPEPPZS4xi8x7Vt4EMEAXnjI/mE/oqFuSSEDsTAUeFVRdIafcK2GmT3N6IZS1lQWG4xvnjDt8xYx8434N01G+dMjydbjAjv+B11m4ZG3nlutgXlGKLz1JTFbZxh/M9enNA1jPLrlhBNmtLUvhp+Nf//BCCgyq03ebQEi+Kp7uZwV4NhClvsvT7Bcu6W6XnX/7CslvcjFZfm7nzdCcxlPW+t+O0eqcu6UpCSm2XOMYd8+dddrpdZrloemQ5x0cyt2vx6UIfVBJ/ejUHJF4ew==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774371513; c=relaxed/relaxed;
	bh=vVIqBuyIq4R4/UVhTmLSRBTYm0AzPhhoH+Jbpk0DIV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=fAM1/Jh/aFwlFXMrw9qP/rO+LXAMjppNyYntOTCDqJBQMfZ33gxAnYtpIr1oJpQ8sIIKwRQfidZ5lFucX0nx0apOeU76XwaRnI9vvAh46CYD6zsz95P/X7w9YptScziyg4npzZQ1BKxwuDvHhI33fQ7HKFFygOSmodl0qe55En2CPAXmIiTwSin2jdDCGCmiF46iM0rlgGkP78ksgEoPK5xeznX6aJppgAZMwTGssaUQGLS2PqjWcSGfu+m05t6N7LF/V8UoiyEiaLyXM8FpyNG+s6xcI+mbOz6+8Ap0+assgV54IOeR5w/DKC4GIX/Bou89o/OUibLDu9ojSB6guw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c88GHMjs; dkim-atps=neutral; spf=pass (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org) smtp.mailfrom=linux.intel.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=c88GHMjs;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linux.intel.com (client-ip=198.175.65.13; helo=mgamail.intel.com; envelope-from=ilpo.jarvinen@linux.intel.com; receiver=lists.ozlabs.org)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fgGT24pHZz2ynP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Mar 2026 03:58:28 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1774371511; x=1805907511;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AVKqbcBAH58YtvbtTvUhV6tMedua8892v/x7yCDldr8=;
  b=c88GHMjsrANGVFPo3lCuF6nvKHhvtB+jxAJP2kt1pg15zkVG5gW0Qxc8
   /zzd8XNv3E/eJlGiN32dxNI96/9Ut6rYayjMw1hdkGUZYPd2U+F2puwLj
   dOoHMfwo7ct31uI7cfFEOLp8A+0qn5CtYxlgghL5bXYhDf+T+Wn7rs6wt
   dXzqBIzhBSemMwdh3voJQq8m8ZoQTmIw3ydAEokent5BKJE+wi4VRqGSd
   S+IEZtftTqKvjDDMB+0cLHwiKF5ydjgNeF/G6weuqs8eV1mspwDes+KSm
   yHEo+cGFyRkm8VSJnKMSMrK8f6LdofgKRYdXsepA07ZZYTCXo9FHhIWg3
   Q==;
X-CSE-ConnectionGUID: f45wNxILQp+hX5ePnP305w==
X-CSE-MsgGUID: tbrkzNA5T2GFDKU4iOBrng==
X-IronPort-AV: E=McAfee;i="6800,10657,11739"; a="86471511"
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="86471511"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 09:58:25 -0700
X-CSE-ConnectionGUID: aesm43ZmRSeKftw4Z5hIbQ==
X-CSE-MsgGUID: C08Qc1D5Q9Gv1bbEQjAQVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,138,1770624000"; 
   d="scan'208";a="224421853"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.244.217])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2026 09:58:15 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Guenter Roeck <linux@roeck-us.net>,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	Russell King <linux@armlinux.org.uk>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	Helge Deller <deller@gmx.de>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Chris Zankel <chris@zankel.net>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc: linux-kernel@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 00/10] PCI: Improve head free space usage
Date: Tue, 24 Mar 2026 18:56:23 +0200
Message-Id: <20260324165633.4583-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.39.5
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi all,

This series attempts to take advantage of free head space (the free
space before the aligned start address) in order to generally produce a
tighter packing of the resources/bridge windows.

The recent changes to the resource fitting algorithm caused resource
allocation failures in some cases where a bridge window that is sized
to be gapless could no longer be assigned. The previous algorithm left
a huge gaps which allowed it to place the remainder (non-aligning part
of the size) before the start address of used for the gapless fit,
whereas the new gapless approach always had to place the remainder
after the aligning part of the resources. There is not always space
for the remainder triggering those failures (e.g., when the aligning
part must be placed at the top of the window).

This series attempts to allow placing the remainder once again before
the aligning part, but now without leaving huge gaps to retain the
benefits of the gapless bridge windows. The approach is somewhat hacky
but should work thanks to PCI resources fundamentally consisting only
power-of-two atoms.

There maybe cases where architecture would not want to do such
relocation. This series adds the relocation to arch
pcibios_align_resource() functions to allow all of them taking
advantage of the better resource packing but if somebody objects doing
this relocation for a particular arch, I can remove it, please just let
me know (this relocation doesn't seem critical unless there are
regressions).

Ilpo Järvinen (10):
  resource: Add __resource_contains_unbound() for internal contains
    checks
  resource: Pass full extent of empty space to resource_alignf CB
  resource: Rename 'tmp' variable to 'full_avail'
  ARM/PCI: Remove unnecessary second application of align
  am68k/PCI: Remove unnecessary second application of align
  MIPS: PCI: Remove unnecessary second application of align
  parisc/PCI: Cleanup align handling
  PCI: Rename window_alignment() to pci_min_window_alignment()
  PCI: Align head space better
  PCI: Fix alignment calculation for resource size larger than align

 arch/alpha/kernel/pci.c          |  1 +
 arch/arm/kernel/bios32.c         |  9 ++++---
 arch/m68k/kernel/pcibios.c       |  8 +++++--
 arch/mips/pci/pci-generic.c      |  8 ++++---
 arch/mips/pci/pci-legacy.c       |  3 +++
 arch/parisc/kernel/pci.c         | 17 ++++++++------
 arch/powerpc/kernel/pci-common.c |  6 ++++-
 arch/s390/pci/pci.c              |  1 +
 arch/sh/drivers/pci/pci.c        |  6 ++++-
 arch/x86/pci/i386.c              |  5 +++-
 arch/xtensa/kernel/pci.c         |  3 +++
 drivers/pci/pci.h                |  3 +++
 drivers/pci/setup-bus.c          | 15 ++++++++----
 drivers/pci/setup-res.c          | 40 +++++++++++++++++++++++++++++++-
 drivers/pcmcia/rsrc_nonstatic.c  |  3 ++-
 include/linux/ioport.h           | 22 +++++++++++++++---
 include/linux/pci.h              | 12 +++++++---
 kernel/resource.c                | 33 +++++++++++++-------------
 18 files changed, 149 insertions(+), 46 deletions(-)


base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
-- 
2.39.5


