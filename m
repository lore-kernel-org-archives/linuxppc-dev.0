Return-Path: <r.goyet@gmail.com>
Received: from mail-qw0-f51.google.com (mail-qw0-f51.google.com
	[209.85.216.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5EAA1B7184
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 20 Feb 2011 22:59:17 +1100 (EST)
Received: by qwb8 with SMTP id 8so648857qwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 20 Feb 2011 03:59:14 -0800 (PST)
MIME-Version: 1.0
Date: Sun, 20 Feb 2011 12:59:13 +0100
Message-ID: <AANLkTi=bkvv0E6VhHtq9vEvADhPxWfQROkfUMaBqZq4f@mail.gmail.com>
Subject: Info : Using a PowerMac G5 as a server
From: Romain Goyet <r.goyet@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi everyone,

  I've this PowerMac G5 machine I'd like to use as a server. It makes
perfect sense to install Linux on it for several reasons :
- OS X isn't maintained on this hardware anymore
- Those machine are still reasonnably fast. They sure aren't the
latest and greatest, but they still do a decent job.
- Support of those in other OSes (NetBSD or FreeBSD for instance) is
pretty bad (no fan control for example).

To make a decent server though, there are two things that are pretty
important IMHO :
- Being able to boot headless (w/o a screen attached)
- Being able to reboot automagically after a power failure

Surprisingly, the Linux kernel does a very good job on this machine in
terms of hardware support and stability : everything works perfectly.
But the global OS fails pathetically in the two said points.
Here are my findings so far, I hope it will help people in the same situati=
on :

1/ Booting a PowerMac G5 headless

This hasn't so much to do with Linux per se, but rather with Yaboot
which seems to be the de-facto standard bootloader on the OpenFirmware
platform.
For some reason, at some point in the booting process, yaboot relies
on a screen being present. If no screen is attached, it will hang. So
much for headless booting.
Now I've figured out several workarounds :

 -> Fake a screen by plugging in a resistor into your VGA port (or to
your DVI port using an adapter). This sure works, but it's rather
redneck
 -> For some reason, the part of yaboot that actually depends on the
script is the "ofboot.b" forth script. This scripts' purpose is to
give you an option of booting off of a CD. I really don't get it since
OpenFirmware itself lets you boot off of a CD just by pressing "C" on
boot. So basically if you skip ofboot.b, you're good to go. When
installing yaboot with ybin, ybin sets the "boot-device" variable in
OpenFirmware to point to ofboot.b. So if you point boot-device
straight to the yaboo binary, you should be able to boot headless
without any issue. Here are several ways to do it :
       - Go to the OpenFirmware prompt (Command-Option-O-F on boot),
and type "setenv boot-device=3Dhd:2,yaboot" (modify the hd:2
accordingly), then "boot"
       - You might be able to achieve the same effect using the
"nvram" tool straight from linux
       - I think simply removing the "magicboot" line off of
yaboot.conf might fix it as well

IOW, it _is_ possible to boot a PowerMac G5 headless on Linux without
any hardware modification.

2/ Rebooting automagically after a power failure

Now this is less fun : I still don't have any solution to offer. To
understand the situation, you should know that this has to be set in
the power-management chip.
Previous PowerMacs used a "PMU" chip, which was fully supported. All
you had to do was to echo "server_mode=3D1" to /proc/pmu/options.

Thing is, G5's use a new chip, named "SMU". And AFAIK, there's no such
option for those machines=E2=80=A6

So if anyone ever knows any element of answer on this, I'd be really
interested !

Kind regards,

 - Romain
