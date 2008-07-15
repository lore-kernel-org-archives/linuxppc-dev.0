Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 34C07DDED4
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jul 2008 12:22:04 +1000 (EST)
Date: Tue, 15 Jul 2008 12:22:03 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] kill useless SMT code in prom_hold_cpus
Message-ID: <20080715022202.GD20457@bakeyournoodle.com>
References: <20080708223631.GP9594@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080708223631.GP9594@localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 08, 2008 at 05:36:31PM -0500, Nathan Lynch wrote:
> I think this code that counts SMT threads and compares against NR_CPUS
> is an artifact of pre-powerpc-merge ppc64.  We care about starting
> only primary threads in the OF client code.

<snip>

> -			prom_printf("%x : starting cpu hw idx %x... ", cpuid, reg);
> +			prom_printf("starting cpu hw idx %x... ", reg);

If we remove this, where else can we see the mapping of hardware IDs
to logical cpu IDs?  This is useful on POWER4 (at least where they can be
different).

<snip>
 
> -	if (cpuid > NR_CPUS)
> -		prom_printf("WARNING: maximum CPUs (" __stringify(NR_CPUS)
> -			    ") exceeded: ignoring extras\n");
> -

I think this printf() is valuable, if your boot a 128 thread machine on
a kernel with NR_CPUS=64, this is the only messaage you get to indicate
that you're wasting 64 threads, and how to resolve it.

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
