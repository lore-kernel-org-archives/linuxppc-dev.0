Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whBKd48YQzDqKp
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Jun 2017 20:45:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/5] powerpc/mm: split store_updates_sp() in two parts in
 do_page_fault()
In-Reply-To: <6daf8f4e-9b39-d585-2c64-9b0348fef123@c-s.fr>
References: <cover.1492606297.git.christophe.leroy@c-s.fr>
 <58f17a04cee5726467ef4e283dfbd7da68fa6ab4.1492606298.git.christophe.leroy@c-s.fr>
 <871sr23flh.fsf@concordia.ellerman.id.au>
 <6daf8f4e-9b39-d585-2c64-9b0348fef123@c-s.fr>
Date: Mon, 05 Jun 2017 20:45:06 +1000
Message-ID: <87shjer9vx.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Le 02/06/2017 =C3=A0 11:26, Michael Ellerman a =C3=A9crit :
>> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>>=20
>>> Only the get_user() in store_updates_sp() has to be done outside
>>> the mm semaphore. All the comparison can be done within the semaphore,
>>> so only when really needed.
>>>
>>> As we got a DSI exception, the address pointed by regs->nip is
>>> obviously valid, otherwise we would have had a instruction exception.
>>> So __get_user() can be used instead of get_user()
>>=20
>> I don't think that part is true.
>>=20
>> You took a DSI so there *was* an instruction at NIP, but since then it
>> may have been unmapped by another thread.
>>=20
>> So I don't think you can assume the get_user() will succeed.
>
> The difference between get_user() and __get_user() is that get_user()=20
> performs an access_ok() in addition.
>
> Doesn't access_ok() only checks whether addr is below TASK_SIZE to=20
> ensure it is a valid user address ?

Yeah more or less, via some gross macros.

I was actually not that worried about the switch from get_user() to
__get_user(), but rather that you removed the check of the return value.
ie.=20

-	if (get_user(inst, (unsigned int __user *)regs->nip))
-		return 0;

Became:

	if (is_write && user_mode(regs))
-		store_update_sp =3D store_updates_sp(regs);
+		__get_user(inst, (unsigned int __user *)regs->nip);


I think dropping the access_ok() probably is alright, because the NIP
must (should!) have been in userspace, though as Ben says it's always
good to be paranoid.

But ignoring that the address can fault at all is wrong AFAICS.

cheers
