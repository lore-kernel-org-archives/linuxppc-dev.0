Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8977ACD1284
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2024 08:58:40 +0000 (UTC)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=rOGIeJ6l;
	dkim-atps=neutral
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4VDKcv1YzCz3vbN
	for <linuxppc-dev@archiver.kernel.org>; Tue,  9 Apr 2024 18:58:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=rOGIeJ6l;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4VDKc54SFwz30fh
	for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Apr 2024 18:57:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1712653077;
	bh=P0pjqDL1fQu8o32YoyNBzlgTnO0AyBJXTa6E6xDr6hU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rOGIeJ6l4xVwwk0XjnOyhmsxAhk7452CumvunomtGki62pburr68/pa/bAyB/8fmF
	 sNBzAUR42JbhUXWhVXbSl28qOaua/fy5NL1L0K2XHQGpOANWVSHklb2zO1G9Y6X7i3
	 ypyHOH/Mo06MNu0WmgAY4hPn3bch9mLTYJdfQ7cBbiUi4oxqb9o3+0ErOkr6B+gEAo
	 G8EQqAz40W3Cs4TgP1wNqZmADkG7nAk8gWgQpmrL9aPyP/i0vNCJA9P+laAuamvYHb
	 YjAsmd31TKmB1CUd7Sx33GqTIYdGiyR+Miy+KK3Mxpha836sJKXKK1UOsSLjEEHdqE
	 rex1j5CzXFJJQ==
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4VDKc519mMz4wqM;
	Tue,  9 Apr 2024 18:57:57 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nathan Chancellor <nathan@kernel.org>
Subject: Re: [PATCH] powerpc: Fix fatal warnings flag for LLVM's integrated
 assembler
In-Reply-To: <20240405-ppc-fix-wa-fatal-warnings-clang-v1-1-bdcd969f2ef0@kernel.org>
References: <20240405-ppc-fix-wa-fatal-warnings-clang-v1-1-bdcd969f2ef0@kernel.org>
Date: Tue, 09 Apr 2024 18:57:56 +1000
Message-ID: <87y19map63.fsf@mail.lhotse>
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
Cc: justinstitt@google.com, ajd@linux.ibm.com, llvm@lists.linux.dev, patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>, morbo@google.com, bgray@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Nathan Chancellor <nathan@kernel.org> writes:
> When building with LLVM_IAS=1, there is an error because
> '-fatal-warnings' is not recognized as a valid flag:
>
>   clang: error: unsupported argument '-fatal-warnings' to option '-Wa,'
>
> Use the double hyphen version of the flag, '--fatal-warnings', which
> works with both the GNU assembler and LLVM's integrated assembler.
>
> Fixes: 608d4a5ca563 ("powerpc: Error on assembly warnings")

Thanks.

I guess I need to do some of my clang builds with LLVM_IAS=1 :}

cheers
