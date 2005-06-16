Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5025F67A6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 05:41:22 +1000 (EST)
In-Reply-To: <ecc06b51023e6ebd23d075aa3948749e@onz.com>
References: <ecc06b51023e6ebd23d075aa3948749e@onz.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <33f285d9677314c043e77908198a3e0e@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 16 Jun 2005 15:41:20 -0400
To: Allen Curtis <acurtis@onz.com>
Cc: Ppc Embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC cpm2_devices DPRAM resource
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jun 16, 2005, at 1:45 PM, Allen Curtis wrote:

> Should the DPRAM appear as it's own platform_device?

No.

> Option 1) Specify the portion of the DPRAM used by each device with 
> that platform_device definition. (current)

You mean the parameter space?  That's different from DPRAM.

> Option 2) Define the whole DPRAM region as its own platform_device 
> entry. Move the device DPRAM information to the device specific 
> platform structure.

How is this any different from using the dpalloc() as it is today?

The problem is that for the few standard devices we publicly support in
Linux it is easy to think of DPRAM as a "general" resource.  However, 
for
more challenging devices and implementation, there are sometimes 
specific
regions of DPRAM that must be used with various additional restrictions.
For many of the "real world" devices I have done, drivers would manage
their own, well known, DPRAM areas.  It isn't something that is easy
to generalize or configure in advance.

Thanks.


	-- Dan
