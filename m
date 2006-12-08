Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 81E0F67B6F
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 05:43:00 +1100 (EST)
Message-ID: <4579B12D.3090300@freescale.com>
Date: Fri, 08 Dec 2006 12:38:37 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/4] powerpc: Call of_register_i2c_devices() for fsl-i2c.
References: <20061207173541.GG22989@ld0162-tx32.am.freescale.net>
	<DC219401-9766-4BFD-BA94-7BA1997D9530@kernel.crashing.org>
In-Reply-To: <DC219401-9766-4BFD-BA94-7BA1997D9530@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> You are assuming the bus number is the same as our index. This may  not 
> be true.

http://ozlabs.org/pipermail/linuxppc-dev/2006-December/028924.html

The above patch sets the I2C ID to the index, so as long as there are no 
non-SOC i2c busses with static bus numbers, it'll work.

If there are non-SOC i2c busses (such as on a PCI card) that claim a 
conflicting static bus ID, there'll be problems -- but that problem 
isn't powerpc or device-tree specific.

A more robust solution would be to allow each i2c adapter driver to 
specify an i2c_board_info list when registering itself.  The adapter 
driver could then get this list from platform code (if appropriate; a 
PCI card that uses i2c internally would simply have its own list), 
without having to deal with system-wide bus IDs.

-Scott
