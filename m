Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9CC2ADDE1B
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 21:28:13 +1000 (EST)
Received: from 82-46-178-156.cable.ubr06.king.blueyonder.co.uk
	([82.46.178.156] helo=[192.168.2.228])
	by mail.genesi-usa.com with esmtpa (Exim 4.66 (FreeBSD))
	(envelope-from <matt@genesi-usa.com>) id 1HyQmF-000IYA-0p
	for linuxppc-dev@ozlabs.org; Wed, 13 Jun 2007 11:12:39 +0000
Message-ID: <466FD4EC.80304@genesi-usa.com>
Date: Wed, 13 Jun 2007 12:28:44 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Enforcing built-in driver init order?
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I'm trying to work out how to decouple the BestComm SRAM driver from the
BestComm DMA engine. SRAM is far more useful than just as a DMA buffer,
especially as it can stay active over deep sleep and SDRAM refresh turned
off, as a temporary place to put things. Even with a full set of tasks
there are still some kilobytes free. In future processors the SRAM will
only get larger meaning you can do more things with it, and it may be
used for more than DMA.

My simple problem is, if I split the two drivers apart, the SRAM platform
driver is not guaranteed to load before the DMA platform driver. If it
were a module I could have depmod handle it and load them in order but
this isn't possible since DMA is required on boot, and SRAM is required
for DMA.

Any clues or hints on how it can be EASILY enforced that the SRAM platform
driver is present (and can be checked for??) before the BestComm engine
is turned on and tasks are arbitrarily loaded?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
