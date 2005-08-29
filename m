Return-Path: <kjoutwater@raytheon.com>
Received: from lax-gate4.raytheon.com (lax-gate4.raytheon.com [199.46.200.233])
	by ozlabs.org (Postfix) with ESMTP id 986E56811D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Aug 2005 06:52:02 +1000 (EST)
Received: from ds02w00.directory.ray.com (ds02w00.directory.ray.com
	[147.25.146.118])
	by lax-gate4.raytheon.com (8.12.10/8.12.10) with ESMTP id
	j7TK4ga0021062 for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Aug 2005 13:04:42 -0700 (PDT)
Received: from ds02w00 (localhost [127.0.0.1])
	by ds02w00.directory.ray.com (Switch-3.1.7/Switch-3.1.7) with ESMTP id
	j7TK4XtX022916
	for <linuxppc-embedded@ozlabs.org>; Mon, 29 Aug 2005 20:04:36 GMT
Received: from ds02w00.directory.ray.com with LMTP by ds02w00
	(2.0.6/sieved-2-0-build-559)
	for <linuxppc-embedded@ozlabs.org>; Mon, 29 Aug 2005 20:04:33 +0000
Received: from tu2-msg04.rsc.raytheon.com (tu2-msg04.RSC.RAYTHEON.COM
	[147.24.232.105])
	by ds02w00.directory.ray.com (Switch-3.1.7/Switch-3.1.0) with ESMTP id
	j7TK430G022643
	sender kjoutwater@raytheon.com for <linuxppc-embedded@ozlabs.org>;
	Mon, 29 Aug 2005 20:04:08 GMT
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
From: Keith J Outwater <kjoutwater@raytheon.com>
Message-ID: <OF3A16F4F3.EBDE8FF7-ON0725706C.006D0CC0-0725706C.006E3BB4@mck.us.ray.com>
Date: Mon, 29 Aug 2005 13:04:01 -0700
Content-Type: text/plain; charset="US-ASCII"
Subject: Question regarding partitioning of hardware drivers
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello everyone - 
I am developing an embedded ppc system using a 2.4 series kernel and I 
have a question regarding hardware drivers.
I have 4 LEDs connected to a GPIO port.  Each LED is controlled by a bit 
on the I/O port - set a bit to zero to turn the LED on, set the bit to one 
to turn the LED off.  The state of the bits are readable, so 
read-modify-write works.  The GPIO port is implemented with a Xilinx IP 
module and I have a driver available.  The Xilinx driver supports multiple 
GPIO ports. 
I have a driver available for the heartbeat LED ('status_led' by Wolfgang 
Denk) that works.
Now to the question:
I wish to use one of the four LEDs as a 'heartbeat' and the remainder as 
user LEDs.  Since all LEDs are accessed using the same hardware resource, 
the Linux heartbeat driver and the user GPIO driver will have to 
arbitrate.  I would like to separate the status led (heartbeat) driver 
from the GPIO driver as much as I can.  Is there an effective approach for 
doing this?  I think I could brute-force things by simply combining the 
GPIO and status LED drivers and then tell the 'unified' driver which LED 
to use as the heartbeat, but that approach eliminates the benefits of 
using existing drivers 'as-is', among other things.
I'm thinking that what I need to be able to do is give each driver access 
to a mutex that the drivers can then use to coordinate access to the 
hardware, but I'm not sure how to set up the mutex or where to put the 
code that does the initialization and mapping for the hardware access.

Keith
