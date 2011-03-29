Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A49ECB6EEE
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Mar 2011 19:13:20 +1100 (EST)
Subject: Re: [PATCH 15/18] powerpc/smp: Don't expose per-cpu "cpu_state" array
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: michael@ellerman.id.au
In-Reply-To: <1301377040.32738.14.camel@concordia>
References: <1299566250-10516-1-git-send-email-benh@kernel.crashing.org>
	<1299566250-10516-16-git-send-email-benh@kernel.crashing.org>
	<1301377040.32738.14.camel@concordia>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 29 Mar 2011 19:13:08 +1100
Message-ID: <1301386388.2402.672.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-03-29 at 16:37 +1100, Michael Ellerman wrote:
> Takes a cpu parameter ..
> 
> > +void generic_set_cpu_dead(unsigned int cpu)
> > +{
> > +     __get_cpu_var(cpu_state) = CPU_DEAD;
> > +}
> 
> But doesn't use it.

Yeah that's a bug. Fortunately it's always called on the current CPU :-)
I'll fix it tho.

Thanks,
Ben.
