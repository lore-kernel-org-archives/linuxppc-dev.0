Return-Path: <SRS0=vnEJ=O5=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE3EC43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 11:20:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1262621773
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 11:20:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1262621773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43L8SH6B2hzDr8R
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Dec 2018 22:20:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43L8Pz3sHHzDr7d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Dec 2018 22:18:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 43L8Pz0YSHz9sBh;
 Thu, 20 Dec 2018 22:18:15 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 1/3] powerpc: Discard more sections in linker script
In-Reply-To: <20181210222854.21156-2-joel@jms.id.au>
References: <20181210222854.21156-1-joel@jms.id.au>
 <20181210222854.21156-2-joel@jms.id.au>
Date: Thu, 20 Dec 2018 22:18:15 +1100
Message-ID: <87d0pwqweg.fsf@concordia.ellerman.id.au>
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

> Building the ppc64 kernel with a modern binutils results in this
> warning:
>
>  powerpc64le-linux-gnu-ld: warning: orphan section `.gnu.hash' from
>  `linker stubs' being placed in section `.gnu.hash'
>
> Alan Modra <amodra@gmail.com> explains:
>
>  > .gnu.hash, like .hash, is used by glibc ld.so for dynamic symbol
>  > lookup.  I imagine you don't need either section in a kernel, so
>  > discarding both sounds reasonable.  Likely you could discard .interp
>  > and .dynstr too, and .dynsym when !CONFIG_PPC32.
>
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> See https://lore.kernel.org/lkml/CACPK8Xft3n5KkpTjN3=7_VUCXHFcK7mxvZm2Rrqu7tppcBoyOg@mail.gmail.com/T/#m58532c86cf0c7b4fb01cc1fe724e48d4c7d8e4a7
>
> v3: Add dynstr hunk to this patch (it was incorrectly left in patch 2)
> ---
>  arch/powerpc/kernel/vmlinux.lds.S | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Building ppc64le_defconfig with gcc 8.1.0 / binutils 2.30, this is giving me:

  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-nm: .tmp_vmlinux1: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-nm: .tmp_vmlinux1: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-nm: .tmp_vmlinux1: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-nm: .tmp_vmlinux1: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-nm: .tmp_vmlinux1: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-nm: .tmp_vmlinux1: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-nm: .tmp_vmlinux1: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-nm: .tmp_vmlinux1: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-nm: .tmp_vmlinux1: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-nm: .tmp_vmlinux2: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-nm: .tmp_vmlinux2: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-nm: vmlinux: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-nm: vmlinux: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-nm: .tmp_vmlinux2: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-nm: .tmp_vmlinux2: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-nm: vmlinux: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-nm: vmlinux: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-objdump: vmlinux: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-objdump: vmlinux: attempt to load strings from a non-string section (number 0)
  WARNING: 2 bad relocations
  c000000001490a50 R_PPC64_ADDR64    (null)
  c000000001490a68 R_PPC64_ADDR64    (null)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-objdump: vmlinux: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-objdump: vmlinux: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-objdump: vmlinux: attempt to load strings from a non-string section (number 0)
  /opt/cross/kisskb/korg/gcc-8.1.0-nolibc/powerpc64-linux/bin/powerpc64-linux-objdump: vmlinux: attempt to load strings from a non-string section (number 0)

Haven't had time to dig into why yet.

cheers
