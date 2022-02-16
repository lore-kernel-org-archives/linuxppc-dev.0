Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9211AC433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Feb 2022 12:23:21 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4JzHDR5Fclz3cNZ
	for <linuxppc-dev@archiver.kernel.org>; Wed, 16 Feb 2022 23:23:19 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=TMxJSrmZ;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (mail.ozlabs.org
 [IPv6:2404:9400:2221:ea00::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4JzHCl0ZFkz30Mf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Feb 2022 23:22:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=TMxJSrmZ; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzHCd2Q32z4xcP;
 Wed, 16 Feb 2022 23:22:37 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
 s=201909; t=1645014159;
 bh=b5eBM0apAamYiz9FmsL/tdSBnGcg3AeLZmO6Sx4f7CI=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=TMxJSrmZkyabs6lKbBV2TP83SZhbStzLgUK6grRi9ZcKO7+n12nPpEJHnpP9OCnY8
 8/bVkXeSr4TuornxqhL4RcEJrh5rUkChWpyGLeNFcP3Fu87/lxk921secNCIk3zvXn
 BlugRQjvtHFZmPYTcTXBw7d7BsSBvevEK4rNDjwe4nPGbzuq+EGD1vma1jJ/4Dgehe
 sxUPxAJ2AFXp33B1HKQXCUuBwuY1vMQ9z/9K1vmjr0O+WWlzXUtQEA/4e7zkVvD8JR
 25CCKfBbyRgfLd8CdMrj1LnmkMIF+epDwaFgwNX5TeFYQN4QCzduAchXgnbefq4FDq
 CcGqmYN75RJWA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Kees Cook <keescook@chromium.org>, Christophe Leroy
 <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v4 00/13] Fix LKDTM for PPC64/IA64/PARISC v4
In-Reply-To: <202202150807.D584917D34@keescook>
References: <cover.1644928018.git.christophe.leroy@csgroup.eu>
 <202202150807.D584917D34@keescook>
Date: Wed, 16 Feb 2022 23:22:33 +1100
Message-ID: <87y22bm25y.fsf@mpe.ellerman.id.au>
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
Cc: linux-arch@vger.kernel.org, linux-ia64@vger.kernel.org,
 linux-parisc@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Helge Deller <deller@gmx.de>, linux-kernel@vger.kernel.org, "James E.J.
 Bottomley" <James.Bottomley@hansenpartnership.com>, linux-mm@kvack.org,
 Paul Mackerras <paulus@samba.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Kees Cook <keescook@chromium.org> writes:
> On Tue, Feb 15, 2022 at 01:40:55PM +0100, Christophe Leroy wrote:
>> PPC64/IA64/PARISC have function descriptors. LKDTM doesn't work
>> on those three architectures because LKDTM messes up function
>> descriptors with functions.
>> 
>> This series does some cleanup in the three architectures and
>> refactors function descriptors so that it can then easily use it
>> in a generic way in LKDTM.
>
> Thanks for doing this! It looks good to me. :)

How should we merge this series, it's a bit all over the map.

I could put it in a topic branch?

cheers
