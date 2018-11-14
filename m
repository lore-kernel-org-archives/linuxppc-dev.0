Return-Path: <SRS0=Q8z7=NZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CFE9C43441
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 10:22:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E7762080F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 10:22:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E7762080F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42w0t40zz2zF3c9
	for <linuxppc-dev@archiver.kernel.org>; Wed, 14 Nov 2018 21:22:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42w0qs5KKgzF3QB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Nov 2018 21:20:25 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42w0qr3yQXz9s7W;
 Wed, 14 Nov 2018 21:20:24 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>, Stephen Rothwell <sfr@canb.auug.org.au>,
 Alan Modra <amodra@gmail.com>
Subject: Re: linux-next: build warnings from Linus' tree
In-Reply-To: <CACPK8XeDHt46rUJWQ1n=4fRWioogs9K0Z8dkxUa=E2ShfQ1Vdg@mail.gmail.com>
References: <20180612081413.323d85b8@canb.auug.org.au>
 <CACPK8XeDHt46rUJWQ1n=4fRWioogs9K0Z8dkxUa=E2ShfQ1Vdg@mail.gmail.com>
Date: Wed, 14 Nov 2018 21:20:23 +1100
Message-ID: <87k1lgufiw.fsf@concordia.ellerman.id.au>
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
Cc: Linux-Next Mailing List <linux-next@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Joel Stanley <joel@jms.id.au> writes:
> Hello Alan,
>
> On Tue, 12 Jun 2018 at 07:44, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
>> Building Linus' tree, today's linux-next build (powerpc ppc64_defconfig)
>> produced these warning:
>>
>> ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
>> ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
>> ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'.
>>
>> This may just be because I have started building using the native Debian
>> gcc for the powerpc builds ...
>
> Do you know why we started creating these?

It's controlled by the ld option --hash-style, which AFAICS still
defaults to sysv (generating .hash).

But it seems gcc can be configured to have a different default, and at
least my native ppc64le toolchains are passing gnu, eg:

 /usr/lib/gcc/powerpc64le-linux-gnu/6/collect2 -plugin
 /usr/lib/gcc/powerpc64le-linux-gnu/6/liblto_plugin.so
 -plugin-opt=/usr/lib/gcc/powerpc64le-linux-gnu/6/lto-wrapper
 -plugin-opt=-fresolution=/tmp/ccw1U2fF.res
 -plugin-opt=-pass-through=-lgcc -plugin-opt=-pass-through=-lgcc_s
 -plugin-opt=-pass-through=-lc -plugin-opt=-pass-through=-lgcc
 -plugin-opt=-pass-through=-lgcc_s --sysroot=/ --build-id --eh-frame-hdr
 -V -shared -m elf64lppc
 --hash-style=gnu
 ^^^^^^^^^^^^^^^^

So that's presumably why we're seeing it, some GCCs are configured to
use it.

> If it's intentional, should we be putting including them in the same
> way as .hash sections?
>
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/powerpc/kernel/vmlinux.lds.S#n282
>
>   .hash : AT(ADDR(.hash) - LOAD_OFFSET) { *(.hash) }

That would presumably work.

My question though is do we even need it?

From what I can see for it to be useful you need the section as well as
an entry in the dynamic section pointing at it, and we don't have a
dynamic section at all:

  $ readelf -S vmlinux | grep gnu.hash
    [ 4] .gnu.hash         GNU_HASH         c000000000dbbdb0  00dcbdb0
  $ readelf -d vmlinux
  
  There is no dynamic section in this file.

Compare to the vdso:

$ readelf -d arch/powerpc/kernel/vdso64/vdso64.so

Dynamic section at offset 0x868 contains 12 entries:
  Tag        Type                         Name/Value
 0x000000000000000e (SONAME)             Library soname: [linux-vdso64.so.1]
 0x0000000000000004 (HASH)               0x120
 0x000000006ffffef5 (GNU_HASH)           0x170
 0x0000000000000005 (STRTAB)             0x320
 0x0000000000000006 (SYMTAB)             0x1d0
 0x000000000000000a (STRSZ)              269 (bytes)
 0x000000000000000b (SYMENT)             24 (bytes)
 0x0000000070000003 (PPC64_OPT)          0x0
 0x000000006ffffffc (VERDEF)             0x450
 0x000000006ffffffd (VERDEFNUM)          2
 0x000000006ffffff0 (VERSYM)             0x42e
 0x0000000000000000 (NULL)               0x0


So can't we just discard .gnu.hash? And in fact do we need .hash either?

Actually arm64 discards the latter, and parisc discards both.

Would still be good to hear from Alan or someone else who knows anything
about toolchain stuff, ie. not me :)

cheers
