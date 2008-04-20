Return-Path: <rje@valleytech.com>
Received: from smtp-0.hosting.atlantic.net (smtp-0.hosting.atlantic.net
	[209.208.105.24]) by ozlabs.org (Postfix) with ESMTP id 2DE7EDE096
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 20 Apr 2008 15:49:16 +1000 (EST)
Message-ID: <480AD64E.1040406@valleytech.com>
Date: Sun, 20 Apr 2008 01:36:14 -0400
From: "R. Ebersole (VTI - new)" <rje@valleytech.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org.
Subject: mpc8349, gb ethernet, bridging
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi.

We are having some issues regarding bridging the 2 ethernet ports of an 
mpc8349, and are
trying to determine what is going on.


We are attempting to daisy-chain several mpc8349-based boards via the 2 
ethernet ports
on each 8349.  When we enable bridging for the units, we (sometimes) 
start seeing the following
on one of the interior bridge's (mostly on the root bridge) console(s):

NETDEV WATCHDOG: eth1 : transmit timed out

We then see the bridge output  messages that indicate that is is going 
through a topology
state change.

This situation keeps recurring.

At some point, the message from the bridge that it is entering a 
disabled state for port #2
(eth1) is followed by garbage (actually, it appears to be some pointers 
and/or memory
addresses printed out), and the system hangs.

We are using NAPI and the skbuff-recycling for the gianfar driver.
We use ring(s) of 32 buffers.
The gianfar's watchdog is set to  1Hz (once a seond ?)

We are not sure if/how affect things:

Port #1 of the 'root' bridge  is attached directly to our LAN
Port #1 of the 'root' bridge runs at 10 Mbs
Port #2 of the 'root' bridge runs at 1Gbs
All other ports in the chain are       1Gbs
We are using CAT-5 cables for all connections

We have an application on each bridge in the chain that periodically 
sends several hundred bytes
'up the chain', towards its head (ie, towards our LAN).   This 
application is typically running
when the issue is seen.

Setting the bridge's forwarding delay to 0 and hellotime to 6,000 
helped, but did
not solve the issue.

???

-- 

Sometimes I feel like a red shirt in the Star Trek episode of life.

--

This message contains confidential information and is intended only for the
individual named.  If you are not the intended recipient you should not
disseminate, distribute or copy this e-mail.  Please notify the sender
immediately by e-mail if you have received this e-mail by mistake and delete
this e-mail from your system.
