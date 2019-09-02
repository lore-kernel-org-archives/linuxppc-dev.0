Return-Path: <SRS0=Itbs=W5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4B9CC3A5A4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 01:46:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 048B1217F4
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 01:46:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 048B1217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 46MCcQ4w7LzDqbk
	for <linuxppc-dev@archiver.kernel.org>; Mon,  2 Sep 2019 11:46:46 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 46MCZ56m5lzDqSw
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Sep 2019 11:44:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 46MCZ41XWlz9s7T;
 Mon,  2 Sep 2019 11:44:44 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: linux-next: manual merge of the powerpc tree with the arm64 tree
In-Reply-To: <20190902094711.2625ba31@canb.auug.org.au>
References: <20190902094711.2625ba31@canb.auug.org.au>
Date: Mon, 02 Sep 2019 11:44:43 +1000
Message-ID: <87lfv7tqt0.fsf@mpe.ellerman.id.au>
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
Cc: Linux Next Mailing List <linux-next@vger.kernel.org>,
 Peter Collingbourne <pcc@google.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> Today's linux-next merge of the powerpc tree got a conflict in:
>
>   arch/Kconfig
>
> between commit:
>
>   5cf896fb6be3 ("arm64: Add support for relocating the kernel with RELR relocations")
>
> from the arm64 tree and commit:
>
>   0c9c1d563975 ("x86, s390: Move ARCH_HAS_MEM_ENCRYPT definition to arch/Kconfig")
>
> from the powerpc tree.
>
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks.

That conflict seems entirely trivial, but Catalin/Will if it bothers you
I have the conflicting commit in a topic branch based on rc2 which you
could merge to resolve it:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/commit/?h=topic/mem-encrypt&id=0c9c1d56397518eb823d458b00b06bcccd956794


cheers

> -- 
> Cheers,
> Stephen Rothwell
>
> diff --cc arch/Kconfig
> index 6f4d3e9bf486,89e2e3f64f79..000000000000
> --- a/arch/Kconfig
> +++ b/arch/Kconfig
> @@@ -932,20 -925,9 +932,23 @@@ config LOCK_EVENT_COUNT
>   	  the chance of application behavior change because of timing
>   	  differences. The counts are reported via debugfs.
>   
>  +# Select if the architecture has support for applying RELR relocations.
>  +config ARCH_HAS_RELR
>  +	bool
>  +
>  +config RELR
>  +	bool "Use RELR relocation packing"
>  +	depends on ARCH_HAS_RELR && TOOLS_SUPPORT_RELR
>  +	default y
>  +	help
>  +	  Store the kernel's dynamic relocations in the RELR relocation packing
>  +	  format. Requires a compatible linker (LLD supports this feature), as
>  +	  well as compatible NM and OBJCOPY utilities (llvm-nm and llvm-objcopy
>  +	  are compatible).
>  +
> + config ARCH_HAS_MEM_ENCRYPT
> + 	bool
> + 
>   source "kernel/gcov/Kconfig"
>   
>   source "scripts/gcc-plugins/Kconfig"
