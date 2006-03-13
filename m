Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (mail.sipsolutions.net [66.160.135.76])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 63603679E2
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Mar 2006 18:24:14 +1100 (EST)
Subject: Re: suspend2 on PowerBook: keyboard doesn't work on resume
From: Johannes Berg <johannes@sipsolutions.net>
To: Dustin Lang <dstn@cs.toronto.edu>
In-Reply-To: <Pine.LNX.4.58.0603112043460.25986@monte.ai>
References: <Pine.LNX.4.58.0603112043460.25986@monte.ai>
Content-Type: text/plain
Date: Mon, 13 Mar 2006 07:40:47 +0100
Message-Id: <1142232047.4228.1.camel@quad.lan>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

> I'm trying to get suspend2 working on my PowerBook G4 of Oct 2003 vintage.
> 
> I'm running kernel 2.6.15.6 with the 2.6.15.1 suspend2 patch (it applied
> and built fine).

Interesting. I was pretty sure that version wouldn't work at all :->

> On the next startup, the kernel boots and it resumes.  I see the root
> terminal again, complete with my "hibernate" command and the syslog
> messages detailing the progress of suspend2.  The system does not respond
> to keystrokes, however.  After a few seconds, the "Running" message is
> printed out, and after 60 seconds, the system reboots.  To me this
> suggests that the system is mostly resuming correctly, but something has
> gone funny with the keyboard driver.
> 
> Keyboard-related dmesg:
> 
> MacIO PCI driver attached to Intrepid chipset
> input: Macintosh mouse button emulation as /class/input/input0
> adb: starting probe task...
> [snip]
> PCI: Enabling device 0002:20:0d.0 (0000 -> 0002)
> adb devices: [2]: 2 c3 [3]: 3 1 [7]: 7 1f
> ADB keyboard at 2, handler 1
> Detected ADB keyboard, type ANSI.

There's an ADB keyboard -- this all probably suggests that the ADB
driver from pre-resume and original kernel are stepping onto each other.
Maybe they have no good enough power management?

> Does anyone on the list use suspend2 on a PowerBook?

I used to, but on a later powerbook with USB keyboard, so...

johannes
