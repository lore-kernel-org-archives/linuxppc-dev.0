Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 11878DDEFC
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 13:26:51 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id l873Qpnw023611
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 13:26:51 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.250.244])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l873UOpD202390
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 13:30:24 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l873QoXf009037
	for <linuxppc-dev@ozlabs.org>; Fri, 7 Sep 2007 13:26:50 +1000
Date: Fri, 7 Sep 2007 13:26:49 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 2/6] cuimage for Bamboo board
Message-ID: <20070907032649.GB3082@localhost.localdomain>
References: <20070831200449.598781000@linux.vnet.ibm.com>
	<20070831200643.029244000@linux.vnet.ibm.com>
	<20070903010111.GC31499@localhost.localdomain>
	<1188826931.3772.11.camel@localhost.localdomain>
	<20070905011045.GC17189@localhost.localdomain>
	<1188952819.3223.5.camel@localhost.localdomain>
	<20070905054645.GA26788@localhost.localdomain>
	<1188971635.3223.9.camel@localhost.localdomain>
	<20070905114243.3c787838@weaponx.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905114243.3c787838@weaponx.rchland.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 11:42:43AM -0500, Josh Boyer wrote:
> Updated patch below.  NOTE: This relies on Scott Wood's strtoull patch
> as PIBS stores the MAC addresses as ASCII strings in flash.
> 
> 
> Add a cuboot wrapper for the Bamboo board.  This also removes some obsoleted
> linker declarations that have been moved into ops.h
> 
> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

Except..
[snip]
> --- linux-2.6.orig/arch/powerpc/boot/treeboot-bamboo.c
> +++ linux-2.6/arch/powerpc/boot/treeboot-bamboo.c

It's not the fault of this patch, but since bamboo actually boots from
PIBS, not OpenBIOS, it probably shouldn't be lumped in with the
treeboot stuff.  PIBS should be able to load ELF images directly,
rather than using the silly treeboot header, for one thing.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
