Return-Path: <SRS0=ZoyS=Q4=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C266BC43381
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 01:49:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 10C382086C
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 01:49:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10C382086C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 444cpB2FfrzDqN3
	for <linuxppc-dev@archiver.kernel.org>; Thu, 21 Feb 2019 12:49:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 444cmJ5ZTxzDqM3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2019 12:47:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 444cmG48S0z9s5c;
 Thu, 21 Feb 2019 12:47:26 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, j.neuschaefer@gmx.net
Subject: Re: [PATCH v3 00/16] powerpc/32: Use BATs/LTLBs for STRICT_KERNEL_RWX
In-Reply-To: <cover.1550648295.git.christophe.leroy@c-s.fr>
References: <cover.1550648295.git.christophe.leroy@c-s.fr>
Date: Thu, 21 Feb 2019 12:47:26 +1100
Message-ID: <87mumpx68h.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> The purpose of this serie is to:
> - use BATs with STRICT_KERNEL_RWX on book3s (See patch 13 for details.)
> - use LTLBs with STRICT_KERNEL_RWX on 8xx (See patch 15 for a few details.)

This doesn't boot qemu-mac99 for me:

  spawn ~/src/qemu/ppc-softmmu/qemu-system-ppc -nographic -vga none -M mac99 -m 1G -kernel build/vmlinux -initrd ppc32-initrd.gz -append console=ttyPZ0 init=/bin/sh
  >> =============================================================
  >> OpenBIOS 1.1 [Feb 15 2019 10:05]
  >> Configuration device id QEMU version 1 machine id 1
  >> CPUs: 1
  >> Memory: 1024M
  >> UUID: 00000000-0000-0000-0000-000000000000
  >> CPU type PowerPC,G4
  milliseconds isn't unique.
  Welcome to OpenBIOS v1.1 built on Feb 15 2019 10:05
  >> [ppc] Kernel already loaded (0x01000000 + 0x00c2c338) (initrd 0x01d2d000 + 0x007e72f0)
  >> [ppc] Kernel command line: console=ttyPZ0 init=/bin/sh
  >> switching to new context:
  OF stdout device is: /pci@f2000000/mac-io@c/escc@13000/ch-a@13020
  Preparing to boot Linux version 5.0.0-rc2-gcc-8.2.0-00125-g4fcb83ca7936 (michael@ka4) (gcc version 8.2.0 (Buildroot 2018.11-rc2-00003-ga0787e9)) #724 Thu Feb 21 12:03:14 AEDT 2019
  Detected machine type: 00000400
  command line: 
  memory layout at init:
    memory_limit : 00000000 (16 MB aligned)
    alloc_bottom : 02515000
    alloc_top    : 30000000
    alloc_top_hi : 40000000
    rmo_top      : 30000000
    ram_top      : 40000000
  copying OF device tree...
  Building dt strings...
  Building dt structure...
  Device tree strings 0x02516000 -> 0x025150a4
  Device tree struct  0x02517000 -> 0x3fde7eb0
  Quiescing Open Firmware ...
  Booting Linux via __start() @ 0x01000000 ...
  FAIL! Booting BE pmac32


That's pmac32 defconfig ish.
I haven't had time to debug it further sorry.

cheers
