Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4AAA67A60
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Nov 2005 17:58:00 +1100 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ee5bI-00049T-KZ
	for linuxppc-embedded@ozlabs.org; Mon, 21 Nov 2005 07:56:28 +0100
Received: from dsl-202-45-109-210.vic.netspace.net.au ([202.45.109.210])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 21 Nov 2005 07:56:28 +0100
Received: from ronkbox-news by dsl-202-45-109-210.vic.netspace.net.au with
	local (Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 21 Nov 2005 07:56:28 +0100
To: linuxppc-embedded@ozlabs.org
From: Ron Kellam <ronkbox-news@yahoo.com>
Date: Mon, 21 Nov 2005 17:56:07 +1100
Message-ID: <qpr2o1dhoelk8rt11jl3lbangfs0hj710a@4ax.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
Subject: anyone used i2c-algo-8260 for the MPC8272 family?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I'm trying to get i2c-algo-8260 and i2c-pm826 working on an MPC8247.
It doesn't... It just hangs the kernel.

There are some subtle differences b/t the 8260 family and 8272 family.
The 8272 family only has 8KB DPRAM (c.f. 16KB), so I believe the
definition of PROFF_I2C in include/linux/cpm_8260.h should be
different.  I've changed it from:

	#define PROFF_I2C	((16 * 1024) - 64)
to 
	#define PROFF_I2C	((8 * 1024) - 64)

but still get no I2C activity, and a kernel hang.

Anyone have this working, or any thoughts to contribute?

Regards,
Ron Kellam.
