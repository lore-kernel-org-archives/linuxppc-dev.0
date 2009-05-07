Return-Path: <jan.neskudla.ext@nsn.com>
Received: from demumfd001.nsn-inter.net (demumfd001.nsn-inter.net
	[217.115.75.233])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "demumfd001.nsn-inter.net",
	Issuer "VeriSign Class 3 Secure Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6DA9EDDE1B
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 00:34:19 +1000 (EST)
Received: from demuprx016.emea.nsn-intra.net ([10.150.129.55])
	by demumfd001.nsn-inter.net (8.12.11.20060308/8.12.11) with ESMTP id
	n47EAmlX009786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 7 May 2009 16:10:48 +0200
Received: from demuxf9c (demuxf9c.ul.emea.nsn-intra.net [10.151.17.108])
	by demuprx016.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP
	id n47EAlsl017730
	(version=TLSv1/SSLv3 cipher=RC4-MD5 bits=128 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 7 May 2009 16:10:48 +0200
Subject: RE: [PATCH 0/5] rapidio: adding memory mapping IO support and misc
	fixes
From: Jan Neskudla <jan.neskudla.ext@nsn.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Thu, 07 May 2009 16:10:47 +0200
Message-Id: <1241705447.19689.114.camel@demuxf9c>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hallo, 

I tested your patches, and the MMIO is working when enabled in the
rionet driver. Only the compilation of rionet as modules was a problem.
I had to add following lines into rio.c to export missing symbols.

EXPORT_SYMBOL_GPL(rio_unmap_inb_region);
EXPORT_SYMBOL_GPL(rio_map_inb_region);
EXPORT_SYMBOL_GPL(rio_unmap_outb_region);
EXPORT_SYMBOL_GPL(rio_map_outb_region);

And one more think, when I enabled usage of DMA, rionet does not compile too, 
but in this case I do not have a fix. I tested this on kernel 2.6.29.1 and 
EP8548 as target board. 

                        Jan 




> 
> The patch series add MMIO support to Linux rapidio and fix a few nits.
> The patches cross rapidio, netdev, powerpc sub-systems.  It will be
> good for them to go through one tree.  Probably Andrew?  As the
> previous rapidio patches are mostly merged by you.
> 
> - Leo
