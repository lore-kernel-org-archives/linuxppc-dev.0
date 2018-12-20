Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22C2EC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 11:23:05 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CBDE821773
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 11:23:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CBDE821773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43L8WW1TsYzDr1D
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 22:23:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43L8T10Jg3zDr7f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 22:20:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43L8T04rTnz9s55;
 Thu, 20 Dec 2018 22:20:52 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/3] powerpc: Discard dynsym section for !PPC32
In-Reply-To: <20181210222854.21156-3-joel@jms.id.au>
References: <20181210222854.21156-1-joel@jms.id.au>
 <20181210222854.21156-3-joel@jms.id.au>
Date: Thu, 20 Dec 2018 22:20:53 +1100
Message-ID: <87a7l0qwa2.fsf@concordia.ellerman.id.au>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Alan Modra <amodra@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Joel Stanley <joel@jms.id.au> writes:

> Alan Modra <amodra@gmail.com> explains:
>
>  > Likely you could discard .interp > and .dynstr too, and .dynsym when
>  > !CONFIG_PPC32.
>
> Discarding of interp and dynstr happened in a previous patch. The dynsym
> cleanup was a bit less straightforward, so it gets it's own patch.
>
> Signed-off-by: Joel Stanley <joel@jms.id.au>

And with the same toolchain this gives me:

  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-objdump: vmlinux: not a dynamic object
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-objdump: vmlinux: Invalid operation
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-objdump: vmlinux: not a dynamic object
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-objdump: vmlinux: Invalid operation
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-objdump: --stop-address: bad number: 0x


cheers
