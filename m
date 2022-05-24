Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4D94C433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 11:26:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4L6sNP2HLWz3gyP
	for <linuxppc-dev@archiver.kernel.org>; Tue, 24 May 2022 21:26:45 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4L6s7x6KBJz3chJ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2022 21:15:57 +1000 (AEST)
Received: by gandalf.ozlabs.org (Postfix)
 id 4L6s7x6DBKz4yTG; Tue, 24 May 2022 21:15:57 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4L6s7x4VkJz4yTD;
 Tue, 24 May 2022 21:15:57 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@ozlabs.org
In-Reply-To: <YoTEb2BaH3MDkH+2@cleo>
References: <YoTEb2BaH3MDkH+2@cleo>
Subject: Re: [PATCH v2 0/6] KASAN support for 64-bit Book 3S powerpc
Message-Id: <165339057205.1718562.17343833852981208467.b4-ty@ellerman.id.au>
Date: Tue, 24 May 2022 21:09:32 +1000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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
Cc: Daniel Axtens <dja@axtens.net>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 18 May 2022 20:03:27 +1000, Paul Mackerras wrote:
> This patch series implements KASAN on 64-bit POWER with radix MMU,
> such as POWER9 or POWER10.  Daniel Axtens posted previous versions of
> these patches, but is no longer working on KASAN, and I have been
> asked to get them ready for inclusion.
> 
> Because of various technical difficulties, mostly around the need to
> allow for code that runs in real mode, we only support "outline" mode
> (as opposed to "inline" mode), where the compiler adds a call to
> a checking procedure before every store to memory.
> 
> [...]

Patches 1-5 applied to powerpc/next.

[1/6] kasan: Document support on 32-bit powerpc
      https://git.kernel.org/powerpc/c/60e832def18de7a0753393034c6ae459b3bee70a
[2/6] powerpc/mm/kasan: rename kasan_init_32.c to init_32.c
      https://git.kernel.org/powerpc/c/f08aed52412c860f68e30da148da58ad8e40a43b
[3/6] powerpc: Book3S 64-bit outline-only KASAN support
      https://git.kernel.org/powerpc/c/41b7a347bf1491e7300563bb224432608b41f62a
[4/6] powerpc/kasan: Don't instrument non-maskable or raw interrupts
      https://git.kernel.org/powerpc/c/5352090a999570c6e8a701bcb755fd91e8c5a2cd
[5/6] powerpc/kasan: Disable address sanitization in kexec paths
      https://git.kernel.org/powerpc/c/2ab2d5794f14c08676690bf0859f16cc768bb3a4

cheers
