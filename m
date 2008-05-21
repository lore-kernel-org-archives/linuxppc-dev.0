Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B7D99DF230
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 07:28:02 +1000 (EST)
Subject: [PATCH 0/2] USB: isp1760: Fixes and support for more hardware configs
From: Nate Case <ncase@xes-inc.com>
To: Sebastian Siewior <bigeasy@linutronix.de>
Content-Type: text/plain
Date: Wed, 21 May 2008 16:27:50 -0500
Message-Id: <1211405270.13845.626.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-usb@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I spent a little time getting the new isp1760 driver to work on my ppc64
board with an ISP1761.  There were two main problems I encountered:

  - Driver wrote to the PORT 1 control register which is actually
    the OTG control register on the ISP1761.  This needs to be skipped
    on ISP1761 until we have proper OTG support.

  - Driver assumed 32-bit data bus mode.  You have to jump through
    a couple small hoops to get 16-bit mode to work, including some
    changes to the scratch register test.  I also had to re-order some
    of the steps to occur _after_ setting HW MODE control.

The first patch is a minor fix.  The second patch takes care of the
above issues and also adds support for the other bits in HW MODE control
that might vary from board to board.

Sebastian: I tried to be careful to minimize functional changes for your
case (isp1760, 32-bit mode), so things should work the same for you with
these patches applied.  However, I only have an ISP1761 to test with so
I'd appreciate it if you could test with your board.

I'm CCing linuxppc-dev in case there's any feedback on the OF device
tree property usage in patch 2/2.

-- 
Nate Case <ncase@xes-inc.com>
