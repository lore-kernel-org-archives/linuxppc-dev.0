Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DDE96679F9
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 04:18:49 +1000 (EST)
In-Reply-To: <20060426191957.14C4F353DAC@atlas.denx.de>
References: <20060426191957.14C4F353DAC@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6E3621C5-A379-4ABC-99C0-9A02B48D525D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: FT u-boot shim 
Date: Thu, 27 Apr 2006 13:18:43 -0500
To: Wolfgang Denk <wd@denx.de>
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


On Apr 26, 2006, at 2:19 PM, Wolfgang Denk wrote:

> In message <A8793E99-83C1-4FD9-8735- 
> D2E8F98B3003@kernel.crashing.org> you wrote:
>>
>> I think thats part of the idea with arch/powerpc defining a standard
>> mechanism for how a boot loader should pass information to the kernel
>> (via a flat device tree).
>
> Yet another standard.
>
>> How would you propose that we handle booting arch/powerpc kernels
>> from u-boot going forward? (for new board ports and existing board
>> ports).
>
> Ideally, I'd like to see a common kernel  interface  for  all  archi-
> tectures,  PowerPC  and ARM and MIPS and ... But last time I dared to
> suggest this I've been told what a nincompoop I am.
>
> I will accept what is decided by the P.T.B., but  I  request  not  to
> break backwards compatibility with existing systems.

I've been thinking about the various issues related to booting an  
arch/powerpc kernel via u-boot.   I was hoping to get some ideas/ 
comments on what people thought about the various issues/questions  
related to producing a system that can boot an arch/powerpc kernel  
for an embedded system.  I'm using u-boot as the boot loader since  
its a popular choice (I imagine the issues are similar for others):

[NOTE: dts, flat dev tree, etc are used interchangeably]

1. boot with an "old" u-boot (via bd_t):
* Have a boot wrapper that takes bd_t and dts and merges them @ runtime
* Boot wrapper has to be custom based on bd_t definition for the system
* dts owned by kernel??

2. boot with a "new" u-boot (has a .dts in it):
* capable of booting arch/powerpc kernel directly w/o modification
* in a production system don't want to update u-boot
* dts owned by u-boot??

Some questions/issues:
* ownership of .dts is problematic.  I hate having a file duplicated  
by both u-boot and kernel.  However it also seems bad to make the  
build of either depend on the user grabbing a dts from some third  
party.  Ideas?  A concrete example would be the MPC8349 ADS/SYS/MDS  
port.  Boards ship with an "old" u-boot, thus we need a kernel  
wrapper with .dts.  However, newer u-boot's can (hopefully will) have  
a dts in them

* updating of dts:  In case 1, this is trivial since its part of the  
kernel blob.  Case 2. is more difficult.  What do people think of  
treating the dts like the environment.  You have a version compiled  
in, but can alternately have a blob in another location that will be  
used if exists.  This would allow one to update the dts portion w/o  
effecting the actual boot loader.

* one solution to the copies of .dts is that we make the wrapper  
portion of the kernel the owner of the official latest and  
greatest .dts.  Every so often a maintainer can sync their .dts with  
u-boot to keep them relatively in sync.  However, the main mechanism  
would be to load the latest .dts blob into the secondary location.   
We can provide scripts/tools to do this via u-boot and linux.

comments, other issues people have thought of?

- kumar
