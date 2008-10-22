Return-Path: <neko@genesi-usa.com>
Received: from yw-out-2324.google.com (yw-out-2324.google.com [74.125.46.28])
	by ozlabs.org (Postfix) with ESMTP id D88CADDE1E
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 05:40:53 +1100 (EST)
Received: by yw-out-2324.google.com with SMTP id 5so556550ywh.39
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 11:40:52 -0700 (PDT)
Message-ID: <48FF73B2.8040600@genesi-usa.com>
Date: Wed, 22 Oct 2008 13:40:50 -0500
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] powerpc: Remove device_type = "rtc" properties in .dts
	files
References: <20081021185844.GA31070@oksana.dev.rtsoft.ru>
	<48FF2CBB.7060605@genesi-usa.com>
	<20081022135046.GA30347@oksana.dev.rtsoft.ru>
In-Reply-To: <20081022135046.GA30347@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=windows-1251; format=flowed
Sender: Matt Sealey <neko@genesi-usa.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



Anton Vorontsov wrote:
> On Wed, Oct 22, 2008 at 08:38:03AM -0500, Matt Sealey wrote:
>> I'm extremely troubled that it is "not used in the code", surely 
>> device_type is checked as a legacy for Open Firmware (otherwise a lot of 
>> devices may never be detected!),
> 
> Checked where? 

of_find_device_by_type() goes through it and 
of_find_compatible_node() - while not directly, checks the 
type field of the node which is filled in from device_type 
BEFORE it checks the compatible property.

This isn't specific CHRP/FDT platform code it's in the generic 
tree scanning functions.

> platforms, the CHRP is running real OF, so it is irrelevant if it
> checks for device_type = "rtc" or not.)

Except when there is no compatible property because the device 
is adequately identified by device_type (for instance if you 
are looking for every serial port on a system, device_type is 
your only hope without checking for every different KIND of 
serial port you may ever possibly encounter.. or if you are 
checking for what kind of console OF attached you to (be it 
display/keyboard combination or serial or something else).

It's a useful property that should be kept around, you never 
know when it might be needed :D but of course since it's not 
in ePAPR, no point in shoving it in when "compatible" 
describes your board very very accurately anyway (except when 
you have no need to be very very accurate and are just looking 
for serial ports... :)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
