Return-Path: <jwboyer@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id E7EB3DDE07
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 08:07:11 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so340000yxg.39
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 14:07:10 -0700 (PDT)
Date: Thu, 30 Oct 2008 17:05:22 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: 2.6.28-rc1: NVRAM being corrupted on ppc64 preventing boot
	(bisected)
Message-ID: <20081030210522.GA6532@yoda.jdub.homelinux.org>
References: <alpine.LFD.2.00.0810232028500.3287@nehalem.linux-foundation.org>
	<20081030142632.GA15645@csn.ul.ie>
	<18698.7794.500191.189515@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18698.7794.500191.189515@cargo.ozlabs.ibm.com>
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: Mel Gorman <mel@csn.ul.ie>, linuxppc-dev@ozlabs.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 31, 2008 at 07:52:02AM +1100, Paul Mackerras wrote:
>Mel Gorman writes:
>
>> On some ppc64 machines, NVRAM is being corrupted very early in boot (before
>> console is initialised). The machine reboots and then fails to find yaboot
>> printing the error "PReP-BOOT: Unable to load PRep image".  It's nowhere near
>> as serious as the ftrace+e1000 problem as the machine is not bricked but it's
>> fairly scary looking, the machine cannot boot and the fix is non-obvious. To
>> "fix" the machine;
>> 
>> 1. Go to OpenFirmware prompt
>> 2. type dev nvram
>> 3. type wipe-nvram
>> 
>> The machine will reboot, reconstruct the NVRAM using some magic and yaboot
>> work again allowing an older kernel to be used. I bisected the problem down
>> to this commit.
>
>Eek!
>
>Which ppc64 machines has this been seen on, and how were they being
>booted (netboot, yaboot, etc.)?
>
>Is it just the Powerstations with their SLOF-based firmware, or is it
>IBM pSeries machines as well?

I'm pretty sure it was with pSeries machines.  I saw reports of POWER5
being effected (p520 and p710).  I believe one of them resolved the
issue by upgrading firmware on the machine.

josh
