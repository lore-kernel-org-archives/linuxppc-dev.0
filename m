Return-Path: <jan.neskudla.ext@nsn.com>
Received: from demumfd002.nsn-inter.net (demumfd002.nsn-inter.net
	[217.115.75.234])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "demumfd002.nsn-inter.net",
	Issuer "VeriSign Class 3 Secure Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CC649DDDF4
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 19:18:11 +1000 (EST)
Subject: RapidIO - general questions
From: Jan Neskudla <jan.neskudla.ext@nsn.com>
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 12 May 2009 11:17:52 +0200
Message-Id: <1242119872.16400.113.camel@demuxf9c>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hallo 

we'd likes to use a RapidIO as a general communication bus on our new
product, and so I have some questions about general design of Linux RIO
subsystem. I did not find any better mailing list for RapidIO
discussion. 

[1] - we'd like to implement following features 
    * Hot-plug (hot-insert/hot-remove) of devices
    * Error handling (port-write packets - configuration, handling of
them)
    * Static ID configuration based on port numbers 
    * Aux driver - basic driver, for sending messages over different
mboxes, handling ranges of doorbells	

    Is it here anyone who is working on any improvement, or anyone who
knows the development plans for RapidIO subsystem? 

[2] - I have a following problem with a current implementation of
loading drivers. The driver probe-function call is based on comparison
of VendorID (VID) and DeviceID (DID) only. Thus if I have 3 devices with
same DID and VID connected to the same network (bus), the driver is
loaded 3times, instead only once for the actual device Master port. 

Rionet driver solved this by enabling to call initialization function
just once, and it expect that this is the Master port. 

Is it this correct behavior  ? It looks to me that RapidIO is handled
like a local bus (like PCI) 
 
                                   Jan 
