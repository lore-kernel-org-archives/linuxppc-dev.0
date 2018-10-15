Return-Path: <SRS0=mWF2=M3=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08544C28CF8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 04:37:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5879A20842
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 04:37:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5879A20842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42YQdf311DzF3SD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 15 Oct 2018 15:37:10 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42YPr56ZdSzF36f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Oct 2018 15:01:09 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix, from userid 1034)
 id 42YPr53Snlz9sjH; Mon, 15 Oct 2018 15:01:08 +1100 (AEDT)
X-powerpc-patch-notification: thanks
X-powerpc-patch-commit: 960e30029863db95ec79a71009272d4661db5991
In-Reply-To: <20181011024303.23921-1-joel@jms.id.au>
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Subject: Re: [v3] powerpc/Makefile: Fix PPC_BOOK3S_64 ASFLAGS
Message-Id: <42YPr53Snlz9sjH@ozlabs.org>
Date: Mon, 15 Oct 2018 15:01:08 +1100 (AEDT)
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
Cc: Nick Desaulniers <ndesaulniers@google.com>,
 Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 2018-10-11 at 02:43:03 UTC, Joel Stanley wrote:
> Ever since commit 15a3204d24a3 ("powerpc/64s: Set assembler machine type
> to POWER4") we force -mpower4 to be passed to the assembler irrespective
> of the CFLAGS used.
> 
> When building a powerpc64 kernel with clang, clang will not add -many to
> the assembler flags, so any instructions that the compiler has generated
> that are not available on power4 will cause an error:
> 
>  /usr/bin/as -a64 -mppc64 -mlittle-endian -mpower8 \
>   -I ./arch/powerpc/include -I ./arch/powerpc/include/generated \
>   -I ./include -I ./arch/powerpc/include/uapi \
>   -I ./arch/powerpc/include/generated/uapi -I ./include/uapi \
>   -I ./include/generated/uapi -I arch/powerpc -I arch/powerpc \
>   -maltivec -mpower4 -o init/do_mounts.o /tmp/do_mounts-3b0a3d.s
>  /tmp/do_mounts-51ce54.s:748: Error: unrecognized opcode: `isel'
> 
> GCC does include -many, so the GCC driven gas call will succeed:
> 
>   as -v -I ./arch/powerpc/include -I ./arch/powerpc/include/generated -I
>   ./include -I ./arch/powerpc/include/uapi
>   -I ./arch/powerpc/include/generated/uapi -I ./include/uapi
>   -I ./include/generated/uapi -I arch/powerpc -I arch/powerpc
>    -a64 -mpower8 -many -mlittle -maltivec -mpower4 -o init/do_mounts.o
> 
> Note that isel is power7 and above for IBM CPUs. GCC only generates it
> for Power9 and above, but the above test was run against the clang
> generated assembly.
> 
> Peter Bergner explains:
> 
>  > When using -many -mpower4, gas will first try and find a matching
>  > power4 mnemonic and failing that, it will then allow any valid mnemonic
>  > that gas knows about.  GCC's use of -many predates me though.
>  >
>  > IIRC, Alan looked at trying to remove it, but I forget why he didn't.
>  > Could be either a gcc or gas issue at the time.  I'm not sure whether
>  > issue still exists or not.  He and I have modified how gas works
>  > internally a fair amount since he tried removing gcc use of -many
>  >
>  > I will also note that when using -many, gas will choose the first
>  > mnemonic that matches in the mnemonic table and we have (mostly) sorted
>  > the table so that server mnemonics show up earlier in the table than
>  > other mnemonics, so they'll be seen/chosen first
> 
> By explicitly setting -many we can build with Clang and GCC while
> retaining the -mpower4 option.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/960e30029863db95ec79a71009272d

cheers
