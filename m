Return-Path: <kernelmailz@googlemail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1A887B70B6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 16:42:21 +1000 (EST)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by ozlabs.org (Postfix) with ESMTP id 07E97DDDE5
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 15:27:09 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id e21so762475fga.16
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 22:27:07 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20090629192722.GA12789@b07421-ec1.am.freescale.net>
References: <abe8a1fd0906271246q920124ard61422d9577e2d09@mail.gmail.com>
	<abe8a1fd0906271249k479e5a87gfe1ee9c02798a234@mail.gmail.com>
	<m3ab3t4623.fsf@google.com>
	<abe8a1fd0906272157j4246e9d3hec2e374535a22c89@mail.gmail.com>
	<abe8a1fd0906290849w1ba6bd33of60a9c2e110c10fd@mail.gmail.com>
	<20090629192722.GA12789@b07421-ec1.am.freescale.net>
Date: Tue, 30 Jun 2009 10:57:07 +0530
Message-ID: <abe8a1fd0906292227p15fbfe34r595e80db780b77ca@mail.gmail.com>
Subject: Re: Inline Assembly queries
From: kernel mailz <kernelmailz@googlemail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: gcc-help@gcc.gnu.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Scott,
I agree with you, kind of understand that it is required.
But buddy unless you see some construct work or by adding the
construct a visible difference is there, the concept is just piece of
theory.

I am trying all the kernel code inline assembly to find an example
that works differently with memory.

For instance take atomic_add , atomic_add_return, while the
atomic_add_return has the "memory", atomic_add skips it.

-TZ

On Tue, Jun 30, 2009 at 12:57 AM, Scott Wood<scottwood@freescale.com> wrote=
:
> On Mon, Jun 29, 2009 at 09:19:57PM +0530, kernel mailz wrote:
>> I tried a small example
>>
>> int *p =3D 0x1000;
>> int a =3D *p;
>> asm("sync":::"memory");
>> a =3D *p;
>>
>> and
>>
>> volatile int *p =3D 0x1000;
>> int a =3D *p;
>> asm("sync");
>> a =3D *p
>>
>> Got the same assembly.
>> Which is right.
>>
>> So does it mean, if proper use of volatile is done, there is no need
>> of "memory" ?
>
> No. =A0As I understand it, volatile concerns deletion of the asm statemen=
t
> (if no outputs are used) and reordering with respect to other asm
> statements (not sure whether GCC will actually do this), while the memory
> clobber concerns optimization of non-asm loads/stores around the asm
> statement.
>
>> static inline unsigned long
>> __xchg_u32(volatile void *p, unsigned long val)
>> {
>> =A0 =A0 =A0 =A0unsigned long prev;
>>
>> =A0 =A0 =A0 =A0__asm__ __volatile__(
>>
>> "1: =A0 =A0 lwarx =A0 %0,0,%2 \n"
>>
>> " =A0 =A0 =A0 stwcx. =A0%3,0,%2 \n\
>> =A0 =A0 =A0 =A0bne- =A0 =A01b"
>>
>> =A0 =A0 =A0 =A0: "=3D&r" (prev), "+m" (*(volatile unsigned int *)p)
>> =A0 =A0 =A0 =A0: "r" (p), "r" (val)
>> // =A0 =A0 =A0 =A0:"memory","cc");
>>
>> =A0 =A0 =A0 =A0return prev;
>> }
>> #define ADDR 0x1000
>> int main()
>> {
>> =A0 =A0 =A0 =A0__xchg_u32((void*)ADDR, 0x2000);
>> =A0 =A0 =A0 =A0__xchg_u32((void*)ADDR, 0x3000);
>>
>> =A0 =A0 =A0 =A0return 0;
>>
>> }
>>
>> Got the same asm, when compiled with O1 , with / without "memory" clobbe=
r
>
> This isn't a good test case, because there's nothing other than inline
> asm going on in that function for GCC to optimize. =A0Plus, it's generall=
y
> not a good idea, when talking about what the compiler is or isn't allowed
> to do, to point to a single test case (or even several) and say that it
> isn't required because you don't notice a difference. =A0Even if there we=
re
> no code at all with which it made a difference with GCC version X, it
> could make a difference with GCC version X+1.
>
> -Scott
>
