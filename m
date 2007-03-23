Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id 4C702DDFED
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Mar 2007 17:22:16 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: AVNET 440GX board
Date: Fri, 23 Mar 2007 07:22:25 +0100
References: <393e3a4b0703221234n20eee581g6cbf9af9be2c5ebb@mail.gmail.com>
In-Reply-To: <393e3a4b0703221234n20eee581g6cbf9af9be2c5ebb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200703230722.25498.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Ken,

On Thursday 22 March 2007 20:34, Ken Sakurai wrote:
> I'm trying to boot Linux on  AVNET 440gx eval board but no luck so far.
> What I did are that I downloaded a plain 2.6.20 kernel from kernel.org,
> configured with 440GX, OCOTEA target (I'm not sure OCOTEA is correct
> target),

I don't know the AVNET 440GX eval board. Is it _identical_ to the IBM/AMCC 
Ocotea? If not you will most likely have no luck with this image. You will 
have to port Linux to this special board.

> then loaded the kernel image via tftp  and tried to boot with bootelf
> command.
> But I had no output message from Linux.
>
> I suspected setting of Linux serial console. So I changed the kernel
> parameter to
> "ttyS0,19200" which I suppose correct becuase this is the minicom setting.
> But still didn't work.
>
> The board comes with u-boot 1.0.2 with some fixes.  I'm checking the u-boot
> source code (might be some hint in there) and the serial device
> initialization code in Linux.
>
> Has anyone had experiece with Linux on AVNET 440GX board?
> Any advise would be appreciated !

See below.

> -
> Ken
>
> ------
>
> => tftp
> Waiting for PHY auto negotiation to complete.. done
> ENET Speed is 100 Mbps - FULL duplex connection
> *** Warning: no boot file name; using '6501A8C0.img'

Hmmmm. That's a strange image name. Normally you should boot the uImage file 
from U-Boot.

> Using ppc_440x_eth2 device
> TFTP from server 192.168.1.1; our IP address is 192.168.1.101
> Filename '6501A8C0.img'.
> Load address: 0x100000
> Loading: #################################################################
>          #################################################################
>          #################################
> done
> Bytes transferred = 832121 (cb279 hex)
> => bootelf
> Loading .text @ 0x01000000 (15316 bytes)
> Loading .data @ 0x01004000 (700416 bytes)
> Clearing .bss @ 0x010af000 (8500 bytes)
> ## Starting application at 0x01000000 ...

And use the "bootm" command to boot the uImage.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
=====================================================================
