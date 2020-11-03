Return-Path: <SRS0=iSul=EJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEA66C00A89
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2020 02:28:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B6272067C
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2020 02:28:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="mOIZpq/4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B6272067C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4CQDH55pBYzDqRv
	for <linuxppc-dev@archiver.kernel.org>; Tue,  3 Nov 2020 13:28:33 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4CQDDz40DjzDqLH
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Nov 2020 13:26:43 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=mOIZpq/4; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4CQDDz1lnyz9s0b;
 Tue,  3 Nov 2020 13:26:42 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1604370403;
 bh=BqT7JctE/zlpiihTd1fDLn7PC/+kOybR9enb4DQTvbY=;
 h=From:To:Subject:In-Reply-To:References:Date:From;
 b=mOIZpq/4wRyJSRNFElpKDYQ2CFBdcjuHTpR3dpC/+EoEW7M95Szd3NNGnlTT5Io54
 yxFyXBjDNWNULYLFX5llTqKmdfCtemJrfPUAie858ctDvNQaJzlLKXWt2kJMhiA0P2
 gPvuN+HXhTLbJFYKQMpUUDBaV8U6XmLY9i/qWbV2ghuF9S87sgRU+rwQpM+WOl8pTg
 jecPAgJjuPR5Fge4uMtDmDwDY0UN7na++d6K9ALTEaEU7C7zc7qvoxhs36rC4lJYqP
 9w40eE90uiTGr6KHC+p6M6fCTjUaKq+UGyymftjr9cjL6D8m4Qupi5N1d2ave3SXAc
 1bKi+/ylaZnAQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Carl Jacobsen <cjacobsen@storix.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: Kernel panic from malloc() on SUSE 15.1?
In-Reply-To: <CAKkwB_S6Bs_+5At2aajbQbJg==WE_4NLdhSK=Bj+td67215Htg@mail.gmail.com>
References: <CAKkwB_S6Bs_+5At2aajbQbJg==WE_4NLdhSK=Bj+td67215Htg@mail.gmail.com>
Date: Tue, 03 Nov 2020 13:26:41 +1100
Message-ID: <878sbjuqe6.fsf@mpe.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Carl Jacobsen <cjacobsen@storix.com> writes:
> I've got a SUSE 15.1 install (on ppc64le) that kernel panics on a very
> simple
> test program, built in a slightly unusual way.
>
> I'm compiling on SUSE 12, using gcc 4.8.3. I'm linking to a static
> copy of libcrypto.a (from openssl-1.1.1g), built without threads.
> I have a 10 line C test program that compiles and runs fine on the
> SUSE 12 system. If I compile the same program on SUSE 15.1 (with
> gcc 7.4.1), it runs fine on SUSE 15.1.
>
> But, if I run the version that I compiled on SUSE 12, on the SUSE 15.1
> system, the call to RAND_status() gets to a malloc() and then panics.
> (And, of course, if I just compile a call to malloc(), that runs fine
> on both systems.) Here's the test program, it's really just a call to
> RAND_status():
>
>     #include <stdio.h>
>     #include <openssl/rand.h>
>
>     int main(int argc, char **argv)
>     {
>         int has_enough_data = RAND_status();
>         printf("The PRNG %s been seeded with enough data\n",
>                has_enough_data ? "HAS" : "has NOT");
>         return 0;
>     }
>
> openssl is configured/built with:
>     ./config no-shared no-dso no-threads -fPIC -ggdb3 -debug -static
>     make
>
> and the test program is compiled with:
>     gcc -ggdb3 -o rand_test rand_test.c libcrypto.a
>
> The kernel on SUSE 12 is: 3.12.28-4-default
> And glibc is: 2.19
>
> The kernel on SUSE 15.1 is: 4.12.14-197.18-default
> And glibc is: 2.26
>
> In a previous iteration it was panicking in pthread_once(), so
> I compiled openssl without pthreads support, and now it panics
> calling malloc().

What's the panic look like?

cheers
