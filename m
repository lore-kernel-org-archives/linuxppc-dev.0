Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xCGfr6QVYzDrW6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 22:33:56 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: James Morse <james.morse@arm.com>,
 Zhou Chengming <zhouchengming1@huawei.com>
Cc: linux-kernel@vger.kernel.org, Andrey Vagin <avagin@openvz.org>,
 Roland McGrath <roland@hack.frob.com>, Oleg Nesterov <oleg@redhat.com>,
 Yury Norov <ynorov@caviumnetworks.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ptrace: Add compat PTRACE_{G,S}ETSIGMASK handlers
In-Reply-To: <596CDDB1.8010502@arm.com>
References: <20170629162637.10676-1-james.morse@arm.com>
 <87k2371i68.fsf@concordia.ellerman.id.au> <596CDDB1.8010502@arm.com>
Date: Wed, 19 Jul 2017 22:33:55 +1000
Message-ID: <87379sip1o.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

James Morse <james.morse@arm.com> writes:

> Hi Michael,
>
> On 17/07/17 11:17, Michael Ellerman wrote:
>> James Morse <james.morse@arm.com> writes:
>>> compat_ptrace_request() lacks handlers for PTRACE_{G,S}ETSIGMASK,
>>> instead using those in ptrace_request(). The compat variant should
>>> read a compat_sigset_t from userspace instead of ptrace_request()s
>>> sigset_t.
>>>
>>> While compat_sigset_t is the same size as sigset_t, it is defined as
>>> 2xu32, instead of a single u64. On a big-endian CPU this means that
>>> compat_sigset_t is passed to user-space using middle-endianness,
>>> where the least-significant u32 is written most significant byte
>>> first.
>>>
>>> If ptrace_request()s code is used userspace will read the most
>>> significant u32 where it expected the least significant.
>> 
>> But that's what the code has done since 2013.
>
>> So won't changing this break userspace that has been written to work
>> around that bug?
>
> Wouldn't the same program then be broken when run natively instead? To work
> around it userspace would have to know it was running under compat instead of
> natively.

True, it would be a mess to make it work in all cases. But that doesn't
mean someone hasn't done it :)

> This only affects this exotic ptrace API for big-endian compat users. I think
> there are so few users that no-one has noticed its broken.
>
> I'm only aware of CRIU using this[0], and it doesn't look like powerpc has to
> support compat-criu users:
> https://github.com/xemul/criu/tree/master/compel/arch
> only has a ppc64 entry, for which
> https://github.com/xemul/criu/blob/master/compel/arch/ppc64/plugins/include/asm/syscall-types.h
> puts 'bits per word' as 64, I don't think it supports ppc32, which is where this
> bug would be seen.
>
>
>> Or do we think nothing actually uses it in the wild and
>> we can get away with it?
>
> I think only Zhou Chengming has hit this, and there is no 'in the wild' code
> that actually inspects the buffer returned by the call.
>
> Zhou, were you using criu on big-endian ilp32 when you found this? Or was it
> some other project that uses this API..
> (ilp32 is a second user of compat on arm64)
...
>
> [0]
> The commit message that added this code points to CRIU and GDB. GDB doesn't use
> this API. Debian's codesearch (which obviously isn't exhaustive) only finds CRIU
> and systemtap making these calls.
>
> It looks like criu just save/restores the sigset_t as a blob:
> https://sources.debian.net/src/criu/2.12.1-2/criu/parasite-syscall.c/?hl=92#L92
>
> It's sigset_t helpers aren't aware of this bug:
> https://github.com/xemul/criu/blob/master/compel/include/uapi/ksigset.h
>
> Systemtap just makes some calls as part of a self test:
> https://sources.debian.net/src/systemtap/3.1-2/testsuite/systemtap.syscall/ptrace.c/?hl=198#L198

OK, that's pretty comprehensive.

You should just mention in the changelog that yes this breaks ABI but we
don't believe there are any users that will be affected, and the broken
behaviour is not easy to workaround in userspace.

cheers
