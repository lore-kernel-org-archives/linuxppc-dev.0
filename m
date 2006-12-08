Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9411467BE6
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 07:35:07 +1100 (EST)
In-Reply-To: <4579B12D.3090300@freescale.com>
References: <20061207173541.GG22989@ld0162-tx32.am.freescale.net>
	<DC219401-9766-4BFD-BA94-7BA1997D9530@kernel.crashing.org>
	<4579B12D.3090300@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FDE06AFE-E8B2-4507-99DA-2B8765AFA5B8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/4] powerpc: Call of_register_i2c_devices() for fsl-i2c.
Date: Fri, 8 Dec 2006 14:34:59 -0600
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 8, 2006, at 12:38 PM, Scott Wood wrote:

> Kumar Gala wrote:
>> You are assuming the bus number is the same as our index. This  
>> may  not be true.
>
> http://ozlabs.org/pipermail/linuxppc-dev/2006-December/028924.html
>
> The above patch sets the I2C ID to the index, so as long as there  
> are no non-SOC i2c busses with static bus numbers, it'll work.
>
> If there are non-SOC i2c busses (such as on a PCI card) that claim  
> a conflicting static bus ID, there'll be problems -- but that  
> problem isn't powerpc or device-tree specific.

True, but I think we can do better.

> A more robust solution would be to allow each i2c adapter driver to  
> specify an i2c_board_info list when registering itself.  The  
> adapter driver could then get this list from platform code (if  
> appropriate; a PCI card that uses i2c internally would simply have  
> its own list), without having to deal with system-wide bus IDs.

What about doing the of_register_i2c_devices in the fsl-i2c driver  
itself.  Than it knows what bus number its been assigned.

- k
