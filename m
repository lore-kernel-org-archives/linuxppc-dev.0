Return-Path: <scottwood@freescale.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CEC15B7081
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 05:27:28 +1000 (EST)
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 673BEDDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 05:27:27 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n5TJRNsD017553
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 12:27:23 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n5TJRNpW020098
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jun 2009 14:27:23 -0500 (CDT)
Date: Mon, 29 Jun 2009 14:27:22 -0500
From: Scott Wood <scottwood@freescale.com>
To: kernel mailz <kernelmailz@googlemail.com>
Subject: Re: Inline Assembly queries
Message-ID: <20090629192722.GA12789@b07421-ec1.am.freescale.net>
References: <abe8a1fd0906271246q920124ard61422d9577e2d09@mail.gmail.com>
	<abe8a1fd0906271249k479e5a87gfe1ee9c02798a234@mail.gmail.com>
	<m3ab3t4623.fsf@google.com>
	<abe8a1fd0906272157j4246e9d3hec2e374535a22c89@mail.gmail.com>
	<abe8a1fd0906290849w1ba6bd33of60a9c2e110c10fd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <abe8a1fd0906290849w1ba6bd33of60a9c2e110c10fd@mail.gmail.com>
Cc: gcc-help@gcc.gnu.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 29, 2009 at 09:19:57PM +0530, kernel mailz wrote:
> I tried a small example
> 
> int *p = 0x1000;
> int a = *p;
> asm("sync":::"memory");
> a = *p;
> 
> and
> 
> volatile int *p = 0x1000;
> int a = *p;
> asm("sync");
> a = *p
> 
> Got the same assembly.
> Which is right.
> 
> So does it mean, if proper use of volatile is done, there is no need
> of "memory" ?

No.  As I understand it, volatile concerns deletion of the asm statement
(if no outputs are used) and reordering with respect to other asm
statements (not sure whether GCC will actually do this), while the memory
clobber concerns optimization of non-asm loads/stores around the asm
statement.

> static inline unsigned long
> __xchg_u32(volatile void *p, unsigned long val)
> {
>        unsigned long prev;
> 
>        __asm__ __volatile__(
> 
> "1:     lwarx   %0,0,%2 \n"
> 
> "       stwcx.  %3,0,%2 \n\
>        bne-    1b"
> 
>        : "=&r" (prev), "+m" (*(volatile unsigned int *)p)
>        : "r" (p), "r" (val)
> //        :"memory","cc");
> 
>        return prev;
> }
> #define ADDR 0x1000
> int main()
> {
>        __xchg_u32((void*)ADDR, 0x2000);
>        __xchg_u32((void*)ADDR, 0x3000);
> 
>        return 0;
> 
> }
> 
> Got the same asm, when compiled with O1 , with / without "memory" clobber

This isn't a good test case, because there's nothing other than inline
asm going on in that function for GCC to optimize.  Plus, it's generally
not a good idea, when talking about what the compiler is or isn't allowed
to do, to point to a single test case (or even several) and say that it
isn't required because you don't notice a difference.  Even if there were
no code at all with which it made a difference with GCC version X, it
could make a difference with GCC version X+1.

-Scott
