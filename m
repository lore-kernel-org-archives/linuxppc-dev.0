Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xxMSB1wcBzDqkc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Sep 2017 22:21:46 +1000 (AEST)
Subject: Re: [PATCH v1 0/3] powerpc: memcmp() optimization
To: wei.guo.simon@gmail.com, linuxppc-dev@lists.ozlabs.org
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
References: <1505815439-18720-1-git-send-email-wei.guo.simon@gmail.com>
From: Christophe LEROY <christophe.leroy@c-s.fr>
Message-ID: <531bcb91-c5ef-278b-ab6f-a2b8f246a26a@c-s.fr>
Date: Tue, 19 Sep 2017 14:21:33 +0200
MIME-Version: 1.0
In-Reply-To: <1505815439-18720-1-git-send-email-wei.guo.simon@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

Could you in the email/patch subject and in the commit texts write 
powerpc/64 instead of powerpc as it doesn't apply to powerpc/32

Christophe

Le 19/09/2017 à 12:03, wei.guo.simon@gmail.com a écrit :
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> There is some room to optimize memcmp() in powerpc for following 2 cases:
> (1) Even src/dst addresses are not aligned with 8 bytes at the beginning,
> memcmp() can align them and go with .Llong comparision mode without
> fallback to .Lshort comparision mode do compare buffer byte by byte.
> (2) VMX instructions can be used to speed up for large size comparision.
> 
> This patch set also updates selftest case to make it compiled.
> 
> 
> Simon Guo (3):
>    powerpc: Align bytes before fall back to .Lshort in powerpc memcmp
>    powerpc: enhance memcmp() with VMX instruction for long bytes
>      comparision
>    powerpc:selftest update memcmp selftest according to kernel change
> 
>   arch/powerpc/include/asm/asm-prototypes.h          |   2 +-
>   arch/powerpc/lib/copypage_power7.S                 |   2 +-
>   arch/powerpc/lib/memcmp_64.S                       | 165 ++++++++++++++++++++-
>   arch/powerpc/lib/memcpy_power7.S                   |   2 +-
>   arch/powerpc/lib/vmx-helper.c                      |   2 +-
>   .../selftests/powerpc/copyloops/asm/ppc_asm.h      |   2 +-
>   .../selftests/powerpc/stringloops/asm/ppc_asm.h    |  31 ++++
>   7 files changed, 197 insertions(+), 9 deletions(-)
> 
