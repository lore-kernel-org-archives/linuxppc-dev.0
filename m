Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id A1FF5DDF82
	for <linuxppc-dev@ozlabs.org>; Fri,  8 May 2009 01:26:03 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id B45A829EC9
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 17:24:45 +0200 (CEST)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 01761-10 for <linuxppc-dev@ozlabs.org>;
	Thu,  7 May 2009 17:24:45 +0200 (CEST)
Received: from archvile.prtnl (archvile.prtnl [192.168.1.153])
	by protonic.prtnl (Postfix) with ESMTP id 733F429EBA
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 17:24:45 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-dev@ozlabs.org
Subject: Re: MPC5121 new board constantly resetting after u-boot passes
	control to Linux
Date: Thu, 7 May 2009 17:26:25 +0200
References: <c788c1220905070143t5271ebe1ra12df43f8f53e491@mail.gmail.com>
In-Reply-To: <c788c1220905070143t5271ebe1ra12df43f8f53e491@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200905071726.25676.david.jander@protonic.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 07 May 2009 10:43:49 Damien Dusha wrote:
> Dear all,
>
> We are attempting to bring up a new MPC5121e board, somewhat based on the
> Silicon Turnkey's ADS5121 development board.  We are using a kernel and
> u-boot based on Freescale/STx's board support package.

Somewhat based on the ADS? How much? The ADS is quite a "special" board, and 
no other board should be similar with it (unless you have some strange reason 
to even copy the CPLD that's on it, which I assume you did not).

> We have successfully modified u-boot for the 64MB of DDR2 RAM, and we can
> use u-boot's (and the BDI's) memory test facility to check that the RAM is
> working.
>
> Our problem is that as soon as control is passed from u-boot to Linux, the
> board immediately resets.  It appears that the kernel has been decompressed
> correctly, and the memory at 0x00000000 appears to be similar to the same
> memory on the ADS board at the same address.  i.e. We have some confidence
> that the kernel is being decompressed correctly.
>
> With debug on, u-boot produces the following output on the console:
>
> U-Boot 2009.01-svn27683 (May 07 2009 - 15:35:15) MPC512X
>
> CPU:   MPC5121e rev. 2.0, Core e300c4 at 396 MHz, CSB at 198 MHz
>Board: ADS5121 rev. 0x0000 (CPLD rev. 0x00)
>[...removed lots of hard-to-read text output...]

The ADS5121 board has a CPLD that is being initialized at the beginning, and 
your output looks like you have not actually created a different 
board-support/name for your hardware. So I suspect, the linux kernel and/or 
your device tree is expecting the CPLD where there is probably no such CPLD, 
hence the crash.
You should try to create your own board-support stuff 
in /arch/powerpc/platforms/512x/... or use the generic support as it exists 
in mailine linux already. Then make your own DTS file describing YOUR 
hardware and be careful not to mention the ADS-board anywhere in it 
(specially not in "compatible..." sentences), to avoid confusing linux 
drivers that do special things for the ADS, that will probably break things 
for you.
Please also fix your u-boot BSP...

Best regards,

-- 
David Jander
Protonic Holland.
