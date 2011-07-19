Return-Path: <eric.dumazet@gmail.com>
Received: from mail-ww0-f45.google.com (mail-ww0-f45.google.com [74.125.82.45])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 62E15B71BF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 19:06:21 +1000 (EST)
Received: by wwj40 with SMTP id 40so3126656wwj.14
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 19 Jul 2011 02:06:16 -0700 (PDT)
Subject: Re: [PATCH v2] net: filter: BPF 'JIT' compiler for PPC64
From: Eric Dumazet <eric.dumazet@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1311062135.25044.409.camel@pasglop>
References: <4E23E5C3.1070209@ozlabs.org>  <4E24E867.9050909@ozlabs.org>
	<1311058260.16961.12.camel@edumazet-laptop>
	<1311062135.25044.409.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 19 Jul 2011 11:06:08 +0200
Message-ID: <1311066368.2375.13.camel@edumazet-HP-Compaq-6005-Pro-SFF-PC>
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

Le mardi 19 juillet 2011 à 17:55 +1000, Benjamin Herrenschmidt a écrit :
> On Tue, 2011-07-19 at 08:51 +0200, Eric Dumazet wrote:
> 
> > > +		case BPF_S_ANC_CPU:
> > > +#ifdef CONFIG_SMP
> > > +			/*
> > > +			 * PACA ptr is r13:
> > > +			 * raw_smp_processor_id() = local_paca->paca_index
> > > +			 */
> > 
> > This could break if one day linux supports more than 65536 cpus :)
> > 
> > > +			PPC_LHZ_OFFS(r_A, 13,
> > > +				     offsetof(struct paca_struct, paca_index));
> > > +#else
> > > +			PPC_LI(r_A, 0);
> > > +#endif
> > > +			break;
> 
> As would our implementation of raw_smp_processor_id() and our
> spinlocks :-) I don't think we need to fix that -now- but you are
> welcome to add something like a
> BUILD_BUG_ON(sizeof(local_paca->paca_index) != 2); as a reminder :-)

Please Matt add to your next version this check. I dont think I have to
submit a one line patch later...

On x86_64, cpu_number field is already 32bit, we have some time before
it becomes 64bit ;)

We probably should add some extra check to make sure segment doesnt
change (%gs on x86_64, r13 on ppc64) on a future linux version.
