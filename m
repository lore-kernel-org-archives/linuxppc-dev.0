Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 47BBEDDEED
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 15:34:44 +1100 (EST)
Subject: Re: [PATCH 10/14] ps3: get firmware version
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <45BA8E7B.6010503@am.sony.com>
References: <45B81891.1010309@am.sony.com> <20070126025955.GE18537@lst.de>
	<45BA4DD5.2030106@am.sony.com>
	<1169843138.24996.114.camel@localhost.localdomain>
	<20070126203758.GC17317@localdomain> <45BA8ADA.8000108@am.sony.com>
	<45BA8E7B.6010503@am.sony.com>
Content-Type: text/plain
Date: Sat, 27 Jan 2007 15:34:30 +1100
Message-Id: <1169872471.24996.196.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Actually, now that I think about it, your suggestion seems like the best
> way to do it :-) 
> 
> Since /proc/device-tree/model gives the model, and I can arrange for
> /proc/device-tree/firmware to give a firmware version.  I'll just need to
> add a property to the tree after bootup.

In fact, the most logical place to do that is in the kboot wrapper, when
the tree is created initially. That way, it will be naturally passed
from kernel to kernel via kexec.

The zImage is built with a library to hack at the device-tree so it
should be trivial to do it there.

Ben.
