Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whMk16GLWzDqKp
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 03:48:24 +1000 (AEST)
Subject: Re: [PATCH 2/5] powerpc/mm: split store_updates_sp() in two parts in
 do_page_fault()
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
References: <cover.1492606297.git.christophe.leroy@c-s.fr>
 <58f17a04cee5726467ef4e283dfbd7da68fa6ab4.1492606298.git.christophe.leroy@c-s.fr>
 <871sr23flh.fsf@concordia.ellerman.id.au>
 <6daf8f4e-9b39-d585-2c64-9b0348fef123@c-s.fr>
 <87shjer9vx.fsf@concordia.ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <97200860-c6da-9d4d-fb53-2aa9c9ca655f@c-s.fr>
Date: Mon, 5 Jun 2017 19:48:16 +0200
MIME-Version: 1.0
In-Reply-To: <87shjer9vx.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 05/06/2017 à 12:45, Michael Ellerman a écrit :
> Christophe LEROY <christophe.leroy@c-s.fr> writes:
>
>> Le 02/06/2017 à 11:26, Michael Ellerman a écrit :
>>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>>
>>>> Only the get_user() in store_updates_sp() has to be done outside
>>>> the mm semaphore. All the comparison can be done within the semaphore,
>>>> so only when really needed.
>>>>
>>>> As we got a DSI exception, the address pointed by regs->nip is
>>>> obviously valid, otherwise we would have had a instruction exception.
>>>> So __get_user() can be used instead of get_user()
>>>
>>> I don't think that part is true.
>>>
>>> You took a DSI so there *was* an instruction at NIP, but since then it
>>> may have been unmapped by another thread.
>>>
>>> So I don't think you can assume the get_user() will succeed.
>>
>> The difference between get_user() and __get_user() is that get_user()
>> performs an access_ok() in addition.
>>
>> Doesn't access_ok() only checks whether addr is below TASK_SIZE to
>> ensure it is a valid user address ?
>
> Yeah more or less, via some gross macros.
>
> I was actually not that worried about the switch from get_user() to
> __get_user(), but rather that you removed the check of the return value.
> ie.
>
> -	if (get_user(inst, (unsigned int __user *)regs->nip))
> -		return 0;
>
> Became:
>
> 	if (is_write && user_mode(regs))
> -		store_update_sp = store_updates_sp(regs);
> +		__get_user(inst, (unsigned int __user *)regs->nip);
>
>
> I think dropping the access_ok() probably is alright, because the NIP
> must (should!) have been in userspace, though as Ben says it's always
> good to be paranoid.
>
> But ignoring that the address can fault at all is wrong AFAICS.

I see what you mean now.

Indeed,

-	unsigned int inst;

Became

+	unsigned int inst = 0;

Since __get_user() doesn't modify 'inst' in case of error, 'inst' 
remains 0, and store_updates_sp(0) return false. That was the idea behind.

Christophe

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
