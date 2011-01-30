Return-Path: <minipli@googlemail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CD9A6B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 30 Jan 2011 22:03:47 +1100 (EST)
Received: by fxm5 with SMTP id 5so4796893fxm.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 30 Jan 2011 03:03:42 -0800 (PST)
From: Mathias Krause <minipli@googlemail.com>
Content-Type: text/plain; charset=us-ascii
Subject: State of suspend-to-ram?
Date: Sun, 30 Jan 2011 12:03:41 +0100
Message-Id: <4537ED74-779B-4511-B4ED-339CAC355261@googlemail.com>
To: linuxppc-dev@lists.ozlabs.org
Mime-Version: 1.0 (Apple Message framework v1082)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all!

First of all: Sorry, this is the wrong mailing list, but I searched a =
lot and found none that would fit to PPC user-related problems -- =
linux-ppc would have been one but this one seems to be dead since 2004?!

I've a G4 based Mac mini and would like to suspend it to RAM, though the =
vanilla kernel doesn't allow me to do this (/sys/power/state mentions =
only "disk"). The reason for this is my platform is marked as =
PMAC_MB_MAY_SLEEP instead of PMAC_MB_CAN_SLEEP in =
arch/powerpc/platforms/powermac/feature.c. So I changed that to be =
PMAC_MB_CAN_SLEEP and was able to suspend the system using the =
pm-suspend script from the pm-utils suite. The LED on the front was =
pulsing like it is when suspended under MacOS X. After pushing the power =
button the system started to resume but just got stuck. I see no =
messages on the console, nothing in syslog. So I assume the system =
panics pretty early in the resume path. Because the system has no serial =
console the debug capabilities are fairly limited. Any hints why this =
doesn't work or how to debug this any further?

Some system information:

mk@maxi:~$ cat /proc/cpuinfo=20
processor	: 0
cpu		: 7447A, altivec supported
clock		: 1416.666661MHz
revision	: 1.2 (pvr 8003 0102)
bogomips	: 83.24
timebase	: 41620997
platform	: PowerMac
model		: PowerMac10,1
machine		: PowerMac10,1
motherboard	: PowerMac10,1 MacRISC3 Power Macintosh=20
detected as	: 287 (Mac mini)
pmac flags	: 00000001
L2 cache	: 512K unified
pmac-generation	: NewWorld
Memory		: 1024 MB
mk@maxi:~$ uname -a=20
Linux maxi 2.6.37+ #2 Mon Jan 24 08:56:01 CET 2011 ppc GNU/Linux

Regards,
Mathias
