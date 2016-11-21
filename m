Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMXH82ScDzDvj6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 13:14:44 +1100 (AEDT)
Date: Mon, 21 Nov 2016 13:14:39 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 02/13] powerpc/64: Provide functions for accessing POWER9
 partition table
Message-ID: <20161121021439.GC26748@fergus.ozlabs.ibm.com>
References: <1479454122-26994-1-git-send-email-paulus@ozlabs.org>
 <1479454122-26994-3-git-send-email-paulus@ozlabs.org>
 <878tsgoobx.fsf@linux.vnet.ibm.com>
 <20161119041954.GF29462@fergus.ozlabs.ibm.com>
 <87h974m0ye.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87h974m0ye.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 19, 2016 at 12:05:21PM +0530, Aneesh Kumar K.V wrote:
> Paul Mackerras <paulus@ozlabs.org> writes:
> 
> > On Fri, Nov 18, 2016 at 07:57:30PM +0530, Aneesh Kumar K.V wrote:
> >> Paul Mackerras <paulus@ozlabs.org> writes:
> >>  +
> >> > +	/* Global flush of TLBs and partition table caches for this lpid */
> >> > +	asm volatile("ptesync");
> >> > +	asm volatile(PPC_TLBIE_5(%0,%1,2,0,0) : : "r"(0x800), "r" (lpid));
> >> > +	asm volatile("eieio; tlbsync; ptesync" : : : "memory");
> >> > +}
> >> 
> >> 
> >> It would be nice to convert that 0x800 to a documented IS value or better use
> >> radix__flush_tlb_pid() ?
> >
> > Well, not radix__flush_tlb_pid - this isn't radix and it isn't a PID
> > flush.  I could use TLBIEL_INVAL_SET_LPID except the name implies it's
> > for tlbiel and this is a tlbie.
> >
> 
> I wrote that wrong, we really don't have tlb_pid() what we have is tlb_lpid().
> 
> void radix__flush_tlb_lpid(unsigned long lpid)
> {
> 	unsigned long rb,rs,prs,r;
> 	unsigned long ric = RIC_FLUSH_ALL;
> 
> 	rb = 0x2 << PPC_BITLSHIFT(53); /* IS = 2 */
> 	rs = lpid & ((1UL << 32) - 1);
> 	prs = 0; /* partition scoped */
> 	r = 1;   /* raidx format */
> 
> 	asm volatile("ptesync": : :"memory");
> 	asm volatile(PPC_TLBIE_5(%0, %4, %3, %2, %1)
> 		     : : "r"(rb), "i"(r), "i"(prs), "i"(ric), "r"(rs) : "memory");
> 	asm volatile("eieio; tlbsync; ptesync": : :"memory");
> }

That has R=1, I'm using R=0.

Paul.
