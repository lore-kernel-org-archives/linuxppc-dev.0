Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A8514B7D1B
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Apr 2010 20:27:52 +1000 (EST)
Date: Fri, 23 Apr 2010 20:27:42 +1000
From: Nick Piggin <npiggin@suse.de>
To: David Rientjes <rientjes@google.com>
Subject: Re: [patch 11/14] powerpc: invoke oom-killer from page fault
Message-ID: <20100423102742.GC5683@laptop>
References: <20100422160613.723698029@suse.de>
	<20100422161224.465958039@suse.de>
	<alpine.DEB.2.00.1004221442590.25350@chino.kir.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.00.1004221442590.25350@chino.kir.corp.google.com>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 22, 2010 at 02:44:22PM -0700, David Rientjes wrote:
> On Fri, 23 Apr 2010, npiggin@suse.de wrote:
> 
> > As explained in commit 1c0fe6e3bd, we want to call the architecture independent
> > oom killer when getting an unexplained OOM from handle_mm_fault, rather than
> > simply killing current.
> > 
> > Cc: linuxppc-dev@ozlabs.org
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: linux-arch@vger.kernel.org
> > Signed-off-by: Nick Piggin <npiggin@suse.de>
> > ---
> > Index: linux-2.6/arch/powerpc/mm/fault.c
> > ===================================================================
> > --- linux-2.6.orig/arch/powerpc/mm/fault.c
> > +++ linux-2.6/arch/powerpc/mm/fault.c
> > @@ -359,15 +359,10 @@ bad_area_nosemaphore:
> >   */
> >  out_of_memory:
> >  	up_read(&mm->mmap_sem);
> > -	if (is_global_init(current)) {
> > -		yield();
> > -		down_read(&mm->mmap_sem);
> > -		goto survive;
> > -	}
> > -	printk("VM: killing process %s\n", current->comm);
> > -	if (user_mode(regs))
> > -		do_group_exit(SIGKILL);
> > -	return SIGKILL;
> > +	if (!user_mode(regs))
> > +		return SIGKILL;
> > +	pagefault_out_of_memory();
> > +	return 0;
> 
> Do we really want to return 0 and indicate that the fault was handled?  It 
> seems more consistent to do
> 
> 	if (user_mode(regs))
> 		pagefault_out_of_memory();
> 	return SIGKILL;

Well we don't necessarily want to kill current.
pagefault_out_of_memory() could elect to send a SIGKILL if wants to, but
if it decides current should not be terminated, then we have to just
retry the page fault.
