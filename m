Return-Path: <randy.dunlap@oracle.com>
Received: from agminet02.oracle.com (agminet02.oracle.com [141.146.126.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5B8A6DDF01
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2007 10:47:03 +1100 (EST)
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	by agminet02.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id
	l2KMd620024936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 17:39:06 -0500
Date: Tue, 20 Mar 2007 15:37:51 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: mohan@in.ibm.com
Subject: Re: [Fastboot] [PATCH] Avoid hypervisor statistics calculation in
	real mode
Message-Id: <20070320153751.462da242.randy.dunlap@oracle.com>
In-Reply-To: <20070320133547.GA4191@in.ibm.com>
References: <20070320133547.GA4191@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, fastboot@lists.osdl.org, anton@samba.org,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 20 Mar 2007 19:05:47 +0530 Mohan Kumar M wrote:

> Cc: Anton Blanchard <anton@samba.org>
> Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/hvCall.S         |   34 ++++++++++++++++++++++++
>  arch/powerpc/platforms/pseries/lpar.c           |    2 -
>  arch/powerpc/platforms/pseries/plpar_wrappers.h |   19 +++++++++++++
>  include/asm-powerpc/hvcall.h                    |   15 ++++++++++
>  4 files changed, 69 insertions(+), 1 deletion(-)
> 
> Index: linux-2.6.21-rc4/arch/powerpc/platforms/pseries/hvCall.S
> ===================================================================
> --- linux-2.6.21-rc4.orig/arch/powerpc/platforms/pseries/hvCall.S
> +++ linux-2.6.21-rc4/arch/powerpc/platforms/pseries/hvCall.S
> @@ -123,6 +123,40 @@ _GLOBAL(plpar_hcall)
>  
>  	blr				/* return r3 = status */
>  
> +
> +/* plpar_hcall_raw can be called in real mode. kexec/kdump need some
> + * hypervisor calls to be executed in real mode. So plpar_hcall_raw
> + * does not access the per cpu hypervisor call statistics variables,
> + * since these variables may not be present in the RMO region.
> + */

Hi,
Please use regular kernel long comment style (when not using
kernel-doc).  E.g.:

/*
 * foo
 * bar
 * this is a long comment (several lines)
 */

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

> Index: linux-2.6.21-rc4/include/asm-powerpc/hvcall.h
> ===================================================================
> --- linux-2.6.21-rc4.orig/include/asm-powerpc/hvcall.h
> +++ linux-2.6.21-rc4/include/asm-powerpc/hvcall.h
> @@ -237,6 +237,21 @@ long plpar_hcall_norets(unsigned long op
>  long plpar_hcall(unsigned long opcode, unsigned long *retbuf, ...);
>  
>  /**
> + * plpar_hcall_raw: - Make a pseries hypervisor call, but don't calculate
> + * hypervisor call statistics.

For kernel-doc, the first line must be:

 * function - short description (one line only)

More detailed description can follow the parameters (like you have
done below).

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


Thanks.
---
~Randy
*** Remember to use Documentation/SubmitChecklist when testing your code ***
