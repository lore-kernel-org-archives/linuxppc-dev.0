Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id B671767A6F
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 05:05:50 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: FT u-boot shim 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 27 Apr 2006 13:18:43 CDT."
	<6E3621C5-A379-4ABC-99C0-9A02B48D525D@kernel.crashing.org>
Date: Thu, 27 Apr 2006 21:05:47 +0200
Sender: wd@denx.de
Message-Id: <20060427190547.1DD90353DAC@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	U-Boot Users <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <6E3621C5-A379-4ABC-99C0-9A02B48D525D@kernel.crashing.org>
Kumar Gala wrote:
> 
> 1. boot with an "old" u-boot (via bd_t):
> * Have a boot wrapper that takes bd_t and dts and merges them @ runtime
> * Boot wrapper has to be custom based on bd_t definition for the system
> * dts owned by kernel??

Since we cannot go back in time and fix the "old" U-Boot  this  seems
to be the only option.

> 2. boot with a "new" u-boot (has a .dts in it):
> * capable of booting arch/powerpc kernel directly w/o modification

OK.

> * in a production system don't want to update u-boot

Let's say we have to support such situations, too.

> * dts owned by u-boot??

I'm not sure about this. I tend to believe the  dts  belongs  to  the
kernel.

> Some questions/issues:
> * ownership of .dts is problematic.  I hate having a file duplicated  
> by both u-boot and kernel.  However it also seems bad to make the  
> build of either depend on the user grabbing a dts from some third  
> party.  Ideas?  A concrete example would be the MPC8349 ADS/SYS/MDS  
> port.  Boards ship with an "old" u-boot, thus we need a kernel  
> wrapper with .dts.  However, newer u-boot's can (hopefully will) have  
> a dts in them

Can we provide the dts as a separate blob that gets  built  with  the
kernel image? From U-Boot's point of view, this could be a multi-file
image  which  combines  the  dts and the kernel into a single file so
that users don't have to care much about this.

> * updating of dts:  In case 1, this is trivial since its part of the  
> kernel blob.  Case 2. is more difficult.  What do people think of  
> treating the dts like the environment.  You have a version compiled  

I don't like this idea.

> in, but can alternately have a blob in another location that will be  
> used if exists.  This would allow one to update the dts portion w/o  
> effecting the actual boot loader.

If we consider this, then we might as well combine the dts  with  the
kernel  image.  Alternatively,  the dts might be stored in a separate
location in memory. It would be easy to extend the "bootm" command to
take an additional argument (dts address).

> * one solution to the copies of .dts is that we make the wrapper  
> portion of the kernel the owner of the official latest and  
> greatest .dts.  Every so often a maintainer can sync their .dts with  
> u-boot to keep them relatively in sync.  However, the main mechanism  
> would be to load the latest .dts blob into the secondary location.   

Why not load it separately or as part of the Linux kernel image?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
No user-servicable parts inside. Refer to qualified service personnel.
