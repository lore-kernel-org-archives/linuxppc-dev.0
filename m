Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 01F55679E0
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 09:58:28 +1100 (EST)
Message-ID: <4579ED1F.5050205@freescale.com>
Date: Fri, 08 Dec 2006 16:54:23 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 4/4] powerpc: Call of_register_i2c_devices() for fsl-i2c.
References: <20061207173541.GG22989@ld0162-tx32.am.freescale.net>
	<DC219401-9766-4BFD-BA94-7BA1997D9530@kernel.crashing.org>
	<4579B12D.3090300@freescale.com>
	<FDE06AFE-E8B2-4507-99DA-2B8765AFA5B8@kernel.crashing.org>
In-Reply-To: <FDE06AFE-E8B2-4507-99DA-2B8765AFA5B8@kernel.crashing.org>
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
> What about doing the of_register_i2c_devices in the fsl-i2c driver  
> itself.  Than it knows what bus number its been assigned.

It won't know the dynamic bus number until after it registers the 
adapter, which is too late (even if the new-style device registration 
were modified to support registering devices after adapter registration, 
legacy probing drivers for devices on the same address might grab the 
device first, before the proper device gets registered).

The allocation of an i2c bus ID could be factored out into its own 
function that gets called before registering the i2c adapter.  This 
(plus calling of_register_i2c_devices in the adapter driver) isn't much 
different from passing the list in with the adapter registration, but it 
would avoid some list management.  OTOH, it means we'd have to continue 
having global numeric bus IDs even after the last legacy driver is 
converted.

-Scott
