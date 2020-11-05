Return-Path: <SRS0=Sqku=EL=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0239C00A89
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2020 11:30:41 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 332FD20A8B
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2020 11:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="EuqJG+oW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 332FD20A8B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CRhCd0dC2zDqHR
	for <linuxppc-dev@archiver.kernel.org>; Thu,  5 Nov 2020 22:30:37 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CRh7F6YxNzDqs3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2020 22:26:49 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=EuqJG+oW; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4CRh7927Qnz9sVS;
 Thu,  5 Nov 2020 22:26:45 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1604575608;
 bh=N3LQMBxz53FTAnoaW8tqbR9RuS1nFNL/IBcDzTEmo04=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=EuqJG+oW9YMlU/9C7w+LY7w/BEHnurdsiXw5EYLeUouxUmPtg9DLXMDz6koBzkxFP
 /0Tdhcy4LzU97SCf0ag1B9XfPPfCzdauwZdXGomHJaB/s4VOtaFYmryYlWheiAwxAJ
 p8ydnxllcULes9/vYcWWndvJDvPUHHyKjqOJu4D4txoq8JMyMyAYRkm2ASAbiHYP/r
 GEtXi5DM2CcI3+gnulMIrGgHvItowZwos2kYpEtDoZEq4gCyyvNWlgTXF8G8V9vkaZ
 hRWv8Cs33o7XpzNAIdrgVm40jwWUQSU2QFGO1+x3JhRd8lyIbpOhMPgjlpYFqdu77L
 khu7frJN8nxJg==
From: Michael Ellerman <mpe@ellerman.id.au>
To: YiFei Zhu <zhuyifei1999@gmail.com>
Subject: Re: [PATCH seccomp 3/8] powerpc: Enable seccomp architecture tracking
In-Reply-To: <CABqSeAQ+3sjLXH7GVt_tZrFT_e0nNMm8QgT+FBNQYSOc8viM=A@mail.gmail.com>
References: <cover.1604410035.git.yifeifz2@illinois.edu>
 <4ec2970fcc819eb4d5dac2bd35233ccdadfda845.1604410035.git.yifeifz2@illinois.edu>
 <87wnz1to9n.fsf@mpe.ellerman.id.au>
 <CABqSeAQ+3sjLXH7GVt_tZrFT_e0nNMm8QgT+FBNQYSOc8viM=A@mail.gmail.com>
Date: Thu, 05 Nov 2020 22:26:44 +1100
Message-ID: <87ft5ot56z.fsf@mpe.ellerman.id.au>
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
Cc: linux-sh@vger.kernel.org, Tobin Feldman-Fitzthum <tobin@ibm.com>,
 Hubertus Franke <frankeh@us.ibm.com>, Jack Chen <jianyan2@illinois.edu>,
 linux-riscv@lists.infradead.org, Andrea Arcangeli <aarcange@redhat.com>,
 linux-s390@vger.kernel.org, YiFei Zhu <yifeifz2@illinois.edu>,
 linux-csky@vger.kernel.org, Tianyin Xu <tyxu@illinois.edu>,
 linux-xtensa@linux-xtensa.org, Kees Cook <keescook@chromium.org>,
 Jann Horn <jannh@google.com>, Valentin Rothberg <vrothber@redhat.com>,
 Aleksa Sarai <cyphar@cyphar.com>, Josep Torrellas <torrella@illinois.edu>,
 Will Drewry <wad@chromium.org>, linux-parisc@vger.kernel.org,
 Linux Containers <containers@lists.linux-foundation.org>,
 kernel list <linux-kernel@vger.kernel.org>,
 Andy Lutomirski <luto@amacapital.net>,
 Dimitrios Skarlatos <dskarlat@cs.cmu.edu>,
 David Laight <David.Laight@aculab.com>,
 Giuseppe Scrivano <gscrivan@redhat.com>, linuxppc-dev@lists.ozlabs.org,
 Tycho Andersen <tycho@tycho.pizza>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

YiFei Zhu <zhuyifei1999@gmail.com> writes:
> On Wed, Nov 4, 2020 at 4:22 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> > +#ifdef __LITTLE_ENDIAN__
>>
>> As Kees mentioned this should (must?!) match the configured endian.
>>
>> But I think it would still be better to use the CONFIG symbol, which is
>> CONFIG_CPU_LITTLE_ENDIAN.
>
> My attempt here is to be consistent with asm/syscall.h
> syscall_get_arch [1]. Would it make sense to change that to
> CONFIG_CPU_LITTLE_ENDIAN then?
>
> [1] https://elixir.bootlin.com/linux/latest/source/arch/powerpc/include/asm/syscall.h#L116

Looking across the tree with have thousands of usages of
__LITTLE_ENDIAN__, so it's probably not worth converting to
CONFIG_CPU_LITTLE_ENDIAN.

>> > +# define SECCOMP_ARCH_NATIVE         (AUDIT_ARCH_PPC64 | __SECCOMP_ARCH_LE)
>>
>> You use __SECCOMP_ARCH_LE there, but previously you only defined
>> __SECCOMP_ARCH_LE_BIT.
>>
>> Is there some magic somewhere that defines __SECCOMP_ARCH_LE based on
>> __SECCOMP_ARCH_LE_BIT ?
>
> Oops, my bad here.

OK :)

>> > +# define SECCOMP_ARCH_NATIVE_NR              NR_syscalls
>> > +# define SECCOMP_ARCH_NATIVE_NAME    "ppc64"
>>
>> What's the name used for?
>
> This is used in the last patch in this series to report in procfs the
> name of each architecture tracked by the bitmap cache.

OK, yeah I think it would be better if the matched the uname -m values.

>> Usually we use "ppc64" for 64-bit big endian and "ppc64le" for 64-bit
>> little endian.
>>
>> And usually we use "ppc" for 32-bit.
>
> Ok.


cheers
