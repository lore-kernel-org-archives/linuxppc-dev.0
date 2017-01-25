Return-Path: <arndbergmann@gmail.com>
Received: from mail-ot0-x243.google.com (mail-ot0-x243.google.com
 [IPv6:2607:f8b0:4003:c0f::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7q945X8gzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jan 2017 02:44:08 +1100 (AEDT)
Received: by mail-ot0-x243.google.com with SMTP id 73so23928747otj.1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 07:44:08 -0800 (PST)
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB026DC3C@AcuExch.aculab.com>
References: <20170121120339.1c774b28@kryten> <20170121204948.742f89bf@kryten>
 <87pojd9e5l.fsf@concordia.ellerman.id.au>
 <063D6719AE5E284EB5DD2968C1650D6DB026DC3C@AcuExch.aculab.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 25 Jan 2017 16:44:05 +0100
Message-ID: <CAK8P3a1wVG=_GS8a9z89hPcrNHAXSxN9EqUQRb37ujPC3baWQA@mail.gmail.com>
Subject: Re: BUILD_BUG_ON(!__builtin_constant_p(feature)) breaks bcc trace tool
To: David Laight <David.Laight@aculab.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Anton Blanchard <anton@samba.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Nicholas Piggin <npiggin@gmail.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 25, 2017 at 11:35 AM, David Laight <David.Laight@aculab.com> wrote:
> From: Michael Ellerman

>> #define inline                inline          __attribute__((always_inline)) notrace
>>
>> So in fact every inline function is marked always_inline all the time,
>> which seems dubious.
>
> I've had to do that in the past to get gcc to inline some small leaf functions
> that were only called once.
> (That was for some embedded code where I don't actually want any function calls
> at all.)
>
> To my mind 'inline' should mean 'always_inline' since you need to explicitly
> stop functions being inlined even when not marked 'inline'.

On x86, this is configurable using OPTIMIZE_INLINING, but IIRC no
other architecture
supports it in mainline Linux. I have played a bit with enabling it on
ARM, which
showed a couple of build warnings and errors from the changed inlining, but
they were all fixable. I have not submitted that since I have not actually been
able to do extensive runtime testing on it.

It may turn out to be worthwhile for powerpc, where you have a much more limited
set of configurations you care about and you already do some regular testing.
Potentially this is more efficient than the current default, and any
function that
actually requires being forced inline can be annotated as __always_inline rather
than plain inline.

     Arnd
