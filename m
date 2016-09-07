Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sTXzJ0b2mzDrq3
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Sep 2016 16:06:36 +1000 (AEST)
Date: Wed, 7 Sep 2016 15:52:24 +1000
From: Paul Mackerras <paulus@ozlabs.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc/mm: Preserve CFAR value on SLB miss caused
 by access to bogus address
Message-ID: <20160907055224.GC21443@fergus.ozlabs.ibm.com>
References: <20160902114759.GA12433@fergus.ozlabs.ibm.com>
 <20160902114921.GB12433@fergus.ozlabs.ibm.com>
 <87k2errjga.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87k2errjga.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Sep 04, 2016 at 05:00:13PM +0530, Aneesh Kumar K.V wrote:
[snip]
> > @@ -1389,6 +1393,7 @@ unrecover_mce:
> >   * r3 has the faulting address
> >   * r9 - r13 are saved in paca->exslb.
> >   * r3 is saved in paca->slb_r3
> > + * cr6.eq is set for a D-SLB miss, clear for a I-SLB miss
> >   * We assume we aren't going to take any exceptions during this procedure.
> >   */
> >  slb_miss_realmode:
> > @@ -1399,29 +1404,31 @@ slb_miss_realmode:
> >  
> >  	stw	r9,PACA_EXSLB+EX_CCR(r13)	/* save CR in exc. frame */
> >  	std	r10,PACA_EXSLB+EX_LR(r13)	/* save LR */
> > +	std	r3,PACA_EXSLB+EX_DAR(r13)
> 
> 
> We already have that in EX_R3(r13) right ? Any specific reason we can't

No, what's in EX_R3(r13) is the original value of r3.  What's in r3
now is the faulting address.  We save that here so we can put it in
regs->dar later on.

Paul.
