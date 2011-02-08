Return-Path: <ayman@elkhashab.com>
Received: from hrndva-omtalb.mail.rr.com (hrndva-omtalb.mail.rr.com
	[71.74.56.125]) by ozlabs.org (Postfix) with ESMTP id 11F1FB712F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  9 Feb 2011 06:25:24 +1100 (EST)
Received: from hrndva-omtalb.mail.rr.com ([10.128.143.53])
	by hrndva-qmta04.mail.rr.com with ESMTP
	id <20110208192022878.KZHN2580@hrndva-qmta04.mail.rr.com>
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Feb 2011 19:20:22 +0000
Received: from crust.elkhashab.com (localhost [127.0.0.1])
	by crust.elkhashab.com (8.14.3/8.14.3/Debian-5) with ESMTP id
	p18JJDMO016560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Feb 2011 13:19:13 -0600
Received: (from ayman@localhost)
	by crust.elkhashab.com (8.14.3/8.14.3/Submit) id p18JJDAB016559
	for linuxppc-dev@lists.ozlabs.org; Tue, 8 Feb 2011 13:19:13 -0600
Date: Tue, 8 Feb 2011 13:19:13 -0600
From: Ayman El-Khashab <ayman@elkhashab.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: help debugging linux setting PLX Gen2 PCIe switches to gen1 speed
Message-ID: <20110208191913.GA16286@crust.elkhashab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I've got a custom 460SX board with PLX gen2 (8616) switches.  

When u-boot comes up everything is fine and my switches are indicating they 
are in Gen2 PCIe mode.  If I let it boot my linux kernel (denx 2.6.36.1), boot
almost immediately, the LEDs on my switches start to blink indicating they 
have are now at Gen1 speed.  I've turned on debug in ppc4xx_pci.c but don't see 
anything obvious.  As far as when it happens, it looks like the last message
to the console is "uncompressing kernel" and then the LEDs start blinking.
seems that it indicates it is very early.  I've also tried removing all the PCIe
from the device tree, but that did not matter.

In the data sheet it indicates that PEDSRn_RCEI can change the advertised rate.
I've disabled that in the code, but it did not make any difference.

I am just not sure where things are getting switched over.  Any help would be 
appreciated. 

best
ayman
