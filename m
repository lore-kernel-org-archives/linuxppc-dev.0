Return-Path: <chrisalfred@internode.on.net>
Received: from mail.internode.on.net (bld-mail17.adl2.internode.on.net
	[150.101.137.102]) by ozlabs.org (Postfix) with ESMTP id 5C7FFB7D97
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 08:33:07 +1000 (EST)
Received: from kos (unverified [150.101.122.103])
	by mail.internode.on.net (SurgeMail 3.8f2) with ESMTP id
	27846673-1927428 for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Jun 2010 07:48:04 +0930 (CST)
Message-ID: <83C8A8763104479A8B315FB38247DDDF@kos>
From: "Chris Alfred \(Internode\)" <chrisalfred@internode.on.net>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: Porting a driver to powerpc using FDT
Date: Wed, 16 Jun 2010 08:18:04 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I am trying to port a DSA (Distributed Switch Architecture) driver for 
the Micrel KS8995M managed switch connected to a MPC5200. There is an 
SPI interface and MII interface managed by the DSA driver.

I can't understand how probe gets called when the flatted device tree 
(FDT) system is used, and how to bind such a driver using the FDT (if 
you have to at all).

The DSA driver is initialised via:

    // net/dsa/dsa.c

    static struct platform_driver dsa_driver = {
     .probe  = dsa_probe,
     .remove  = dsa_remove,
     .shutdown = dsa_shutdown,
     .driver = {
      .name = "dsa",
      .owner = THIS_MODULE,
     },
    };

    static int __init dsa_init_module(void)
    {
     return platform_driver_register(&dsa_driver);
    }

dsa_init_module is being called; but how do I get the system to call 
.probe?

Chris
