Return-Path: <michael@ellerman.id.au>
Date: Wed, 9 Oct 2013 12:21:30 +1100
From: Michael Ellerman <michael@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc, perf: Configure BHRB filter before enabling PMU
 interrupts
Message-ID: <20131009012130.GA23780@concordia>
References: <1381120226-14838-1-git-send-email-khandual@linux.vnet.ibm.com>
 <20131008042137.GE31666@concordia>
 <5253B26E.3020800@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5253B26E.3020800@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 08, 2013 at 12:51:18PM +0530, Anshuman Khandual wrote:
> On 10/08/2013 09:51 AM, Michael Ellerman wrote:
> > On Mon, Oct 07, 2013 at 10:00:26AM +0530, Anshuman Khandual wrote:
> >> Right now the `config_bhrb` PMU specific call happens after write_mmcr0
> >> which actually enables the PMU for event counting and interrupt. So
> >> there is a small window of time where the PMU and BHRB runs without the
> >> required HW branch filter (if any) enabled in BHRB. This can cause some
> >> of the branch samples to be collected through BHRB without any filter
> >> being applied and hence affecting the correctness of the results. This
> >> patch moves the BHRB config function call before enabling the interrupts.
> > 
> > Patch looks good.
> > 
> > But it reminds me I have an item in my TODO list:
> >  - "Why can't config_bhrb() be done in compute_mmcr()" ?
> > 
> 
> compute_mmcr() function deals with generic MMCR* configs for normal PMU
> events. Even if BHRB config touches MMCRA register, it's configuration
> does not interfere with the PMU config for general events. So its best
> to keep them separate. 

I'm unconvinced. If they'd been together to begin with this bug never
would have happened.

And there's the added overhead of another indirect function call.

> Besides, we can always look at these code consolidation
> issues in future. 

The future is now.

> But this patch solves a problem which is happening right now.

Sure, I'm not saying we shouldn't merge it as a fix. But I think we
should do the cleanup to move it into compute_mmcr() for 3.13.

cheers
