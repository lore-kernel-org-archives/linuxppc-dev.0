Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5EAD967A6D
	for <linuxppc-dev@ozlabs.org>; Fri, 26 May 2006 11:14:26 +1000 (EST)
Subject: Re: [snd] looking for layout-ids
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Johannes Berg <johannes@sipsolutions.net>
In-Reply-To: <1148553785.11759.12.camel@johannes.berg>
References: <1148553785.11759.12.camel@johannes.berg>
Content-Type: text/plain
Date: Fri, 26 May 2006 11:14:08 +1000
Message-Id: <1148606048.8089.8.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc <debian-powerpc@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2006-05-25 at 12:43 +0200, Johannes Berg wrote:
> Hey,
> 
> In order to replace snd-powermac for the newer machines where the
> 'sound' node has the 'layout-id' property, I'm looking for testers on
> machines that have a layout-id [1] property with one of the following
> values: 0x24, 0x29, 0x33, 0x50 and 0x3a.

Some tips:

 0x24 is old G5's (PowerMac7,2 and 7,3) primary i2s bus
 0x29 is not in my list so I don't know what machine it is 
 0x33 is aluminium powerbook 15" rev. 2 (PowerMac5,4)
 0x3a is mac mini (I can test that one one of these days but we'll need
the
	        toonie codec, which is basically a "null" codec with only
	        the amps GPIOs available)
 0x50 is not in my list

Also not in your list nor in the driver:

 0x3c is recent single CPU desktop G5 (PowerMac9,1) (SMU based) bus
i2s-a
 0x3d is same as above bus i2s-c

The later is a onyx + topaz setup iirc, possibly similar to the quad.

> Once I have all these, I will, along with submitting snd-aoa [2], submit
> a patch to snd-powermac that makes it refuse loading in presence of a
> layout-id property as a first step to migrate to snd-aoa.
> 
> At the same time, I'll probably make i2sbus refuse attaching to a device
> unless there's a layout-id property so that it doesn't claim devices aoa
> doesn't handle yet.
> 
> johannes
> 
> [1] to find your layout-id, execute the following:
> 
>   find /proc/device-tree/ -name layout-id | xargs hexdump -e '1/4 "0x%x\n"'
> 
> If you get no output, you have no layout-id property. If you do get
> output, it will look like this:
>   0x46
> This is the layout-id of your sound node.
> 
> [2] Before you ask: I will not do this before snd-aoa supports headphone
> detection :)
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
