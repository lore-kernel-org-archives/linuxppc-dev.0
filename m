Return-Path: <aph@redhat.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 9D6ECB70CA
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 19:31:12 +1000 (EST)
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id D90BADDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 19:31:11 +1000 (EST)
Message-ID: <4A49DB4D.5060304@redhat.com>
Date: Tue, 30 Jun 2009 10:30:53 +0100
From: Andrew Haley <aph@redhat.com>
MIME-Version: 1.0
To: kernel mailz <kernelmailz@googlemail.com>
Subject: Re: Inline Assembly queries
References: <abe8a1fd0906271246q920124ard61422d9577e2d09@mail.gmail.com>
	<abe8a1fd0906271249k479e5a87gfe1ee9c02798a234@mail.gmail.com>
	<m3ab3t4623.fsf@google.com>
	<abe8a1fd0906272157j4246e9d3hec2e374535a22c89@mail.gmail.com>
	<abe8a1fd0906290849w1ba6bd33of60a9c2e110c10fd@mail.gmail.com>
	<m3ljna20fx.fsf@google.com>
	<abe8a1fd0906292253ye4595c9wb0c085b7d89aea7@mail.gmail.com>
In-Reply-To: <abe8a1fd0906292253ye4595c9wb0c085b7d89aea7@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: gcc-help@gcc.gnu.org, linuxppc-dev@ozlabs.org,
	Ian Lance Taylor <iant@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

kernel mailz wrote:
> Consider atomic_add and atomic_add_return in kernel code.
> 
> On Tue, Jun 30, 2009 at 2:59 AM, Ian Lance Taylor<iant@google.com> wrote:
>> kernel mailz <kernelmailz@googlemail.com> writes:
>>
>>> I tried a small example
>>>
>>> int *p = 0x1000;
>>> int a = *p;
>>> asm("sync":::"memory");
>>> a = *p;
>>>
>>> and
>>>
>>> volatile int *p = 0x1000;
>>> int a = *p;
>>> asm("sync");
>>> a = *p
>>>
>>> Got the same assembly.
>>> Which is right.
>>>
>>> So does it mean, if proper use of volatile is done, there is no need
>>> of "memory" ?
>> You have to consider the effects of inlining, which may bring in other
>> memory loads and stores through non-volatile pointers.

> Consider
> 
> static __inline__ void atomic_add(int a, atomic_t *v)
> {
>         int t;
> 
>         __asm__ __volatile__(
> "1:     lwarx   %0,0,%3         # atomic_add\n\
>         add     %0,%2,%0\n"
>         PPC405_ERR77(0,%3)
> "       stwcx.  %0,0,%3 \n\
>         bne-    1b"
>         : "=&r" (t), "+m" (v->counter)
>         : "r" (a), "r" (&v->counter)
>         : "cc");
> }
> 
> static __inline__ int atomic_add_return(int a, atomic_t *v)
> {
>         int t;
> 
>         __asm__ __volatile__(
>         LWSYNC_ON_SMP
> "1:     lwarx   %0,0,%2         # atomic_add_return\n\
>         add     %0,%1,%0\n"
>         PPC405_ERR77(0,%2)
> "       stwcx.  %0,0,%2 \n\
>         bne-    1b"
>         ISYNC_ON_SMP
>         : "=&r" (t)
>         : "r" (a), "r" (&v->counter)
>         : "cc", "memory");
> 
>         return t;
> }
> 
> I am not able to figure out why "memory" is added in latter

The latter, as well as its stated purpose, forms a memory barrier, so the
compiler must be prevented from moving memory access across it.  See
http://www.open-std.org/jtc1/sc22/wg21/docs/papers/2008/n2745.html

Andrew.
