Return-Path: <SRS0=JA7W=R5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66339C43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 00:57:17 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B56812080F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 00:57:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B56812080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44St5602mTzDqM3
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Mar 2019 11:57:14 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44St3N04MDzDqH6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Mar 2019 11:55:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44St3L58fpz9sSV;
 Tue, 26 Mar 2019 11:55:42 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: vmlinux.lds: Drop Binutils 2.18 workarounds
In-Reply-To: <20190321003253.22100-1-joel@jms.id.au>
References: <20190321003253.22100-1-joel@jms.id.au>
Date: Tue, 26 Mar 2019 11:55:42 +1100
Message-ID: <874l7qpi7l.fsf@concordia.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Joel Stanley <joel@jms.id.au> writes:
> Segher added some workarounds for GCC 4.2 and bintuils 2.18. We now set
> 4.6 and 2.20 as the minimum, so they can be dropped.
>
> This is mostly a revert of c69cccc95fe4 ("powerpc: Fix build bug with
> binutils < 2.18 and GCC < 4.2").
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
>  arch/powerpc/kernel/vmlinux.lds.S | 35 ++++---------------------------
>  1 file changed, 4 insertions(+), 31 deletions(-)

Seems this breaks some toolchains, at least the one from kernel.org:

  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: .tmp_vmlinux1: Not enough room for program headers, try linking with -N
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-ld: final link failed: Bad value
  make[1]: *** [/kisskb/src/Makefile:1024: vmlinux] Error 1

http://kisskb.ellerman.id.au/kisskb/buildresult/13743374/

Not sure why.

That's binutils 2.30.

cheers
