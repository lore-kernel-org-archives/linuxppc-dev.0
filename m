Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 3qPVvs4SZ3zDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Mar 2016 21:19:05 +1100 (AEDT)
Subject: Re: [PATCH] powerpc/8xx: Fix do_mtspr_cpu6 build on older compilers
To: Scott Wood <oss@buserror.net>, Michael Ellerman <mpe@ellerman.id.au>
References: <1458023151-32066-1-git-send-email-oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <56E7E18E.30207@c-s.fr>
Date: Tue, 15 Mar 2016 11:18:54 +0100
MIME-Version: 1.0
In-Reply-To: <1458023151-32066-1-git-send-email-oss@buserror.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Le 15/03/2016 07:25, Scott Wood a écrit :
> Some versions of GCC, reportedly before 4.9, fail with
> arch/powerpc/mm/8xx_mmu.c:139:2: error: memory input 1 is not directly
> addressable
>
> Use a register constraint instead of a memory constraint to avoid this.
> Also change the one-element array into a simple variable.
>
> Signed-off-by: Scott Wood <oss@buserror.net>
> Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
> Christope, could you test?  And was there any particular reason for the [1]?
As far as I remember the idea behind the [1] was to ensure that the 
variable was allocated from stack memory and not optimised in a register.

I will not be able to test it as I don't have any CPU suffering CPU6 
errata, but I observe that the result of your patch doesn't exactly 
match the solution proposed by Freescale in the ERRATA:

MPC860 CPU6 ERRATA says:
each "mtspr" instruction which accesses one of these registers must be 
preceded by a store word and a
load word instruction of a data operand equal to the spr_address of the 
respective register. As an
example, to write the data from the general purpose register r1 to the 
special purpose register
M_TW, the procedure in Table 6 should be followed:

Table 6. Writing Data from r1 to M_TW:
lis r2, some address_msb
li r3, 0x3f80
stw r3, some address_lsb(r2)
lwz r3, some address_lsb(r2)
mtspr M_TW, r1

Without your patch (with gcc 4.8.3), I get:
c000d8cc <set_context>:
[...]
c000d8f4:    39 40 3f 80     li      r10,16256
c000d8f8:    91 41 00 08     stw     r10,8(r1)
c000d8fc:    81 41 00 08     lwz     r10,8(r1)
c000d900:    7d 3f c3 a6     mtspr   799,r9
c000d904:    39 20 33 80     li      r9,13184
c000d908:    91 21 00 08     stw     r9,8(r1)
c000d90c:    81 21 00 08     lwz     r9,8(r1)
c000d910:    7c 79 c3 a6     mtspr   793,r3
[...]

With your patch (with gcc 4.8.3), I get:
c000d8dc <set_context>:
[...]
c000d904:    39 40 3f 80     li      r10,16256
c000d908:    39 21 00 08     addi    r9,r1,8
c000d90c:    7d 40 49 2e     stwx    r10,0,r9
c000d910:    7d 40 48 2e     lwzx    r10,0,r9
c000d914:    7d 1f c3 a6     mtspr   799,r8
c000d918:    39 40 33 80     li      r10,13184
c000d91c:    7d 40 49 2e     stwx    r10,0,r9
c000d920:    7d 40 48 2e     lwzx    r10,0,r9
c000d924:    7c 79 c3 a6     mtspr   793,r3
[...]

I'm not able to tell if using stwx/lwzx instead of stw/lwz is valid.

Christophe

>
>   arch/powerpc/include/asm/reg_8xx.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/reg_8xx.h b/arch/powerpc/include/asm/reg_8xx.h
> index d41412c..cb7dfb9 100644
> --- a/arch/powerpc/include/asm/reg_8xx.h
> +++ b/arch/powerpc/include/asm/reg_8xx.h
> @@ -53,11 +53,11 @@
>   #ifdef CONFIG_8xx_CPU6
>   #define do_mtspr_cpu6(rn, rn_addr, v)	\
>   	do {								\
> -		int _reg_cpu6 = rn_addr, _tmp_cpu6[1];		\
> -		asm volatile("stw %0, %1;"				\
> -			     "lwz %0, %1;"				\
> +		int _reg_cpu6 = rn_addr, _tmp_cpu6;		\
> +		asm volatile("stwx %0, 0, %1;"				\
> +			     "lwzx %0, 0, %1;"				\
>   			     "mtspr " __stringify(rn) ",%2" :		\
> -			     : "r" (_reg_cpu6), "m"(_tmp_cpu6),		\
> +			     : "r" (_reg_cpu6), "r" (&_tmp_cpu6),	\
>   			       "r" ((unsigned long)(v))			\
>   			     : "memory");				\
>   	} while (0)
