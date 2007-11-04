Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 50DE9DDE3B
	for <linuxppc-dev@ozlabs.org>; Sun,  4 Nov 2007 12:02:49 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DD2A9B2C-5D35-4F53-8542-3470C6FA5265@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: use of aliases in device trees
Date: Sat, 3 Nov 2007 20:02:39 -0500
To: linux-ppc list <linuxppc-dev@ozlabs.org>
Cc: U-Boot Users List <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In some discussion on the u-boot dev list it became clear that having  
aliases in the device tree might be useful as a common way to deal  
with finding specific nodes that need fixing up by the firmware.   
This problem also exists in the kernel bootwrappers.

The common example is how to associate a given MAC address with the  
proper ethernet node.  In u-boot an explicit path is hard coded into  
the u-boot build for each ethernet device.  In the bootwrapper we use  
"linux,network-index = <N>" in the given ethernet node.

One common solution would be having a top level aliases like the pmac  
tree's have:

aliases {
	enet0 = "...";
	enet1 = "...";
	pci0 = "...";
	pci1 = "...";
};

I wanted to see what people think of this idea and about trying to  
use common names for the aliases?  If nothing else I believe we will  
look at doing this on the FSL boards/parts.

- k
