Return-Path: <kernelmailz@googlemail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 60307B7063
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 28 Jun 2009 14:57:52 +1000 (EST)
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.153])
	by ozlabs.org (Postfix) with ESMTP id 85C6FDDD01
	for <linuxppc-dev@ozlabs.org>; Sun, 28 Jun 2009 14:57:50 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so938611fga.16
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jun 2009 21:57:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <m3ab3t4623.fsf@google.com>
References: <abe8a1fd0906271246q920124ard61422d9577e2d09@mail.gmail.com>
	<abe8a1fd0906271249k479e5a87gfe1ee9c02798a234@mail.gmail.com>
	<m3ab3t4623.fsf@google.com>
Date: Sun, 28 Jun 2009 10:27:47 +0530
Message-ID: <abe8a1fd0906272157j4246e9d3hec2e374535a22c89@mail.gmail.com>
Subject: Re: Inline Assembly queries
From: kernel mailz <kernelmailz@googlemail.com>
To: Ian Lance Taylor <iant@google.com>
Content-Type: text/plain; charset=windows-1252
Cc: gcc-help@gcc.gnu.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thanks Ian,
For the "memory" clobber
I tried with the a function in linux kernel

--
/*
 * Atomic exchange
 *
 * Changes the memory location '*ptr' to be val and returns
 * the previous value stored there.
 */
static inline unsigned long
__xchg_u32(volatile void *p, unsigned long val)
{
        unsigned long prev;

        __asm__ __volatile__(

"1:     lwarx   %0,0,%2 \n"

"       stwcx.  %3,0,%2 \n\
        bne-    1b"

        : "=3D&r" (prev), "+m" (*(volatile unsigned int *)p)
        : "r" (p), "r" (val)
//        :"memory","cc");

        return prev;
}
#define ADDR 0x1000
int main()
{
	__xchg_u32((void*)ADDR, 0x2000);
	__xchg_u32((void*)ADDR, 0x3000);

	return 0;

}

Got the same asm, when compiled with O1 , with / without "memory" clobber

100003fc <main>:
100003fc:       39 20 10 00     li      r9,4096
10000400:       38 00 20 00     li      r0,8192
10000404:       7d 60 48 28     lwarx   r11,0,r9
10000408:       7c 00 49 2d     stwcx.  r0,0,r9
1000040c:       40 a2 ff f8     bne-    10000404 <main+0x8>
10000410:       38 00 30 00     li      r0,12288
10000414:       7d 60 48 28     lwarx   r11,0,r9
10000418:       7c 00 49 2d     stwcx.  r0,0,r9
1000041c:       40 a2 ff f8     bne-    10000414 <main+0x18>
10000420:       38 60 00 00     li      r3,0
10000424:       4e 80 00 20     blr

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
