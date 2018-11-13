Return-Path: <SRS0=INWp=NY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ED30C43441
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 12:19:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E76F22360
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 12:19:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E76F22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42vRWY6MC2zF3L5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 13 Nov 2018 23:19:21 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42vRRv4yBRzF3LD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Nov 2018 23:16:11 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 42vRRv0d8Xz9sBn; Tue, 13 Nov 2018 23:16:11 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42vRRt5YxVz9s9G; Tue, 13 Nov 2018 23:16:09 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 43c6494fa1499912c8177e71450c0279041152a6
In-Reply-To: <20181107053853.4190-1-mpe@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/io: Fix the IO workarounds code to work with Radix
Message-Id: <42vRRt5YxVz9s9G@ozlabs.org>
Date: Tue, 13 Nov 2018 23:16:09 +1100 (AEDT)
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
Cc: agraf@suse.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2018-11-07 at 05:38:53 UTC, Michael Ellerman wrote:
> Back in 2006 Ben added some workarounds for a misbehaviour in the
> Spider IO bridge used on early Cell machines, see commit
> 014da7ff47b5 ("[POWERPC] Cell "Spider" MMIO workarounds"). Later these
> were made to be generic, ie. not tied specifically to Spider.
> 
> The code stashes a token in the high bits (59-48) of virtual addresses
> used for IO (eg. returned from ioremap()). This works fine when using
> the Hash MMU, but when we're using the Radix MMU the bits used for the
> token overlap with some of the bits of the virtual address.
> 
> This is because the maximum virtual address is larger with Radix, up
> to c00fffffffffffff, and in fact we use that high part of the address
> range for ioremap(), see RADIX_KERN_IO_START.
> 
> As it happens the bits that are used overlap with the bits that
> differentiate an IO address vs a linear map address. If the resulting
> address lies outside the linear mapping we will crash (see below), if
> not we just corrupt memory.
> 
>   virtio-pci 0000:00:00.0: Using 64-bit direct DMA at offset 800000000000000
>   Unable to handle kernel paging request for data at address 0xc000000080000014
>   ...
>   CFAR: c000000000626b98 DAR: c000000080000014 DSISR: 42000000 IRQMASK: 0
>   GPR00: c0000000006c54fc c00000003e523378 c0000000016de600 0000000000000000
>   GPR04: c00c000080000014 0000000000000007 0fffffff000affff 0000000000000030
>          ^^^^
>   ...
>   NIP [c000000000626c5c] .iowrite8+0xec/0x100
>   LR [c0000000006c992c] .vp_reset+0x2c/0x90
>   Call Trace:
>     .pci_bus_read_config_dword+0xc4/0x120 (unreliable)
>     .register_virtio_device+0x13c/0x1c0
>     .virtio_pci_probe+0x148/0x1f0
>     .local_pci_probe+0x68/0x140
>     .pci_device_probe+0x164/0x220
>     .really_probe+0x274/0x3b0
>     .driver_probe_device+0x80/0x170
>     .__driver_attach+0x14c/0x150
>     .bus_for_each_dev+0xb8/0x130
>     .driver_attach+0x34/0x50
>     .bus_add_driver+0x178/0x2f0
>     .driver_register+0x90/0x1a0
>     .__pci_register_driver+0x6c/0x90
>     .virtio_pci_driver_init+0x2c/0x40
>     .do_one_initcall+0x64/0x280
>     .kernel_init_freeable+0x36c/0x474
>     .kernel_init+0x24/0x160
>     .ret_from_kernel_thread+0x58/0x7c
> 
> This hasn't been a problem because CONFIG_PPC_IO_WORKAROUNDS which
> enables this code is usually not enabled. It is only enabled when it's
> selected by PPC_CELL_NATIVE which is only selected by
> PPC_IBM_CELL_BLADE and that in turn depends on BIG_ENDIAN. So in order
> to hit the bug you need to build a big endian kernel, with IBM Cell
> Blade support enabled, as well as Radix MMU support, and then boot
> that on Power9 using Radix MMU.
> 
> Still we can fix the bug, so let's do that. We simply use fewer bits
> for the token, taking the union of the restrictions on the address
> from both Hash and Radix, we end up with 8 bits we can use for the
> token. The only user of the token is iowa_mem_find_bus() which only
> supports 8 token values, so 8 bits is plenty for that.
> 
> Fixes: 566ca99af026 ("powerpc/mm/radix: Add dummy radix_enabled()")
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Applied to powerpc fixes.

https://git.kernel.org/powerpc/c/43c6494fa1499912c8177e71450c02

cheers
