Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DAFC267A3F
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 16:47:56 +1000 (EST)
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim) id 1Fkxec-0000kJ-0n
	from <mingo@elte.hu>
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 08:24:34 +0200
Date: Tue, 30 May 2006 08:24:47 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc vdso updates
Message-ID: <20060530062447.GD19870@elte.hu>
References: <1148961097.15722.11.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1148961097.15722.11.camel@localhost.localdomain>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This patch cleans up some locking & error handling in the ppc vdso and 
> moves the vdso base pointer from the thread struct to the mm context 
> where it more logically belongs. It brings the powerpc implementation 
> closer to Ingo's new x86 one and also adds an arch_vma_name() function 
> allowing to print [vsdo] in /proc/<pid>/maps if Ingo's x86 vdso patch 
> is also applied.

looks good to me.

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Reviewed-by: Ingo Molnar <mingo@elte.hu>

> This is 2.6.18 material, hopefully should go along with Ingo's x86 
> vdso updates. Ingo, if you change something to arch_vma_name(), please 
> let me know.

ok. There's one bit that could potentially be 2.6.17 material:

>  	 * at vdso_base which is the "natural" base for it, but we might fail
>  	 * and end up putting it elsewhere.
>  	 */
> +	down_write(&mm->mmap_sem);
>  	vdso_base = get_unmapped_area(NULL, vdso_base,
>  				      vdso_pages << PAGE_SHIFT, 0, 0);

get_unmapped_area() without holding the mmap semaphore seems dangerous. 
The VDSO setup itself should be 'private' to the process, but i'm not 
totally sure that no other kernel code could get access to this mm. For 
example the swapout code? Am i missing something?

	Ingo
