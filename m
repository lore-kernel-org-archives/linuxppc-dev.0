Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8189067A60
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 05:20:40 +1000 (EST)
In-Reply-To: <20060427190547.1DD90353DAC@atlas.denx.de>
References: <20060427190547.1DD90353DAC@atlas.denx.de>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D358E665-60E4-48C0-82FD-7A1C16DAF00C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: FT u-boot shim 
Date: Thu, 27 Apr 2006 14:20:34 -0500
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

> Let's say we have to support such situations, too.
>
>> * dts owned by u-boot??
>
> I'm not sure about this. I tend to believe the  dts  belongs  to  the
> kernel.
>
>> Some questions/issues:
>> * ownership of .dts is problematic.  I hate having a file duplicated
>> by both u-boot and kernel.  However it also seems bad to make the
>> build of either depend on the user grabbing a dts from some third
>> party.  Ideas?  A concrete example would be the MPC8349 ADS/SYS/MDS
>> port.  Boards ship with an "old" u-boot, thus we need a kernel
>> wrapper with .dts.  However, newer u-boot's can (hopefully will) have
>> a dts in them
>
> Can we provide the dts as a separate blob that gets  built  with  the
> kernel image? From U-Boot's point of view, this could be a multi-file
> image  which  combines  the  dts and the kernel into a single file so
> that users don't have to care much about this.

The problem is that there are somethings that u-boot knows that needs  
to go into the blob (memory size, boot args, initrd info,  
frequencies, etc.)

>> * updating of dts:  In case 1, this is trivial since its part of the
>> kernel blob.  Case 2. is more difficult.  What do people think of
>> treating the dts like the environment.  You have a version compiled
>
> I don't like this idea.
>
>> in, but can alternately have a blob in another location that will be
>> used if exists.  This would allow one to update the dts portion w/o
>> effecting the actual boot loader.
>
> If we consider this, then we might as well combine the dts  with  the
> kernel  image.  Alternatively,  the dts might be stored in a separate
> location in memory. It would be easy to extend the "bootm" command to
> take an additional argument (dts address).

How would we distinguish the bootm command that takes a blob versus  
the ones we have today?

>> * one solution to the copies of .dts is that we make the wrapper
>> portion of the kernel the owner of the official latest and
>> greatest .dts.  Every so often a maintainer can sync their .dts with
>> u-boot to keep them relatively in sync.  However, the main mechanism
>> would be to load the latest .dts blob into the secondary location.
>
> Why not load it separately or as part of the Linux kernel image?

As stated before, the main issue is doing some runtime fix ups to the  
blob before its handed to the kernel.

The following pieces of info are setup at runtime that are board  
specific:

linux,stdout_path
cpus/<foo>/clock-frequency
cpus/<foo>/timebase-frequency
cpus/<foo>/bus-frequency
<soc>/pci/bus-range
<soc>/bus-frequency
<soc>/serial/clock-frequecny
<soc>/ethernet/address

We could hand bootm a memory location with a blob and do the fix ups  
at runtime, we would still have some coupling between the blob and u- 
boot build.  At least the blob wouldn't be built into u-boot.

- kumar
