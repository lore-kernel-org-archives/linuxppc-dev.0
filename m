Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r5gZ016XNzDq6M
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 May 2016 16:54:00 +1000 (AEST)
Subject: Re: powerpc: Discard ffs() function and use builtin_ffs instead
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Scott Wood <oss@buserror.net>
References: <3r5flF6kL6z9t5R@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <762b62b5-0246-7045-e4cf-7559ab8c5bb2@c-s.fr>
Date: Fri, 13 May 2016 08:53:55 +0200
MIME-Version: 1.0
In-Reply-To: <3r5flF6kL6z9t5R@ozlabs.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 13/05/2016 à 08:16, Michael Ellerman a écrit :
> On Thu, 2016-12-05 at 15:32:22 UTC, Christophe Leroy wrote:
>> With the ffs() function as defined in arch/powerpc/include/asm/bitops.h
>> GCC will not optimise the code in case of constant parameter, as shown
>> by the small exemple below.
>>
>> int ffs_test(void)
>> {
>> 	return 4 << ffs(31);
>> }
>>
>> c0012334 <ffs_test>:
>> c0012334:       39 20 00 01     li      r9,1
>> c0012338:       38 60 00 04     li      r3,4
>> c001233c:       7d 29 00 34     cntlzw  r9,r9
>> c0012340:       21 29 00 20     subfic  r9,r9,32
>> c0012344:       7c 63 48 30     slw     r3,r3,r9
>> c0012348:       4e 80 00 20     blr
>>
>> With this patch, the same function will compile as follows:
>>
>> c0012334 <ffs_test>:
>> c0012334:       38 60 00 08     li      r3,8
>> c0012338:       4e 80 00 20     blr
>
> But what code does it generate when it's not a constant?

The generated code is the same with and without the patch when not a 
constant:

int ffs_test2(int x)
{
     return ffs(x);
}

c001233c <ffs_test2>:
c001233c:       7d 23 00 d0     neg     r9,r3
c0012340:       7d 23 18 38     and     r3,r9,r3
c0012344:       7c 63 00 34     cntlzw  r3,r3
c0012348:       20 63 00 20     subfic  r3,r3,32
c001234c:       4e 80 00 20     blr

>
> And which gcc version first added the builtin version?
Don't know, but __builtin_ffs() is already used in 
arch/powerpc/include/asm/page_32.h

Christophe
