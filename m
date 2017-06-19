Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wrp7V1nW5zDqgX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jun 2017 21:06:14 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, dave.hansen@intel.com,
 hbabu@us.ibm.com, linuxram@us.ibm.com
Subject: Re: [RFC v2 10/12] powerpc: Read AMR only if pkey-violation caused
 the exception.
In-Reply-To: <1497671564-20030-11-git-send-email-linuxram@us.ibm.com>
References: <1497671564-20030-1-git-send-email-linuxram@us.ibm.com>
 <1497671564-20030-11-git-send-email-linuxram@us.ibm.com>
Date: Mon, 19 Jun 2017 21:06:13 +1000
Message-ID: <87bmpkuti2.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ram Pai <linuxram@us.ibm.com> writes:

> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 8db9ef8..a4de1b4 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -493,13 +493,15 @@ EXC_COMMON_BEGIN(data_access_common)
>  	ld	r12,_MSR(r1)
>  	ld	r3,PACA_EXGEN+EX_DAR(r13)
>  	lwz	r4,PACA_EXGEN+EX_DSISR(r13)
> +	std	r3,_DAR(r1)
> +	std	r4,_DSISR(r1)
>  #ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
> +	andis.  r0,r4,DSISR_KEYFAULT@h /* save AMR only if its a key fault */
> +	beq+	1f

This seems to be incremental on top of one of your other patches.

But I don't see why, can you please just squash this into whatever patch
adds this code in the first place.

cheers
