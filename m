Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 230CBDDF80
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 07:03:19 +1100 (EST)
Message-ID: <46018F7B.40107@freescale.com>
Date: Wed, 21 Mar 2007 15:03:07 -0500
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
	<46014BF5.6060509@freescale.com>
	<995355b28eecaafe955a5628ee939340@kernel.crashing.org>
	<46018315.1030703@freescale.com>
	<c4aa5f9e5e15d2e9686f77384f6cb532@kernel.crashing.org>
	<46018A00.9080703@freescale.com>
	<7a793472a33a30c35723be73e9cfce2f@kernel.crashing.org>
In-Reply-To: <7a793472a33a30c35723be73e9cfce2f@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stuart Yoder <stuart.yoder@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

>> If the property exists in the device tree, then it should be used, no? 
>>  Whether or not it exists is not for the driver to decide.
> 
> The property doesn't describe anything about the device;
> it merely tells you something about what the firmware did
> during booting.

Ah, I see your point.  But how else can the bootloader tell the kernel what MAC address to 
use?  You need to make sure that both use the same address.  I don't think the kernel 
command line supports MAC addresses.

> Just everything everywhere that mentions "mac-address" should be
> completely and utterly eradicated :-)

Are you saying that Linux should not acknowledge the existence of the mac-address 
property, even though it's part of the OF spec?

> And sure I understand you have to change one component at a
> time -- seems to me uboot is the first step to fix?

Depends on what you mean by a fix.  Although I understand your point that the MAC address 
doesn't really belong in the device tree, I don't see any better place for it.  So for 
now, I'm going on the assumption that mac-address and local-mac-address are valid 
properties, so it's just a question on *how* they should be supported.  In that context, 
the kernel has been updated already, and some of U-Boot has also.  Well, I'm ignoring some 
of the more obscure IBM systems, because I don't know anything about them.  All that's 
left is 85xx, 86xx, and 5xxx, and then I can clean up the DTS files, and then as far as 
I'm concerned, I'm done.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
