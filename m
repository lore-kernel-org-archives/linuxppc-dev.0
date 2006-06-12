Return-Path: <bcook@bpointsys.com>
Received: from bpointsys.com (70-253-197-251.ded.swbell.net [70.253.197.251])
	by ozlabs.org (Postfix) with ESMTP id 6E85267B15
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Jun 2006 23:30:42 +1000 (EST)
From: Brent Cook <bcook@bpointsys.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Jumbo ethernet frames on MVME6100
Date: Mon, 12 Jun 2006 08:30:45 -0500
References: <821B2170E9E7F04FA38DF7EC21DE487105550413@VCAEXCH01.hq.corp.viasat.com>
In-Reply-To: <821B2170E9E7F04FA38DF7EC21DE487105550413@VCAEXCH01.hq.corp.viasat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200606120830.45800.bcook@bpointsys.com>
Cc: "Martin, Tim" <tim.martin@viasat.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 09 June 2006 19:57, Martin, Tim wrote:
> I'm using Linux 2.6.6 with the Motorola Computer Group patch for the
> MVME6100 available at
>
> https://mcg.motorola.com/cfm/templates/swDetails.cfm?PageID=704&Software
> ID=6&ProductID=202
>
> and compiling with GCC from ELDK 3.1.1, although using the userspace
> module utils (e.g. insmod) from ELDK 4.0.

> The patch includes support for the Marvel gigabit ethernet part on the
> board (MV64360?) which works for non-jumbo ethernet frames, but doesn't
> receive (or even generate errors) if I send jumbo-ethernet frames.  I
> haven't debugged this issue very long, but a cursory look through the
> driver hints that jumbo frame support should be on (the port config
> serial register PCSR has what I imagine to be okay bits).
>
> I'm ifconfiging the 2nd ethernet device with the command
> ifconfig eth1 mtu 9000 192.168.1.1
>
> I'm wondering if anyone else using an MVME6100 has gotten jumbo frame
> support to work?

I can say that the MV64x60 ethernet driver that got rolled into the mainline 
kernel around the 2.6.11/12 timeframe does support jumbo frames for send and 
receive. If that patch is anything like some patches I've seen for similar 
products (based on old Marvel/Galileo reference code), I'd say your best-off 
cherry-picking the HW-specific bits from the patch and trying to either 
forward-port/add from scratch the board support to something >= 2.6.12 and 
getting the improved MV64x60 support as a bonus, or backporting at least the 
newer MV ethernet driver. Not only is the newer one _much_ simpler and easier 
to read (like 3 or 4x shorter), but it would appear to work better as well.

> Also, at what point did the Linux 2.6 kernel embedded PPC support start
> working with GCC 4.x (e.g. GCC in ELDK 4.0).  I'm getting compiler
> errors when I use GCC 4.x with this version of the kernel.

No problems here with 2.6.11 through 17-rc6 on gcc 4.

 - Brent
