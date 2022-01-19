Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9478C433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Jan 2022 11:07:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Jf2sv1nmmz3ccH
	for <linuxppc-dev@archiver.kernel.org>; Wed, 19 Jan 2022 22:07:31 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Jf2rg5Rt0z3bNC
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jan 2022 22:06:27 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jf2rg1CJpz4y4Z;
 Wed, 19 Jan 2022 22:06:27 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
In-Reply-To: <7a50ef902494d1325227d47d33dada01e52e5518.1641818726.git.christophe.leroy@csgroup.eu>
References: <7a50ef902494d1325227d47d33dada01e52e5518.1641818726.git.christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3] powerpc/32s: Fix kasan_init_region() for KASAN
Message-Id: <164259036257.3588160.3465491440781256341.b4-ty@ellerman.id.au>
Date: Wed, 19 Jan 2022 22:06:02 +1100
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
Cc: Maxime Bizon <mbizon@freebox.fr>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 10 Jan 2022 15:29:25 +0000, Christophe Leroy wrote:
> It has been reported some configuration where the kernel doesn't
> boot with KASAN enabled.
> 
> This is due to wrong BAT allocation for the KASAN area:
> 
> 	---[ Data Block Address Translation ]---
> 	0: 0xc0000000-0xcfffffff 0x00000000       256M Kernel rw      m
> 	1: 0xd0000000-0xdfffffff 0x10000000       256M Kernel rw      m
> 	2: 0xe0000000-0xefffffff 0x20000000       256M Kernel rw      m
> 	3: 0xf8000000-0xf9ffffff 0x2a000000        32M Kernel rw      m
> 	4: 0xfa000000-0xfdffffff 0x2c000000        64M Kernel rw      m
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/32s: Fix kasan_init_region() for KASAN
      https://git.kernel.org/powerpc/c/d37823c3528e5e0705fc7746bcbc2afffb619259

cheers
