Return-Path: <SRS0=MnD0=R6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D43DC43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 12:51:08 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C094F2087C
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 12:51:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C094F2087C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44TntJ0qdszDqPg
	for <linuxppc-dev@archiver.kernel.org>; Wed, 27 Mar 2019 23:51:04 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44TnqM3hWZzDqDZ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2019 23:48:29 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id x2RClx6c021285;
 Wed, 27 Mar 2019 07:48:01 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id x2RCltKW021271;
 Wed, 27 Mar 2019 07:47:55 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Wed, 27 Mar 2019 07:47:55 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc: vmlinux.lds: Drop Binutils 2.18 workarounds
Message-ID: <20190327124754.GY3969@gate.crashing.org>
References: <20190321003253.22100-1-joel@jms.id.au>
 <874l7qpi7l.fsf@concordia.ellerman.id.au>
 <d340ae4b-a009-0ef3-9621-da3e0a7684f5@c-s.fr>
 <20190326181914.GS3969@gate.crashing.org>
 <5f4aa4b2-1c44-70b9-c383-5d40aecd695c@c-s.fr>
 <20190326201231.GV3969@gate.crashing.org>
 <20190326222941.GW3969@gate.crashing.org>
 <8aa0290a-908c-38d8-e040-c8c0cc226eb9@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8aa0290a-908c-38d8-e040-c8c0cc226eb9@c-s.fr>
User-Agent: Mutt/1.4.2.3i
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
Cc: linuxppc-dev@lists.ozlabs.org, Joel Stanley <joel@jms.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, Mar 27, 2019 at 07:40:32AM +0100, Christophe Leroy wrote:
> Le 26/03/2019 à 23:29, Segher Boessenkool a écrit :
> >I tried to reproduce this.  It does not fail with a ppc6xx_defconfig
> >build, and mpc885_ads_defconfig fails with
> 
> So far, the only defconfig which fails for me is ppc64_defconfig, like 
> Michael.

Oh, I misunderstood then.  Let me try that :-)

> 885_ads is ok, I just noticed the STACK header in vmlinux that is not 
> there when the patch is not applies.

Right...  The linker generates that by default, it's nothing to worry
about.

> >What is your GCC?
> 
> [root@localhost linux-powerpc]# powerpc64-linux-gcc -v
> Using built-in specs.
> COLLECT_GCC=powerpc64-linux-gcc
> COLLECT_LTO_WRAPPER=/opt/gcc-8.1.0-nolibc/powerpc64-linux/bin/../libexec/gcc/powerpc64-linux/8.1.0/lto-wrapper
> Target: powerpc64-linux
> Configured with: /home/arnd/git/gcc/configure --target=powerpc64-linux 
> --enable-targets=all 
> --prefix=/home/arnd/cross/x86_64/gcc-8.1.0-nolibc/powerpc64-linux 
> --enable-languages=c --without-headers --disable-bootstrap --disable-nls 
> --disable-threads --disable-shared --disable-libmudflap --disable-libssp 
> --disable-libgomp --disable-decimal-float --disable-libquadmath 
> --disable-libatomic --disable-libcc1 --disable-libmpx 
> --enable-checking=release
> Thread model: single
> gcc version 8.1.0 (GCC)

Okay cool, a plain GCC build, importantly not a vendor compiler.  Built
with my scripts no less ;-)

> [root@localhost linux-powerpc]# powerpc64-linux-ld -v
> GNU ld (GNU Binutils) 2.30


Segher
