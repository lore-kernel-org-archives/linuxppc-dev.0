Return-Path: <SRS0=YHW0=BB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35014C433E0
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 05:03:07 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF1E4207BB
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 05:03:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="O2t3NNmb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF1E4207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BBNdN4jVczDqvL
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jul 2020 15:03:04 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BBNMB23b1zDqtd
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jul 2020 14:50:46 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=O2t3NNmb; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4BBNM73Xpmz9sSn;
 Wed, 22 Jul 2020 14:50:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1595393445;
 bh=EikksBvUVVSgx7PbC9PoBMWAYLrAx1ActPVYUU8rTkE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=O2t3NNmb0TZYIhUfd294PgsE0mDk0NkX5s1kaEv2oF7KxbCWK0AOu14+8RiOCoTRa
 T4mAWJ+SJSElYmJQtB6y4fi3rvkBiIaQ7NXxAaODgjyE5nInphmmRww0/Im03/ehaX
 ypJjRz/oqooZ3L0EP63rd83/6xZX4mIoxF/UOZCC8S2P+Ki2CbMaWsG/zNTpIL74Tc
 GKWn3cXJ1Ki3jrENb3I3H3VSUbEIj07AZbgiHDrz0d1ftQBb8OhUd140mXnnmd4Fvg
 9H3ACTDWC9E10Oi0TdCkgLIebySHJ/MqkcThKvaYh9PRK4/yDDXQ/XhMG7u5XBB1xk
 VNFfjcFWrSAHA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH v5 1/4] riscv: Move kernel mapping to vmalloc zone
In-Reply-To: <bb461dde0df3eaf0bed949eebf0657b227431bb3.camel@kernel.crashing.org>
References: <mhng-cd9a74ea-2edf-47e4-aade-b090f1a069f1@palmerdabbelt-glaptop1>
 <bb461dde0df3eaf0bed949eebf0657b227431bb3.camel@kernel.crashing.org>
Date: Wed, 22 Jul 2020 14:50:42 +1000
Message-ID: <87sgdkqhjx.fsf@mpe.ellerman.id.au>
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
Cc: aou@eecs.berkeley.edu, alex@ghiti.fr, linux-mm@kvack.org,
 Anup Patel <Anup.Patel@wdc.com>, linux-kernel@vger.kernel.org,
 Atish Patra <Atish.Patra@wdc.com>, paulus@samba.org, zong.li@sifive.com,
 Paul Walmsley <paul.walmsley@sifive.com>, linux-riscv@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> On Tue, 2020-07-21 at 16:48 -0700, Palmer Dabbelt wrote:
>> > Why ? Branch distance limits ? You can't use trampolines ?
>> 
>> Nothing fundamental, it's just that we don't have a large code model in the C
>> compiler.  As a result all the global symbols are resolved as 32-bit
>> PC-relative accesses.  We could fix this with a fast large code model, but then
>> the kernel would need to relax global symbol references in modules and we don't
>> even do that for the simple code models we have now.  FWIW, some of the
>> proposed large code models are essentially just split-PLT/GOT and therefor
>> don't require relaxation, but at that point we're essentially PIC until we
>> have more that 2GiB of kernel text -- and even then, we keep all the
>> performance issues.
>
> My memory might be out of date but I *think* we do it on powerpc
> without going to a large code model, but just having the in-kernel
> linker insert trampolines.

We build modules with the large code model, and always have AFAIK:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/Makefile?commit=4fa640dc52302b5e62b01b05c755b055549633ae#n129

  # -mcmodel=medium breaks modules because it uses 32bit offsets from
  # the TOC pointer to create pointers where possible. Pointers into the
  # percpu data area are created by this method.
  #
  # The kernel module loader relocates the percpu data section from the
  # original location (starting with 0xd...) to somewhere in the base
  # kernel percpu data space (starting with 0xc...). We need a full
  # 64bit relocation for this to work, hence -mcmodel=large.
  KBUILD_CFLAGS_MODULE += -mcmodel=large


We also insert trampolines for branches, but IIUC that's a separate
issue.

cheers
