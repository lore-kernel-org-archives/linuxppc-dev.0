Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DF4D3DDF56
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Apr 2007 20:52:59 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3UAquEJ029161
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Apr 2007 06:52:56 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3UAqum7554810
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Apr 2007 06:52:56 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3UAqtMn009209
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Apr 2007 06:52:55 -0400
Date: Mon, 30 Apr 2007 06:01:08 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: powerpc: Revise PPC44x MMU code for arch/powerpc
Message-ID: <20070430110107.GH23995@crusty.rchland.ibm.com>
References: <20070430040625.GD6436@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070430040625.GD6436@localhost.localdomain>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 30, 2007 at 02:06:25PM +1000, David Gibson wrote:
> Index: working-2.6/include/asm-powerpc/mmu-44x.h
> ===================================================================
> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ working-2.6/include/asm-powerpc/mmu-44x.h	2007-04-30 14:05:35.000000000 +1000

<snip>

> +#ifndef __ASSEMBLY__
> +
> +typedef unsigned long long phys_addr_t;
> +
> +extern phys_addr_t fixup_bigphys_addr(phys_addr_t, phys_addr_t);

This function can likely get removed entirely in arch/powerpc.  ioremap can
already take a 64 bit address and do the correct thing, so I'm not sure it's
even needed anymore.

josh
