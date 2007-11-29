Return-Path: <agl@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7D19FDDDF4
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 02:11:16 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lATFB1b2022688
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 10:11:01 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lATFB1Ep291802
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 10:11:01 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lATFB0lb018680
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Nov 2007 10:11:00 -0500
Subject: Re: Problems booting a 64k page kernel
From: aglitke <agl@us.ibm.com>
To: michael@ellerman.id.au
In-Reply-To: <1196293142.7875.1.camel@concordia>
References: <1196290249.27582.122.camel@localhost.localdomain>
	<1196293142.7875.1.camel@concordia>
Content-Type: text/plain
Date: Thu, 29 Nov 2007 09:12:56 -0600
Message-Id: <1196349176.27582.129.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael, thanks for your reply...

I am seeing the segmentation fault both on the default SLES10 initrd and
the default RHEL5.1 initrd.  Therefore, I am reasonably sure this is a
problem with my kernel build and not the initrd itself.

On Thu, 2007-11-29 at 10:39 +1100, Michael Ellerman wrote:
> On Wed, 2007-11-28 at 16:50 -0600, aglitke wrote:
> > Hello all.  I am new to building 64k page kernels and can't seem to get
> > one to boot correctly.  Everything looks okay until init gets a signal
> > 11 while booting.  Attached is my boot log and the kernel config I used.
> > To generate this config I merely enabled the 64k page option in make
> > menuconfig to alter a previously working config.
> > 
> > Any help you can provide would be greatly appreciated.
> 
> I've seen that happen with an init linked with uClibc, its dynamic
> loader was doing mmap with MAP_FIXED on non-64K aligned addresses.
> What user space are you using?
> 
> cheers
> 
-- 
Adam Litke - (agl at us.ibm.com)
IBM Linux Technology Center
