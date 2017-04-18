Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3w6Z1B3VX6zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Apr 2017 15:48:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm: some cleanup of do_page_fault()
In-Reply-To: <20170413145342.40ED56E667@localhost.localdomain>
References: <20170413145342.40ED56E667@localhost.localdomain>
Date: Tue, 18 Apr 2017 15:48:11 +1000
Message-ID: <87shl66zc4.fsf@concordia.ellerman.id.au>
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> This patch is a bunch of small cleanups of the do_page_fault()
> function:
> 1/ Function store_updates_sp() checks whether the faulting
> instruction is a store updating r1. Therefore we can limit its calls
> to stores exceptions
> 2/ Only the get_user() in store_updates_sp() has to be done outside
> the mm semaphore. All the comparison can be done within the semaphore,
> so only when really needed.
> 3/ As we got a DSI exception, the address pointed by regs->nip is
> obviously valid, otherwise we would have had a instruction exception.
> So __get_user() can be used instead of get_user()
> 4/ Replaced one duplicate 'trap == 0x400' by 'is_exec'
> 5/ Created a 'is_user = user_mode(regs)' and replaced all
> 'user_mode(regs)'.
> Analysis of the assembly code shows that when using user_mode(regs),
> at least the 'andi. r7,r8,16384' is redone several times, and also
> the 'lwz r8,132(r31)' at times. With the new form, the 'is_user'
> is mapped to cr4, then all further use of is_user results in just
> things like 'beq cr4,218 <do_page_fault+0x218>'
> 6/ The 8xx has a dedicated exception for breakpoints, that directly
> calls do_break()

Those are probably all OK, if you send them as separate patches.

> 7/ stdu and stdux only exist on PPC64, so no need to check for them
> on PPC32

I don't love that, because it adds two ifdefs in the C code and the gain
must be pretty small.

cheers
