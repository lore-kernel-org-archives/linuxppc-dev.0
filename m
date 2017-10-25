Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMQdT5820zDqkr
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 21:01:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64: set DSCR default initially from SPR
In-Reply-To: <20171024114444.13933-1-npiggin@gmail.com>
References: <20171024114444.13933-1-npiggin@gmail.com>
Date: Wed, 25 Oct 2017 12:01:10 +0200
Message-ID: <874lqn1r89.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> Take the DSCR value set by firmware as the dscr_default value,
> rather than zero.
>
> POWER9 recommends DSCR default to a non-zero value.
>
> From: Nicholas Piggin <npiggin@gmail.com>
> ---
> This has a problem that OS which set the DSCR to non-default
> then kexec to Linux will be used as our default. I send a
> corresponding patch to skiboot which resets SPRs in opal_reinit_cpus
> which will make this do the right thing in that case.

That doesn't work for pseries etc.

We should reset it in the kexec down path.

cheers
