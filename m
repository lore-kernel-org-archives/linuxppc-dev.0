Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 21EE0DDE3D
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Feb 2007 09:22:43 +1100 (EST)
Message-ID: <45CA5130.2020006@freescale.com>
Date: Wed, 07 Feb 2007 16:22:40 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: mac-address vs. local-mac-address
References: <45CA41F7.6020700@freescale.com>
	<1170883956.2620.305.camel@localhost.localdomain>
	<45CA47AB.1000302@freescale.com>
	<0EF1DDFB-E590-422C-8FA6-0FD643E68F49@kernel.crashing.org>
	<45CA4DBC.7090401@freescale.com>
	<31D17474-FA61-4E0A-9114-FB6C965451FF@kernel.crashing.org>
In-Reply-To: <31D17474-FA61-4E0A-9114-FB6C965451FF@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:

>> For most boards, the compiled-in option is just some random MAC 
>> address.  When the board is shipped, the manufacturer creates his own 
>> set of environment variables and overrides what's stored on flash.
> 
> And where does the mfg store these?

Ideally, on the Ethernet adapters's internal EEPROM.  On non-OF systems, the 
driver is supposed to read the MAC address from the hardware.

> Ok, so 'compiled-in' wasn't the best choice.  What I meant is 
> 'local-mac-address' is the MAC address u-boot decides to use when it 
> boots before any user interaction.  

I agree with that.

> (this may be the compiled-in one, or 
> one from flash env settings, or whatever other source the board code 
> decides).

Well, I think you mean that it should be only the environment variable.  The 
compiled-in version is just a default value for the environment, so that should 
be ignored.  On a few U-Boot Ethernet drivers, the driver queries the hardware 
and fetches the MAC address from it.  The driver then updates the environment 
variable.

So in all case, when U-Boot boots the kernel, it should use the environment 
variable to update local-mac-address, and leave mac-address alone.  I'm trying 
to get a consensus on this proposition.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
