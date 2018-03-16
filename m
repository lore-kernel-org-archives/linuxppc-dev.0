Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402mNr3JKlzDqnN
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 00:23:08 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>,
 Michal Suchanek <msuchanek@suse.de>
Cc: Kate Stewart <kstewart@linuxfoundation.org>, Madhavan Srinivasan
 <maddy@linux.vnet.ibm.com>, Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Michael Neuling <mikey@neuling.org>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, "Naveen N. Rao"
 <naveen.n.rao@linux.vnet.ibm.com>, Daniel Axtens <dja@axtens.net>,
 Nicholas Piggin <npiggin@gmail.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater
 <clg@kaod.org>, David Gibson <david@gibson.dropbear.id.au>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Linux Kernel Mailing List
 <linux-kernel@vger.kernel.org>, Sergey Senozhatsky
 <sergey.senozhatsky@gmail.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Andrew Donnellan <andrew.donnellan@au1.ibm.com>, Philippe Ombredanne
 <pombredanne@nexb.com>, Joe Perches <joe@perches.com>, Oliver O'Halloran
 <oohall@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, "Tobin C.
 Harding" <me@tobin.cc>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Al Viro
 <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH RFC rebase 2/9] powerpc: Use barrier_nospec in
 copy_from_user
In-Reply-To: <CA+55aFw8LJ7T_4jTe4q5q0d2JuP0iBWdwcTXZULKe-c4w7QrPA@mail.gmail.com>
References: <20180313200108.GA4082@hirez.programming.kicks-ass.net>
 <cover.1521141122.git.msuchanek@suse.de>
 <32268431948dc1a32264a98a76d41d71ae7536b3.1521141122.git.msuchanek@suse.de>
 <CA+55aFw8LJ7T_4jTe4q5q0d2JuP0iBWdwcTXZULKe-c4w7QrPA@mail.gmail.com>
Date: Sat, 17 Mar 2018 00:22:54 +1100
Message-ID: <87605wi28h.fsf@concordia.ellerman.id.au>
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

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Mar 15, 2018 at 12:15 PM, Michal Suchanek <msuchanek@suse.de> wrote:
>> This is based on x86 patch doing the same.
>>
>> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
>> ---
>> --- a/arch/powerpc/include/asm/uaccess.h
>> +++ b/arch/powerpc/include/asm/uaccess.h
>> @@ -258,8 +259,10 @@ do {                                                               \
>>         long __gu_err = -EFAULT;                                        \
>>         unsigned long  __gu_val = 0;                                    \
>>         const __typeof__(*(ptr)) __user *__gu_addr = (ptr);             \
>> +       int can_access = access_ok(VERIFY_READ, __gu_addr, (size));     \
>>         might_fault();                                                  \
>> -       if (access_ok(VERIFY_READ, __gu_addr, (size)))                  \
>> +       barrier_nospec();                                               \
>> +       if (can_access)                                                 \
>>                 __get_user_size(__gu_val, __gu_addr, (size), __gu_err); \
>>         (x) = (__force __typeof__(*(ptr)))__gu_val;                             \
>>         __gu_err;                                                       \
>
> Is the above really correct? The barrier is *before* the conditional
> branch that might be mis-predicted.
>
> I don't know how the ppc barrier works, but that sounds completely bogus.

Yeah it should be after the branch.

I don't have a formal spec for the barrier yet, it should be defined in
a hopefully soon to be released revision of the ISA.

But the gist is it will stall execution until any older branches are no
longer speculating.

It doesn't order any two arbitrary instructions, such as a comparison
and a branch, which I suspect is how Michal was interpreting it.

cheers
