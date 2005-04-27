Return-Path: <frannk_m1@yahoo.com>
Received: from web32211.mail.mud.yahoo.com (web32211.mail.mud.yahoo.com
	[68.142.207.142]) by ozlabs.org (Postfix) with SMTP id A088067B17
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Apr 2005 14:44:32 +1000 (EST)
Message-ID: <20050427043750.93023.qmail@web32211.mail.mud.yahoo.com>
Date: Tue, 26 Apr 2005 21:37:50 -0700 (PDT)
From: Frank <frannk_m1@yahoo.com>
To: Stuart Yoder <stuart.yoder@conformative.com>, 'Wolfgang Denk' <wd@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

--- Stuart YoYoderststuartoyoderoconformativeom> wrote:
> 
> We've run into a few issues with U-boot, but they are not
> ununsolveable
> 
> -it doesn't provide an alternate execution path for the 2nd
> CPU when it
> is started by the kernel

You have to set a flag or something to sync. the booting process
of the other cpu's

> -U-boot needs to detect which CPU is executing
> -U-boot on the 2nd CPU should not execute any platform/board
> specific

We did this by having the cpcpuead a register that is updated as
each cpcpuomes up.

> setup code-- this is stuff you only want to do once
> -U-boot on the 2nd CPU cannot relocate itself to SDSDRAMecause
> Linux is
> already running there and assumes it owns all of memory

You have to carve the memory up by dividing the total memory by
the number of cpus. This can be done at complie time with a
#define. I did this in board_init_f I believe. We had a quad
7450 board with each one booting in sequence and orchestrated by
the master CPU (cpu 0). The master held each one in reset until
the previous cpu reported in. Unfortunately, I don't work for
the company anymore and don't have access to the source.
BTW, it was done right because it worked.:-)

> -it needs some way of getting to the Linux kernel entry point
> for
> secondary CPUs
> -it also appears that it should set up HID1 (other stuff??)
> for SMSMP> systems
> 
> Stuart
> 
> > -----Original Message-----
> > From: Wolfgang DeDenkmamailtodwdedenxede
> > Sent: Tuesday, April 26, 2005 12:35 PM
> > To: Stuart YoYoder> > Cc: 'lilinuxppcedevist'
> > Subject: Re: PoPowerPC SMSMP
> > 
> > 
> > In message <054301c54a6f$d1cf82b0$2f010a0a@foundation.com>
> you wrote:
> > > 
> > > I am using U-boot on my SMSMPystem and U-boot is not
SMSMP> aware.  Do 
> > > you
> > 
> > Strictly speaking this statement is wrong.
> > 
> > So far I am not aware of a port of U-Boot to a SMSMPystem.  
> > If  there was  such  a  port, and if it was properly done, 
> > then U-Boot probably _were_ SMSMPware.
> > 
> > Best regards,
> > 
> > Wolfgang DeDenk> > 
> > -- 
> > Software Engineering:  Embedded and ReRealtimeystems, 
> Embedded Linux
> > Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: 
> > wdwdedenxedevery program has at least one bug and can be 
> > shortened by  at  least one  instruction  --  from  which,  
> > by induction, one can deduce that every program can be 
> > reduced to one instruction which doesn't work.
> > 
> > 
> > 
> 
> 
> _______________________________________________
> LiLinuxppcedevailing list
> LiLinuxppcedevzozlabsrorg>
hthttps/ozozlabsrorgailman/lilistinfoilinuxppcedev> 

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
