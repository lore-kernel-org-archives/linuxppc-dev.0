Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wfK1f3NwfzDqLy
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Jun 2017 19:39:50 +1000 (AEST)
Subject: Re: [PATCH 2/5] powerpc/mm: split store_updates_sp() in two parts in
 do_page_fault()
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
References: <cover.1492606297.git.christophe.leroy@c-s.fr>
 <58f17a04cee5726467ef4e283dfbd7da68fa6ab4.1492606298.git.christophe.leroy@c-s.fr>
 <871sr23flh.fsf@concordia.ellerman.id.au>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <6daf8f4e-9b39-d585-2c64-9b0348fef123@c-s.fr>
Date: Fri, 2 Jun 2017 11:39:23 +0200
MIME-Version: 1.0
In-Reply-To: <871sr23flh.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 02/06/2017 à 11:26, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
> 
>> Only the get_user() in store_updates_sp() has to be done outside
>> the mm semaphore. All the comparison can be done within the semaphore,
>> so only when really needed.
>>
>> As we got a DSI exception, the address pointed by regs->nip is
>> obviously valid, otherwise we would have had a instruction exception.
>> So __get_user() can be used instead of get_user()
> 
> I don't think that part is true.
> 
> You took a DSI so there *was* an instruction at NIP, but since then it
> may have been unmapped by another thread.
> 
> So I don't think you can assume the get_user() will succeed.
> 

The difference between get_user() and __get_user() is that get_user() 
performs an access_ok() in addition.

Doesn't access_ok() only checks whether addr is below TASK_SIZE to 
ensure it is a valid user address ?

Christophe
