Return-Path: <SRS0=nAH3=MZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02234C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 15:50:40 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44D5720659
	for <linuxppc-dev@archiver.kernel.org>; Sat, 13 Oct 2018 15:50:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44D5720659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42XTgd35ZRzF3Fb
	for <linuxppc-dev@archiver.kernel.org>; Sun, 14 Oct 2018 02:50:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=kernel.crashing.org
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42XTdV3f2czDqKg
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 02:48:46 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 42XTdV30KJz8tPx
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 14 Oct 2018 02:48:46 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 42XTdV2jkrz9sCT; Sun, 14 Oct 2018 02:48:46 +1100 (AEDT)
Authentication-Results: ozlabs.org; spf=permerror (mailfrom)
 smtp.mailfrom=kernel.crashing.org (client-ip=63.228.1.57;
 helo=gate.crashing.org; envelope-from=segher@kernel.crashing.org;
 receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=kernel.crashing.org
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 42XTdT2fjzz9sB5;
 Sun, 14 Oct 2018 02:48:44 +1100 (AEDT)
Received: from gate.crashing.org (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.14.1) with ESMTP id w9DFmXvl030903;
 Sat, 13 Oct 2018 10:48:34 -0500
Received: (from segher@localhost)
 by gate.crashing.org (8.14.1/8.14.1/Submit) id w9DFmVQs030894;
 Sat, 13 Oct 2018 10:48:31 -0500
X-Authentication-Warning: gate.crashing.org: segher set sender to
 segher@kernel.crashing.org using -f
Date: Sat, 13 Oct 2018 10:48:30 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Fix stackprotector detection for non-glibc
 toolchains
Message-ID: <20181013154829.GO29268@gate.crashing.org>
References: <20181012225832.13827-1-mpe@ellerman.id.au>
 <7e1acec1-c840-321b-0a93-99679fce6cb3@c-s.fr>
 <87k1mm12p6.fsf@concordia.ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k1mm12p6.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, Oct 13, 2018 at 10:55:01PM +1100, Michael Ellerman wrote:
> So it's only my cross compilers that don't work.
> 
> The kernel.org ones are:
>   Configured with: /home/arnd/git/gcc/configure --target=powerpc64-linux
>   --enable-targets=all
>   --prefix=/home/arnd/cross/x86_64/gcc-8.1.0-nolibc/powerpc64-linux
>   --enable-languages=c --without-headers --disable-bootstrap
>   --disable-nls --disable-threads --disable-shared --disable-libmudflap
>   --disable-libssp --disable-libgomp --disable-decimal-float
>   --disable-libquadmath --disable-libatomic --disable-libcc1
>   --disable-libmpx --enable-checking=release
> 
> Whereas mine is:
>   Configured with: ../../src/gcc/configure
>   --prefix=/home/kerkins/workspace/gcc-build/gcc/gcc-8-branch/target/ppc/build/install/powerpc-linux
>   --disable-multilib --disable-bootstrap --enable-languages=c
>   --with-pkgversion='Custom 2c79ff811dfcee1c' --target=powerpc-linux
>   --enable-targets=all
> 
> 
> So I wonder if something in there is making the difference?

You have --disable-libssp on the buildall-built compiler, which makes GCC
assume your libc has the SSP support routines, which gives you these default
offsets (which are what they are on glibc).  Never mind that you explicitly
do not have a libc ;-)

> I guess I'll just rewrite the change log to say "some toolchains".

Or "most".


Segher
