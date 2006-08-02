Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 12AA2679E7
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 23:32:17 +1000 (EST)
In-Reply-To: <1154507145.24203.0.camel@localhost.localdomain>
References: <1154507145.24203.0.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <027C3DD1-67E1-4CF2-B8B6-36CD1F09D1D2@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: SMP in 32-bit arch/powerpc
Date: Wed, 2 Aug 2006 08:32:14 -0500
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 2, 2006, at 3:25 AM, Adrian Cox wrote:

> Is anybody else having problems with 32-bit SMP support in arch/ 
> powerpc?
> I'm using 2.6.17 as my current base, because I've not yet merged the
> latest mpic changes.
>
> I'm currently bringing up a dual-7448 board, and when I build the  
> kernel
> with CONFIG_SMP, the bootmem allocator corrupts the device tree. The
> strange thing is, this still happens when I don't start the second  
> CPU.
> Kernels built without CONFIG_SMP run flawlessly on the same hardware.

There are a few patches to prom.c that may help.  I know I've run  
into this on other 32-bit systems booting from u-boot.  These patches  
resolved my issue.

* [PATCH] powerpc: Auto reserve of device tree blob
* [POWERPC] Prevent duplicate lmb reservations for Device...

- kumar
