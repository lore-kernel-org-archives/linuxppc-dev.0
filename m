Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2BB1ADDF7E
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 19:24:46 +1000 (EST)
Subject: Re: [PATCH] powerpc: Show current speed in /proc/cpuinfo
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20070427084118.GA8842@lixom.net>
References: <20070427084118.GA8842@lixom.net>
Content-Type: text/plain
Date: Fri, 27 Apr 2007 19:24:38 +1000
Message-Id: <1177665878.14873.320.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-04-27 at 03:41 -0500, Olof Johansson wrote:
> On other architectures, the frequency in /proc/cpuinfo moves with cpufreq
> changes. It makes sense to do the same on powerpc to keep users from
> getting confused. Fall back to old ppc_proc_freq for non-cpufreq systems.
> 
> Also change the format to three decimals, having full Hz granularity is
> silly these days.

That doesn't work if cpufreq is a module... on mac, I used to have
exactly that hack, though at one point I changed to just updating
ppc_proc_freq :-) But then, it's easy because I only change the freq on
all CPUs at the same time. Might be different for you.

Ben.
