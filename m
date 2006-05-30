Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8FD6567A3F
	for <linuxppc-dev@ozlabs.org>; Tue, 30 May 2006 17:22:05 +1000 (EST)
Subject: Re: [PATCH] powerpc vdso updates
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20060530062447.GD19870@elte.hu>
References: <1148961097.15722.11.camel@localhost.localdomain>
	<20060530062447.GD19870@elte.hu>
Content-Type: text/plain
Date: Tue, 30 May 2006 17:21:40 +1000
Message-Id: <1148973700.15722.34.camel@localhost.localdomain>
Mime-Version: 1.0
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


> get_unmapped_area() without holding the mmap semaphore seems dangerous. 
> The VDSO setup itself should be 'private' to the process, but i'm not 
> totally sure that no other kernel code could get access to this mm. For 
> example the swapout code? Am i missing something?

Well, all of this happens so early, I doubt anything will cause actual
harm, for get_unmapped_area to be a problem, something would have to
concurrently allocate a VMA (or dispose of) I think that can't happen at
this point before we even run the binary but yes, better safe than
sorry... I supose the whole patch could get in 2.6.17 even without the
arch_vma_name (that is it can be there, it wont be used though until
your patch gets in).

Ben.
