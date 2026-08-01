Return-Path: <linuxppc-dev+bounces-25192-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3C97C5516F
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Aug 2026 03:14:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hBp2Q0W9Vz2yT0;
	Sat, 01 Aug 2026 13:14:38 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=pass smtp.remote-ip="2607:f8b0:4864:20::1034" arc.chain=google.com
ARC-Seal: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785554077;
	cv=pass; b=bvxmWR+ShFkZa3mxiJ+19WGVPKw4iaotYIIE32IM5cu/hYNxj0cU7rfcKv64C3cv6rIoWs7bLu7V1UxoiE73frCmk3RYljrGZPireFSwsWRzHcO0BeWdoS6VjTrDL2G1s8pTFwF40uAB7Wpx2Jzji+rGdipLCfXv+3aY/twoYVz+EXq72A8B5fwGO4cK+4Vqu4xiqS6lw0szCFNnx9OuWXjPSrDI7puLPU6XPrBNoQfvnN2T2gKfN5TPcvXvjENSXKyvmAQD3/sJ2IrrkZJFD2CfPai2PK/ADprq0TYYaSuFRee51F3GICANjkydAHlyQR8fBqIcazHWQv7VyfxvhQ==
ARC-Message-Signature: i=2; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785554077; c=relaxed/relaxed;
	bh=+rw6YPJ50RjL1GovCOCPdzvw3GYvtNLIB8As8xxkSu0=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=VGb3KpBOz0fEUesJPuIn+P/OC//O6t/7dunL86FBYAinjuCyCKdq56Fmb0RGMRh3OQyxDGN446zqOmbyBJ6UhKuj50sln97QX3d+8/hcIriRYuJQK9263HewPxfdpNJvXHSAEZgNI2FfrylLx+iWPxZfGehUApp0usB9LEiVRigCLD2K7aRtiumRbW1QQuW6Rknb04vKFJcia3pJwtxBVjVd61Ot+n7PEYtE6ohSgy6qN1mqH6HVozIyel6kTIJiHk3i+YeC7flErO8pl82g9aws9nlCJZVidpubKeFXZDsJBMGYZqv6k7E5+kuJRYxMxl7T7B11noUipAsNE/FB3A==
ARC-Authentication-Results: i=2; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I7SEDaF1; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=bobpaul@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=I7SEDaF1;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=bobpaul@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hBp2N3kXSz2ySN
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 13:14:35 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so1278542a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jul 2026 20:14:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785554071; cv=none;
        d=google.com; s=arc-20260327;
        b=mJakFG7JPnJuaSDPiH2aMASDCH49RN1AKt43Ct8TrRRXvzlmeJUsc1sGinVXDSy+jk
         8NoyJo8Sss2vGWlkrDIcA/GGUnzVj0wB1kpbR6043hHi3y048fxMDU7a+UEIXY1awmGX
         M3qlsYqXVMeXHMLJ90cvKzocRqbCrUo8rby6NOjqpzrrhK8/RW1RmkbxfaTHLQGiESyF
         vDa8gGsr4iFdwBTIDjyextqtxExfsJoUUDTq84fqszI0JSBOiKant9/puFaHtfT42PWM
         Md1p/SvYqHVpOPDWyXASbNxfqMyLCx74BPrEi/uMdAwmCNwUMegrJqiDWbsYleIS1aMd
         CFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=+rw6YPJ50RjL1GovCOCPdzvw3GYvtNLIB8As8xxkSu0=;
        fh=1yUgcW/WJkBKu7j68UptqTJxr17CwW+Jd/xTap6TLsU=;
        b=dUy/4tMUxClhVb0mU/jCvnDuiEVBv/TaU/SmcklN6y+zkX/zBLM7ZZq5SrX2/nZnTA
         2WDkTu/8/mYUny+DTHmurGxMO5zCsqK+HzgSdsIgM/Ftrb6uFjSG+p6qAH6/s06XuW6Y
         m+LBNVTP+Yl4eoMuu+2pFHnmSyskEq/5HLsN/fT54+5YIfljyRIMc8tZ46QQ7cnQJTDQ
         unQrhtmrZKY10iSW5KM4f7CSzOTejhe66EXtb+iwHXGvjR7SNSb260Sj0HqBuo/PTpSl
         VYhZ4VNPwN0lMLbwZgFlk835YAf2UQ2YVO8pAySBr8T8PgckeQfKnU+50rsnooTcp/c3
         TZPQ==;
        darn=lists.ozlabs.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785554071; x=1786158871; darn=lists.ozlabs.org;
        h=content-type:to:subject:message-id:date:from:mime-version:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=+rw6YPJ50RjL1GovCOCPdzvw3GYvtNLIB8As8xxkSu0=;
        b=I7SEDaF1wVC4EayKxPPLaXMPI7mtCDdZLIXu7HLOn0YOYdtKb1mmdGEGEMRqEVUeOs
         fdLAeEXTsfi2sl6mAzohhEkE24u5Ka8J70n0KyojEmz23iCf/NbmYNBPK/fO2HMzYBno
         fPv2mAxLTOgXDavDNwRBAxuFWiPg4nEp9cJQDsOQmYzJLvRBLKsmN7YIW7t6A/elAVyx
         udntQ/NjtU9fimwUeRw6QVz/1qlaOqqOGkJj5S91L6FieQHvkfVxBGo759Iwi8CHOXex
         b2CrqVO0LlyEl82Jnz++Icu5chKWyiuqa5s//GkDCtMRcX6P3JLX5RDpIrUlTeIZVmL3
         tPUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785554071; x=1786158871;
        h=content-type:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+rw6YPJ50RjL1GovCOCPdzvw3GYvtNLIB8As8xxkSu0=;
        b=Q79R+2+NcnEj17ewi03zew83K3smLWvgG1DrDkCNmQZelStno9+18eHpGg1RrbNhex
         dNNJrpyik/EVC1H91XHI/WGr9b4z9WtTBVXZhdBKVwpIrvPJL42l7MoULtusdi7AeJMC
         WNTAJe1c5gj598D26em2uQHWZF7aeU9f5Ez5E/UY53nkzhwVI6jnO/FgxNfs62/C9Cev
         y8TbN5pOaAO73YUmxMKjAOzMsYAUYP4RHAeT5nuGrkJxDrCwrXgY+/KBa2yY55iQ7vaa
         aO/utvAe+T6qYNlx1rtqVuCq1k3/zHmjLA8OR2BZArPhR0v/c5LezTarSy09kmx1EazD
         emGQ==
X-Gm-Message-State: AOJu0YwuW9vTSmIWAzT8w/DGpNG5lqtpTM70lHA43KoAfJlmQm5ftTO9
	DaljQw97la/OSz5oBxhPQRZdkyQdRVM8yKMWFsd5w7ryMhmVD8BJIuW38COwWVvBxwJQDtCT4eU
	o9OvxjuWpXv5WgaM5x7Q+fYMKAWMDeJhUjqEV
X-Gm-Gg: AR+sD11TC5HaYkiK8ShJktucCc5MHOaZZ97raGO+JfVMobHo2Qo1zLAI2B+PrwSEj8U
	yJztkqqEgQrJlUZbmNB/zmFgoxJ+RDyJGnxc0ts+WkIfogxLosGTUz8IM64sgsfu7n/htR7ciQR
	6nNZA+tQ61zODejFFXbg2mZ5GFxUqudmIQOiZzKzruUHBpOPX/FZG3b5gO5W1fs8wrQZU2N/sk+
	zAr1fVLi2ZCbZekeQ4MlqKd2HbhkqACpcQr2jkP5abfcAaLO88nsWHPOuZgcJwGL4Rjvw7/Xp5Y
	tX3gbG3N7uM3mMGR8i7xjLxdBjA1BPDQFFlOLNehmN2Icb9KklVfjpLt7OHMD2x2aGjtDDxFDBx
	0GOyqIkutlnD0N2h+yleM6iei+NNsMoA=
X-Received: by 2002:a17:90b:2d50:b0:38e:7d77:2fbb with SMTP id
 98e67ed59e1d1-38fbc51c198mr1960151a91.32.1785554071080; Fri, 31 Jul 2026
 20:14:31 -0700 (PDT)
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
From: Paul Klapperich <paul.klapperich@gmail.com>
Date: Fri, 31 Jul 2026 22:14:18 -0500
X-Gm-Features: AUfX_mz8P9aNP0I0UExdSIbZD6IRnHcfSQwQF1T3Xjo_b_QWHy10ZLZgJ1aUi0I
Message-ID: <CADyY0-5M0+N1u45RVZN3Tf52iKaXcvKeUaqgdw-wP1B_4zuA0w@mail.gmail.com>
Subject: [Regression] PowerNV: JMicron JMB58x AHCI 32-bit DMA fallback
 triggers EEH freeze on 7.x kernels
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"

Hi everyone,

I am encountering a reproducible PCIe/EEH regression on a PowerNV
platform (Talos II, POWER9) when moving from kernel 6.18.x to the
7.1.x series.

Hardware Context:

Platform: Raptor Computing Systems Talos II (PowerNV, POWER9)

Storage Controller: 0001:01:00.0 SATA controller: JMicron Technology
Corp. JMB58x AHCI SATA controller (direct root port, no PLX bridge)

The Issue: On mainline/Arch POWER kernel 7.1.4, the kernel's
enforcement of a 32-bit DMA mask (AHCI_HFLAG_32BIT_ONLY) on the JMB58x
controller appears to be causing a low-memory translation failure
during early initialization. This immediately trips the PowerNV Host
Bridge (PHB) into an Enhanced Error Handling (EEH) frozen state and
locks up the bus.

Conversely, booting the exact same hardware setup with a 6.18.7 kernel
succeeds completely, as it negotiates the 64-bit DMA window without
triggering the platform translation fault.

Boot Log Contrast:

Under working 6.18.7 kernel:

# dmesg | grep -iE "ahci|eeh"
[    0.211910] EEH: PowerNV platform initialized
[    0.391733] EEH: Capable adapter found: recovery enabled.
[    2.192909] ahci 0001:01:00.0: enabling device (0540 -> 0542)
[    2.193223] ahci 0001:01:00.0: SSS flag set, parallel bus scan disabled
[    2.193264] ahci 0001:01:00.0: AHCI vers 0001.0301, 32 command
slots, 6 Gbps, SATA mode
[    2.193270] ahci 0001:01:00.0: 5/5 ports implemented (port mask 0x1f)
[    2.193275] ahci 0001:01:00.0: flags: 64bit ncq sntf stag pm led
clo pmp fbs pio slum part ccc apst boh
[    2.196895] scsi host0: ahci
[    2.197276] scsi host1: ahci
[    2.198768] scsi host2: ahci
[    2.199068] scsi host3: ahci
[    2.199995] scsi host4: ahci

Under broken 7.1.4 kernel:

 # dmesg | grep -iE "ahci|eeh"
 [    3.298353] EEH: PowerNV platform initialized
 [    3.460692] EEH: Capable adapter found: recovery enabled.
 [    4.510396] ahci 0001:01:00.0: enabling device (0540 -> 0542)
 [    4.510428] ahci 0001:01:00.0: controller can't do 64bit DMA, forcing 32bit
 [    4.510691] ahci 0001:01:00.0: SSS flag set, parallel bus scan disabled
 [    4.510735] ahci 0001:01:00.0: AHCI vers 0001.0301, 32 command
slots, 6 Gbps, SATA mode
 [    4.510742] ahci 0001:01:00.0: 5/5 ports implemented (port mask 0x1f)
 [    4.510747] ahci 0001:01:00.0: flags: ncq sntf stag pm led clo pmp
fbs pio slum part ccc apst boh
 [    4.512167] scsi host0: ahci
 [    4.512556] scsi host1: ahci
 [    4.512831] scsi host2: ahci
 [    4.513076] scsi host3: ahci
 [    4.513466] scsi host4: ahci
 [    4.824011] EEH: Recovering PHB#1-PE#fd
 [    4.824019] EEH: PE location: UOPWR.A100019-Node0-CPU1 Slot1 (8x),
PHB location: N/A
 [    4.824023] EEH: Frozen PHB#1-PE#fd detected
 [    4.824025] EEH: Call Trace:
 [    4.824027] EEH: [000000007ad80bda] __eeh_send_failure_event+0x68/0x140
 [    4.824038] EEH: [0000000042fa5ce7] eeh_dev_check_failure.part.0+0x280/0x6d0
 [    4.824044] EEH: [00000000ca5dc769] ioread32+0xd0/0x190
 [    4.824051] EEH: [000000000ad730be] ata_wait_register+0xa4/0x108 [libata]
 [    4.824064] EEH: [000000007fb91492]
ahci_exec_polled_cmd.constprop.0+0x104/0x210 [libahci]
 [    4.824070] EEH: [0000000063044e17] ahci_do_softreset+0x140/0x380 [libahci]
 [    4.824074] EEH: [00000000d97bc211]
ata_do_reset.constprop.0+0xbc/0xf0 [libata]
 [    4.824084] EEH: [0000000093546eba] ata_eh_reset+0xb14/0x12d0 [libata]
 [    4.824094] EEH: [00000000b2341f96] ata_eh_recover+0x3f0/0x1580 [libata]
 [    4.824102] EEH: [00000000bbcd8f21]
sata_pmp_error_handler+0x388/0xb90 [libata]
 [    4.824109] EEH: [00000000b87225ad] ahci_error_handler+0x6c/0x100 [libahci]
 [    4.824114] EEH: [00000000eda810ea]
ata_scsi_port_error_handler+0x4a8/0x9a0 [libata]
 [    4.824123] EEH: [0000000006f6b52d] ata_scsi_error+0xc0/0x130 [libata]
 [    4.824131] EEH: [000000002528ea40] scsi_error_handler+0x11c/0x760
[scsi_mod]
 [    4.824142] EEH: [000000005ba0d15d] kthread+0x17c/0x190
 [    4.824148] EEH: [0000000067c7c775] start_kernel_thread+0x14/0x18
 [    4.824153] EEH: This PCI device has failed 1 times in the last
hour and will be permanently disabled after 5 failures.
 [    4.824156] EEH: Notify device drivers to shutdown
 [    4.824159] EEH: Beginning: 'error_detected(IO frozen)'
 [    4.824162] PCI 0001:01:00.0#00fd: EEH: driver not EEH aware
 [    4.824165] EEH: Finished:'error_detected(IO frozen)' with
aggregate recovery state:'none'
 [    4.824170] EEH: Collect temporary log
 [    4.824198] EEH: of node=0001:01:00.0
 [    4.824203] EEH: PCI device/vendor: 0585197b
 [    4.824207] EEH: PCI cmd/status register: 00100546
 [    4.824209] EEH: PCI-E capabilities and status follow:
 [    4.824220] EEH: PCI-E 00: 00120010 10008102 0000285e 0041a023
 [    4.824230] EEH: PCI-E 10: 00230008 00000000 00000000 00000000
 [    4.824232] EEH: PCI-E 20: 00000000
 [    4.824234] EEH: PCI-E AER capability register set follows:
 [    4.824245] EEH: PCI-E AER 00: 15020001 00000000 00400000 00462030
 [    4.824254] EEH: PCI-E AER 10: 00000000 0000e000 000001e0 00000000
 [    4.824275] EEH: PCI-E AER 20: 00000000 00000000 00000000 00000000
 [    4.824279] EEH: PCI-E AER 30: 00000000 00000000
 [    4.824313] EEH: Reset with hotplug activity
 [   14.513778] ahci 0001:01:00.0: AHCI controller unavailable!
 [   14.513794] ahci 0001:01:00.0: AHCI controller unavailable!
 [   15.561995] ahci 0001:01:00.0: AHCI controller unavailable!
 [   15.591811] ahci 0001:01:00.0: AHCI controller unavailable!
 [   15.591821] ahci 0001:01:00.0: AHCI controller unavailable!
 [   15.591828] ahci 0001:01:00.0: AHCI controller unavailable!
 [   15.591834] ahci 0001:01:00.0: AHCI controller unavailable!
 [   15.591840] ahci 0001:01:00.0: AHCI controller unavailable!
 [   20.592398] EEH: Sleep 5s ahead of complete hotplug
 [   26.110843] ahci 0001:01:00.0: enabling device (0140 -> 0142)
 [   26.110876] ahci 0001:01:00.0: controller can't do 64bit DMA, forcing 32bit
 [   26.111136] ahci 0001:01:00.0: SSS flag set, parallel bus scan disabled

this repeats until the device is disabled after 5 resets.

Confirmation:
I built 7.1.4 after reverting commit 105c4256 "ata: ahci: force 32-bit
DMA for JMicron JMB582/JMB585" and boot completed successfully with an
apparently working JMB585 sata controller.

Conclusion:
It appears that the recent JMicron 32-bit DMA workaround interacts
poorly with PowerNV. Is there anything a user might do to work around
this issue without reverting 105c4256?

Let me know what additional information would be helpful.

Thanks,
Paul

