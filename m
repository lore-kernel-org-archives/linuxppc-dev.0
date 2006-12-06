Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5158867C98
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Dec 2006 03:09:17 +1100 (EST)
In-Reply-To: <4576E8CC.6050508@grandegger.com>
References: <4576E8CC.6050508@grandegger.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B1186D1B-C47D-46C3-B928-8FDE4A55363B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: How to use the device tree for lite5200
Date: Wed, 6 Dec 2006 10:09:11 -0600
To: Wolfgang Grandegger <wg@grandegger.com>
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


On Dec 6, 2006, at 9:59 AM, Wolfgang Grandegger wrote:

> Hello,
>
> I want to boot PowerPC Linux 2.6.19 on my Icecube board but I didn't
> succeed yet to get lite5200.dts compiled and an appropriate image  
> created:
>
>    $ dtc -b0 lite5200.dts
>    DTC: dts->dts  on file "lite5200.dts"
>    ERROR: Missing /chosen node
>    Input tree has errors
>
> What is the procedure to make and boot an uImage for the U-Boot
> bootloader. I read about the third argument for bootm but did not
> understand how to use it.

How have you booted in the past?  Do you tftp down the images or run  
from flash?

Here's an example assuming you have a kernel image at address  
$loadaddr and the dtb at $ftaddr

dtc -b0 -Idts -Odtb -V16 lite5200.dts > lite5200.dtb

download lite5200.dtb to the system

=> bootm $loadaddr - $fdtaddr

- k
