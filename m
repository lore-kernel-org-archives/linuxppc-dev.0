Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id AA6C72C0096
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:31:38 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 25 Jun 2013 12:27:53 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2DDE02BB0044
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:31:34 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5OFVPQd786930
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:31:25 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5OFVXhl027401
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 01:31:33 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Correct build warnings with CONFIG_TRANSPARENT_HUGEPAGE
 disabled
In-Reply-To: <87hagnzgzk.fsf@linux.vnet.ibm.com>
References: <51C8594B.1080701@linux.vnet.ibm.com>
 <87hagnzgzk.fsf@linux.vnet.ibm.com>
Date: Mon, 24 Jun 2013 21:01:31 +0530
Message-ID: <87ehbrzfsc.fsf@linux.vnet.ibm.com>
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

"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:

> Nathan Fontenot <nfont@linux.vnet.ibm.com> writes:
>
>> Building with CONFIG_TRANSPARENT_HUGEPAGE disabled causes the following
>> build wearnings;
>>
>> powerpc/arch/powerpc/include/asm/mmu-hash64.h: In function =E2=80=98__ha=
sh_page_thp=E2=80=99:
>> powerpc/arch/powerpc/include/asm/mmu-hash64.h:354: warning: no return st=
atement in function returning non-void
>>
>> This patch adds a return -1 to the static inline for __hash_page_thp()
>> to correct the warnings.
>>
>> Signed-off-by: Nathan Fontenot <nfont@linux.vnet.ibm.com>
>
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>
> Wondering why i am not finding this
>
> [root@llmp24l02 thp]# make arch/powerpc/mm/hash_utils_64.o
> ....
> .....
>   CC      arch/powerpc/mm/hash_utils_64.o
> [root@llmp24l02 thp]# grep TRANSPARENT_HUGEPAGE .config
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
> # CONFIG_TRANSPARENT_HUGEPAGE is not set
> [root@llmp24l02 thp]#=20
> [root@llmp24l02 thp]# gcc --version
> gcc (GCC) 4.7.2 20121109 (Red Hat 4.7.2-8)
> Copyright (C) 2012 Free Software Foundation, Inc.
> This is free software; see the source for copying conditions.  There is NO
> warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOS=
E.
>
>

new compilers have __builtin_unreachable in BUG. That is why it didn't
trigger for me.=20

new compiler:
_____________
static inline __attribute__((always_inline)) __attribute__((no_instrument_f=
unction)) int __hash_page_thp(unsigned long ea, unsigned long access,
      unsigned long vsid, pmd_t *pmdp,
      unsigned long trap, int local,
      int ssize, unsigned int psize)
{
 do { __asm__ __volatile__( "1:	twi 31,0,0\n" ".section __bug_table,\"a\"\n=
" "2:\t" ".llong" " " "1b, %0\n" "\t.short %1, %2\n" ".org 2b+%3\n" ".previ=
ous\n" : : "i" ("/home/opensource/sources/kernels/linux-powerpc/arch/powerp=
c/include/asm/mmu-hash64.h"), "i" (353), "i" (0), "i" (sizeof(struct bug_en=
try))); __builtin_unreachable(); } while (0);
}

failure:
__________
static inline __attribute__((always_inline)) __attribute__((no_instrument_f=
unction)) int __hash_page_thp(unsigned long ea, unsigned long access,
      unsigned long vsid, pmd_t *pmdp,
      unsigned long trap, int local,
      int ssize, unsigned int psize)
{
 do { __asm__ __volatile__( "1: twi 31,0,0\n" ".section __bug_table,\"a\"\n=
" "2:\t" ".llong" " " "1b, %0\n" "\t.short %1, %2\n" ".org 2b+%3\n" ".previ=
ous\n" : : "i" ("/home/nfont/src/powerpc/arch/powerpc/include/asm/mmu-hash6=
4.h"), "i" (353), "i" (0), "i" (sizeof(struct bug_entry))); do { } while (1=
); } while (0);
}


-aneesh
