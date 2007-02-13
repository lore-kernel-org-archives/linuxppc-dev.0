Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8DA4BDDE2E
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 02:45:35 +1100 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l1DFjV7j031292
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 10:45:31 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by westrelay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.2) with ESMTP id
	l1DFjUp1518942
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 08:45:31 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l1DFjQeZ023414
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 08:45:28 -0700
Subject: Re: [0/16] Preliminary Ebony (440GP) support for arch/powerpc
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070213060904.GA6214@localhost.localdomain>
References: <20070213060904.GA6214@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 09:46:05 -0600
Message-Id: <1171381565.4003.48.camel@zod.rchland.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-02-13 at 17:09 +1100, David Gibson wrote:
> Here is a preliminary set of patches implementing support for the
> 440GP based Ebony evaluation board in arch/powerpc.  A number of the
> earlier patches are in Paul's queue already, so may appear in
> powerpc.git at any point.  Most of the later ones need at least some
> cleanup or reworking before they'll be ready for merging.
> 
> With these patches I can boot to a shell prompt on initrd on my Ebony
> board.  There are still a bunch of problems: clock timings are way out
> (runs about 4* fast), things freeze up when I attempt to use an
> nfsroot, many devices aren't supported.  A lot of things are hardcoded
> in the device tree, so you may well have to tweak it if your Ebony is
> different from mine.

I've noticed a couple issues so far on my board, which should just be a
stock Ebony.

1) Things are off when just using the zImage.ebony image.  For reasons
I've yet to narrow down, the bootwrapper thinks something passed an
initrd to it via the a2 parameter in prep_kernel even though there is no
initrd.  I get output like:

Loading file "zImage.ebony" ...                                                 
Sending tftp boot request ...                                                   
Transfer Complete ...                                                           
Loaded successfully ...                                                         
Entry point at 0x400010 ...                                                     
                                                                                
zImage starting: loaded at 0x00400000 (sp: 0x0052bda4)                          
Allocating 0x275088 bytes for kernel ...                                        
Using loader supplied initrd at 0xfff88000 (0x5463007e bytes)                   
gunzipping (0x52c320 <- 0x40a000:0x51e0a4)...done 0x256a94 bytes                
...moving kernel to final address 0x0                                           
                                                                                
Linux/PowerPC load: console=ttyS0                                               
Finalizing device tree... flat tree at 0x4085a0                                 

Which is obviously bogus.  When I ifdef out the check for a2 != 0, it
doesn't try to do the initrd step.

2) I get no boot output after the "Finalizing device tree..." step.  I
don't have a BDI or RW at the moment, but I'll try and figure out where
it's at and what it's doing.

josh
