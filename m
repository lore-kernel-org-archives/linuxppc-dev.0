Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 53A6067C00
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Dec 2006 06:13:56 +1100 (EST)
Message-ID: <45771721.1080102@grandegger.com>
Date: Wed, 06 Dec 2006 20:16:49 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: How to use the device tree for lite5200
References: <4576E8CC.6050508@grandegger.com>
	<B1186D1B-C47D-46C3-B928-8FDE4A55363B@kernel.crashing.org>
In-Reply-To: <B1186D1B-C47D-46C3-B928-8FDE4A55363B@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Dec 6, 2006, at 9:59 AM, Wolfgang Grandegger wrote:
> 
>> Hello,
>>
>> I want to boot PowerPC Linux 2.6.19 on my Icecube board but I didn't
>> succeed yet to get lite5200.dts compiled and an appropriate image 
>> created:
>>
>>    $ dtc -b0 lite5200.dts
>>    DTC: dts->dts  on file "lite5200.dts"
>>    ERROR: Missing /chosen node
>>    Input tree has errors
>>
>> What is the procedure to make and boot an uImage for the U-Boot
>> bootloader. I read about the third argument for bootm but did not
>> understand how to use it.
> 
> How have you booted in the past?  Do you tftp down the images or run 
> from flash?

Yes, at least for development.

> Here's an example assuming you have a kernel image at address $loadaddr 
> and the dtb at $ftaddr
> 
> dtc -b0 -Idts -Odtb -V16 lite5200.dts > lite5200.dtb
> 
> download lite5200.dtb to the system
> 
> => bootm $loadaddr - $fdtaddr

Great, that worked with the additional "-f" option, as suggested by 
Grant. Now I can boot the kernel but BESTCOM and FEC support seem still 
missing. Are there already patches around?

Thanks to all who replied.

Wolfgang.
