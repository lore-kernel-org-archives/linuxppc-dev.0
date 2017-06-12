Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wmnyW2DspzDq9m
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 08:44:35 +1000 (AEST)
Date: Tue, 13 Jun 2017 00:44:26 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com,
 bsingharora@gmail.com, anton@samba.org, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org, stewart@linux.vnet.ibm.com, dja@axtens.net,
 eranian@google.com, hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
Subject: Re: [PATCH v9 07/10] powerpc/perf: PMU functions for Core IMC and
 hotplugging
In-Reply-To: <692e037d-5367-208f-ac6f-8fd43e1643ba@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1706130043170.2152@nanos>
References: <1496665922-702-1-git-send-email-anju@linux.vnet.ibm.com>
 <1496665922-702-2-git-send-email-anju@linux.vnet.ibm.com>
 <alpine.DEB.2.20.1706061135490.1885@nanos>
 <692e037d-5367-208f-ac6f-8fd43e1643ba@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 7 Jun 2017, Anju T Sudhakar wrote:
> On Tuesday 06 June 2017 03:39 PM, Thomas Gleixner wrote:
> > On Mon, 5 Jun 2017, Anju T Sudhakar wrote:
> > > +static void cleanup_all_core_imc_memory(struct imc_pmu *pmu_ptr)
> > > +{
> > > +	struct imc_mem_info *ptr = pmu_ptr->mem_info;
> > > +
> > > +	if (!ptr)
> > > +		return;
> > That's pointless.
> 
> No, it is not.  We may end up here from imc_mem_init() when the memory
> allocation for pmu_ptr->mem_info fails. So in that case we can just
> return from here, and kfree wont be called with a NULL pointer.

What's the problem with that. kfree() CAN be called with a NULL pointer. It
has a check already.

Thanks,

	tglx
