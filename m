Return-Path: <dan.carpenter@oracle.com>
Received: from userp2120.oracle.com (userp2120.oracle.com [156.151.31.85])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zXF473R8QzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Feb 2018 20:21:43 +1100 (AEDT)
Date: Thu, 1 Feb 2018 12:21:23 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [bug report] powerpc/mm/radix: Add tlbflush routines
Message-ID: <20180201092123.hdjhvyuqni4oq5ut@mwanda>
References: <20180131154521.GA21698@mwanda>
 <87fu6le25x.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87fu6le25x.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 31, 2018 at 08:58:50PM -0800, Michael Ellerman wrote:
> Dan Carpenter <dan.carpenter@oracle.com> writes:
> 
> > Hello Aneesh Kumar K.V,
> >
> > The patch 1a472c9dba6b: "powerpc/mm/radix: Add tlbflush routines"
> > from Apr 29, 2016, leads to the following static checker warning:
> >
> > 	arch/powerpc/mm/tlb_nohash.c:218 __local_flush_tlb_page()
> > 	warn: always true condition '(pid != ~0) => (0-u32max != u64max)'
> >
> > arch/powerpc/mm/tlb_nohash.c
> >    211  void __local_flush_tlb_page(struct mm_struct *mm, unsigned long vmaddr,
> >    212                              int tsize, int ind)
> >    213  {
> >    214          unsigned int pid;
> >    215  
> >    216          preempt_disable();
> >    217          pid = mm ? mm->context.id : 0;
> >    218          if (pid != MMU_NO_CONTEXT)
> >                     ^^^^^^^^^^^^^^^^^^^^^
> >    219                  _tlbil_va(vmaddr, pid, tsize, ind);
> >    220          preempt_enable();
> >    221  }
> >
> > I don't know very much about PowerPC.  The static checker is guessing
> > which headers to pull in instead of relying on the build system so there
> > are a lot of false positives.
> 
> O_o 
> 
> That's a bit nuts ... :)
> 

Heh.

Thanks for looking into this.

regards,
dan carpenter
