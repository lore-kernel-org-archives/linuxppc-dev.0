Return-Path: <stuart.yoder@conformative.com>
Received: from relay3.mail.twtelecom.net (relay3.mail.twtelecom.net
	[216.136.95.10]) by ozlabs.org (Postfix) with ESMTP id 8212E67A6D
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Apr 2005 05:07:47 +1000 (EST)
From: "Stuart Yoder" <stuart.yoder@conformative.com>
To: "'Wolfgang Denk'" <wd@denx.de>
Date: Tue, 26 Apr 2005 14:07:36 -0500
Message-ID: <056501c54a93$382d7bc0$2f010a0a@foundation.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050426173513.23FD1C1510@atlas.denx.de>
Cc: 'linuxppc-dev list' <linuxppc-dev@ozlabs.org>
Subject: RE: PowerPC + SMP 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


We've run into a few issues with U-boot, but they are not unsolveable--

-it doesn't provide an alternate execution path for the 2nd CPU when it
is started by the kernel
-U-boot needs to detect which CPU is executing
-U-boot on the 2nd CPU should not execute any platform/board specific
setup code-- this is stuff you only want to do once
-U-boot on the 2nd CPU cannot relocate itself to SDRAM because Linux is
already running there and assumes it owns all of memory
-it needs some way of getting to the Linux kernel entry point for
secondary CPUs
-it also appears that it should set up HID1 (other stuff??) for SMP
systems

Stuart

> -----Original Message-----
> From: Wolfgang Denk [mailto:wd@denx.de] 
> Sent: Tuesday, April 26, 2005 12:35 PM
> To: Stuart Yoder
> Cc: 'linuxppc-dev list'
> Subject: Re: PowerPC + SMP 
> 
> 
> In message <054301c54a6f$d1cf82b0$2f010a0a@foundation.com> you wrote:
> > 
> > I am using U-boot on my SMP system and U-boot is not SMP aware.  Do 
> > you
> 
> Strictly speaking this statement is wrong.
> 
> So far I am not aware of a port of U-Boot to a SMP system.  
> If  there was  such  a  port, and if it was properly done, 
> then U-Boot probably _were_ SMP aware.
> 
> Best regards,
> 
> Wolfgang Denk
> 
> -- 
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: 
> wd@denx.de Every program has at least one bug and can be 
> shortened by  at  least one  instruction  --  from  which,  
> by induction, one can deduce that every program can be 
> reduced to one instruction which doesn't work.
> 
> 
> 
