Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 80E32B7C33
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Apr 2010 21:17:07 +1000 (EST)
Subject: Re: [PATCH v2] powerpc: Track backing pages allocated by
	vmemmap_populate()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mark Nelson <markn@au1.ibm.com>
In-Reply-To: <201004131602.23898.markn@au1.ibm.com>
References: <201003261812.34095.markn@au1.ibm.com>
	<201004131416.23941.markn@au1.ibm.com>
	<1271136257.13902.9.camel@concordia>
	<201004131602.23898.markn@au1.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 13 Apr 2010 21:16:44 +1000
Message-ID: <1271157404.13059.102.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2010-04-13 at 16:02 +1000, Mark Nelson wrote:
> That's a good question, and one that I probably should have added to
> the
> commit message.
> But, following through, it looks like we end up calling into
> __remove_section() from mm/memory_hotplug.c and if
> CONFIG_SPARSEMEM_VMEMMAP is enabled we just return EBUSY as freeing
> memmap with vmemmap isn't implemented yet.
> 
> So for the moment, I'm not sure we have to worry about it.

We probably don't. IE. The vmemmap will remain for those struct pages,
which means they won't need to be allocated again if some memory is
plugged back there. If not, we just waste a bit of memory. Not a big
deal.

Cheers,
Ben.
