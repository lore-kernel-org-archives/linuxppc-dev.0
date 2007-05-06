Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 6ACE4DDEDB
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 10:09:33 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/4] Add support for 750CL Holly board
Date: Sun, 6 May 2007 02:09:21 +0200
References: <1178302414.3026.202.camel@zod.rchland.ibm.com>
	<20070505143925.GA21503@lixom.net>
	<1178377874.3393.17.camel@zod.rchland.ibm.com>
In-Reply-To: <1178377874.3393.17.camel@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200705060209.21852.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Saturday 05 May 2007, Josh Boyer wrote:
> > 
> > It would be very easy to take tsi108_setup_pci take the config base as
> > a function paramter and pass it in from the board setup code, and store
> > it in a static variable to be used for the tsi108_clear_pci_cfg_error
> > function.
> > 
> > That'd easily make the code multiplatform friendly without having to
> > add it to the device tree. Very few other platforms have the config base
> > address in there, if any. It shouldn't be a requirement that Holly has it.
> 
> Yeah, after thinking about it, that's what I plan on doing actually.
> 

Yes, sounds fair enough. The more interesting bits to clean up in the
driver are to convert it to an of_platform_driver and to use phylib, and
then autodetecting this will be trivial, and until then hardcoding in the
board setup seems a good solution.

	Arnd <><
