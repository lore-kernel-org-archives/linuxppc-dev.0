Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 35672DDECC
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 18:16:38 +1000 (EST)
Date: Tue, 02 Oct 2007 17:16:31 +0900 (JST)
Message-Id: <20071002.171631.-1300535306.kouish@swc.toshiba.co.jp>
To: paulus@samba.org
Subject: [PATCH 0/5] Updates of "Celleb" patches for 2.6.24
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Follwing patch series is an update to support Cell Reference Set (Celleb).
Two patches of former series are declined, two are updated, and rest 
three still remain.

Declined patches are "fixing SLB initialization" and "VFD support for
Celleb 2." I found former patch not necessary anymore, and latter seems
under discussion to drive such device generally.

[PATCH 1/5] Celleb: Move pause, kexec_cpu_down to beat.c
  This is quite simple patch to move two functions from "setup.c" to
"beat.c". This patch is slightly updated to declare beat_kexec_cpu_down()
function unconditionally.

[PATCH 2/5] Celleb: Support for Power/Reset buttons
  This is patch to add support Power/Reset buttons on Celleb. With
this patch, Power/Reset button causes call of ctrl_alt_del() function,
not to call machine dependent routines.

  I think it is better than this to handle such buttons in consistent way,
such as 'event', but I have to make working such buttons with existing
Fedora's inittab. I feel we have to have acpi or like that, but currently
we don't have such subsystem.

[PATCH 3/5] Celleb: New HTAB Guest OS Interface on Beat
  This is a patch to support new HTAB Guest OS Interface on Beat. Beat v3
and later will provide you such interface. Beat v2 or former provide you
older Guest OS Interface only, so this patch detects whether the new inter-
face is available or not, and reflect it to ppc_md.

  Not changed from former patch.

[PATCH 4/5] Celleb: Serial I/O update
  This patch updates scc_sio.c to support newer serial-port detection
algorithm.

  Not changed from former patch.

[PATCH 5/5] Celleb: update for PCI
  This patch incorporates PCI support for Celleb.
  - io_workarounds.c: Kicks synchronization port whenever reading
  MMIO registers (so-called "dummy read").
  - Replaced "volatile void * __iommu" to "PCI_IO_ADDR" because the
  compiler complains on volatile pointer.
  - Setup via bus name.
  - alloc_maybe_bootmem() has been gone.

  Not changed from former patch.


Best regards,
Kou Ishizaki
