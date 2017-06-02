Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfJkQ4mlmzDqLt
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 19:26:38 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/5] powerpc/mm: split store_updates_sp() in two parts in
 do_page_fault()
In-Reply-To: <58f17a04cee5726467ef4e283dfbd7da68fa6ab4.1492606298.git.christophe.leroy@c-s.fr>
References: <cover.1492606297.git.christophe.leroy@c-s.fr>
 <58f17a04cee5726467ef4e283dfbd7da68fa6ab4.1492606298.git.christophe.leroy@c-s.fr>
Date: Fri, 02 Jun 2017 19:26:34 +1000
Message-ID: <871sr23flh.fsf@concordia.ellerman.id.au>
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

> Only the get_user() in store_updates_sp() has to be done outside
> the mm semaphore. All the comparison can be done within the semaphore,
> so only when really needed.
>
> As we got a DSI exception, the address pointed by regs->nip is
> obviously valid, otherwise we would have had a instruction exception.
> So __get_user() can be used instead of get_user()

I don't think that part is true.

You took a DSI so there *was* an instruction at NIP, but since then it
may have been unmapped by another thread.

So I don't think you can assume the get_user() will succeed.

cheers
