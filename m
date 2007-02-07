Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 06B7ADDE2A
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 08:17:45 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l17LHiUw023440
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 14:17:44 -0700 (MST)
Received: from [10.82.19.119] (ld0169-tx32.am.freescale.net [10.82.19.119])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l17LHh6v029970
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Feb 2007 15:17:44 -0600 (CST)
Message-ID: <45CA41F7.6020700@freescale.com>
Date: Wed, 07 Feb 2007 15:17:43 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: mac-address vs. local-mac-address
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi everyone,

What is the current consensus on using mac-address vs. local-mac-address in the 
device tree?  The 1275 spec says this:

"local-mac-address" Standard property name to specify preassigned network address.
"mac-address" Standard property name to specify network address last used.

I think we need to agree on some interpretation of these statements, and all the 
code should be updated to implement that interpretation.

My interpretation is that mac-address is supposed to the contain these MAC 
addresses under these circumstances:

1) If the Ethernet interface is up, it's the MAC address that is currently in use.
2) If the Ethernet interface is not up, it's the MAC address that was in use the 
last time the Ethernet interface was shut down.

In Linux, the ifconfig command is used to change the MAC address.  This command 
calls the driver's set_mac_address function, so it is the driver that sets the 
MAC address in the hardware.

In order to properly support the mac-address property, the driver must also 
update the device tree with the new MAC address.  That's the only way that 
mac-address can contain the "specify network address last used".

Linux doesn't support that.  In some cases, the actual device tree is located on 
a TFTP server, and it's only copied temporarily into RAM by U-Boot.  There's no 
way that a Linux driver can update that.

On a full-blown OF machine, the firmware does provide APIs for updating the 
device tree, and so we could support mac-address on these machines.  But U-Boot 
disappears once the kernel loads, so there is no firmware to call to update the 
device tree.

Therefore, I propose that on systems where the driver cannot update the device 
tree, the mac-address property should be absent from the device tree.  U-Boot 
should not add one, and the Linux device drivers should not reference it.

Comments?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
