Return-Path: <rsmith@imagemap.com>
Received: from fileserver3.imagemap.com (mail.imagemap.com [68.156.94.66])
	by ozlabs.org (Postfix) with ESMTP id BCC8567C3F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Apr 2006 00:06:30 +1000 (EST)
Received: from amavis by fileserver3.imagemap.com with scanned-ok (Exim 3.36
	#1 (Debian)) id 1FTg1s-0003yz-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 12 Apr 2006 10:09:08 -0400
Received: from fileserver3.imagemap.com ([127.0.0.1])
	by localhost (fileserver3 [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 15114-04 for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 10:08:59 -0400 (EDT)
Received: from [192.168.0.196] (helo=[192.168.0.196])
	by fileserver3.imagemap.com with esmtp (Exim 3.36 #1 (Debian))
	id 1FTg1j-0003yg-00
	for <linuxppc-embedded@ozlabs.org>; Wed, 12 Apr 2006 10:08:59 -0400
Message-ID: <443D084F.9010607@imagemap.com>
Date: Wed, 12 Apr 2006 10:01:51 -0400
From: Randy Smith <rsmith@imagemap.com>
MIME-Version: 1.0
CC: linuxppc-embedded@ozlabs.org
Subject: Re: root file system mounted via NFS - retry?
References: <443CF3F8.408@imagemap.com>
	<200604120750.31421.bcook@bpointsys.com>
In-Reply-To: <200604120750.31421.bcook@bpointsys.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Brent Cook wrote:
> On Wednesday 12 April 2006 07:35, Randy Smith wrote:
>   
>> Hello,
>>
>> I have a general question regarding having a root file system mounted
>> via NFS.  Our system consists of a linux PC that acts as the NFS server
>> and two embedded ppc boards running linux that mount their file systems
>> via NFS.  The problem is that the embedded boards boot much faster than
>> the PC, and when they attempt to mount the root file system, the NFS
>> server is not up yet.  The embedded boards hang and it takes quite a
>> long time before the watchdog timer reboots them.  The next time round,
>> they come up just fine.
>> What I would like for them to do is keep trying until the NFS server
>> appears and then continue to boot.
>>
>>     
>
> Sorry to try the obvious, but could you make the firmware's auto-boot timeout 
> longer? I know that u-boot and several others support this.
>   
We are using U-boot and yes, I can set the delay.  This does work around 
the problem, but I was hoping for a more 'elegant' solution.
> Also, you could try, instead of mounting root NFS directly from the kernel, an 
> initrd or embedding an initramfs that does the mount using a script. They you 
> could retry as much as you wanted without having to teach the kernel 
> anything.
>   
Another possibility.  Thanks!
> Or, just hook up some GPIOs from your PC to the reset lines on those PPC's. 
> Then reset them once your PC is up.
>   
This is not possible with our current design, but it would solve the 
problem.
> Or rather than running the PPC kernel from flash, tftp it to RAM from your 
> PC - that way your PPCs can't even load the kernel until the PC is up 
> (assuming your firmware knows how to do this and handles faults gracefully.)
>   
The way our system was initially designed, it worked this way.  We are 
modifying the design to remove the dependency on NFS by embedding the 
boot loader, kernel and root file system on the flash.  We aren't quite 
there yet so in the meantime we moved the kernel to the flash and now we 
are seeing this problem.

And in fact, the problem may not be as I described.  I have been running 
some other tests and I am getting indications that the problem may be in 
the hardware that our ppc boards are talking to.  I stripped a ppc board 
down to just the computer part and hooked up a serial line to it.  
Cold-boot and the stripped down ppc reached the mount nfs part and 
waited for a little while, and then continued on, so I am discounting 
the theory that the NFS mount was failing due to timeout.  The other ppc 
board hung with the same behavior, but I cannot put a serial line on it.

The question remains though, does the NFS timeo and retrans parameters 
on the nfsroot kernel command line apply to the 2.4.25 kernel supplied 
by DENX' ELDK?

Thanks,

-Randy
>  - Brent
>
>   
