Return-Path: <SRS0=Olcr=NC=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0C6CC67863
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 09:56:46 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 238E820779
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 09:56:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 238E820779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42dsP8285GzDrWW
	for <linuxppc-dev@archiver.kernel.org>; Mon, 22 Oct 2018 20:56:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42dryZ349PzDrqN
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Oct 2018 20:37:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42dryZ1yBNz9sDC; Mon, 22 Oct 2018 20:37:10 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: fb978ca207743badfe7efd9eebe68bcbb4969f79
In-Reply-To: <872199441fd43b05fc1c7d049098ef7c0e83f4c5.1537262646.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: powerpc/kgdb: add kgdb_arch_set/remove_breakpoint()
Message-Id: <42dryZ1yBNz9sDC@ozlabs.org>
Date: Mon, 22 Oct 2018 20:37:09 +1100 (AEDT)
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

On Tue, 2018-09-18 at 09:26:03 UTC, Christophe Leroy wrote:
> Generic implementation fails to remove breakpoints after init
> when CONFIG_STRICT_KERNEL_RWX is selected:
> 
> [   13.251285] KGDB: BP remove failed: c001c338
> [   13.259587] kgdbts: ERROR PUT: end of test buffer on 'do_fork_test' line 8 expected OK got $E14#aa
> [   13.268969] KGDB: re-enter exception: ALL breakpoints killed
> [   13.275099] CPU: 0 PID: 1 Comm: init Not tainted 4.18.0-g82bbb913ffd8 #860
> [   13.282836] Call Trace:
> [   13.285313] [c60e1ba0] [c0080ef0] kgdb_handle_exception+0x6f4/0x720 (unreliable)
> [   13.292618] [c60e1c30] [c000e97c] kgdb_handle_breakpoint+0x3c/0x98
> [   13.298709] [c60e1c40] [c000af54] program_check_exception+0x104/0x700
> [   13.305083] [c60e1c60] [c000e45c] ret_from_except_full+0x0/0x4
> [   13.310845] [c60e1d20] [c02a22ac] run_simple_test+0x2b4/0x2d4
> [   13.316532] [c60e1d30] [c0081698] put_packet+0xb8/0x158
> [   13.321694] [c60e1d60] [c00820b4] gdb_serial_stub+0x230/0xc4c
> [   13.327374] [c60e1dc0] [c0080af8] kgdb_handle_exception+0x2fc/0x720
> [   13.333573] [c60e1e50] [c000e928] kgdb_singlestep+0xb4/0xcc
> [   13.339068] [c60e1e70] [c000ae1c] single_step_exception+0x90/0xac
> [   13.345100] [c60e1e80] [c000e45c] ret_from_except_full+0x0/0x4
> [   13.350865] [c60e1f40] [c000e11c] ret_from_syscall+0x0/0x38
> [   13.356346] Kernel panic - not syncing: Recursive entry to debugger
> 
> This patch creates powerpc specific version of
> kgdb_arch_set_breakpoint() and kgdb_arch_remove_breakpoint()
> using patch_instruction()
> 
> Fixes: 1e0fc9d1eb2b ("powerpc/Kconfig: Enable STRICT_KERNEL_RWX for some configs")
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/fb978ca207743badfe7efd9eebe68b

cheers
