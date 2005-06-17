Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id 6C7E3679E1
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 16:53:52 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j5H6xAEY025689
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 09:59:12 +0300 (EEST)
Message-ID: <42B27223.3040808@intracom.gr>
Date: Fri, 17 Jun 2005 09:48:03 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Allen Curtis <acurtis@onz.com>
References: <ecc06b51023e6ebd23d075aa3948749e@onz.com>	<33f285d9677314c043e77908198a3e0e@embeddededge.com>
	<b2f31907a6e9a9180a96318ceeacb468@onz.com>
In-Reply-To: <b2f31907a6e9a9180a96318ceeacb468@onz.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Allen Curtis wrote:
>>> Should the DPRAM appear as it's own platform_device?
>>
>>
>> No.
>>
>>> Option 1) Specify the portion of the DPRAM used by each device with 
>>> that platform_device definition. (current)
>>
>>
>> You mean the parameter space?  That's different from DPRAM.
>>
>>> Option 2) Define the whole DPRAM region as its own platform_device 
>>> entry. Move the device DPRAM information to the device specific 
>>> platform structure.
>>
>>
>> How is this any different from using the dpalloc() as it is today?
>>
>> The problem is that for the few standard devices we publicly support in
>> Linux it is easy to think of DPRAM as a "general" resource.  However, for
>> more challenging devices and implementation, there are sometimes specific
>> regions of DPRAM that must be used with various additional restrictions.
>> For many of the "real world" devices I have done, drivers would manage
>> their own, well known, DPRAM areas.  It isn't something that is easy
>> to generalize or configure in advance.
>>
> Time for code.
> 
> - Allen
> 

FWIW the current dpalloc implementation supports "carving out" the usable
dpram out of the whole. I mean you could conceivably not "give" the driver
specific dpram areas to the generic allocator. This should be a per platform
configuration item.

The current code just doesn't bother...

Regards

Pantelis
