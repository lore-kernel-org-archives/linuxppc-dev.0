Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9zkV2YkKzDrD4
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 20:17:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: James Morse <james.morse@arm.com>, linux-kernel@vger.kernel.org
Cc: Zhou Chengming <zhouchengming1@huawei.com>,
 Andrey Vagin <avagin@openvz.org>, Roland McGrath <roland@hack.frob.com>,
 Oleg Nesterov <oleg@redhat.com>, Yury Norov <ynorov@caviumnetworks.com>,
 James Morse <james.morse@arm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] ptrace: Add compat PTRACE_{G,S}ETSIGMASK handlers
In-Reply-To: <20170629162637.10676-1-james.morse@arm.com>
References: <20170629162637.10676-1-james.morse@arm.com>
Date: Mon, 17 Jul 2017 20:17:35 +1000
Message-ID: <87k2371i68.fsf@concordia.ellerman.id.au>
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

> compat_ptrace_request() lacks handlers for PTRACE_{G,S}ETSIGMASK,
> instead using those in ptrace_request(). The compat variant should
> read a compat_sigset_t from userspace instead of ptrace_request()s
> sigset_t.
>
> While compat_sigset_t is the same size as sigset_t, it is defined as
> 2xu32, instead of a single u64. On a big-endian CPU this means that
> compat_sigset_t is passed to user-space using middle-endianness,
> where the least-significant u32 is written most significant byte
> first.
>
> If ptrace_request()s code is used userspace will read the most
> significant u32 where it expected the least significant.

But that's what the code has done since 2013.

So won't changing this break userspace that has been written to work
around that bug? Or do we think nothing actually uses it in the wild and
we can get away with it?

cheers
