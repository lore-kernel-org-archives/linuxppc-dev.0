Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (smtp.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E28BF679FC
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 08:11:46 +1000 (EST)
Date: Fri, 14 Apr 2006 15:06:25 -0700
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 00/05] robust per_cpu allocation for modules
Message-Id: <20060414150625.3ba369d2.akpm@osdl.org>
In-Reply-To: <1145049535.1336.128.camel@localhost.localdomain>
References: <1145049535.1336.128.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mips@linux-mips.org, davidm@hpl.hp.com, linux-ia64@vger.kernel.org,
	mj@atrey.karlin.mff.cuni.cz, spyro@f2s.com, joe@tensilica.com,
	ak@suse.de, linuxppc-dev@ozlabs.org, paulus@samba.org,
	benedict.gaster@superh.com, bjornw@axis.com, mingo@elte.hu,
	grundler@parisc-linux.org, starvik@axis.com, torvalds@osdl.org,
	tglx@linutronix.de, rth@twiddle.net, chris@zankel.net,
	tony.luck@intel.com, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, marc@tensilica.com, lethal@linux-sh.org,
	schwidefsky@de.ibm.com, linux390@de.ibm.com, davem@davemloft.net,
	parisc-linux@parisc-linux.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> Example:
> 
>  DEFINE_PER_CPU(int, myint);
> 
>  would now create a variable called per_cpu_offset__myint in
> the .data.percpu_offset section.

Suppose two .c files each have

	DEFINE_STATIC_PER_CPU(myint)

Do we end up with two per_cpu_offset__myint's in the same section?
