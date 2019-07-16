Return-Path: <SRS0=bUW7=VN=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AE48C76188
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 12:43:52 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEE4420693
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 12:43:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEE4420693
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45p0Sj3wfYzDqPN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 16 Jul 2019 22:43:49 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45nzrM18fbzDqM6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Jul 2019 22:15:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 45nzrL2TGxz9sDB;
 Tue, 16 Jul 2019 22:15:46 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: remove meaningless KBUILD_ARFLAGS addition
In-Reply-To: <20190715072959.GB20882@gate.crashing.org>
References: <20190713032106.8509-1-yamada.masahiro@socionext.com>
 <20190713124744.GS14074@gate.crashing.org>
 <20190713131642.GU14074@gate.crashing.org>
 <CAK7LNASBmZxX+U=LS+dgvet96cA3T6Tf_tiAa2vduUV81DEnBw@mail.gmail.com>
 <20190713235430.GZ14074@gate.crashing.org>
 <87v9w393r5.fsf@concordia.ellerman.id.au>
 <20190715072959.GB20882@gate.crashing.org>
Date: Tue, 16 Jul 2019 22:15:47 +1000
Message-ID: <87pnma89ak.fsf@concordia.ellerman.id.au>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Paul Mackerras <paulus@samba.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Segher Boessenkool <segher@kernel.crashing.org> writes:
> On Mon, Jul 15, 2019 at 05:05:34PM +1000, Michael Ellerman wrote:
>> Segher Boessenkool <segher@kernel.crashing.org> writes:
>> > Yes, that is why I used the environment variable, all binutils work
>> > with that.  There was no --target option in GNU ar before 2.22.
>> 
>> Yeah, we're not very good at testing with really old binutils, so I
>> guess we broke that.
>> 
>> I'm inclined to merge this, it doesn't seem to break anything, and it
>> fixes using --target on old binutils that don't have it.
>
> But we don't set the target any other way either.  I don't think this
> will work with a 32-bit toolchain (default target 32 bit) and a 64-bit
> kernel, or the other way around.

I think it does, but maybe I'm misunderstanding.

My test setup is:

  ~/linux$ export PATH=/home/toolchains/ppc/gcc-8-branch/powerpc-linux/bin/:$PATH
  ~/linux$ echo "int test(void) { return 2; }" > test.c
  ~/linux$ powerpc-linux-gcc -c test.c 
  ~/linux$ file test.o 
  test.o: ELF 32-bit MSB relocatable, PowerPC or cisco 4500, version 1 (SYSV), not stripped
  ~/linux$ make CROSS_COMPILE=powerpc-linux- -s ppc64le_defconfig
  ~/linux$ make CROSS_COMPILE=powerpc-linux- -s -j 320
  ~/linux$ echo $?
  0

And it's definitely calling ar with no flags, eg:

  rm -f init/built-in.a; powerpc-linux-ar rcSTPD init/built-in.a init/main.o init/version.o init/do_mounts.o init/do_mounts_rd.o init/do_mounts_initrd.o init/do_mounts_md.o init/initramfs.o init/init_task.o

So presumably at some point ar learnt to cope with objects that don't
match its default? (how do I ask it what its default is?)

> Then again, does that work at *all* nowadays?  Do we even consider that
> important, *should* it work?

Yes and yes. There were a lot of bugs in the kernel makefiles after we
added LE support which prevented a biarch/biendian compiler from working.
But now it does work and we want it to keep working because it means you
can have a single compiler for building 32-bit, 64-bit BE & 64-bit LE.

cheers
