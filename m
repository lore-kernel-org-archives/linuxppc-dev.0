Return-Path: <appro@fy.chalmers.se>
Received: from anubis.medic.chalmers.se (anubis.medic.chalmers.se
	[129.16.30.218]) by ozlabs.org (Postfix) with ESMTP id BDD7567C9E
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Jul 2005 07:22:55 +1000 (EST)
Message-ID: <42CAFA23.7080700@fy.chalmers.se>
Date: Tue, 05 Jul 2005 23:22:43 +0200
From: Andy Polyakov <appro@fy.chalmers.se>
MIME-Version: 1.0
To: openssl-dev@openssl.org
References: <19EE6EC66973A5408FBE4CB7772F6F0A02C8770E@ltnmail.xyplex.com>	
	<4dd15d1805070508312427a0ba@mail.gmail.com>	
	<4dd15d1805070508451b76afae@mail.gmail.com>	
	<4dd15d1805070509361339d08e@mail.gmail.com>	
	<4dd15d1805070510015cdaac04@mail.gmail.com>
	<4dd15d18050705132178b5fd92@mail.gmail.com>
In-Reply-To: <4dd15d18050705132178b5fd92@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC bn_div_words routine rewrite
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Let's take first call to BN_div_word for example from BN_bn2dec, the
> parameter being passed to BN_div_word is (a=35, w=1000000000) (decimal
> numbers).  It then calls the bn_div_words with (h=0, l=35,
> d=1000000000)  if you examine the code in linux_ppc32.s it will exit
> early on because h is 0.  the routine returns a divide by 0,  which is
> undefined according to the manual.  In the case of ppc8xx the result
> is 0x80000000.

And on the PPC machine I have access to it returns 0. This is 
explanation why I never experienced any SEGV, but a sparse decimal 
output. And it does explain why BN_is_zero condition never met on your 
system and you hit sbrk(0) limit and suffer the penalty. However! Note 
that updated routine, 
http://cvs.openssl.org/getfile/openssl/crypto/bn/asm/ppc.pl?v=1.4 never 
issues divide by 0 [it traps instead, but the condition is never met now 
when called from BN_div_words] and it does return correct answer to me. 
Can you really confirm that updated subroutine doesn't work for you? And 
if so, how does problem manifest? Still SEGV? At same point?

It should pointed out that bug in ppc.pl is encountered only in 0.9.7 
context, as 0.9.8 avoids it by normalizing divisor [and adjusting 
dividend accordingly]. BTW, I can confirm that 0.9.7 produces correct 
decimal ASCII with your routine [but no luck with make test_bn], but in 
0.9.8 context decimal printout comes out truncated [not sparse with some 
significant digits there and there, but truncated] if your routine is 
pasted in. A.
