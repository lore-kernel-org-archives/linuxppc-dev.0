Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 14E5DB6F84
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 17:55:42 +1000 (EST)
Subject: Re: [PATCH v2] net: filter: BPF 'JIT' compiler for PPC64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Eric Dumazet <eric.dumazet@gmail.com>
In-Reply-To: <1311058260.16961.12.camel@edumazet-laptop>
References: <4E23E5C3.1070209@ozlabs.org>  <4E24E867.9050909@ozlabs.org>
	<1311058260.16961.12.camel@edumazet-laptop>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Jul 2011 17:55:35 +1000
Message-ID: <1311062135.25044.409.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-07-19 at 08:51 +0200, Eric Dumazet wrote:

> > +		case BPF_S_ANC_CPU:
> > +#ifdef CONFIG_SMP
> > +			/*
> > +			 * PACA ptr is r13:
> > +			 * raw_smp_processor_id() = local_paca->paca_index
> > +			 */
> 
> This could break if one day linux supports more than 65536 cpus :)
> 
> > +			PPC_LHZ_OFFS(r_A, 13,
> > +				     offsetof(struct paca_struct, paca_index));
> > +#else
> > +			PPC_LI(r_A, 0);
> > +#endif
> > +			break;

As would our implementation of raw_smp_processor_id() and our
spinlocks :-) I don't think we need to fix that -now- but you are
welcome to add something like a
BUILD_BUG_ON(sizeof(local_paca->paca_index) != 2); as a reminder :-)

Cheers,
Ben.
