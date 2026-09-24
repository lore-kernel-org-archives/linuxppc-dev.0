Return-Path: <linuxppc-dev+bounces-28127-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47C0FC9830E
	for <linuxppc-dev@archiver.kernel.org>; Thu, 24 Sep 2026 17:35:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hrLZV0jlLz30VT;
	Fri, 25 Sep 2026 03:35:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1048"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790271313;
	cv=none; b=JdpNdiHESD7oYbk+lsV5MsCymOG9dnNAdGW8kDJbZpTHmvZwLFMJep09Q7U17eX3vcktngsae0A/0XQRG0aECrWj+1RtG6DUsPyNMNxecANWBiEG3qbLpGtdCTBJgr2idv3dnTQbPAYenKXbJ9DB3Ct6YPw+tZhLpfHxCY1YozogFcAUdKEmcj5kfHp/DN2fgisuSkDn1BPeRFT8mE85w8J+DXAo3fZRPeh3F5Hp2bZzT8xIYZO4xByDtLD60z1ffSfM8BfwAghYC2syEB9QEw1ArKjPpSCQQs+RmMQoCU5GqvUa9OI6YdDjnRm7WhHiZFI2mXM8xgB4Ihf/xEUWuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790271313; c=relaxed/relaxed;
	bh=bifIYNcf5W5G5Dl02fXRxJ/gYcCscStcB/nVOPYZVpA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=gTwUE5LOHWUIUip2iCc4RSH3PextqsJqIpkn1c1NeE6VaoU5UIx/ksUIe6dVWUhLZ2Mm6Hn+htX7lmhYkthKd7xNG73lmT5A4p2UwLpo8zGoI5iXyr4AMEjgF28+8DnNIvy9PRItW+tBWwxckO6qJdjzXrRBO7cibVPoZe0KGD72nenOF+4d4d8qsRzIZaCLml50sHvTNEzaziLHydaPBfe0/728CxgkKu4ld92E9vKndX4VxAMfBZ/k/Hn9q0dGxkuO7U8ASwR45PtB3LqNPhuJ2rvD2dntgL6QLmqnXhl5dRk3ziE2/TCXfoq+zIp3sOMyORoAoU5qNYohPek5YQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=FRsGICCT; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com; envelope-from=3s1-1aggkddwbkyrjyaiemmejc.amkjglsvnna-bctjgqrq.mxjyzq.mpe@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--dmatlack.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=FRsGICCT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--dmatlack.bounces.google.com (client-ip=2607:f8b0:4864:20::1048; helo=mail-pj1-x1048.google.com; envelope-from=3s1-1aggkddwbkyrjyaiemmejc.amkjglsvnna-bctjgqrq.mxjyzq.mpe@flex--dmatlack.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1048.google.com (mail-pj1-x1048.google.com [IPv6:2607:f8b0:4864:20::1048])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hrLZR0XL1z30T9
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Sep 2026 03:35:10 +1000 (AEST)
Received: by mail-pj1-x1048.google.com with SMTP id 98e67ed59e1d1-38e8fee6af3so103721a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Sep 2026 10:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790271308; x=1790876108; darn=lists.ozlabs.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bifIYNcf5W5G5Dl02fXRxJ/gYcCscStcB/nVOPYZVpA=;
        b=FRsGICCTOuB+qn7e5Fp8CtR/8fRKzOAiGEC2gA+VAzcFPRv130UY/DnHgHM9c0LoQn
         CP4SQt/k0g2dIfgakxyW0+EauPNLMXcPZvCDYzxwMA5CTMl1BWu1XlJBzgKM+f/e7yIF
         E+0Pu0d6LaixtRfzhsSHLQSwZUMv+TiGQr7eQX1VRLILUZYGUUpU8MfcEMf8s/INMwmR
         /99I6I+73bKpdijVEK4gDfkZG/b3Y5SEcdiGDkQJIBSdHwVrpnwN7n5mUSjs+EpPMgxK
         c8ybYMh1J0oxxL1wTAFiB2D0UbKAwpnwbJXB4HB9E1E7wu6GKrWbcaT45FfFGM36Cce9
         5lWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790271308; x=1790876108;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bifIYNcf5W5G5Dl02fXRxJ/gYcCscStcB/nVOPYZVpA=;
        b=Bc+RN6jkdGzFB7pRYBK7XqZbQX7Lo0caZWGpnyVuwt1Ca/QVrb0Y0V8noXkR7rTFuW
         7Xp1sl1KlzqAbu68UCpbpDMBSduV2qO1Up6eEoGC1kdZHqZJ3wjN8sejWSJ+3XC4zKI9
         G5NVpPlxlAUVIpAkstmjT2j85ZjB9tXLUFymHXYQU0f/C1J7wLkD/epnIgjQc9SsCqQ+
         YPXpJOn1iX9aZvtfNY29y0W8Sa7tEre+dFZRcajmXInDpE/LojvUlv9m53r/mSHZximO
         bfS9te4zq5ngFx8eslNdz1YX31DsYDzDlV8lvUyNDdhEcz9O8o8u6TyThKuYgr1sGOAo
         8lqA==
X-Forwarded-Encrypted: i=1; AKwUvByTH7l52NirRItM1ZI4+ME4gH6tOQEPJRbU7gzmF3nyAI1R71EUcE8DLj9K5whbzOtW6cYoKz3JUStbd8I=@lists.ozlabs.org
X-Gm-Message-State: AFuF++nM2zdGLGcIehLAanC9GfpZ1M9iDGW5okA6dibTfc8OT/3lQV/E
	uD0ZumL1GTb4ZvDpYlk1M6ySHmY9gc8CFX1avjnZrI22fhFeG60jR9XKuBd9Ubw9M65Ir7PANVO
	TM6zKnyfO0qiC/w==
X-Received: from pgdh26.prod.google.com ([2002:a05:6a02:519a:b0:cc5:1155:96c7])
 (user=dmatlack job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7c4:b0:39e:6c69:f46f with SMTP id 98e67ed59e1d1-3a098cf446amr2985971a91.46.1790271307721;
 Thu, 24 Sep 2026 10:35:07 -0700 (PDT)
Date: Thu, 24 Sep 2026 17:34:46 +0000
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
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260924173501.856380-1-dmatlack@google.com>
Subject: [PATCH 00/15] PCI: Index saved capability state by configuration
 space offset
From: David Matlack <dmatlack@google.com>
To: linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org
Cc: Alex Williamson <alex@shazbot.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Jason Gunthorpe <jgg@nvidia.com>, Josh Hilke <jrhilke@google.com>, Lukas Wunner <lukas@wunner.de>, 
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>, "Oliver O'Halloran" <oohall@gmail.com>, 
	Pasha Tatashin <pasha.tatashin@soleen.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Samiullah Khawaja <skhawaja@google.com>, Vipin Sharma <vipinsh@google.com>, 
	David Matlack <dmatlack@google.com>
Content-Type: text/plain; charset="UTF-8"

This series replaces the per-capability save buffers in the PCI core with
a single per-device store indexed by the offset of each register in the
device's configuration space, and lays out struct pci_saved_state the
same way.

Motivation
----------

VFIO needs to carry a device's saved state across a Live Update kexec.
VFIO snapshots a device's pristine configuration with
pci_store_saved_state() when the device is first opened and restores it
with pci_load_and_free_saved_state() when the device is last closed, and
a Live Update kexec can happen in between.

struct pci_saved_state cannot be handed to the next kernel today. Its
layout is defined entirely by the kernel that produced it: which
capabilities get a record, how large each record is, and what each word
within a record means are all properties of the code that happens to be
saving them. Nothing ties a saved value back to the register it came
from, so a receiving kernel has no way to tell whether a blob describes
the device in front of it.

The layout this state wants is the one the device already defines. If a
saved value is identified by the configuration space offset of its
register, the shape of the blob becomes a property of the hardware rather
than of the kernel version, and the receiving kernel can validate it
against the device it enumerated.

The same change addresses a second problem. Capability save buffers are
allocated at nine sites (plus one hand-built by a quirk) spread across
three phases of a device's life (device configuration, capability init
and, for DPC, portdrv bind). Each allocation can fail on its own. Four
of them (AER, DPC, PTM, TPH) ignore the failure and their save paths
skip a missing buffer quietly, so the capability goes unsaved with no
indication why. After this series a device has exactly one saved state
allocation, and its failure is reported.

The series is roughly net-neutral in size (680 insertions, 621
deletions), but most of what it adds is the store itself: 305 lines in
drivers/pci/saved-caps.c, nearly half of them comments. Outside of it
the series removes 246 more lines than it adds.

More importantly, it replaces save/restore code that only worked because
of careful orchestration. The save and restore routines of each
capability had to walk the same registers in the same order through a
running buffer cursor, the allocation had to be sized to match what the
save side would later write, and code elsewhere had to know which slot
held which register. VC went further, using a single walker in three
modes to size, save and restore. Getting any of these out of step put the
wrong value into a register on restore, usually without any error. After
this series, saving is a single pass over the reservation bitmap, and
each restore routine names its registers by configuration space offset,
so it reads as a plain list of the registers being put back. Reserving,
bounds checking, allocating, saving and restoring live in one helper
library that every capability shares.

Series overview
---------------

  Patch 1 moves the DPC save buffer allocation from dpc_probe() to
  pci_dpc_init(), so that every capability save buffer is allocated in
  one phase of a device's life, which patch 2 relies on. It also closes a
  window in which a reset loses the DPC Control register.

  Patch 2 adds the store. Capabilities reserve registers by configuration
  space offset during device setup, and the values are allocated in a
  single array once every capability has been initialized.

  Patch 3 lays out struct pci_saved_state by configuration space offset:
  a bitmap of the DWORDs that were saved, plus their values. It comes
  before the conversions so that the blob describes a device's complete
  saved state at every commit in the series; see "Design notes" below.

  Patches 4-11 convert PCIe, PCI-X, LTR, L1SS, AER, PTM, TPH and DPC to
  the store, one capability at a time.

  Patch 12 lifts the VC Resource Control restore out of the VC
  save/restore walker, and patch 13 converts VC to the store. VC is
  converted last because its walker also handles the arbitration
  tables, whose size the device reports at runtime.

  Patch 14 collapses the save side. Once every capability has reserved
  its registers, the reservation bitmap says exactly which DWORDs
  pci_save_state() has to read, so eight per-capability save functions
  are replaced by one pass over the bitmap.

  Patch 15 removes struct pci_cap_saved_state and the machinery that
  managed it.

Design notes
------------

The store covers capability registers only. The configuration space
header continues to be saved in pci_dev.saved_config_space, which is
embedded in struct pci_dev so that saving it cannot fail, and which a
couple of drivers index directly.

struct pci_saved_caps is embedded in struct pci_dev for the same reason.
Every device needs its reservation bitmap during enumeration, so
allocating it separately would save nothing and only add a failure path
that every caller has to tolerate. It costs 136 bytes per device, which
the allocations it replaces more than pay for; see "Memory overhead"
below.

Registers are saved a DWORD at a time, since configuration space reads
have no side effects, but restored at their own width, because
neighbouring registers within a DWORD may be RW1C or may not tolerate
being written, e.g. PCI_EXP_DEVCTL and PCI_EXP_DEVSTA share a DWORD.

The series is ordered so that struct pci_saved_state describes a
device's complete saved state at every commit. pci_store_saved_state()
is the only way for a driver to hold a device's pristine state across a
reset, and a load that is missing registers fails silently, so a bisect
landing in the middle of the series must not produce a partial blob.
Patch 3 therefore lands before the first conversion, and for as long as
the two representations coexist the blob carries the DWORD array
followed by the records of whatever has not been converted yet. Patch
15 drops the records.

One subtle change in this series is that PCIe capability registers are
now always read from the device during save, instead of using
pcie_capability_read_word() (which returns 0 for registers the device
does not implement). However, reads of PCI config space have no
side-effects, and the restore side still properly skips writing to
unimplemented registers by using pcie_capability_write_word().

Memory overhead
---------------

Embedding struct pci_saved_caps grows struct pci_dev by 136 bytes on
x86_64, from 2424 to 2560 bytes in a non-debug build. Both sizes fall in
the same kmalloc-4k bucket, so a device costs no more slab memory than
it did before.

What the series removes is larger. Every saved capability used to get
its own allocation, and each one paid a 24-byte struct
pci_cap_saved_state header for a payload of 2 to 20 bytes, which then
rounded up to the next slab bucket:

  - A PCIe endpoint with AER, LTR, L1SS and PTM had five allocations
    occupying 224 bytes. It now has one of 64 bytes.

  - A root port that also has DPC had six occupying 256 bytes. It now
    has one of 96 bytes.

  - An SR-IOV VF had one of 64 bytes. It now has one of 32 bytes.

That is 32 to 160 bytes less per device, roughly 80 KB on a machine with
512 devices, and one allocation per device rather than one per
capability.

struct pci_saved_state goes the other way. It now carries the 128-byte
DWORD bitmap in place of a packed list of records, so a blob for the
endpoint above grows from 192 to 256 bytes, and one for the root port
from 192 to 512 bytes. Only the drivers that call
pci_store_saved_state() allocate one, and only while they are holding a
device's state. If that ever matters, the blob could carry only the
bitmap words covering the device's configuration space rather than all
128 bytes.

Cleanups that fell out
----------------------

  - quirk_intel_qat_vf_cap() no longer builds a PCIe save buffer by hand,
    since the reservation keys off pci_is_pcie() rather than off the
    capability list.

  - pci_update_aspm_saved_state() no longer has to know that cap[1] of
    the PCIe save buffer is the Link Control register.

  - pci_vc_do_save_buffer() loses its dual size/save/restore return
    value, its running length, its buffer cursor, and the check that
    compared the two against each other. Patch 14 then drops its save
    mode entirely.

  - AER, PTM and TPH report a failure to reserve. They ignored the
    allocation return value entirely.

  - pci_store_saved_state() used to build a packed array of struct
    pci_cap_saved_data whose entries can become misaligned, after which
    pci_load_saved_state() could perform unaligned 32-bit reads of
    cap->size, which can cause faults on some architectures. This minor
    bug is eliminated by this series.

Future work
-----------

  - Support struct pci_saved_state being preserved and restored across
    a Live Update kexec by VFIO. This will be mostly mechanical (e.g.,
    defining a serialized version in include/linux/kho/abi/ and
    implementing trivial serialization/deserialization routines).

  - Make the one remaining save-state allocation failure fatal to device
    setup. pci_device_add() returns void today, so a device whose saved
    state could not be allocated is added anyway.


David Matlack (15):
  PCI/DPC: Allocate the DPC save buffer during device setup
  PCI: Add an offset-indexed store for saved capability registers
  PCI: Lay out struct pci_saved_state by configuration space offset
  PCI: Save PCIe state in the saved capability store
  PCI: Save PCI-X state in the saved capability store
  PCI/ASPM: Save LTR state in the saved capability store
  PCI/ASPM: Save L1SS state in the saved capability store
  PCI/AER: Save AER state in the saved capability store
  PCI/PTM: Save PTM state in the saved capability store
  PCI/TPH: Save TPH state in the saved capability store
  PCI/DPC: Save DPC state in the saved capability store
  PCI/VC: Split the VC Resource Control restore into a helper
  PCI/VC: Save VC state in the saved capability store
  PCI: Save reserved capability registers in a single pass
  PCI: Remove the per-capability save buffers

 drivers/pci/Makefile     |   3 +-
 drivers/pci/pci.c        | 304 +++++++++++++-------------------------
 drivers/pci/pci.h        |  49 +++----
 drivers/pci/pcie/aer.c   |  74 ++++------
 drivers/pci/pcie/aspm.c  | 102 ++++---------
 drivers/pci/pcie/dpc.c   |  32 +---
 drivers/pci/pcie/ptm.c   |  33 +----
 drivers/pci/probe.c      |   9 +-
 drivers/pci/quirks.c     |  30 +---
 drivers/pci/saved-caps.c | 305 +++++++++++++++++++++++++++++++++++++++
 drivers/pci/tph.c        |  62 ++------
 drivers/pci/vc.c         | 267 +++++++++++++++++-----------------
 include/linux/pci.h      |  31 +++-
 13 files changed, 680 insertions(+), 621 deletions(-)
 create mode 100644 drivers/pci/saved-caps.c


base-commit: fe2ec83746e501645709761605c2464a44fd2929
-- 
2.56.0.rc1.315.gc6ed9934b7-goog


