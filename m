Return-Path: <kernelmailz@googlemail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 8A650B7102
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 01:49:59 +1000 (EST)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.154])
	by ozlabs.org (Postfix) with ESMTP id B850CDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 01:49:58 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1216869fga.16
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 08:49:58 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <abe8a1fd0906272157j4246e9d3hec2e374535a22c89@mail.gmail.com>
References: <abe8a1fd0906271246q920124ard61422d9577e2d09@mail.gmail.com>
	<abe8a1fd0906271249k479e5a87gfe1ee9c02798a234@mail.gmail.com>
	<m3ab3t4623.fsf@google.com>
	<abe8a1fd0906272157j4246e9d3hec2e374535a22c89@mail.gmail.com>
Date: Mon, 29 Jun 2009 21:19:57 +0530
Message-ID: <abe8a1fd0906290849w1ba6bd33of60a9c2e110c10fd@mail.gmail.com>
Subject: Inline Assembly queries
From: kernel mailz <kernelmailz@googlemail.com>
To: gcc-help@gcc.gnu.org, linuxppc-dev@ozlabs.org
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I tried a small example

int *p =3D 0x1000;
int a =3D *p;
asm("sync":::"memory");
a =3D *p;

and

volatile int *p =3D 0x1000;
int a =3D *p;
asm("sync");
a =3D *p

Got the same assembly.
Which is right.

So does it mean, if proper use of volatile is done, there is no need
of "memory" ?
But then why  below example of __xchg uses both ?

I am confused!
Anyone has a clue?

-TZ


---------- Forwarded message ----------
From: kernel mailz <kernelmailz@googlemail.com>
Date: Sun, Jun 28, 2009 at 10:27 AM
Subject: Re: Inline Assembly queries
To: Ian Lance Taylor <iant@google.com>
Cc: gcc-help@gcc.gnu.org, linuxppc-dev@ozlabs.org


Thanks Ian,
For the "memory" clobber
I tried with the a function in linux kernel

--
/*
=A0* Atomic exchange
=A0*
=A0* Changes the memory location '*ptr' to be val and returns
=A0* the previous value stored there.
=A0*/
static inline unsigned long
__xchg_u32(volatile void *p, unsigned long val)
{
=A0 =A0 =A0 =A0unsigned long prev;

=A0 =A0 =A0 =A0__asm__ __volatile__(

"1: =A0 =A0 lwarx =A0 %0,0,%2 \n"

" =A0 =A0 =A0 stwcx. =A0%3,0,%2 \n\
=A0 =A0 =A0 =A0bne- =A0 =A01b"

=A0 =A0 =A0 =A0: "=3D&r" (prev), "+m" (*(volatile unsigned int *)p)
=A0 =A0 =A0 =A0: "r" (p), "r" (val)
// =A0 =A0 =A0 =A0:"memory","cc");

=A0 =A0 =A0 =A0return prev;
}
#define ADDR 0x1000
int main()
{
=A0 =A0 =A0 =A0__xchg_u32((void*)ADDR, 0x2000);
=A0 =A0 =A0 =A0__xchg_u32((void*)ADDR, 0x3000);

=A0 =A0 =A0 =A0return 0;

}

Got the same asm, when compiled with O1 , with / without "memory" clobber

100003fc <main>:
100003fc: =A0 =A0 =A0 39 20 10 00 =A0 =A0 li =A0 =A0 =A0r9,4096
10000400: =A0 =A0 =A0 38 00 20 00 =A0 =A0 li =A0 =A0 =A0r0,8192
10000404: =A0 =A0 =A0 7d 60 48 28 =A0 =A0 lwarx =A0 r11,0,r9
10000408: =A0 =A0 =A0 7c 00 49 2d =A0 =A0 stwcx. =A0r0,0,r9
1000040c: =A0 =A0 =A0 40 a2 ff f8 =A0 =A0 bne- =A0 =A010000404 <main+0x8>
10000410: =A0 =A0 =A0 38 00 30 00 =A0 =A0 li =A0 =A0 =A0r0,12288
10000414: =A0 =A0 =A0 7d 60 48 28 =A0 =A0 lwarx =A0 r11,0,r9
10000418: =A0 =A0 =A0 7c 00 49 2d =A0 =A0 stwcx. =A0r0,0,r9
1000041c: =A0 =A0 =A0 40 a2 ff f8 =A0 =A0 bne- =A0 =A010000414 <main+0x18>
10000420: =A0 =A0 =A0 38 60 00 00 =A0 =A0 li =A0 =A0 =A0r3,0
10000424: =A0 =A0 =A0 4e 80 00 20 =A0 =A0 blr

No diff ?
am I choosing the right example ?

-TZ


On Sun, Jun 28, 2009 at 4:50 AM, Ian Lance Taylor<iant@google.com> wrote:
> kernel mailz <kernelmailz@googlemail.com> writes:
>
>> I've been fiddling my luck with gcc 4.3.2 inline assembly on powerpc
>> There are a few queries
>>
>> 1. asm volatile or simply asm produce the same assembly code.
>> Tried with a few examples but didnt find any difference by adding
>> volatile with asm
>>
>> 2. Use of "memory" and clobbered registers.
>>
>> "memory" -
>> a. announce to the compiler that the memory has been modified
>> b. this instruction writes to some memory (other than a listed output)
>> and GCC shouldn=92t cache memory values in registers across this asm.
>>
>> I tried with stw and stwcx instruction, adding "memory" has no effect.
>>
>> Is there any example scenerio where gcc would generate different
>> assembly by adding / removing "memory" ?
>
> Please never send a message to both gcc@gcc.gnu.org and
> gcc-help@gcc.gnu.org. =A0This message is appropriate for
> gcc-help@gcc.gnu.org, not for gcc@gcc.gnu.org. =A0Thanks.
>
> An asm with no outputs is always considered to be volatile. =A0To see the
> affect of volatile, just try something like
> =A0 =A0asm ("# modify %0" : "=3Dr" (i) : /* no inputs */ : /* no clobbers=
 */);
> Try it with and without optimization.
>
> As the documentation says, the effect of adding a "memory" clobber is
> that gcc does not cache values in registers across the asm. =A0So the
> effect will be shown in something like
> =A0int i =3D *p;
> =A0asm volatile ("# read %0" : : "r" (i));
> =A0return *p;
> The memory clobber will only make a different when optimizing.
>
> Ian
>
