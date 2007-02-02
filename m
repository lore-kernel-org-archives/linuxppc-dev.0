Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.190])
	by ozlabs.org (Postfix) with ESMTP id 8D1EEDDE0D
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Feb 2007 07:26:19 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: "Andriy Korud" <a.korud@vector.com.pl>
Subject: Re: Anyone success with 440GR Rev.B (1.1)?
Date: Fri, 2 Feb 2007 21:26:25 +0100
References: <60E856FD577CC04BA3727AF4122D3F1601238644@3bit.vector.com.pl>
	<adafy9o4l74.fsf@cisco.com>
In-Reply-To: <adafy9o4l74.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702022126.25872.sr@denx.de>
Cc: Roland Dreier <rdreier@cisco.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 02 February 2007 16:45, Roland Dreier wrote:
>  > I have complete system (U-Boot, Linux, userspace) running on 440GR
>  > Rev.A. However after mounting newer chip revision (Rev.B, 1.1) U-Boot
>  > and Linux boots fine, however when trying to execute first userland
>  > application (init), I get:
>  >
>  > Freeing unused kernel memory: 112k init
>  > init has generated signal 4 but has no handler for it
>  > Kernel panic - not syncing: Attempted to kill init!
>
> signal 4 is SIGILL.  Just a guess but do you have a cputable entry for
> 440GR rev B in your arch/powerpc/kernel/cputable.c?

Good idea. That's probably it.

> If you don't then 
> I think the default kernel settings will result in the wrong cacheline
> size being used, which leads to userspace often dying with illegal
> instruction traps.
>
> (I don't see any 440GR entries in cputable.c, neither rev A nor rev B,
> in the upstream kernel so I'm assuming you're patching your kernel
> somehow.  So checking that your patch covers rev B would be the first
> thing to do)

440GR has the same PVR as 440EP:

440EP Rev B == 440GR Rev A
440EP Rev C == 440GR Rev B

So your kernel should support 440EP Rev. C. The denx kernel has support for 
those CPU's included. I'll try to send some patches in the next few days to 
support them in the kernel.org version.

Best regards,
Stefan
