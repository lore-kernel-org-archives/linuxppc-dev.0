Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wBLHz6JQszDqKX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 19:14:07 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v3O9DsKn102410
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 05:14:06 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2a03pbfjsw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 05:14:05 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 24 Apr 2017 19:14:02 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v3O9DpJk3342822
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 19:13:59 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v3O9DQ5r020582
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Apr 2017 19:13:27 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/5] powerpc/mm: Evaluate user_mode(regs) only once in
 do_page_fault()
In-Reply-To: <592ce73ae7cbd2383740ac31e5fed5ca5beac721.1492606298.git.christophe.leroy@c-s.fr>
References: <cover.1492606297.git.christophe.leroy@c-s.fr>
 <592ce73ae7cbd2383740ac31e5fed5ca5beac721.1492606298.git.christophe.leroy@c-s.fr>
Date: Mon, 24 Apr 2017 14:43:02 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87r30i184h.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> Analysis of the assembly code shows that when using user_mode(regs),
> at least the 'andi.' is redone all the time, and also
> the 'lwz ,132(r31)' most of the time. With the new form, the 'is_user'
> is mapped to cr4, then all further use of is_user results in just
> things like 'beq cr4,218 <do_page_fault+0x218>'
>
> Without the patch:
>
>   50:	81 1e 00 84 	lwz     r8,132(r30)
>   54:	71 09 40 00 	andi.   r9,r8,16384
>   58:	40 82 00 0c 	bne     64 <do_page_fault+0x64>
>
>   84:	81 3e 00 84 	lwz     r9,132(r30)
>   8c:	71 2a 40 00 	andi.   r10,r9,16384
>   90:	41 a2 01 64 	beq     1f4 <do_page_fault+0x1f4>
>
>   d4:	81 3e 00 84 	lwz     r9,132(r30)
>   dc:	71 28 40 00 	andi.   r8,r9,16384
>   e0:	41 82 02 08 	beq     2e8 <do_page_fault+0x2e8>
>
>  108:	81 3e 00 84 	lwz     r9,132(r30)
>  110:	71 28 40 00 	andi.   r8,r9,16384
>  118:	41 82 02 28 	beq     340 <do_page_fault+0x340>
>
>  1e4:	81 3e 00 84 	lwz     r9,132(r30)
>  1e8:	71 2a 40 00 	andi.   r10,r9,16384
>  1ec:	40 82 01 68 	bne     354 <do_page_fault+0x354>
>
>  228:	81 3e 00 84 	lwz     r9,132(r30)
>  22c:	71 28 40 00 	andi.   r8,r9,16384
>  230:	41 82 ff c4 	beq     1f4 <do_page_fault+0x1f4>
>
>  288:	71 2a 40 00 	andi.   r10,r9,16384
>  294:	41 a2 fe 60 	beq     f4 <do_page_fault+0xf4>
>
>  50c:	81 3e 00 84 	lwz     r9,132(r30)
>  514:	71 2a 40 00 	andi.   r10,r9,16384
>  518:	40 a2 fc e0 	bne     1f8 <do_page_fault+0x1f8>
>
>  534:	81 3e 00 84 	lwz     r9,132(r30)
>  53c:	71 2a 40 00 	andi.   r10,r9,16384
>  540:	41 82 fc b8 	beq     1f8 <do_page_fault+0x1f8>
>
> This patch creates a local var called 'is_user' which contains the
> result of user_mode(regs)
>
> With the patch:
>
>   20:	81 03 00 84 	lwz     r8,132(r3)
>   48:	55 09 97 fe 	rlwinm  r9,r8,18,31,31
>   58:	2e 09 00 00 	cmpwi   cr4,r9,0
>   5c:	40 92 00 0c 	bne     cr4,68 <do_page_fault+0x68>
>
>   88:	41 b2 01 90 	beq     cr4,218 <do_page_fault+0x218>
>
>   d4:	40 92 01 d0 	bne     cr4,2a4 <do_page_fault+0x2a4>
>
>  120:	41 b2 00 f8 	beq     cr4,218 <do_page_fault+0x218>
>
>  138:	41 b2 ff a0 	beq     cr4,d8 <do_page_fault+0xd8>
>
>  1d4:	40 92 00 e0 	bne     cr4,2b4 <do_page_fault+0x2b4>
>
Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/mm/fault.c | 13 +++++++------
>  1 file changed, 7 insertions(+), 6 deletions(-)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index b56bf472db6d..8d1639eee3af 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -202,6 +202,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  	int is_write = 0;
>  	int trap = TRAP(regs);
>   	int is_exec = trap == 0x400;
> +	int is_user = user_mode(regs);
>  	int fault;
>  	int rc = 0;
>  	unsigned int inst = 0;
> @@ -244,7 +245,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  	 * The kernel should never take an execute fault nor should it
>  	 * take a page fault to a kernel address.
>  	 */
> -	if (!user_mode(regs) && (is_exec || (address >= TASK_SIZE))) {
> +	if (!is_user && (is_exec || (address >= TASK_SIZE))) {
>  		rc = SIGSEGV;
>  		goto bail;
>  	}
> @@ -263,7 +264,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  		local_irq_enable();
>  
>  	if (faulthandler_disabled() || mm == NULL) {
> -		if (!user_mode(regs)) {
> +		if (!is_user) {
>  			rc = SIGSEGV;
>  			goto bail;
>  		}
> @@ -284,10 +285,10 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  	 * can result in fault, which will cause a deadlock when called with
>  	 * mmap_sem held
>  	 */
> -	if (is_write && user_mode(regs))
> +	if (is_write && is_user)
>  		__get_user(inst, (unsigned int __user *)regs->nip);
>  
> -	if (user_mode(regs))
> +	if (is_user)
>  		flags |= FAULT_FLAG_USER;
>  
>  	/* When running in the kernel we expect faults to occur only to
> @@ -306,7 +307,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  	 * thus avoiding the deadlock.
>  	 */
>  	if (!down_read_trylock(&mm->mmap_sem)) {
> -		if (!user_mode(regs) && !search_exception_tables(regs->nip))
> +		if (!is_user && !search_exception_tables(regs->nip))
>  			goto bad_area_nosemaphore;
>  
>  retry:
> @@ -506,7 +507,7 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  
>  bad_area_nosemaphore:
>  	/* User mode accesses cause a SIGSEGV */
> -	if (user_mode(regs)) {
> +	if (is_user) {
>  		_exception(SIGSEGV, regs, code, address);
>  		goto bail;
>  	}
> -- 
> 2.12.0
