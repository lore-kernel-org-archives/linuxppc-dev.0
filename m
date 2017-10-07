Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y8MWh5llJzDqlx
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 21:02:56 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com
Subject: Re: [PATCH 03/25] powerpc: track allocation status of all pkeys
In-Reply-To: <1504910713-7094-12-git-send-email-linuxram@us.ibm.com>
References: <1504910713-7094-1-git-send-email-linuxram@us.ibm.com>
 <1504910713-7094-12-git-send-email-linuxram@us.ibm.com>
Date: Sat, 07 Oct 2017 21:02:55 +1100
Message-ID: <87376vcm28.fsf@concordia.ellerman.id.au>
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

Ram Pai <linuxram@us.ibm.com> writes:

> Total 32 keys are available on power7 and above. However
> pkey 0,1 are reserved. So effectively we  have  30 pkeys.
>
> On 4K kernels, we do not  have  5  bits  in  the  PTE to
> represent  all the keys; we only have 3bits.Two of those
> keys are reserved; pkey 0 and pkey 1. So effectively  we
> have 6 pkeys.
>
> This patch keeps track of reserved keys, allocated  keys
> and keys that are currently free.
>
> Also it  adds  skeletal  functions  and macros, that the
> architecture-independent code expects to be available.
>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu.h |    9 ++++
>  arch/powerpc/include/asm/mmu_context.h   |    1 +
>  arch/powerpc/include/asm/pkeys.h         |   72 ++++++++++++++++++++++++=
++++--
>  arch/powerpc/mm/mmu_context_book3s64.c   |    2 +
>  arch/powerpc/mm/pkeys.c                  |   28 ++++++++++++
>  5 files changed, 108 insertions(+), 4 deletions(-)

This doesn't build for me, with pseries_le_defconfig. I assume it built
for you. So something has changed upstream maybe?


In file included from ../include/linux/pkeys.h:8:0,
                 from ../mm/mprotect.c:26:
../mm/mprotect.c: In function =E2=80=98do_mprotect_pkey=E2=80=99:
../arch/powerpc/include/asm/pkeys.h:27:29: error: =E2=80=98VM_PKEY_BIT0=E2=
=80=99 undeclared (first use in this function)
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
                             ^
../mm/mprotect.c:470:6: note: in expansion of macro =E2=80=98ARCH_VM_PKEY_F=
LAGS=E2=80=99
      ARCH_VM_PKEY_FLAGS;
      ^~~~~~~~~~~~~~~~~~
../arch/powerpc/include/asm/pkeys.h:27:29: note: each undeclared identifier=
 is reported only once for each function it appears in
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
                             ^
../mm/mprotect.c:470:6: note: in expansion of macro =E2=80=98ARCH_VM_PKEY_F=
LAGS=E2=80=99
      ARCH_VM_PKEY_FLAGS;
      ^~~~~~~~~~~~~~~~~~
../arch/powerpc/include/asm/pkeys.h:27:44: error: =E2=80=98VM_PKEY_BIT1=E2=
=80=99 undeclared (first use in this function)
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
                                            ^
../mm/mprotect.c:470:6: note: in expansion of macro =E2=80=98ARCH_VM_PKEY_F=
LAGS=E2=80=99
      ARCH_VM_PKEY_FLAGS;
      ^~~~~~~~~~~~~~~~~~
../arch/powerpc/include/asm/pkeys.h:27:59: error: =E2=80=98VM_PKEY_BIT2=E2=
=80=99 undeclared (first use in this function)
 #define ARCH_VM_PKEY_FLAGS (VM_PKEY_BIT0 | VM_PKEY_BIT1 | VM_PKEY_BIT2 | \
                                                           ^
../mm/mprotect.c:470:6: note: in expansion of macro =E2=80=98ARCH_VM_PKEY_F=
LAGS=E2=80=99
      ARCH_VM_PKEY_FLAGS;
      ^~~~~~~~~~~~~~~~~~
../arch/powerpc/include/asm/pkeys.h:28:5: error: =E2=80=98VM_PKEY_BIT3=E2=
=80=99 undeclared (first use in this function)
     VM_PKEY_BIT3 | VM_PKEY_BIT4)
     ^
../mm/mprotect.c:470:6: note: in expansion of macro =E2=80=98ARCH_VM_PKEY_F=
LAGS=E2=80=99
      ARCH_VM_PKEY_FLAGS;
      ^~~~~~~~~~~~~~~~~~
../arch/powerpc/include/asm/pkeys.h:28:20: error: =E2=80=98VM_PKEY_BIT4=E2=
=80=99 undeclared (first use in this function)
     VM_PKEY_BIT3 | VM_PKEY_BIT4)
                    ^
../mm/mprotect.c:470:6: note: in expansion of macro =E2=80=98ARCH_VM_PKEY_F=
LAGS=E2=80=99
      ARCH_VM_PKEY_FLAGS;
      ^~~~~~~~~~~~~~~~~~
../scripts/Makefile.build:311: recipe for target 'mm/mprotect.o' failed


cheers
