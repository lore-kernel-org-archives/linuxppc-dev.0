Return-Path: <rsiemsen@rossvideo.com>
Received: from server06.rossvideo.com (gw-rossvideo.storm.ca [209.87.241.202])
	by ozlabs.org (Postfix) with ESMTP id 8326E67C42
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Jul 2005 04:41:25 +1000 (EST)
Message-ID: <42C982D2.6070904@rossvideo.com>
Date: Mon, 04 Jul 2005 14:41:22 -0400
From: Ralph Siemsen <rsiemsen@rossvideo.com>
MIME-Version: 1.0
To: David Grab <d.grab@hima.com>
References: <003101c57d66$9de20a20$f201a8c0@SN7606>
In-Reply-To: <003101c57d66$9de20a20$f201a8c0@SN7606>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PCC440GX custom board configuration
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David Grab wrote:

> Now i want to configure Linux to match my custom board. I ported my board
> based on ocotea board configuration files and excluded all the stuff i don´t
> need. My kernel seems to load but get stuck on calibrating delay loop and
> loops between update_proces_times and __delay (at address 0xC0003400) until
> it reboots. Seems like i didn´t match the BogoMips calculation. Actually i
> don´t use the RTC (i comment out all TODC functions). I think this cause the
> problem. So what i have to do to boot without RTC or has someone my RTC
> running with linux?

You are most likely not passing the clock speed from bootloader 
correctly.  You can set it forcibly in the beginning of ocotea.c, or 
else fixup the structure passed between bootloader and kernel so that 
both sides match.  Doing the latter will fix a lot of other troubles 
that you will encounter later on as well.  See also:

http://www.denx.de/twiki/bin/view/DULG/LinuxHangsAfterUncompressingKernel

-R
