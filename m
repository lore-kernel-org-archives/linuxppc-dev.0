Return-Path: <timur@freescale.com>
Message-ID: <47B1BEE7.4050808@freescale.com>
Date: Tue, 12 Feb 2008 09:44:39 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Could the DTS experts look at this?
References: <47ACE630.8090101@pikatech.com>
	<20080211235409.GB18348@localhost.localdomain>
	<20080211235652.GC18348@localhost.localdomain>
	<200802120121.45349.arnd@arndb.de>
In-Reply-To: <200802120121.45349.arnd@arndb.de>
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

Arnd Bergmann wrote:

> On Tuesday 12 February 2008, David Gibson wrote:
>> Or to expand.  It's relatively easy now to just include multiple nodes
>> in the tree and either delete or nop some of them out conditionally
>> using libfdt.  

Yes, but what better place to store the conditions than in the device tree 
itself?  How would libfdt know where the conditions are?  Do you want to have 
two binary blobs?

>> But the conditional logic should be in the manipulating
>> agent (u-boot or bootwrapper or whatever), there's no way we're going
>> to require a conditional expression parser to interpret the device
>> tree blob itself.

I think it's a great feature that solves a lot of problems, and it does so in an 
elegant and efficient manner.  I look forward to trying to change your mind when 
I get around to implementing it.

> How about making the logic to nop out nodes a little more generic
> without changes to the binary format?
> E.g. you could have a "linux,conditional-node" property in the device
> tree whose value is compared to a HW configuration specific string.

The problem with this is that if you use a version of libfdt that does not 
understand "linux,conditional-node", then your device tree will be wrong, 
because it could contain nodes that don't belong.  We would need a new, 
incompatible version number for the device tree to make sure that this doesn't 
happen, even though nothing has changed in the binary layout of the tree.

-- 
Timur Tabi
Linux kernel developer at Freescale
