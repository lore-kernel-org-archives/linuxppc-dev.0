Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 7115F67BDE
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Jun 2006 05:51:21 +1000 (EST)
Date: Sun, 11 Jun 2006 21:51:20 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: hbruegge@rockwellcollins.com
Subject: Re: Using RS232 Terminal as input device
In-Reply-To: <OF62BECBA0.4F3D8E04-ONC1257185.00247B21-C1257185.002CC13C@rockwellcollins.com>
Message-ID: <Pine.LNX.4.60.0606070017490.3970@poirot.grange>
References: <OF62BECBA0.4F3D8E04-ONC1257185.00247B21-C1257185.002CC13C@rockwellcollins.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Tue, 6 Jun 2006 hbruegge@rockwellcollins.com wrote:

> Hi all
> 
> 
> I am using the kernel (2.6.15) in an ppc-based embedded system through a 
> serial console on ttyS0 with no problems.
> 
> Now I attached a graphic card to the system, which is correctly 
> recognized and initialised by the Kernel. If I add "console=tty0 
> console=ttyS0,57600" to the bootargs, I have the boot messages of the 
> kernel on the screen and a login on the ttyS0.
> 
> What I now want to do is to disable the serial console and use the 
> graphic card as output and the raw character data (ASCII) coming in from 
> the terminal connected to the rs232 as input.

Well, it is possible... The keyword to google for is inputattach. A 
hint - it is a part of the linux-console package on sourceforge: 
http://linuxconsole.cvs.sourceforge.net/linuxconsole/ruby/utils/. You 
probably will have to write some glue driver. Or, probably, an easier 
option - write a user-space daemon that reads from /dev/ttyS0 and sends 
events to uinput. With this you don't need any kernel drivers - just a 
user-space daemon.

HTH
Guennadi
---
Guennadi Liakhovetski
