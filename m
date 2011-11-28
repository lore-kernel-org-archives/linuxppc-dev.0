Return-Path: <anton@samba.org>
Date: Mon, 28 Nov 2011 22:47:52 +1100
From: Anton Blanchard <anton@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/6] powerpc/time: Use clockevents_calc_mult_shift
Message-ID: <20111128224752.6694154b@kryten>
In-Reply-To: <B695AB74-08F7-46DE-A9E9-BC7475FA1F3F@kernel.crashing.org>
References: <20111124060716.362614789@samba.org>
 <20111124060847.198884481@samba.org>
 <B695AB74-08F7-46DE-A9E9-BC7475FA1F3F@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, miltonm@bga.com,
 johnstul@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Kumar,

> > static void register_decrementer_clockevent(int cpu)
> > {
> > 	struct clock_event_device *dec = &per_cpu(decrementers,
> > cpu).event; @@ -955,7 +928,8 @@ static void __init
> > init_decrementer_cloc {
> > 	int cpu = smp_processor_id();
> > 
> > -	setup_clockevent_multiplier(ppc_tb_freq);
> > +	clockevents_calc_mult_shift(&decrementer_clockevent,
> > ppc_tb_freq, 4); +
> 
> Where's this magic 4 come from?

No better reason than that's what most other users do. We weren't
placing any limits on the shift/multiply in the old loop I don't think
we need to, so we could probably just use 1 instead.

Anton
