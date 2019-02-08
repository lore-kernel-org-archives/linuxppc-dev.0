Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44457C169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 12:34:44 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73A69217D8
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 12:34:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73A69217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wvl52CMDzDq7N
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 23:34:41 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43wvh01npPzDqHY
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 23:32:00 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43wvgz52vLz9sBZ;
 Fri,  8 Feb 2019 23:31:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 7/7] powerpc/eeh: Add eeh_force_recover to debugfs
In-Reply-To: <20190208030802.10805-7-oohall@gmail.com>
References: <20190208030802.10805-1-oohall@gmail.com>
 <20190208030802.10805-7-oohall@gmail.com>
Date: Fri, 08 Feb 2019 23:31:57 +1100
Message-ID: <87tvheihqa.fsf@concordia.ellerman.id.au>
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
Cc: Oliver O'Halloran <oohall@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Oliver O'Halloran <oohall@gmail.com> writes:

> This patch adds a debugfs interface to force scheduling a recovery event.
> This can be used to recover a specific PE or schedule a "special" recovery
> even that checks for errors at the PHB level.
> To force a recovery of a normal PE, use:
>
>  echo '<#pe>:<#phb>' > /sys/kernel/debug/powerpc/eeh_force_recover
>
> To force a scan broken PHBs:
>
>  echo 'null' > /sys/kernel/debug/powerpc/eeh_force_recover

Why 'null', that seems like an odd choice. Why not "all" or "scan" or
something?

Also it oopsed on me:

[   76.323164] sending failure event
[   76.323421] BUG: Unable to handle kernel instruction fetch (NULL pointer?)
[   76.323655] Faulting instruction address: 0x00000000
[   76.323856] Oops: Kernel access of bad area, sig: 11 [#1]
[   76.323946] LE PAGE_SIZE=64K MMU=Hash SMP NR_CPUS=2048 NUMA pSeries
[   76.324295] Modules linked in: vmx_crypto kvm binfmt_misc ip_tables x_tables autofs4 crc32c_vpmsum
[   76.324669] CPU: 2 PID: 97 Comm: eehd Not tainted 5.0.0-rc2-gcc-8.2.0-00080-gfacc0d1d9517 #435
[   76.325054] NIP:  0000000000000000 LR: c0000000000451f8 CTR: 0000000000000000
[   76.325402] REGS: c0000000fec779c0 TRAP: 0400   Not tainted  (5.0.0-rc2-gcc-8.2.0-00080-gfacc0d1d9517)
[   76.325768] MSR:  800000014280b033 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI,LE,TM[E]>  CR: 24000482  XER: 20000000
[   76.326243] CFAR: c000000000002528 IRQMASK: 0 
[   76.326243] GPR00: c000000000045edc c0000000fec77c50 c000000001574000 c0000000fec77cb0 
[   76.326243] GPR04: 0000000000000000 00177d76e3e321bc 00177d76e4293a1f 5deadbeef0000100 
[   76.326243] GPR08: 5deadbeef0000200 0000000000000000 0000000000000000 00177d76e3e3216b 
[   76.326243] GPR12: 0000000000000000 c00000003fffdf00 c0000000001438a8 c0000000fe211700 
[   76.326243] GPR16: 0000000000000000 0000000000000000 0000000000000000 0000000000000000 
[   76.326243] GPR20: 0000000000000000 0000000000000000 0000000000000000 c000000000e814e8 
[   76.326243] GPR24: c000000000e814c0 5deadbeef0000100 c000000001622480 0000000100000000 
[   76.326243] GPR28: c000000001413310 c0000000016244e0 c0000000014132f0 c0000001f84246a0 
[   76.329073] NIP [0000000000000000]           (null)
[   76.329285] LR [c0000000000451f8] eeh_handle_special_event+0x78/0x348
[   76.329602] Call Trace:
[   76.329762] [c0000000fec77c50] [c0000000fec77ce0] 0xc0000000fec77ce0 (unreliable)
[   76.330113] [c0000000fec77d00] [c000000000045edc] eeh_event_handler+0x10c/0x1c0
[   76.330464] [c0000000fec77db0] [c000000000143a4c] kthread+0x1ac/0x1c0
[   76.330681] [c0000000fec77e20] [c00000000000bdc4] ret_from_kernel_thread+0x5c/0x78
[   76.331026] Instruction dump:
[   76.331197] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
[   76.331550] XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX XXXXXXXX 
[   76.331803] ---[ end trace dc73d37df5bb9ecd ]---


cheers
