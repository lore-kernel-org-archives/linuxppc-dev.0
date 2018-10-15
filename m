Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39487C04AA5
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 12:50:11 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC1872064A
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 12:50:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC1872064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YdZS3fPxzDqCB
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 23:50:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YdSq3BF7zDr0X
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 23:45:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42YdSp5JQFz9s3T;
 Mon, 15 Oct 2018 23:45:14 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: qemu boot failures with today's linux-next
In-Reply-To: <20181015191859.2f600de5@canb.auug.org.au>
References: <20181015191859.2f600de5@canb.auug.org.au>
Date: Mon, 15 Oct 2018 23:45:10 +1100
Message-ID: <87murfz8dl.fsf@concordia.ellerman.id.au>
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
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> Today's linux-next tree does not boot in qemu (with kvm or without).
> Here is the (non-kvm) boot log (the kvm one is basically the same):
>
> ------------------------------------------------------
...
>   Welcome to Open Firmware
>
>   Copyright (c) 2004, 2017 IBM Corporation All rights reserved.
>   This program and the accompanying materials are made available
>   under the terms of the BSD License available at
>   http://www.opensource.org/licenses/bsd-license.php
>
> Booting from memory...
> OF stdout device is: /vdevice/vty@71000000
> Preparing to boot Linux version 4.19.0-rc7 (sfr@ash) (gcc version 8.2.0 (Debian 8.2.0-4)) #2 SMP Mon Oct 15 18:53:28 AEDT 2018
                                  ^^^^^^^^^^
                                  I assume that's wrong, this is actually linux-next you're booting?


> Detected machine type: 0000000000000101
> command line: 
> Max number of cores passed to firmware: 2048 (NR_CPUS = 2048)
> Calling ibm,client-architecture-support... done
> memory layout at init:
>   memory_limit : 0000000000000000 (16 MB aligned)
>   alloc_bottom : 0000000001640000
>   alloc_top    : 0000000030000000
>   alloc_top_hi : 0000000080000000
>   rmo_top      : 0000000030000000
>   ram_top      : 0000000080000000
> instantiating rtas at 0x000000002fff0000... done
> prom_hold_cpus: skipped
> copying OF device tree...
> Building dt strings...
> Building dt structure...
> Device tree strings 0x0000000001850000 -> 0x0000000001850a02
> Device tree struct  0x0000000001860000 -> 0x0000000001870000
> Quiescing Open Firmware ...
> Booting Linux via __start() @ 0x0000000000400000 ...
> ------------------------------------------------------
>
> I have no idea what may have caused this.

If you git Ctrl-a-c you should get the qemu prompt. Then you can run
'info registers' to print the regs and maybe see where it's stuck.

And/or build with EARLY_DEBUG_LPAR to get early console output.

cheers
