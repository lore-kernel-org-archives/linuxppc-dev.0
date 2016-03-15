Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qPhby1gYMzDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Mar 2016 04:35:58 +1100 (AEDT)
Message-ID: <1458063351.12370.24.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>, Michael Ellerman
 <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
Date: Tue, 15 Mar 2016 12:35:51 -0500
In-Reply-To: <56E7E18E.30207@c-s.fr>
References: <1458023151-32066-1-git-send-email-oss@buserror.net>
 <56E7E18E.30207@c-s.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: [PATCH] powerpc/8xx: Fix do_mtspr_cpu6 build on older compilers
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2016-03-15 at 11:18 +0100, Christophe Leroy wrote:
> Le 15/03/2016 07:25, Scott Wood a écrit :
> > Some versions of GCC, reportedly before 4.9, fail with
> > arch/powerpc/mm/8xx_mmu.c:139:2: error: memory input 1 is not directly
> > addressable
> > 
> > Use a register constraint instead of a memory constraint to avoid this.
> > Also change the one-element array into a simple variable.
> > 
> > Signed-off-by: Scott Wood <oss@buserror.net>
> > Cc: Christophe Leroy <christophe.leroy@c-s.fr>
> > ---
> > Christope, could you test?  And was there any particular reason for the
> > [1]?
> As far as I remember the idea behind the [1] was to ensure that the 
> variable was allocated from stack memory and not optimised in a register.

Taking the address of it should accomplish that.

> I will not be able to test it as I don't have any CPU suffering CPU6 
> errata, 

I'm wondering if anyone using current kernels cares about chips that have this
erratum.  Maybe it's time to remove support for them.


> but I observe that the result of your patch doesn't exactly 
> match the solution proposed by Freescale in the ERRATA:
>
> MPC860 CPU6 ERRATA says:
> each "mtspr" instruction which accesses one of these registers must be 
> preceded by a store word and a
> load word instruction of a data operand equal to the spr_address of the 
> respective register. As an
> example, to write the data from the general purpose register r1 to the 
> special purpose register
> M_TW, the procedure in Table 6 should be followed:
> 
> Table 6. Writing Data from r1 to M_TW:
> lis r2, some address_msb
> li r3, 0x3f80
> stw r3, some address_lsb(r2)
> lwz r3, some address_lsb(r2)
> mtspr M_TW, r1
> 
> Without your patch (with gcc 4.8.3), I get:
> c000d8cc <set_context>:
> [...]
> c000d8f4:    39 40 3f 80     li      r10,16256
> c000d8f8:    91 41 00 08     stw     r10,8(r1)
> c000d8fc:    81 41 00 08     lwz     r10,8(r1)
> c000d900:    7d 3f c3 a6     mtspr   799,r9
> c000d904:    39 20 33 80     li      r9,13184
> c000d908:    91 21 00 08     stw     r9,8(r1)
> c000d90c:    81 21 00 08     lwz     r9,8(r1)
> c000d910:    7c 79 c3 a6     mtspr   793,r3
> [...]
> 
> With your patch (with gcc 4.8.3), I get:
> c000d8dc <set_context>:
> [...]
> c000d904:    39 40 3f 80     li      r10,16256
> c000d908:    39 21 00 08     addi    r9,r1,8
> c000d90c:    7d 40 49 2e     stwx    r10,0,r9
> c000d910:    7d 40 48 2e     lwzx    r10,0,r9
> c000d914:    7d 1f c3 a6     mtspr   799,r8
> c000d918:    39 40 33 80     li      r10,13184
> c000d91c:    7d 40 49 2e     stwx    r10,0,r9
> c000d920:    7d 40 48 2e     lwzx    r10,0,r9
> c000d924:    7c 79 c3 a6     mtspr   793,r3
> [...]
> 
> I'm not able to tell if using stwx/lwzx instead of stw/lwz is valid.

It says "a store word and a load word instruction".  lwzx is a load word
instruction just as lwz is.

-Scott
