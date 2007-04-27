Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 2F5AADDEC9
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 03:51:13 +1000 (EST)
Date: Fri, 27 Apr 2007 12:51:38 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Show current speed in /proc/cpuinfo
Message-ID: <20070427175138.GA15582@lixom.net>
References: <20070427084118.GA8842@lixom.net>
	<1177665878.14873.320.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1177665878.14873.320.camel@localhost.localdomain>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 27, 2007 at 07:24:38PM +1000, Benjamin Herrenschmidt wrote:
> On Fri, 2007-04-27 at 03:41 -0500, Olof Johansson wrote:
> > On other architectures, the frequency in /proc/cpuinfo moves with cpufreq
> > changes. It makes sense to do the same on powerpc to keep users from
> > getting confused. Fall back to old ppc_proc_freq for non-cpufreq systems.
> > 
> > Also change the format to three decimals, having full Hz granularity is
> > silly these days.
> 
> That doesn't work if cpufreq is a module... on mac, I used to have
> exactly that hack, though at one point I changed to just updating
> ppc_proc_freq :-) But then, it's easy because I only change the freq on
> all CPUs at the same time. Might be different for you.

CONFIG_CPU_FREQ is a bool. do you mean the cpufreq driver?

I could change the output to be:

clock	:	xxxx.000MHz  (current speed)

and

clock	:	xxxx.000MHz  (reported by firmware)


depending on how I get the info.


-Olof
