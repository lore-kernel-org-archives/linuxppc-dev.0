Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DBEC4B7BCA
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Dec 2009 13:37:45 +1100 (EST)
Subject: Re: [PATCH] powerpc/mm: setting mmaped page cache property through
	device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Li Yang <leoli@freescale.com>
In-Reply-To: <2a27d3730912010334q24bf0e06g84839aae131475ec@mail.gmail.com>
References: <1259663450-28790-1-git-send-email-leoli@freescale.com>
	<1259665127.2076.363.camel@pasglop>
	<2a27d3730912010334q24bf0e06g84839aae131475ec@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 04 Dec 2009 13:37:37 +1100
Message-ID: <1259894257.2076.1244.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-12-01 at 19:34 +0800, Li Yang wrote:
> The scenario for the second case is to pre-allocate some memory to a
> certain application or device (probably through mem=XXX kernel
> parameter or limit through device tree).  The memory is not known to
> kernel, but fully managed by the application/device.  We need being
> able to map the region cachable for better performance.
> 
> > trying to achieve here ? We can find a solution though it might
> involve
> > a specific driver to handle that memory.
> 
> Right, but what the user to kernel API should be used?  Is it ok to
> use the O_SYNC flag as I previously proposed? 

If it's cachable, why don't you write yourself a little driver that
allocates memory maps it to userspace and provides you with the physical
addresses and problem solved ?

Cheers,
Ben.
