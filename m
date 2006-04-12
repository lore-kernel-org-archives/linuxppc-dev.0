Return-Path: <bcook@bpointsys.com>
Received: from bpointsys.com (70-253-197-251.ded.swbell.net [70.253.197.251])
	by ozlabs.org (Postfix) with ESMTP id F186967BD1
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 23:02:37 +1000 (EST)
From: Brent Cook <bcook@bpointsys.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: root file system mounted via NFS - retry?
Date: Wed, 12 Apr 2006 07:50:31 -0500
References: <443CF3F8.408@imagemap.com>
In-Reply-To: <443CF3F8.408@imagemap.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200604120750.31421.bcook@bpointsys.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 12 April 2006 07:35, Randy Smith wrote:
> Hello,
>
> I have a general question regarding having a root file system mounted
> via NFS.  Our system consists of a linux PC that acts as the NFS server
> and two embedded ppc boards running linux that mount their file systems
> via NFS.  The problem is that the embedded boards boot much faster than
> the PC, and when they attempt to mount the root file system, the NFS
> server is not up yet.  The embedded boards hang and it takes quite a
> long time before the watchdog timer reboots them.  The next time round,
> they come up just fine.
> What I would like for them to do is keep trying until the NFS server
> appears and then continue to boot.
>

Sorry to try the obvious, but could you make the firmware's auto-boot timeout 
longer? I know that u-boot and several others support this.

Also, you could try, instead of mounting root NFS directly from the kernel, an 
initrd or embedding an initramfs that does the mount using a script. They you 
could retry as much as you wanted without having to teach the kernel 
anything.

Or, just hook up some GPIOs from your PC to the reset lines on those PPC's. 
Then reset them once your PC is up.

Or rather than running the PPC kernel from flash, tftp it to RAM from your 
PC - that way your PPCs can't even load the kernel until the PC is up 
(assuming your firmware knows how to do this and handles faults gracefully.)

 - Brent
