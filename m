Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 978F4B70A3
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 07:52:44 +1000 (EST)
Subject: Re: Reserved pages in PowerPC
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ankita Garg <ankita@in.ibm.com>
In-Reply-To: <20100916120806.GJ2332@in.ibm.com>
References: <20100916052311.GC2332@in.ibm.com>
	<1284631464.30449.85.camel@pasglop> <20100916120806.GJ2332@in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 17 Sep 2010 07:52:31 +1000
Message-ID: <1284673951.30449.93.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-09-16 at 17:38 +0530, Ankita Garg wrote:
> Thanks Ben for taking a look at this. So I checked the rtas messages
> on
> the serial console and see the following:
> 
> instantiating rtas at 0x000000000f632000... done
> 
> Which does not correspond to the higher addresses that I see as
> reserved
> (observation on a 16G machine). 

Well, I'd suggest you audit prom_init.c which builds the reserve map,
and the various memblock_reserve() calls in prom.c

Cheers,
Ben.
