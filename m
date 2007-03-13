Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 4280ADDE27
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 09:59:47 +1100 (EST)
Message-ID: <45F6F4EE.8090504@freescale.com>
Date: Tue, 13 Mar 2007 13:01:02 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
	<4CB3B3D5-6D4A-4D67-92FC-3B8C38850326@kernel.crashing.org>
	<20070313181617.GA5360@ld0162-tx32.am.freescale.net>
	<F7652F68-D6FF-465C-BC8F-4F0C4D976AC0@kernel.crashing.org>
In-Reply-To: <F7652F68-D6FF-465C-BC8F-4F0C4D976AC0@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> On Mar 13, 2007, at 1:16 PM, Scott Wood wrote:
>> On Mon, Mar 12, 2007 at 04:07:57PM -0500, Kumar Gala wrote:
>>> Why is linux,stdout-path needed by cuboot?
>>
>> It's used by serial.c to find the console, and the kernel requires  it as
>> well.  There's no information in the bd_t that would allow the
>> bootwrapper to generate this, so it has to come from the device tree.
>>
>> The only reason it's not required with dt-enabled u-boot is that u- boot
>> has it hardcoded in the board's config file.
> 
> I don't think we should put this into the .dts but, have code in the  
> wrapper that handles it.

How?  Any means I can think of would be uglier, more complex, and/or put 
information in the bootwrapper that it shouldn't have.

I think it belongs in the dts, anyway...  The default serial port is 
more a property of the board than a configuration issue (although it has 
aspects of both).  Any bootloader that wants to set a non-default serial 
port is welcome to overwrite the property.

-Scott
