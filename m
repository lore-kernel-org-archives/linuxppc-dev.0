Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 94BEADDFB9
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 02:15:19 +1100 (EST)
Message-ID: <46014BF5.6060509@freescale.com>
Date: Wed, 21 Mar 2007 10:15:01 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/17] bootwrapper: Add dt_set_mac_addresses().
References: <20070316172641.GA29709@ld0162-tx32.am.freescale.net>
	<20070316172853.GJ29784@ld0162-tx32.am.freescale.net>
	<20070317013159.GH3969@localhost.localdomain>
	<45FC8643.1080807@freescale.com>
	<20070318115656.GA12765@localhost.localdomain>
	<45FEA7B3.9090304@freescale.com>
	<1b943ac2c00b7f1f5696d006b67e9877@kernel.crashing.org>
In-Reply-To: <1b943ac2c00b7f1f5696d006b67e9877@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> Normally, that's true.  The problem is that device drivers first check 
>> mac-address and
>> then local-mac-address (see of_get_mac_address()).  If the DTS define 
>> mac-address as
>> something other than 00-00-00-00-00-00, the drivers are going to see 
>> mac-address that and
>> use it.
> 
> So fix that :-)  

I'm working on it.

 > It's a layering violation anyway, a device
> driver has no business peering at "mac-address", that's info
> for a way higher layer ;-)

Eh, I don't think I agree with that.  mac-address is supposed to be used 
if it exists, because it represents the "most recent MAC address".  If 
it's not set, then the driver checks local-mac-address.

See of_get_mac_address(), which I wrote.

>> Obviously, the DTS files shouldn't have mac-address in them.  But I 
>> haven't gotten around
>> to cleaning that up, because I'm still waiting for the U-Boot 
>> maintainers to apply my
>> pre-requisite patches.
> 
> Well there's that, sure.  Please put comments in your source
> code saying this _is_ a hack and for _what_ and that it should
> be removed when your dependency is fixed, and all is fine.

I don't consider it a hack.  The U-Boot code checks for mac-address, and 
then updates it if it exists.  Then it checks for local-mac-address and 
does the same.  I don't see this code changing ever, because we're 
always going to need to support older device trees that don't have just 
local-mac-address.

>> Perhaps mac-address should be deleted instead of just ignored?
> 
> That would be incorrect behaviour if you get passed a device
> tree where "mac-address" is correctly set (i.e., the device
> has been used for booting, or something).

Ok.
