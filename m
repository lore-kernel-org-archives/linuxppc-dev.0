Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AC3D1DDDD4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Nov 2008 08:28:01 +1100 (EST)
Message-ID: <491B4A16.5090803@freescale.com>
Date: Wed, 12 Nov 2008 15:26:46 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: jcherukuri_necc@yahoo.com
Subject: Re: problems loading 2.6.25 kernel onto PQ2FADS-VR board
References: <204868.67373.qm@web110312.mail.gq1.yahoo.com>
In-Reply-To: <204868.67373.qm@web110312.mail.gq1.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jyotshna Cherukuri wrote:
> Bytes transferred = 12288 (3000 hex)
> => bootm 400000 - 800000
> ## Booting image at 00400000 ...
>    Image Name:   Linux-2.6.25
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1624845 Bytes =  1.5 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>    Booting using the fdt at 0x800000
>    Loading Device Tree to 007fc000, end 007fefff ... OK
> 
> And Then it stops. The board doesn't print anything else. Can anyone 
> please help me to whats going on and to what I need to  enable to see 
> some debug info on the serial port ( minicom in my case ).
> 
> P.S :  I did enable all the early level debugging in the kernel but yet 
> I dont see anything on the console.

Make sure that CONFIG_PPC_EARLY_DEBUG_CPM_ADDR is set properly for 
u-boot; it probably wants 0xf0000088.  The default vaule corresponds to 
cuImage.

If that doens't help, try booting the cuImage (without passing a device 
tree from u-boot); it's what I tested with as there was no device tree 
aware u-boot for this board at the time.  If that works and uImage 
doesn't, then there may be a mismatch between what u-boot is setting up 
in the device tree and what the kernel expects.

-Scott
