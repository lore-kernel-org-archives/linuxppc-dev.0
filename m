Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F27B51007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 30 Jan 2011 22:09:23 +1100 (EST)
Subject: Re: State of suspend-to-ram?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mathias Krause <minipli@googlemail.com>
In-Reply-To: <4537ED74-779B-4511-B4ED-339CAC355261@googlemail.com>
References: <4537ED74-779B-4511-B4ED-339CAC355261@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 30 Jan 2011 22:09:13 +1100
Message-ID: <1296385753.2349.184.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2011-01-30 at 12:03 +0100, Mathias Krause wrote:
> Hi all!
> 
> First of all: Sorry, this is the wrong mailing list, but I searched a
> lot and found none that would fit to PPC user-related problems --
> linux-ppc would have been one but this one seems to be dead since
> 2004?

 .../....

The matter is mostly to get the video chip back. It gets powered down
during suspend and we don't have the black magic formula to
re-initialize it.

I've reverse-engineered that for other similar chips, but not that one.
If you think you're up to the task, let me know privately and I'll point
you to some tools that can help spying what the MacOS driver does, which
you can then use to find the right sequence. But beware, it's nasty :-)

Cheers,
Ben.

> I've a G4 based Mac mini and would like to suspend it to RAM, though
> the vanilla kernel doesn't allow me to do this (/sys/power/state
> mentions only "disk"). The reason for this is my platform is marked as
> PMAC_MB_MAY_SLEEP instead of PMAC_MB_CAN_SLEEP in
> arch/powerpc/platforms/powermac/feature.c. So I changed that to be
> PMAC_MB_CAN_SLEEP and was able to suspend the system using the
> pm-suspend script from the pm-utils suite. The LED on the front was
> pulsing like it is when suspended under MacOS X. After pushing the
> power button the system started to resume but just got stuck. I see no
> messages on the console, nothing in syslog. So I assume the system
> panics pretty early in the resume path. Because the system has no
> serial console the debug capabilities are fairly limited. Any hints
> why this doesn't work or how to debug this any further?
> 
> Some system information:
> 
> mk@maxi:~$ cat /proc/cpuinfo 
> processor	: 0
> cpu		: 7447A, altivec supported
> clock		: 1416.666661MHz
> revision	: 1.2 (pvr 8003 0102)
> bogomips	: 83.24
> timebase	: 41620997
> platform	: PowerMac
> model		: PowerMac10,1
> machine		: PowerMac10,1
> motherboard	: PowerMac10,1 MacRISC3 Power Macintosh 
> detected as	: 287 (Mac mini)
> pmac flags	: 00000001
> L2 cache	: 512K unified
> pmac-generation	: NewWorld
> Memory		: 1024 MB
> mk@maxi:~$ uname -a 
> Linux maxi 2.6.37+ #2 Mon Jan 24 08:56:01 CET 2011 ppc GNU/Linux
> 
> Regards,
> Mathias
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
