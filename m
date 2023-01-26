Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EE60C05027
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Jan 2023 10:06:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4P2bw51gFSz2ybK
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Jan 2023 21:06:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=bIX2pRRD;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4P2bv539LQz2xGH
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2023 21:05:53 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=bIX2pRRD;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4P2btw0J1Wz4xZb;
	Thu, 26 Jan 2023 21:05:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1674727549;
	bh=P+pKB31T+nGljehfFqRVXunWhIcYvj3vXGbYNYsut+g=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bIX2pRRDeu7g+dWGMkZsM3GN1RksgQ0vg8jSRQ9hXRcrl+77Sq7usFghmvF/YwEL8
	 QN1DqRIrmUnHbUkbkEoydqQLi78FZpgGsGFYKaHA5gWF8Om33Qu5yNwIEY24CptzMU
	 NV87WaPFTdj7+K3/ZwQ5A1QM5whAc8BYTSP7Z8uP0sS73VJahbROKSUlhkTI86iB9C
	 OTdhJaqhjFCzKTHRiujbfmDhjmyJd9WoeXBbCmZZpqtohOaIPBP8Re/t4+tkjTB+0T
	 c+2xWY76nUHDStcvNUQhWPURaHyJ6tbRQQd5Jytfa4uiir2mdVlhFA9Ym/PFIVJDgI
	 3DtzUqzp2b9mA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Masahiro Yamada <masahiroy@kernel.org>, Nathan Chancellor
 <nathan@kernel.org>
Subject: Re: [PATCH v2 05/14] powerpc: Remove linker flag from KBUILD_AFLAGS
In-Reply-To: <CAK7LNAROfEi7021v+SkDd=uU1hM_vzuGYvDD6OQ0bJ2Tu0yjvA@mail.gmail.com>
References: <20221228-drop-qunused-arguments-v2-0-9adbddd20d86@kernel.org>
 <20221228-drop-qunused-arguments-v2-5-9adbddd20d86@kernel.org>
 <871qnjqmmq.fsf@mpe.ellerman.id.au>
 <CAK7LNAR2ASj6bGS6sR5x=cDCDDFW3ZkHRTdsHAY_+JEqojTUNQ@mail.gmail.com>
 <Y9HgXE9kmcfmva1C@dev-arch.thelio-3990X>
 <CAK7LNAROfEi7021v+SkDd=uU1hM_vzuGYvDD6OQ0bJ2Tu0yjvA@mail.gmail.com>
Date: Thu, 26 Jan 2023 21:05:43 +1100
Message-ID: <87ilgtpq4o.fsf@mpe.ellerman.id.au>
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
Cc: nicolas@fjasle.eu, linux-kbuild@vger.kernel.org, trix@redhat.com, llvm@lists.linux.dev, ndesaulniers@google.com, npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Masahiro Yamada <masahiroy@kernel.org> writes:
> On Thu, Jan 26, 2023 at 11:07 AM Nathan Chancellor <nathan@kernel.org> wrote:
>>
>> On Thu, Jan 26, 2023 at 10:29:54AM +0900, Masahiro Yamada wrote:
>> > On Wed, Jan 25, 2023 at 1:11 PM Michael Ellerman <mpe@ellerman.id.au> wrote:
>> > >
>> > > Nathan Chancellor <nathan@kernel.org> writes:
>> > > > When clang's -Qunused-arguments is dropped from KBUILD_CPPFLAGS, it
>> > > > points out that KBUILD_AFLAGS contains a linker flag, which will be
>> > > > used:
>> > >
>> > > Should that say "unused" ?
>> >
>> >
>> >
>> > Nathan, shall I fix it up locally?
>> > (it will change the commit hash, though.)
>>
>> Yes please, if you would not mind. Sorry about that and thank you for
>> spotting it Michael!
>>
>> Since you have to rebase to fix it, you can include Michael's acks?
>>
>> Cheers,
>> Nathan
>
> Done.

Thanks.

cheers
