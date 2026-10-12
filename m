Return-Path: <linuxppc-dev+bounces-29329-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6920FCA9ED0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 12 Oct 2026 20:13:33 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4j3TDq6wKGz30NF;
	Tue, 13 Oct 2026 07:13:31 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1791836011;
	cv=none; b=Kw52pWfrcxjkue0YCfF0mFkykIns5i5rJSMZevDxhOgMemtszwsWGK80sc9yHM4maPPFGIi8vhB6VFUwNxZH7JGcLSLWeyTr2zsAeKH3Vb2psYjRFLJlVamp74g0VRIKohGJ1Wyrzvv7yhh6gtZV59BLDqeaghQ5dt2JOfNiBku0johDEPBwR7q/BXNENRWitCPpeHr2A5aCedPYnnBo6zUPC8Z9wVqx3CCik6Z9ZLzHmSpO00rrekVqgCU2Cn+mD3Eywa65v5MqlDlmEGC1j6ekPNgxQfzo6O5S97i6jgmUl4v0b60HmMNxfVnRLC00YK+l7nSOvDJcaV5HuzKL+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1791836011; c=relaxed/relaxed;
	bh=ipfnvz0/kYIxjRDd3MrcP9WRjs1t+zUVD4kVE6VTnwU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=QSBc4O2/VRliAtQS+v8y875K2xvg5gHs64yb0dcMxXsvJ09vw90zpgGmyVWZmVuS+OActrgJAh32J4IaIrslJM7oYyWh2cKL3EgFMaQ8aQ5X5XqVdZzUJmrOXc/qpICaKt9mcPNVXSBvx02N0WbCo4Jc2NCQYBJlRTlwurTYh2H9dVJ/4R/wRuuccjVrYh8uw8V7us+4mBWpKv4LgfJNoBsYbVhh/dmiXsqz5KiPzoK8M2sNaXeJYZOWaXYhrkAN9kMOxvjh/Akhp1qsNjSjyU6ZGe4N7U6CuMrkiOHCtBt5hZauRe1YPBlEc1BP5v+NSZ13/zZ+NZDtp0OocCo3MA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyoLdGpv; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hyoLdGpv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4j3TDq0Shzz304Q
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2026 07:13:31 +1100 (AEDT)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4BC6240898;
	Mon, 12 Oct 2026 20:13:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F36091F0089B;
	Mon, 12 Oct 2026 20:13:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791836008;
	bh=ipfnvz0/kYIxjRDd3MrcP9WRjs1t+zUVD4kVE6VTnwU=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=hyoLdGpv1N7sGAm4AzcgqI1HFHbe9lWlVuA3Xsh44J4j5++B7nzx8MNFy6RYzr12C
	 iwqiQ0OvFbdYiGii4edVrqlWETtX6iGWSl8ifOtoJ3+n2j/P270LtV7sFm5BlcwvAk
	 dcMkM+/KPOaunj9hNmijb7wT/r6jNqgmKyTqNSvgPJ3i1NPFvzF7pENZhnXP+zYQPj
	 o346GIOlTfOzowVTN6JWDvHXWlge+N3ggnejNlJgqvW3ji4T4EvdtXpb9TkKr/L/d4
	 kT0EfCGjux5TZ3AoMUUe+51ASBBzIQgmJcWv8U1FRXNwF9LkyLM9JOzTw7UXyOS3QD
	 aavAHvs1d6AJg==
Date: Mon, 12 Oct 2026 15:13:26 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Perlow, Jason" <jperlow@gmail.com>
Cc: "To: Bjorn Helgaas" <bhelgaas@google.com>,
	Lukas Wunner <lukas@wunner.de>,
	Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
	Oliver O'Halloran <oohall@gmail.com>, linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Aditya Garg <aditya.garg@linux.dev>
Subject: Re: PCI/AER: MacBookPro16,1 test results with Apple SEP ANFE quirk
Message-ID: <20261012201326.GA1374572@bhelgaas>
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
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABZrw2H+3yt2Y7xiq6OyAWaJM7P9ox-2nJxoQuJMwoJHLgi+YQ@mail.gmail.com>

On Fri, Oct 09, 2026 at 11:38:50PM -0400, Perlow, Jason wrote:
> Bjorn, Lukas,
> 
> I have tested the Apple SEP ANFE quirk together with Lukas's false-alarm
> recovery fix on two MacBookPro16,1 systems. Both stayed up for over two
> hours after booting the candidate kernel. The patch is being prepared
> against pci/for-linus at 79c168e2aa957ed0054c93db17caba653b95e377.
> 
> The candidate retains eddba19b8b5f ("PCI/AER: Support Advisory Non-Fatal
> Errors"), adds 79c168e2aa95 ("PCI/AER: Skip error recovery on false
> alarms"), and leaves the ANFE mask unchanged only on the Apple T2 Secure
> Enclave Processor [106b:1802]. The global ANFE revert is absent from the
> test kernel. The per-device flag approach follows Aditya's earlier
> proposal, with an EARLY fixup so the flag is set before pci_aer_init().
> 
> The test systems are:
> 
>   MEDUSA:  MacBookPro16,1, Core i7-9750H
>   CHIMERA: MacBookPro16,1, Core i9-9980HK
> 
> Both ran 7.3.0-rc6-6-t2-edge-apple-sep-anfe-test, confirmed by uname and
> the kernel banner in each current boot journal. At the 23:24 EDT check
> on October 9, MEDUSA had 2 hours 22 minutes uptime and Chimera had
> 2 hours 21 minutes. Their boot IDs were unchanged from the initial
> successful candidate boots. graphical.target and the display manager
> were active on both, and neither had failed systemd units.
> 
> Read-only config-space checks gave the same results on both systems:
> 
>   Function                    Correctable error mask
>   Apple SEP, 04:00.2           0x00006000
>   Apple function, 04:00.0      0x00004000
>   Apple function, 04:00.1      0x00004000
>   AMD GPU, 03:00.0             0x00000000
> 
> ANFE bit 13 is therefore masked on the SEP and unmasked on the other
> observed functions. No config-register writes were used in these checks.
> The implementation matches vendor/device ID, not these bus addresses.
> 
> Neither candidate boot journal contains an AER/GHES report, kernel
> panic, oops, BUG or call trace. Neither recorded additional kernel
> messages after the initial 21:04 checks through the 23:24 check.
> 
> The earlier Wunner-only candidate booted on MEDUSA but then powered off,
> as I reported on October 8. Its retained journal ended before that event;
> there was no recorded shutdown sequence or panic. The cause of the power
> loss is still unknown, and this quirk does not establish a firmware
> mechanism. The combined candidate has not reproduced that symptom within
> the observed interval.
> 
> There are remaining boot warnings unrelated to the reported AER symptom:
> ACPI duplicate-table/method errors, AMD SDMA fence fallback warnings,
> HID rotation probe failures, and Broadcom P2P failures. Chimera also logs
> CPU 0 machine-check records in banks 12 and 13. These warning categories,
> including the same machine-check status/address records, appear in the
> previous boot logs. I am retaining them as separate follow-up issues.
> 
> This was a v7.3-rc6 test build with the existing T2 driver/patch stack,
> using Debian Forky GCC 16.2 and binutils 2.47. It was not a vanilla
> upstream kernel or an identical-toolchain comparison to the older GCC 14
> release image. Artifact checksums, exact source/provenance, config checks,
> t2gmux/t2smc builds and imported-symbol CRC checks passed. A generic
> KVM/OVMF boot also passed; the hardware observations above come from the
> two physical systems, not KVM.
> 
> The T2 team reports that [106b:1802] identifies the SEP across T2 models,
> but this report covers only these two MacBookPro16,1 machines. I have not
> tested other T2 models, power-off/cold-start, suspend/resume, reset, kexec
> or deliberate AER error injection. Physical confirmation of the rendered
> GUI is not included in this report; desktop service state was checked
> remotely. The existing release/rescue boot files were preserved.
> 
> The patch (enclosed) leaves other ANFE handling enabled and is idempotent
> across
> repeated fixup/AER initialization. Please review it as a targeted workaround
> for the MacBookPro16,1 regression, with the testing limits above.

Thanks for this!  Since you posted this before Aditya's essentially
identical patch
(https://lore.kernel.org/all/20261010172301.12764-1-aditya.garg@linux.dev/),
I used this one instead.  It's on pci/for-linus for v7.3.

