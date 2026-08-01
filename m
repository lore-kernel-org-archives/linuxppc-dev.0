Return-Path: <linuxppc-dev+bounces-25198-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6D3C55172
	for <linuxppc-dev@archiver.kernel.org>; Sat,  1 Aug 2026 13:32:27 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hC3lF2xcRz2yfD;
	Sat, 01 Aug 2026 23:32:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1785591145;
	cv=none; b=Q1Q7LQj8HkS6SRtcADc9N0wVfr+kJZGeaNbpyqmaX8pilBWtukOFYZ/e5hFZOGEXebozERvU68AaKUMU6OC/SA3f/0FD5HdA1ccbeoOIc7zzI74O4o/I4n0pY2OIT2/MDrUjthLlLmqvZp4cc7HRDnZWUu2rgRgfgwGNEUVLSXfjVQRjrOmhc4Cak1TA8mqZGz6nCxOATmWe7wxGoq2xFQInFNItKVqeltyQmhDBLlM7TKGO1q0HeRD8mCzcBIGKeX+7tnY2NSBbww7JxSI8p4wob2MlE1JJg6VTH55Y6nPavgjbkGaJLxlhER7GZ1TFMv3OYif7QWEU1uDXLAm0kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1785591145; c=relaxed/relaxed;
	bh=PhOFKGpbH1WhPH9M8N+VXUAAGjU21nz1ZuJtM9V2zVY=;
	h=From:To:Subject:In-Reply-To:Date:Message-ID:References; b=Rh/2mnqyjTxHpLfV5wj7mE/OnNPr39PzDIRz2OJUmZ8DhqUG750UB5HQ0MAx1mQ0KatZSv/brfm6tSnaz69y4Iu+rCKefHRWixSQEpulRBrEyITzIRxKKcC8sbKn4j17j9DEg2w/+T6SPo3lEacxgatwPodSPPeYq0m2dql8MdgnBGkmJb1tqy/0gq9gHy9W7o7nbRHHIJYeFWTdMUOsj3K8CpJRG7eRY6jncxULuv5qfAefgksFWFN/3croqAB3kqLEdNcLTF7UIhicFabfCz+C3cG29+D2ivnolo8BqTUYnsfeA/weB7mgAV/SQliNGHHxTDrvdKamNodx4RMWSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PHmb+01R; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=PHmb+01R;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=ritesh.list@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hC3lC6zMJz2yFg
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 23:32:22 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2d032846c95so21726555ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 01 Aug 2026 06:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785591139; x=1786195939; darn=lists.ozlabs.org;
        h=references:message-id:date:in-reply-to:subject:to:from:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=PhOFKGpbH1WhPH9M8N+VXUAAGjU21nz1ZuJtM9V2zVY=;
        b=PHmb+01RQFhH0sGXNb12U+WD2nNC4OMQY3lG2Bnp7qz5hm/dZr8MmQp3Ay6gHCNvZV
         5mTps9HXIvKDE7qD7YFWK36aKaaDDghxUnypuModPcO+NIqmVUF3I5h7kBxAQOqENp0I
         /feE24c63POV4VhsBmFuWs3CH1DEuOxl5HgvW5wF176IVp7QGBEk7Y8AFU+3Mh7rGt8P
         j2XEawUj4tXXgirO8SjqhTARoBP0Wbj6P5+VZ/uvAzeMgWbvCIJOmSDOiZBRVqg0kP1U
         nULuq2hl6jNZNoltMnW7tQZwLOzljUpzb/Fd7FpscnFe4IiAt+0BEaHiBc0dpxZn9bHu
         febQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785591139; x=1786195939;
        h=references:message-id:date:in-reply-to:subject:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PhOFKGpbH1WhPH9M8N+VXUAAGjU21nz1ZuJtM9V2zVY=;
        b=bqA8vUhJbjwbvaUdlf5iMz4GQL42FVYfjJaxMckDxWa/U09tYxvoM+j2SB81s9jiau
         pOul/krAjB8e4SGjAJSDo5s6ze8/Tt6LkokEQHYcxgayerM+oxhje8HZnNruPEw8tdyQ
         i59+DhSOqxbcOSGTqtqodDBSmaBYI5F79Gci0zMDBKZVtrbQKUBTWIIVedvKkL6oI2WD
         /kke9JNWzTLpbZ3s9LQPEOha6l0PTK8ULArDZXAliYTUc/fbdrtOf/sHvUxaAqkLSV+c
         5+Y+a1+Q5zjvXuIIunuItPBAD8LFQ/HQOPJyG3fXBlaqLS6+Rh92DM3jGD37rvxObC5d
         Aozg==
X-Forwarded-Encrypted: i=1; AHgh+RqqZj1U842l7F1SIiDd8UkaFUghIkpwbvpaFbLlL5wU84PAYCmzn7N9lfZlg8ID2S7x00jTQTWJUFpO+GE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyJmZnZoOm0f7nwqdo4jgQe2ian+lBQ3dsv47rWE073azoxSH4u
	coQhK9Q3KWhzbcDlnJ+/csvMDic402+Kt61DiYCcPHaGqr303kfXy6nSknaYGA==
X-Gm-Gg: AR+sD10Mnr8pJWQdVJXFefyV5pdfUOUQmwNXH9gqoPQR6uidRIrsIa1pXcrMSQRyL+5
	Lnt4kQXUSYSGY+KVnoORwWA4HOAbVwq0MxLE85mmUtdYBhCKDITtOmfbHY0hlqPqqyFZQNs2BvL
	8/QCotnHARxrAh9vKZW8e5wm2/qk/WH1b54+S1E/f/3ZuIJNGc7dtB6+8lncPSYz2OmoeIJ2Gu1
	Z/nk2uHYTmyhNRY9mgOLHTzQfW0QfqaR83ebFQGyQwUfC++EV+WWi0myRqEJgMboOF0Su6h/sN9
	4+XHAKB4s02eiyINFNIZdfWDx4igTFgI5Jd6uI+N9W6FPIHPM/sbNSrSEhgSXpBhkQQNfpUwr/K
	vTaAoKXjVbMwCuelJuDwCK1lvwLNwfPGnskWjphFU2AmMFl93ZaIedOWxs28T41Dpr5CriDK8DS
	CB8TotVdjWp3M+EDOb4f8DRHh2YtbEU/zjFhZ784/gMsKTBw32fermjXvmAG4=
X-Received: by 2002:a05:6a20:728e:b0:3c3:8bab:804 with SMTP id adf61e73a8af0-3c92a8119aamr3484369637.49.1785591139232;
        Sat, 01 Aug 2026 06:32:19 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e04456dsm15889822eec.14.2026.08.01.06.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 06:32:18 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Paul Klapperich <paul.klapperich@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [Regression] PowerNV: JMicron JMB58x AHCI 32-bit DMA fallback triggers EEH freeze on 7.x kernels
In-Reply-To: <CADyY0-5M0+N1u45RVZN3Tf52iKaXcvKeUaqgdw-wP1B_4zuA0w@mail.gmail.com>
Date: Sat, 01 Aug 2026 18:35:26 +0530
Message-ID: <4ihem1nt.ritesh.list@gmail.com>
References: <CADyY0-5M0+N1u45RVZN3Tf52iKaXcvKeUaqgdw-wP1B_4zuA0w@mail.gmail.com>
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


Hi Paul,

Paul Klapperich <paul.klapperich@gmail.com> writes:

> Hi everyone,
>
> I am encountering a reproducible PCIe/EEH regression on a PowerNV
> platform (Talos II, POWER9) when moving from kernel 6.18.x to the
> 7.1.x series.
>
> Hardware Context:
>
> Platform: Raptor Computing Systems Talos II (PowerNV, POWER9)
>
> Storage Controller: 0001:01:00.0 SATA controller: JMicron Technology
> Corp. JMB58x AHCI SATA controller (direct root port, no PLX bridge)
>
> The Issue: On mainline/Arch POWER kernel 7.1.4, the kernel's
> enforcement of a 32-bit DMA mask (AHCI_HFLAG_32BIT_ONLY) on the JMB58x
> controller appears to be causing a low-memory translation failure
> during early initialization. This immediately trips the PowerNV Host
> Bridge (PHB) into an Enhanced Error Handling (EEH) frozen state and
> locks up the bus.
>
> Conversely, booting the exact same hardware setup with a 6.18.7 kernel
> succeeds completely, as it negotiates the 64-bit DMA window without
> triggering the platform translation fault.
>
> Boot Log Contrast:
>
> Under working 6.18.7 kernel:
>
> # dmesg | grep -iE "ahci|eeh"

1. Could you please attach and share the full dmesg (with no grep
   filtering) for both 6.18.7 (working kernel) and 7.1.4 (non-working
   kernel) along with their respective .config files. That should
   clarify few other things.

2. cat /sys/firmware/opal/msglog
   From both the kernels (after bootup and possibly after an EEH error
   has occurred at-least once on the non-working kernel)

-ritesh


> [    0.211910] EEH: PowerNV platform initialized
> [    0.391733] EEH: Capable adapter found: recovery enabled.
> [    2.192909] ahci 0001:01:00.0: enabling device (0540 -> 0542)
> [    2.193223] ahci 0001:01:00.0: SSS flag set, parallel bus scan disabled
> [    2.193264] ahci 0001:01:00.0: AHCI vers 0001.0301, 32 command
> slots, 6 Gbps, SATA mode
> [    2.193270] ahci 0001:01:00.0: 5/5 ports implemented (port mask 0x1f)
> [    2.193275] ahci 0001:01:00.0: flags: 64bit ncq sntf stag pm led
> clo pmp fbs pio slum part ccc apst boh
> [    2.196895] scsi host0: ahci
> [    2.197276] scsi host1: ahci
> [    2.198768] scsi host2: ahci
> [    2.199068] scsi host3: ahci
> [    2.199995] scsi host4: ahci
>
> Under broken 7.1.4 kernel:
>
>  # dmesg | grep -iE "ahci|eeh"
>  [    3.298353] EEH: PowerNV platform initialized
>  [    3.460692] EEH: Capable adapter found: recovery enabled.
>  [    4.510396] ahci 0001:01:00.0: enabling device (0540 -> 0542)
>  [    4.510428] ahci 0001:01:00.0: controller can't do 64bit DMA, forcing 32bit
>  [    4.510691] ahci 0001:01:00.0: SSS flag set, parallel bus scan disabled
>  [    4.510735] ahci 0001:01:00.0: AHCI vers 0001.0301, 32 command
> slots, 6 Gbps, SATA mode
>  [    4.510742] ahci 0001:01:00.0: 5/5 ports implemented (port mask 0x1f)
>  [    4.510747] ahci 0001:01:00.0: flags: ncq sntf stag pm led clo pmp
> fbs pio slum part ccc apst boh
>  [    4.512167] scsi host0: ahci
>  [    4.512556] scsi host1: ahci
>  [    4.512831] scsi host2: ahci
>  [    4.513076] scsi host3: ahci
>  [    4.513466] scsi host4: ahci
>  [    4.824011] EEH: Recovering PHB#1-PE#fd
>  [    4.824019] EEH: PE location: UOPWR.A100019-Node0-CPU1 Slot1 (8x),
> PHB location: N/A
>  [    4.824023] EEH: Frozen PHB#1-PE#fd detected
>  [    4.824025] EEH: Call Trace:
>  [    4.824027] EEH: [000000007ad80bda] __eeh_send_failure_event+0x68/0x140
>  [    4.824038] EEH: [0000000042fa5ce7] eeh_dev_check_failure.part.0+0x280/0x6d0
>  [    4.824044] EEH: [00000000ca5dc769] ioread32+0xd0/0x190
>  [    4.824051] EEH: [000000000ad730be] ata_wait_register+0xa4/0x108 [libata]
>  [    4.824064] EEH: [000000007fb91492]
> ahci_exec_polled_cmd.constprop.0+0x104/0x210 [libahci]
>  [    4.824070] EEH: [0000000063044e17] ahci_do_softreset+0x140/0x380 [libahci]
>  [    4.824074] EEH: [00000000d97bc211]
> ata_do_reset.constprop.0+0xbc/0xf0 [libata]
>  [    4.824084] EEH: [0000000093546eba] ata_eh_reset+0xb14/0x12d0 [libata]
>  [    4.824094] EEH: [00000000b2341f96] ata_eh_recover+0x3f0/0x1580 [libata]
>  [    4.824102] EEH: [00000000bbcd8f21]
> sata_pmp_error_handler+0x388/0xb90 [libata]
>  [    4.824109] EEH: [00000000b87225ad] ahci_error_handler+0x6c/0x100 [libahci]
>  [    4.824114] EEH: [00000000eda810ea]
> ata_scsi_port_error_handler+0x4a8/0x9a0 [libata]
>  [    4.824123] EEH: [0000000006f6b52d] ata_scsi_error+0xc0/0x130 [libata]
>  [    4.824131] EEH: [000000002528ea40] scsi_error_handler+0x11c/0x760
> [scsi_mod]
>  [    4.824142] EEH: [000000005ba0d15d] kthread+0x17c/0x190
>  [    4.824148] EEH: [0000000067c7c775] start_kernel_thread+0x14/0x18
>  [    4.824153] EEH: This PCI device has failed 1 times in the last
> hour and will be permanently disabled after 5 failures.
>  [    4.824156] EEH: Notify device drivers to shutdown
>  [    4.824159] EEH: Beginning: 'error_detected(IO frozen)'
>  [    4.824162] PCI 0001:01:00.0#00fd: EEH: driver not EEH aware
>  [    4.824165] EEH: Finished:'error_detected(IO frozen)' with
> aggregate recovery state:'none'
>  [    4.824170] EEH: Collect temporary log
>  [    4.824198] EEH: of node=0001:01:00.0
>  [    4.824203] EEH: PCI device/vendor: 0585197b
>  [    4.824207] EEH: PCI cmd/status register: 00100546
>  [    4.824209] EEH: PCI-E capabilities and status follow:
>  [    4.824220] EEH: PCI-E 00: 00120010 10008102 0000285e 0041a023
>  [    4.824230] EEH: PCI-E 10: 00230008 00000000 00000000 00000000
>  [    4.824232] EEH: PCI-E 20: 00000000
>  [    4.824234] EEH: PCI-E AER capability register set follows:
>  [    4.824245] EEH: PCI-E AER 00: 15020001 00000000 00400000 00462030
>  [    4.824254] EEH: PCI-E AER 10: 00000000 0000e000 000001e0 00000000
>  [    4.824275] EEH: PCI-E AER 20: 00000000 00000000 00000000 00000000
>  [    4.824279] EEH: PCI-E AER 30: 00000000 00000000
>  [    4.824313] EEH: Reset with hotplug activity
>  [   14.513778] ahci 0001:01:00.0: AHCI controller unavailable!
>  [   14.513794] ahci 0001:01:00.0: AHCI controller unavailable!
>  [   15.561995] ahci 0001:01:00.0: AHCI controller unavailable!
>  [   15.591811] ahci 0001:01:00.0: AHCI controller unavailable!
>  [   15.591821] ahci 0001:01:00.0: AHCI controller unavailable!
>  [   15.591828] ahci 0001:01:00.0: AHCI controller unavailable!
>  [   15.591834] ahci 0001:01:00.0: AHCI controller unavailable!
>  [   15.591840] ahci 0001:01:00.0: AHCI controller unavailable!
>  [   20.592398] EEH: Sleep 5s ahead of complete hotplug
>  [   26.110843] ahci 0001:01:00.0: enabling device (0140 -> 0142)
>  [   26.110876] ahci 0001:01:00.0: controller can't do 64bit DMA, forcing 32bit
>  [   26.111136] ahci 0001:01:00.0: SSS flag set, parallel bus scan disabled
>
> this repeats until the device is disabled after 5 resets.
>
> Confirmation:
> I built 7.1.4 after reverting commit 105c4256 "ata: ahci: force 32-bit
> DMA for JMicron JMB582/JMB585" and boot completed successfully with an
> apparently working JMB585 sata controller.
>
> Conclusion:
> It appears that the recent JMicron 32-bit DMA workaround interacts
> poorly with PowerNV. Is there anything a user might do to work around
> this issue without reverting 105c4256?
>
> Let me know what additional information would be helpful.
>
> Thanks,
> Paul

