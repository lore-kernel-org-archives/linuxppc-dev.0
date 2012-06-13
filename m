Return-Path: <dargaud@lpsc.in2p3.fr>
Received: from lpsc-mail.in2p3.fr (lpsc-mail.in2p3.fr [134.158.40.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A35D3B6FF5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Jun 2012 02:20:57 +1000 (EST)
Received: from [134.158.40.174] (lpsc0174x.in2p3.fr [134.158.40.174])
 by lpsc-mail.in2p3.fr (8.13.1/8.13.1/In2p3) with ESMTP id q5DFLMEj016247
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jun 2012 17:21:22 +0200
Message-ID: <4FD8AFF2.6000702@lpsc.in2p3.fr>
Date: Wed, 13 Jun 2012 17:21:22 +0200
From: Guillaume Dargaud <dargaud@lpsc.in2p3.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Replacement to of_register_platform_driver ?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello all,
I just updated to the most recent kernel and a driver I wrote last year 
won't compile:
xad.c:534:2: error: implicit declaration of function 
'of_register_platform_driver'

I see references to this function as 'obsolete' but could not find 
what's the new recommended way to do things. Here's a bit of the 
offending code:

static struct of_platform_driver xad_driver = {
	.probe  = xad_driver_probe,
	.remove = xad_driver_remove,
	.driver = {
		.owner = THIS_MODULE,
		.name = "xad-driver",
		.of_match_table = xad_device_id,
	},
};

...

static int __init xad_init(void) {
...	
	first = MKDEV (my_major, my_minor);
	register_chrdev_region(first, count, DEVNAME);
	my_cdev = cdev_alloc ();
	if (NULL==my_cdev) goto Err;
	
	cdev_init(my_cdev, &fops);
	rc=cdev_add (my_cdev, first, count);
...	
	rc = of_register_platform_driver(&xad_driver);
...
}


-- 
Guillaume Dargaud
http://www.gdargaud.net/
