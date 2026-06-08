Return-Path: <linuxppc-dev+bounces-22273-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D39CD8C9D
	for <linuxppc-dev@archiver.kernel.org>; Mon,  8 Jun 2026 15:39:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gYx7F2mTWz2ytj;
	Tue, 09 Jun 2026 01:39:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1780933193;
	cv=none; b=UAJwyavOJ9CI0Kz3HRzbOaCI2yeIpPUHUaOFCy4PhZF/snCJHCJNiaUjeMKorZufeYuFd0fgvgclECVw02EWsERSaOqbxvna+5F7DnP309c+MI38E/I1VSOivUKmtXVPEy4QlKg9IKrqT9Y8enykxKPAtrZz+0HXoZMFjDJz2BOd5PMBIwCIn2n4ketI+qQqAVMs+ga4Q1hcM0ye8XEhCAZHAQ/lANQCvdj4rROZStMqSwaVWpiprCH4gyx9bynNpiY3eSyLaboa9uTDQ5ey94J+ZDGHsKDuFsv/jhVttLNYfcbc5u8V7MKIdbMdXC5Q1rKmN/ya75E72dEtRz7IXA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1780933193; c=relaxed/relaxed;
	bh=N3oy4xmq4C4ND1356+b9YpxpOAFUgRGxgZuuCWGlALs=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=g0pNJGx15LrwOE7wwy4E2hm/n5olmF4Rg5aO4ptB338NkrdvZGVOMvSJiB8MAw0rmZPcqO7LkSkKEHLUxhmE8dOgVcLKsjUaVI1f6d0AmBKnDGEbYNFo6QMqYRJOQ4N2J/4icIQiPeJO/XTr1BBuve8l0tc8+RKaN9CGpWDGPrL+M6W1g1C4B5Wj4mvlsxxEaQY28/HIP6/pg4x3c6DKGMZlDvLZCh94UON2dcB64Cbqi6KM3JUID0VRERwcVeRejIZ8CXv8CIvOdgFZkpIsX1QfFuh2nsJVOO8xweGUowpyFECbUoHrFWqshuBWUeodA9VsUfBvPllpP3Yp7XzOJA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASw9aDWd; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ASw9aDWd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=helgaas@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4gYx7D1k4sz2ytV
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Jun 2026 01:39:52 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with UTF8SMTP id AFA4543BDF;
	Mon,  8 Jun 2026 15:39:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 5FC471F00893;
	Mon,  8 Jun 2026 15:39:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780933189;
	bh=N3oy4xmq4C4ND1356+b9YpxpOAFUgRGxgZuuCWGlALs=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=ASw9aDWdRcO7+VnSW2ORQGoUq5sR68vKzzC5eSwoopKcdBsNabRop9c+64TT3Q8q1
	 OZCkT82Xu3lHjUeb11mlsrsVw/S45chKYAyMTNAUji+8Avn2GqonWR3Sdt9keDJ9K3
	 Rp0phRCU8VvKmlicMoRxl//sXnhu7b5+p/bD8/F2m/nbRZIRLOPxtHG86//XU8uEBv
	 oBf1QOqvaL4iOZWjBEpnxN48WixHqyPmOeujDfNFZPGzT+snWhA7HvTTN2EI1eSAbS
	 eJ4DEznL5qblmRj9QvlrobqcL8e2eADX0spcyGJpnwwD3I9K2Nmb4P0g8f8+9PXLib
	 ve9A0Eri3Z+Yg==
Date: Mon, 8 Jun 2026 10:39:48 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Timothy Pearson <tpearson@raptorengineering.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Shawn Anastasio <sanastasio@raptorengineering.com>,
	sashiko-bot@kernel.org, linux-pci@vger.kernel.org,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2 1/3] ppc/pnv: Add null checks for OpenCapi PHBs
Message-ID: <20260608153948.GA36499@bhelgaas>
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
In-Reply-To: <20260527180816.2749186-2-adityag@linux.ibm.com>

On Wed, May 27, 2026 at 11:38:14PM +0530, Aditya Gupta wrote:
> For opencapi phb direct slots, the .pdev for php_slots will be NULL
> 
> Various sections of the code in pnv_php can do a null dereference and
> crash the kernel.
> 
> Originally, the issue was hit during boot:
> 
>     [    1.568588] PowerPC PowerNV PCI Hotplug Driver version: 0.1
>     [    1.569722] BUG: Kernel NULL pointer dereference at 0x00000074
>     [    1.569811] Faulting instruction address: 0xc000000000b75fd0
>     [    1.569890] Oops: Kernel access of bad area, sig: 11 [#1]
>     [    1.569963] LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=2048 NUMA PowerNV
>     ...
>     [    1.571492] NIP [c000000000b75fd0] pnv_php_get_adapter_state+0x60/0x154
>     [    1.571604] LR [c000000000b75fbc] pnv_php_get_adapter_state+0x4c/0x154
>     [    1.571690] Call Trace:
>     [    1.571725] [c000c0000688f990] [c000000000b75fbc] pnv_php_get_adapter_state+0x4c/0x154 (unreliable)
>     [    1.571783] [c000c0000688fa20] [c000000000b78bd0] pnv_php_enable+0x94/0x378
>     [    1.571951] [c000c0000688fac0] [c000000000b7912c] pnv_php_register_one.isra.0+0x11c/0x1e0

Drop timestamps since they don't add useful information.

Indent quoted material by two spaces to reduce wrapping.

Run "git log --oneline drivers/pci/hotplug/pnv_php.c" and "git log
--oneline drivers/pci/hotplug/" and match subject line style.

> This occurs for hotplug slots on root buses where bus->self == NULL,
> such as OpenCAPI PHB direct slots. An added debug print (not part of
> this patch) confirmed it was opencapi:

Style "OpenCAPI" and "PHB" consistently in commit log and subject.

>     [    1.617227] pnv_php: slot 'OPENCAPI-0009' has NULL pdev (bus 0009:00, parent=NO (root bus))
>     [    1.617308] pnv_php: slot 'OPENCAPI-0009' dn->full_name='pciex@603a000000000', compatible='ibm,power10-pau-opencapi-pciex'
> 
> This only required null check in 'pnv_php_get_adapter_state', which
> caused the kernel to boot.
> 
> Even with 'pnv_php_get_adapter_state' null check, there are more
> possible null dereferences pointed by sashiko, including cases where
> userspace crashes the kernel, such as:
> 
>     $ cat /sys/bus/pci/slots/*/attention
>     ...
>     [  557.036295] Kernel attempted to read user page (6e) - exploit attempt? (uid: 0)
>     [  557.036354] BUG: Kernel NULL pointer dereference on read at 0x0000006e
>     [  557.036383] Faulting instruction address: 0xc000000000a83334
>     [  557.036413] Oops: Kernel access of bad area, sig: 11 [#1]
>     [  557.036449] LE PAGE_SIZE=64K MMU=Hash  SMP NR_CPUS=2048 NUMA PowerNV
>     ...
>     [  557.037749] [c000000046707a20] [c000000046707b90] 0xc000000046707b90 (unreliable)
>     [  557.037795] [c000000046707a70] [0000000000000001] 0x1
>     [  557.037850] [c000000046707ab0] [c000000000acb00c] attention_read_file+0x54/0xa8
>     [  557.037910] [c000000046707b30] [c000000000abfbfc] pci_slot_attr_show+0x3c/0x58
>     [  557.037977] [c000000046707b50] [c0000000008181ec] sysfs_kf_seq_show+0xd4/0x204
>     [  557.038022] [c000000046707be0] [c000000000815004] kernfs_seq_show+0x44/0x58
> 
> Add null checks to prevent the null dereferences.
> 
> Cc: stable@vger.kernel.org
> Fixes: 80f9fc236279 ("PCI: pnv_php: Work around switches with broken presence detection")
> Signed-off-by: Aditya Gupta <adityag@linux.ibm.com>

