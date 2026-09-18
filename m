Return-Path: <linuxppc-dev+bounces-27752-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2040C982D8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 18 Sep 2026 18:49:14 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hmhVd0jlqz2xft;
	Sat, 19 Sep 2026 04:49:13 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=23.155.224.40
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789757353;
	cv=none; b=KaGpqv1MdCLtSsLz8CWcNrrEZlmcVXS9sawPukOUvD9shZ4+q4tgnyPDSJ3I7WKl2ke1lkJEMz8GBPiU+a8rJmHu266scC8Ybh9ZBVP5eQnoRhs/MRziOlnMG9lUTkgMXf6nBq0FYDQa1jsmvRNMr4lAtxM8L83fYVjIfMVxuYj0S7q+iQCD/i6S6SXaZK8/E2OxU31KABBlquTMn1PWCM168QJ6mHFn3HOfpIoSeQ7qrJtzwhYotnQdE4aXEG8aQvLTYaChauO+MR5OwtYod+K1j1dDYLvot5BoSpFT4LLavT2HPapq/tcRHQE6D53KqnMDKhj/tY/XXzAkbZ4p7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789757353; c=relaxed/relaxed;
	bh=D9MPXf+m07b/sN/Zvt6MaYw4XyXai5SfMegemOrNqw8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=lLmYchmEmWPcswvSf0u2d+dPDkltV06q/qDBChwG8BKLZlq3QAG0TNHhvzCylxN9oUlowKU7IsyrSHQ4Z8GfqhbAI8tdKmNv26f9YJd6dDB21hOFSudqHrSlAFTO70eQLMdCRZdcq1O4KTR2JzfSedLX1JtNogRj60qjWcYHiWgNaAJKyQOo9G8SGG9RPvTn4+ySVaX4FP/5VLEtWGkVZwNlRylck4Hw6akIrU5iTlnein60c+Q05B7B166kXuzu73EetZ5t4r8pzZlC7A6+XGafG6jfIVxD/z/pHeVy2Nxc8HLjZ06Ve3GuiUQze3hMUIKDN6UMHvgAhlf4ffXmEA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com; dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=jnngFgk7; dkim-atps=neutral; spf=pass (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org) smtp.mailfrom=raptorengineering.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=raptorengineering.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; secure) header.d=raptorengineering.com header.i=@raptorengineering.com header.a=rsa-sha256 header.s=B8E824E6-0BE2-11E6-931D-288C65937AAD header.b=jnngFgk7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=raptorengineering.com (client-ip=23.155.224.40; helo=raptorengineering.com; envelope-from=tpearson@raptorengineering.com; receiver=lists.ozlabs.org)
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hmhVZ5L4Dz2xYg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2026 04:49:10 +1000 (AEST)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 8A3D57791C22;
	Fri, 18 Sep 2026 13:49:08 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id NmUqQrNj7Whe; Fri, 18 Sep 2026 13:49:07 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id 22B9877931EC;
	Fri, 18 Sep 2026 13:49:07 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 22B9877931EC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
	t=1789757347; bh=D9MPXf+m07b/sN/Zvt6MaYw4XyXai5SfMegemOrNqw8=;
	h=Date:From:To:Message-ID:MIME-Version;
	b=jnngFgk72CmrCUgTCAf0D/UehEuwQuvrYXk6rOIcZL0jRnRa8IuGm5pYKlqQlV4N9
	 cpViL/RKX1YxwuWLQ0Kja12fVc0cxm6Re7xhqaYaDhQLaIaGj3fHycqv9+oAuabjeM
	 +1BK9HMVVsq31EIoM6JcegnttnVP5GtNcM8C4HS0=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
	by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TPa2XRafTufH; Fri, 18 Sep 2026 13:49:06 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
	by mail.rptsys.com (Postfix) with ESMTP id DC76A7791F8D;
	Fri, 18 Sep 2026 13:49:06 -0500 (CDT)
Date: Fri, 18 Sep 2026 13:49:02 -0500 (CDT)
From: Timothy Pearson <tpearson@raptorengineering.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Cc: Ritesh Harjani <ritesh.list@gmail.com>
Message-ID: <1582840094.85102.1789757342292.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <133526175.85096.1789756371777.JavaMail.zimbra@raptorengineeringinc.com>
References: <133526175.85096.1789756371777.JavaMail.zimbra@raptorengineeringinc.com>
Subject: Re: [BUG] PCIe passthrough of MCS9990 fails
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
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC152 (Linux)/8.5.0_GA_3042)
Thread-Topic: PCIe passthrough of MCS9990 fails
Thread-Index: mIB1Ip8gfRnGqO14AFJUnvnJwztj+N+Ry7n8

I've also seen the following failure in the guest when passing through more than one PCIe function:

[    0.710454] pci 0000:01:00.1: EHCI: unrecognized capability 00
[    0.710546] EEH: Recovering PHB#0-PE#10001
[    0.710598] EEH: PE location: N/A, PHB location: N/A
[    0.710669] EEH: Frozen PHB#0-PE#10001 detected
[    0.710745] EEH: Call Trace:
[    0.710832] EEH: [000000007d519995] __eeh_send_failure_event+0x7c/0x160
[    0.710944] EEH: [00000000419515d5] eeh_dev_check_failure+0x2e0/0x6d0
[    0.711011] EEH: [000000008950df7e] quirk_usb_early_handoff+0xca4/0xfd0
[    0.711076] EEH: [000000002528ae55] pci_fixup_device+0x140/0x2d0
[    0.711137] EEH: [000000002e85a626] pci_apply_final_quirks+0xb4/0x1b8
[    0.711199] EEH: [00000000e0915ba4] do_one_initcall+0x80/0x3b0
[    0.711255] EEH: [0000000014cb0304] kernel_init_freeable+0x340/0x3e4
[    0.711311] EEH: [00000000b18e64ad] kernel_init+0x30/0x1a0
[    0.711357] EEH: [0000000047d4e5e3] ret_from_kernel_user_thread+0x14/0x1c
[    0.711413] EEH: This PCI device has failed 1 times in the last hour and will be permanently disabled after 5 failures.
[    0.711493] EEH: Notify device drivers to shutdown
[    0.711538] EEH: Beginning: 'error_detected(IO frozen)'
[    0.711584] PCI 0000:01:00.1#10001: EEH: no driver
[    0.711589] PCI 0000:01:00.3#10001: EEH: no driver
[    0.711644] PCI 0000:01:00.5#10001: EEH: no driver
[    0.711689] PCI 0000:01:00.7#10001: EEH: no driver
[    0.711737] EEH: Finished:'error_detected(IO frozen)' with aggregate recovery state:'none'
[    0.711860] EEH: Collect temporary log
[    0.712602] EEH: of node=0000:01:00.1
[    0.712654] EEH: PCI device/vendor: 99909710
[    0.712720] EEH: PCI cmd/status register: 00100146
[    0.712761] EEH: PCI-E capabilities and status follow:
[    0.712876] EEH: PCI-E 00: 00010010 00008fc1 0000283f 01078011
[    0.712989] EEH: PCI-E 10: 00110008 00000000 000003c0 00000000
[    0.713044] EEH: PCI-E 20: 00000000
[    0.713082] EEH: of node=0000:01:00.3
[    0.713129] EEH: PCI device/vendor: 99909710
[    0.713187] EEH: PCI cmd/status register: 00100146
[    0.713232] EEH: PCI-E capabilities and status follow:
[    0.713345] EEH: PCI-E 00: 00010010 00008fc1 0000283f 01078011
[    0.713460] EEH: PCI-E 10: 00110008 00000000 000003c0 00000000
[    0.713513] EEH: PCI-E 20: 00000000
[    0.713547] EEH: of node=0000:01:00.5
[    0.713595] EEH: PCI device/vendor: 99909710
[    0.713655] EEH: PCI cmd/status register: 00100146
[    0.713700] EEH: PCI-E capabilities and status follow:
[    0.713812] EEH: PCI-E 00: 00010010 00008fc1 0000283f 01078011
[    0.713938] EEH: PCI-E 10: 00110008 00000000 000003c0 00000000
[    0.714007] EEH: PCI-E 20: 00000000
[    0.714052] EEH: of node=0000:01:00.7
[    0.714108] EEH: PCI device/vendor: 99909710
[    0.714182] EEH: PCI cmd/status register: 00100146
[    0.714239] EEH: PCI-E capabilities and status follow:
[    0.714371] EEH: PCI-E 00: 00010010 00008fc1 0000283f 01078011
[    0.714501] EEH: PCI-E 10: 00110008 00000000 000003c0 00000000
[    0.714571] EEH: PCI-E 20: 00000000
[    0.714623] EEH: Reset with hotplug activity
[    0.714942] pci 0000:01:00.1: quirk_usb_early_handoff+0x0/0xfd0 took 12340 usecs
[    0.716273] PCI: CLS 0 bytes, default 128
[    0.716424] Trying to unpack rootfs image as initramfs...
[    0.725599] Initialise system trusted keyrings
[    0.725679] Key type blacklist registered
[    0.725797] workingset: timestamp_bits=38 max_order=19 bucket_order=0
[    0.725891] zbud: loaded

Passing through one single EHCI function seems to at least allow the guest to boot, but only *once* after each power cycle.

All functions are in the same IOMMU group:

[  617.749136] pci 0031:01:00.0: BAR 0 [mem size 0x00001000]: can't claim; no address assigned
[  617.749797] pci 0031:01:00.1: BAR 0 [mem size 0x00001000]: can't claim; no address assigned
[  617.750412] pci 0031:01:00.2: BAR 0 [mem size 0x00001000]: can't claim; no address assigned
[  617.751035] pci 0031:01:00.3: BAR 0 [mem size 0x00001000]: can't claim; no address assigned
[  617.751668] pci 0031:01:00.4: BAR 0 [mem size 0x00001000]: can't claim; no address assigned
[  617.752270] pci 0031:01:00.5: BAR 0 [mem size 0x00001000]: can't claim; no address assigned
[  617.752871] pci 0031:01:00.6: BAR 0 [mem size 0x00001000]: can't claim; no address assigned
[  617.753467] pci 0031:01:00.7: BAR 0 [mem size 0x00001000]: can't claim; no address assigned
[  617.754039] pci 0031:00:00.0: disabling bridge window [io  0x0000-0xffffffffffffffff] to [bus 01] (unused)
[  617.754642] pci 0031:00:00.0: disabling bridge window [mem 0x00000000-0xffffffffffffffff 64bit pref] to [bus 01] (unused)
[  617.755257] pci 0031:01:00.0: BAR 0 [mem 0x620c080000000-0x620c080000fff]: assigned
[  617.755813] pci 0031:01:00.1: BAR 0 [mem 0x620c080010000-0x620c080010fff]: assigned
[  617.756195] pci 0031:01:00.2: BAR 0 [mem 0x620c080020000-0x620c080020fff]: assigned
[  617.756559] pci 0031:01:00.3: BAR 0 [mem 0x620c080030000-0x620c080030fff]: assigned
[  617.756923] pci 0031:01:00.4: BAR 0 [mem 0x620c080040000-0x620c080040fff]: assigned
[  617.757281] pci 0031:01:00.5: BAR 0 [mem 0x620c080050000-0x620c080050fff]: assigned
[  617.757635] pci 0031:01:00.6: BAR 0 [mem 0x620c080060000-0x620c080060fff]: assigned
[  617.757980] pci 0031:01:00.7: BAR 0 [mem 0x620c080070000-0x620c080070fff]: assigned
[  617.758332] pci 0031:00:00.0: PCI bridge to [bus 01]
[  617.758662] pci 0031:00:00.0:   bridge window [mem 0x620c080000000-0x620c0ffefffff]
[  617.759016] pci_bus 0031:01: Configuring PE for bus
[  617.759357] pci 0031:01     : [PE# fd] Secondary bus 0x0000000000000001 associated with PE#fd
[  617.759875] pci 0031:01:00.0: Configured PE#fd
[  617.760213] pci 0031:01     : [PE# fd] Setting up 32-bit TCE table at 0..80000000
[  617.762565] pci 0031:01     : [PE# fd] Setting up window#0 0..7ffffffffff pg=10000
[  617.763014] pci 0031:01     : [PE# fd] Enabling 64-bit DMA bypass
[  617.763631] pci 0031:01:00.0: Adding to iommu group 10
[  617.764218] pci 0031:01:00.0: enabling device (0140 -> 0142)
[  617.764735] pci 0031:01:00.1: Added to existing PE#fd
[  617.765064] pci 0031:01:00.1: Adding to iommu group 10
[  617.765483] pci 0031:01:00.1: enabling device (0140 -> 0142)
[  617.766003] pci 0031:01:00.2: Added to existing PE#fd
[  617.766331] pci 0031:01:00.2: Adding to iommu group 10
[  617.766764] pci 0031:01:00.2: enabling device (0140 -> 0142)
[  617.767179] pci 0031:01:00.3: Added to existing PE#fd
[  617.767517] pci 0031:01:00.3: Adding to iommu group 10
[  617.767932] pci 0031:01:00.3: enabling device (0140 -> 0142)
[  617.768339] pci 0031:01:00.4: Added to existing PE#fd
[  617.768655] pci 0031:01:00.4: Adding to iommu group 10
[  617.769068] pci 0031:01:00.4: enabling device (0140 -> 0142)
[  617.769468] pci 0031:01:00.5: Added to existing PE#fd
[  617.769768] pci 0031:01:00.5: Adding to iommu group 10
[  617.770176] pci 0031:01:00.5: enabling device (0140 -> 0142)
[  617.770623] pci 0031:01:00.6: Added to existing PE#fd
[  617.770921] pci 0031:01:00.6: Adding to iommu group 10
[  617.771321] pci 0031:01:00.6: enabling device (0140 -> 0142)
[  617.771729] pci 0031:01:00.7: Added to existing PE#fd
[  617.772014] pci 0031:01:00.7: Adding to iommu group 10
[  617.772451] pci 0031:01:00.7: enabling device (0140 -> 0142)


----- Original Message -----
> From: "Timothy Pearson" <tpearson@raptorengineeringinc.com>
> To: "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>
> Cc: "Ritesh Harjani" <ritesh.list@gmail.com>
> Sent: Friday, September 18, 2026 1:32:51 PM
> Subject: [BUG] PCIe passthrough of MCS9990 fails

> When passing through all eight PCIe functions of a MCS9990 PCIe USB
> multifunction 1.0/2.0 controller on a PowerNV POWER9 host using qemu, the guest
> fails to launch:
> 
> qemu-system-ppc64: -device vfio-pci,host=0031:01:00.1,bus=bridge-1,addr=00.1:
> vfio 0031:01:00.1: Failed to set up TRIGGER eventfd signaling for interrupt
> INTX-0: VFIO_DEVICE_SET_IRQS failure: Device or resource busy
> 
> If I instead pass through only one function, or only pass through odd functions
> (the EHCI controller set), I get the following errors in the guest:
> 
> [    0.886625] usb usb1: New USB device found, idVendor=1d6b, idProduct=0002,
> bcdDevice= 6.18
> [    0.886710] usb usb1: New USB device strings: Mfr=3, Product=2,
> SerialNumber=1
> [    0.886791] usb usb1: Product: EHCI Host Controller
> [    0.886845] usb usb1: Manufacturer: Linux 6.18.38 ehci_hcd
> [    0.886902] usb usb1: SerialNumber: 0000:01:00.0
> [    1.142469] usb 1-1: new high-speed USB device number 2 using ehci-pci
> [    6.530490] usb 1-1: device descriptor read/64, error -110
> [   22.147501] usb 1-1: device descriptor read/64, error -110
> [   22.371536] usb 1-1: new high-speed USB device number 3 using ehci-pci
> [   27.526896] usb 1-1: device descriptor read/64, error -110
> [   43.141934] usb 1-1: device descriptor read/64, error -110
> [   43.245985] usb usb1-port1: attempt power cycle
> [   43.638173] usb 1-1: new high-speed USB device number 4 using ehci-pci
> [   54.491254] usb 1-1: device not accepting address 4, error -110
> [   54.611274] usb 1-1: new high-speed USB device number 5 using ehci-pci
> 
> If I reboot the guest, SLOF fails as follows:
> 
> Scanning USB
>  EHCI: Initializing
> usb-ehci: reset failed
> usb-ehci: control transfer timed out_
> usb-ehci: unable to setup device on port 0
> 
> Note that this card works perfectly on the host kernel.

