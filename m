Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B98EBDE227
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 10:41:58 +1000 (EST)
Received: from mailgate01.slac.stanford.edu (mailgate01.slac.stanford.edu
	[134.79.18.80])
	by nospam3.slac.stanford.edu (8.13.8/8.13.8) with ESMTP id
	m3H0aUK9007835
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 17:36:30 -0700 (PDT)
	(envelope-from rmachet@slac.stanford.edu)
Received: from pcds-ts102.slac.stanford.edu (pcds-ts102.slac.stanford.edu
	[134.79.128.151])
	by mailgate01.slac.stanford.edu (8.13.8/8.13.8) with ESMTP id
	m3H0aTub019989
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 17:36:29 -0700 (PDT)
	(envelope-from rmachet@slac.stanford.edu)
Subject: MV64x60 device bus
From: Remi Machet <rmachet@slac.stanford.edu>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Wed, 16 Apr 2008 17:36:36 -0700
Message-Id: <1208392597.5668.82.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I am working on a board with an MV64460 and this controller has what its
data sheet call a device controller (ie a generic asynchronous bus to
connect NOR flashes and other similar devices). On this board a NOR
flash is connected to it and I would like to get it to be recognized by
the Open Firmware MTD map driver.

The problem is that this driver expects the flash to be registered as an
of_platform device, I could do that in the board file itself but I think
it would be more useful to add some generic code for all MV64360 based
boards: 

My idea would be to add to the MV64360 initialization code the
registration of an of_platform bus if a node of type 'devicectrl' is
found (inside the mv64360 node); this node would contain all the devices
attached to the device bus and the of_platform sub-system would take
care of creating the proper of_platform devices.

Does anyone have comments or a better idea ?

Thanks,

Remi
