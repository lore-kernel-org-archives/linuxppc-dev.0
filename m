Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vfkfZ3wJ1zDqXx
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Mar 2017 21:54:30 +1100 (AEDT)
Subject: Re: [PATCH] powerpc: sysdev: cpm1: Optimise gpio bit calculation
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
References: <20170309094206.A832167992@localhost.localdomain>
 <87a88tle0y.fsf@concordia.ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <534d8795-ce21-9af6-498d-22597213a3a2@c-s.fr>
Date: Fri, 10 Mar 2017 11:54:19 +0100
MIME-Version: 1.0
In-Reply-To: <87a88tle0y.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 10/03/2017 à 09:41, Michael Ellerman a écrit :
> Christophe Leroy <christophe.leroy@c-s.fr> writes:
>
>> Help a bit the compiler to provide better code:
>>
>> unsigned int f(int i)
>> {
>> 	return 1 << (31 - i);
>> }
>>
>> unsigned int g(int i)
>> {
>> 	return 0x80000000 >> i;
>> }
>>
>> Disassembly of section .text:
>>
>> 00000000 <f>:
>>    0:	20 63 00 1f 	subfic  r3,r3,31
>>    4:	39 20 00 01 	li      r9,1
>>    8:	7d 23 18 30 	slw     r3,r9,r3
>>    c:	4e 80 00 20 	blr
>>
>> 00000010 <g>:
>>   10:	3d 20 80 00 	lis     r9,-32768
>>   14:	7d 23 1c 30 	srw     r3,r9,r3
>>   18:	4e 80 00 20 	blr
>
> Well yeah, it saves one instruction, but is it worth it? Are these gpio
> routines in some hot path I don't know about?
>

It saves one instruction, and one register (see other exemple below 
where r3 is to be preserved)

gpio_get() and gpio_set() are used extensively by some GPIO based 
drivers like SPI, NAND, so it may be worth it as it doesn't impair 
readability (if anyone prefers, we could write  (1 << 31) >> i  instead 
of  0x80000000 >> i )

unsigned int f(int i, unsigned int *a)
{
	*a = 1 << (31 - i);

	return i;
}

unsigned int g(int i, unsigned int *a)
{
	*a = 0x80000000 >> i;

	return i;
}

toto.o:     file format elf32-powerpc


Disassembly of section .text:

00000000 <f>:
    0:	21 43 00 1f 	subfic  r10,r3,31
    4:	39 20 00 01 	li      r9,1
    8:	7d 29 50 30 	slw     r9,r9,r10
    c:	91 24 00 00 	stw     r9,0(r4)
   10:	4e 80 00 20 	blr

00000014 <g>:
   14:	3d 20 80 00 	lis     r9,-32768
   18:	7d 29 1c 30 	srw     r9,r9,r3
   1c:	91 24 00 00 	stw     r9,0(r4)
   20:	4e 80 00 20 	blr
