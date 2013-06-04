Return-Path: <michael@ellerman.id.au>
Message-ID: <1370339432.15166.6.camel@concordia>
Subject: Re: [PATCH] powerpc/perf: Fix deadlock caused by calling printk()
 in PMU exception
From: Michael Ellerman <michael@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 04 Jun 2013 19:50:32 +1000
In-Reply-To: <51ADADEB.1040109@linux.vnet.ibm.com>
References: <1370319657-26753-1-git-send-email-michael@ellerman.id.au>
 <51ADADEB.1040109@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>,
 sukadev@linux.vnet.ibm.com, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2013-06-04 at 14:35 +0530, Anshuman Khandual wrote:
> > +	seq_printf(p, "%*s: ", prec, "PMS");
> 
> Lets make this PMIS or PMI_S instead of PMS.

Everything else is aligned using a three character prefix, so that would
stuff the alignment up.

> 
> > +	for_each_online_cpu(j)
> > +		seq_printf(p, "%10u ", per_cpu(irq_stat, j).pmu_irqs);
> 
> This would be pmu_spurious_irqs instead of pmu_irqs.

Yep, thanks for reviewing.

I'm actually thinking I'll drop the counter, at least until we can be
sure it's not us causing the spurious interrupts.

cheers
