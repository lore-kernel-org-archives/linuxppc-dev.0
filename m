Return-Path: <arndbergmann@gmail.com>
Received: from mail-ot0-x241.google.com (mail-ot0-x241.google.com
 [IPv6:2607:f8b0:4003:c0f::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v73FX1p2xzDqRN
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 20:45:20 +1100 (AEDT)
Received: by mail-ot0-x241.google.com with SMTP id 65so18839666otq.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jan 2017 01:45:20 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <87pojd9e5l.fsf@concordia.ellerman.id.au>
References: <20170121120339.1c774b28@kryten> <20170121204948.742f89bf@kryten>
 <87pojd9e5l.fsf@concordia.ellerman.id.au>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 24 Jan 2017 10:45:17 +0100
Message-ID: <CAK8P3a34TqLGybCKMivu6jt38mY9yXD_6bYah8DH1+a86SpRQQ@mail.gmail.com>
Subject: Re: BUILD_BUG_ON(!__builtin_constant_p(feature)) breaks bcc trace tool
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Anton Blanchard <anton@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 24, 2017 at 7:15 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:

> Hmm, in fact it seems because we don't define
> CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING and CONFIG_OPTIMIZE_INLINING, we
> get:
>
> #define inline          inline          __attribute__((always_inline)) notrace
>
> So in fact every inline function is marked always_inline all the time,
> which seems dubious.
>
> But still, it seems clang is ignoring always_inline.

I think the problem is that __builtin_constant_p() is usually false on
clang, at least for arguments
that are not constant pointers.

    Arnd
