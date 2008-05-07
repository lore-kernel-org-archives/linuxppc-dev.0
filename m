Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 33F21DDF5A
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 06:42:55 +1000 (EST)
In-Reply-To: <1210157630.25560.884.camel@pmac.infradead.org>
References: <20080507102724.GE4326@pengutronix.de>
	<1210157630.25560.884.camel@pmac.infradead.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9146b2e7fde34e912d20e6ea954bb067@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: jffs2 and unaligned access
Date: Wed, 7 May 2008 22:42:28 +0200
To: David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> memcpy_from/to_io() use word aligned accesses on the io side of 
>> memory.
>> The MPC5200 local plus bus where our flashes are connected does not
>> allow unaligned accesses, so we have to use the io versions of memcpy.
>
> But this region of flash is marked as suitable for execute-in-place,
> otherwise the point() function wouldn't be working to give a direct
> pointer to it. It sounds like we shouldn't be allowing that.
>
> Which in turn means that perhaps we should have a property in the
> corresponding node in the device-tree which indicates that it's not
> suitable for direct access?

This isn't usually a property of the flash device, but of the various
buses/controllers above the flash device.  The device tree should mimic
reality (and it does, it just seems the kernel doesn't use this 
information
yet?)


Segher
