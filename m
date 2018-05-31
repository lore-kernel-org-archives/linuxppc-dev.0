Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40xV663jX2zDrpY
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jun 2018 00:22:22 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] powerpc/64s: Fix compiler store ordering to SLB shadow
 area
In-Reply-To: <20180530103122.27674-1-npiggin@gmail.com>
References: <20180530103122.27674-1-npiggin@gmail.com>
Date: Fri, 01 Jun 2018 00:22:21 +1000
Message-ID: <87tvqnykf6.fsf@concordia.ellerman.id.au>
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

Nicholas Piggin <npiggin@gmail.com> writes:

> The stores to update the SLB shadow area must be made as they appear
> in the C code, so that the hypervisor does not see an entry with
> mismatched vsid and esid. Use WRITE_ONCE for this.
>
> GCC has been observed to elide the first store to esid in the update,
> which means that if the hypervisor interrupts the guest after storing
> to vsid, it could see an entry with old esid and new vsid, which may
> possibly result in memory corruption.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/mm/slb.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
> index 66577cc66dc9..2f4b33b24b3b 100644
> --- a/arch/powerpc/mm/slb.c
> +++ b/arch/powerpc/mm/slb.c
> @@ -63,14 +63,14 @@ static inline void slb_shadow_update(unsigned long ea, int ssize,
>  	 * updating it.  No write barriers are needed here, provided
>  	 * we only update the current CPU's SLB shadow buffer.
>  	 */
> -	p->save_area[index].esid = 0;
> -	p->save_area[index].vsid = cpu_to_be64(mk_vsid_data(ea, ssize, flags));
> -	p->save_area[index].esid = cpu_to_be64(mk_esid_data(ea, ssize, index));
> +	WRITE_ONCE(p->save_area[index].esid, 0);
> +	WRITE_ONCE(p->save_area[index].vsid, cpu_to_be64(mk_vsid_data(ea, ssize, flags)));
> +	WRITE_ONCE(p->save_area[index].esid, cpu_to_be64(mk_esid_data(ea, ssize, index)));

What's the code-gen for that look like? I suspect it's terrible?

Should we just do it in inline-asm I wonder?

cheers
