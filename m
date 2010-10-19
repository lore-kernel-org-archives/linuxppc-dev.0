Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DD441B70D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Oct 2010 08:03:57 +1100 (EST)
Subject: Re: PROBLEM: memory corrupting bug, bisected to 6dda9d55
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <56111.84.105.60.153.1287521237.squirrel@gate.crashing.org>
References: <20101019181021.22456.qmail@kosh.dhis.org>
	<56111.84.105.60.153.1287521237.squirrel@gate.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 20 Oct 2010 08:02:48 +1100
Message-ID: <1287522168.2198.5.camel@pasglop>
Mime-Version: 1.0
Cc: Mel Gorman <mel@csn.ul.ie>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, pacman@kosh.dhis.org,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-10-19 at 22:47 +0200, Segher Boessenkool wrote:
> 
> It looks like it is the frame counter in an USB OHCI HCCA.
> 16-bit, 1kHz update, offset x'80 in a page.
> 
> So either the kernel forgot to call quiesce on it, or the firmware
> doesn't implement that, or the firmware messed up some other way.

I vote for the FW being on crack. Wouldn't be the first time with
Pegasos.

It's an OHCI or an UHCI in there ?

Can you try in prom_init.c changing the prom_close_stdin() function to
also close "stdout" ? 

         if (prom_getprop(_prom->chosen, "stdin", &val, sizeof(val)) > 0)
                 call_prom("close", 1, 0, val);
+        if (prom_getprop(_prom->chosen, "stdout", &val, sizeof(val)) > 0)
+               call_prom("close", 1, 0, val);

See if that makes a difference ?

Last option would be to manually turn the thing off with MMIO in yet-another
pegasos workaround in prom_init.c.

Cheers,
Ben.
