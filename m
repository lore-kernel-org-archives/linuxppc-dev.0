Return-Path: <horms@koto.vergenet.net>
Received: from koto.vergenet.net (koto.vergenet.net [210.128.90.7])
	by ozlabs.org (Postfix) with ESMTP id DD10EDDE07
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 17:38:41 +1100 (EST)
Date: Fri, 23 Mar 2007 15:18:23 +0900
From: Horms <horms@verge.net.au>
To: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: [Fastboot] [PATCH] Avoid hypervisor statistics calculation in
	real mode
Message-ID: <20070323061821.GA24061@verge.net.au>
References: <20070320133547.GA4191@in.ibm.com>
	<20070320153751.462da242.randy.dunlap@oracle.com>
	<20070321055132.GA4200@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070321055132.GA4200@in.ibm.com>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linuxppc-dev@ozlabs.org,
	fastboot@lists.osdl.org, anton@samba.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2007 at 11:21:32AM +0530, Mohan Kumar M wrote:
> Thanks Randy.
> 
> I updated the patch as per your suggestions.
> 
> 
> kexec invokes plpar_hcall hypervisor call in real mode. plpar_hcall
> refers per cpu variable for accounting hypervisor statistics. These
> variables may not be present in the RMO region. So it results in
> 0x300 exception.
> 
> The following patch fixes this problem by using raw hypervisor call
> which does not update the hypervisor call statistics. Thanks to Anton
> for suggesting this idea.

This seems like a lot of code for a very slight variation
on an existing call. But I guess its cleaner than doing an "if" 
inside the assembler.

Funtionality-wise, it seems fine to me. Though I am most defianatly
not an authority on power.

I have put a minor comment inline.

> Cc: Anton Blanchard <anton@samba.org>
> Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/hvCall.S         |   34 ++++++++++++++++++++++++
>  arch/powerpc/platforms/pseries/lpar.c           |    2 -
>  arch/powerpc/platforms/pseries/plpar_wrappers.h |   16 +++++++++++
>  include/asm-powerpc/hvcall.h                    |   14 +++++++++
>  4 files changed, 65 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.21-rc4/arch/powerpc/platforms/pseries/hvCall.S
> ===================================================================
> --- linux-2.6.21-rc4.orig/arch/powerpc/platforms/pseries/hvCall.S
> +++ linux-2.6.21-rc4/arch/powerpc/platforms/pseries/hvCall.S
> @@ -123,6 +123,40 @@ _GLOBAL(plpar_hcall)
>  
>  	blr				/* return r3 = status */
>  
> +/*
> + * plpar_hcall_raw can be called in real mode. kexec/kdump need some
> + * hypervisor calls to be executed in real mode. So plpar_hcall_raw
> + * does not access the per cpu hypervisor call statistics variables,
> + * since these variables may not be present in the RMO region.
> + */

This text makes a little more sense to me:

/* 
 * plpar_hcall_raw may be called in real mode. In particular this may occur
 * during kexec/kdump. plpar_hcall_raw is a variation of plpar_hcall that
 * does not access the per cpu hypervisor call statistics variables, as
 * these variables may not be present in the RMO region.
 */

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/

> +_GLOBAL(plpar_hcall_raw)
> +	HMT_MEDIUM
> +
> +	mfcr	r0
> +	stw	r0,8(r1)
> +
> +	std     r4,STK_PARM(r4)(r1)     /* Save ret buffer */
> +
> +	mr	r4,r5
> +	mr	r5,r6
> +	mr	r6,r7
> +	mr	r7,r8
> +	mr	r8,r9
> +	mr	r9,r10
> +
> +	HVSC				/* invoke the hypervisor */
> +
> +	ld	r12,STK_PARM(r4)(r1)
> +	std	r4,  0(r12)
> +	std	r5,  8(r12)
> +	std	r6, 16(r12)
> +	std	r7, 24(r12)
> +
> +	lwz	r0,8(r1)
> +	mtcrf	0xff,r0
> +
> +	blr				/* return r3 = status */
> +
>  _GLOBAL(plpar_hcall9)
>  	HMT_MEDIUM
>  
> Index: linux-2.6.21-rc4/arch/powerpc/platforms/pseries/lpar.c
> ===================================================================
> --- linux-2.6.21-rc4.orig/arch/powerpc/platforms/pseries/lpar.c
> +++ linux-2.6.21-rc4/arch/powerpc/platforms/pseries/lpar.c
> @@ -378,7 +378,7 @@ static void pSeries_lpar_hptab_clear(voi
>  
>  	/* TODO: Use bulk call */
>  	for (i = 0; i < hpte_count; i++)
> -		plpar_pte_remove(0, i, 0, &dummy1, &dummy2);
> +		plpar_pte_remove_raw(0, i, 0, &dummy1, &dummy2);
>  }
>  
>  /*
> Index: linux-2.6.21-rc4/arch/powerpc/platforms/pseries/plpar_wrappers.h
> ===================================================================
> --- linux-2.6.21-rc4.orig/arch/powerpc/platforms/pseries/plpar_wrappers.h
> +++ linux-2.6.21-rc4/arch/powerpc/platforms/pseries/plpar_wrappers.h
> @@ -78,6 +78,22 @@ static inline long plpar_pte_remove(unsi
>  	return rc;
>  }
>  
> +/* plpar_pte_remove_raw can be called in real mode. It calls plpar_hcall_raw */
> +static inline long plpar_pte_remove_raw(unsigned long flags, unsigned long ptex,
> +		unsigned long avpn, unsigned long *old_pteh_ret,
> +		unsigned long *old_ptel_ret)
> +{
> +	long rc;
> +	unsigned long retbuf[PLPAR_HCALL_BUFSIZE];
> +
> +	rc = plpar_hcall_raw(H_REMOVE, retbuf, flags, ptex, avpn);
> +
> +	*old_pteh_ret = retbuf[0];
> +	*old_ptel_ret = retbuf[1];
> +
> +	return rc;
> +}
> +
>  static inline long plpar_pte_read(unsigned long flags, unsigned long ptex,
>  		unsigned long *old_pteh_ret, unsigned long *old_ptel_ret)
>  {
> Index: linux-2.6.21-rc4/include/asm-powerpc/hvcall.h
> ===================================================================
> --- linux-2.6.21-rc4.orig/include/asm-powerpc/hvcall.h
> +++ linux-2.6.21-rc4/include/asm-powerpc/hvcall.h
> @@ -237,6 +237,20 @@ long plpar_hcall_norets(unsigned long op
>  long plpar_hcall(unsigned long opcode, unsigned long *retbuf, ...);
>  
>  /**
> + * plpar_hcall_raw: - Make a hypervisor call without calculating hcall stats
> + * @opcode: The hypervisor call to make.
> + * @retbuf: Buffer to store up to 4 return arguments in.
> + *
> + * This call supports up to 6 arguments and 4 return arguments. Use
> + * PLPAR_HCALL_BUFSIZE to size the return argument buffer.
> + *
> + * Used when phyp interface needs to be called in real mode. Similar to
> + * plpar_hcall, but plpar_hcall_raw works in real mode and does not
> + * calculate hypervisor call statistics.
> + */
> +long plpar_hcall_raw(unsigned long opcode, unsigned long *retbuf, ...);
> +
> +/**
>   * plpar_hcall9: - Make a pseries hypervisor call with up to 9 return arguments
>   * @opcode: The hypervisor call to make.
>   * @retbuf: Buffer to store up to 9 return arguments in.
> _______________________________________________
> fastboot mailing list
> fastboot@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/fastboot
