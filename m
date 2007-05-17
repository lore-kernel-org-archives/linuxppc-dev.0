Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8322EDDE07
	for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2007 03:22:48 +1000 (EST)
In-Reply-To: <464C871C.4090300@freescale.com>
References: <20070517143846.GC29795@ld0162-tx32.am.freescale.net>
	<FB8DD3C1-A095-4ABB-9E74-7EC66A43D983@kernel.crashing.org>
	<464C800C.20400@freescale.com>
	<FFBD3A3A-ADBE-4DC8-A1A1-4163367244D5@kernel.crashing.org>
	<464C871C.4090300@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5B363A90-5528-4441-BBF9-9C6D8833D938@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/5] powerpc: Document device nodes for I2C devices.
Date: Thu, 17 May 2007 12:21:02 -0500
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


On May 17, 2007, at 11:47 AM, Scott Wood wrote:

> Kumar Gala wrote:
>> On May 17, 2007, at 11:17 AM, Scott Wood wrote:
>>> Kumar Gala wrote:
>>>> As I've stated before, we need a bus number as well so we can   
>>>> handle  things like I2C switches and muxes.
>>>
>>> Is this something we handle now?  If not, then it's really not   
>>> within the scope of this patchset.  If so, how am I breaking it?
>> We don't handle i2c devices in the dev tree today.  If you are  
>> going  to propose a solution it should work for all cases that  
>> people are  aware of even if linux doesn't support the functionality.
>
> But we do handle i2c *controllers* in the device tree, and that's  
> where a bus number property would go.  Given that we don't have a  
> binding for non-toplevel i2c buses, and I'm not adding one, I don't  
> see the relevance.  Note that adding a bus number property makes  
> zero sense for toplevel buses, as at that level the bus number is  
> just a fiction maintained by Linux for user API and device  
> preregistration purposes.

The only support we have for i2c controllers is to support one  
specific i2c controller from Freescale.

If you aren't going to provide a complete solution why are you  
prosing one?  I'm tired of this put stuff in the device tree but only  
as much as I need to do my particular thing.  The device tree is just  
as important an interface point as the kernel/user space interfaces  
and we should treat it as such.  If people aren't willing to work to  
a complete solution than they should stop proposing changes.

> It's not a matter of the binding only covering some cases; it's a  
> matter of the binding being for one thing (i2c devices) and not  
> another (multiplexed i2c buses).

But once you introduce the concept of i2c devices you introduce the  
possibility of hierarchies.  For example, tell me how I'd describe  
the following device http://www.nxp.com/pip/PCA9548ABS.html and any  
i2c devices connected to it?

>> If only some subset of cases are handled what good is the device  
>> tree  to a user?  They will just have to figure out if their usage  
>> is  supported or not and if not find some other solution that  
>> works for  them.
>
> ...just as they'll have to figure out if a binding exists for  
> device type $FOO.

True, but if I go look at the PCI OF spec I have some faith that its  
complete and will cover my needs.

As I've been thinking about this I think trying to even describe i2c  
devices in the device tree is point less.  Since I2C devices have no  
way of uniquely identifying themselves we are looking at taking on  
the role of device name registrar and if someone is willing to do  
that great, but I doubt anyone truly is.

- k
