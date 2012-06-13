Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 571AAB6FB9
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 03:53:45 +1000 (EST)
Date: Wed, 13 Jun 2012 10:47:35 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
Subject: Re: Replacement to of_register_platform_driver ?
Message-ID: <20120613174734.GA4846@ovro.caltech.edu>
References: <4FD8AFF2.6000702@lpsc.in2p3.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4FD8AFF2.6000702@lpsc.in2p3.fr>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 13, 2012 at 05:21:22PM +0200, Guillaume Dargaud wrote:
> Hello all,
> I just updated to the most recent kernel and a driver I wrote last year 
> won't compile:
> xad.c:534:2: error: implicit declaration of function 
> 'of_register_platform_driver'
> 
> I see references to this function as 'obsolete' but could not find 
> what's the new recommended way to do things. Here's a bit of the 
> offending code:
> 
> static struct of_platform_driver xad_driver = {
> 	.probe  = xad_driver_probe,
> 	.remove = xad_driver_remove,
> 	.driver = {
> 		.owner = THIS_MODULE,
> 		.name = "xad-driver",
> 		.of_match_table = xad_device_id,
> 	},
> };
> 
> ...
> 
> static int __init xad_init(void) {
> ...	
> 	first = MKDEV (my_major, my_minor);
> 	register_chrdev_region(first, count, DEVNAME);
> 	my_cdev = cdev_alloc ();
> 	if (NULL==my_cdev) goto Err;
> 	
> 	cdev_init(my_cdev, &fops);
> 	rc=cdev_add (my_cdev, first, count);
> ...	
> 	rc = of_register_platform_driver(&xad_driver);
> ...
> }
> 
> 
> -- 
> Guillaume Dargaud
> http://www.gdargaud.net/
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev

The history of drivers/misc/carma/carma-fpga.c will show you the code
changes necessary. Specifically, these two commits perform the
conversion:

493340207 carma-fpga: Missed switch from of_register_platform_driver()
b00e126ff MISC: convert drivers/misc/* to use module_platform_driver()

Hope it helps,
Ira
