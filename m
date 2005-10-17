Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 2463D6856C
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Oct 2005 16:42:13 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 940EB29EC6
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Oct 2005 08:40:35 +0200 (CEST)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 19881-02 for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Oct 2005 08:40:34 +0200 (CEST)
Received: from linux.local (linux.prtnl [192.168.1.97])
	by protonic.prtnl (Postfix) with ESMTP id 7E7BD28067
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 17 Oct 2005 08:40:34 +0200 (CEST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 17 Oct 2005 08:42:05 +0200
References: <200510141135.47186.david.jander@protonic.nl>
	<00a701c5d0cc$4e0e6840$0301a8c0@chuck2>
In-Reply-To: <00a701c5d0cc$4e0e6840$0301a8c0@chuck2>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510170842.05970.david.jander@protonic.nl>
Subject: Re: jffs2 robustness against powerfailure
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 14 October 2005 16:33, Mark Chambers wrote:
>[...]
> Well, I can tell you this, from bitter experience:  Chips do strange stuff
> when power is
> coming or going.  One thing that can happen is addresses get messed up, so
> writes go
> to the wrong place.  You say your hardware is good, but it may not have
> been thoroughly characterized for power-down behavior.   Probably the same
> chip that
> generates a power-up reset generates a reset when power is falling, check
> if the trip
> voltage is high enough.

There's a hardware watchdog which monitors both power-supplies and asserts 
reset in case of failure. It's reliable and it works.
But that all doesn't matter. You seem to oversee three facts:
1.- The file being written to at the moment of power failure is always the 
file that has a CRC failure (if that happens) afterwards, not other files. So 
"writes go to the wrong place" is quite unlikely.
2.- If a piece of flash get's corrupted, there's always the jffs2's CRC that 
should trip and detect that block as invalid.
3.- If there really were writes to the wrong place, I'd expect that to be 
noticeable by looking at the files. There is random data being written to the 
files, but fortunately not that random: It's all 32-bit integers from 
0...10000. That makes the chances of corrupt random data, or valid data 
written to the wrong place not being noticed actually quite small!

It looks to me very much like a jffs2 bug or design flaw, maybe a 
race-condition, but since I don't know jffs2 internals that much, I can't 
tell for sure. Isn't this a known issue?

> You could rule a power problem out by running your tests where you reset
> the processor (shorting hreset or poreset somewhere) but not power-cycling
> the board, and see if
> the failures are the same.

I could do that, but I fear it will give the same results.
Ok, for sciences sake I'll do that experiment.

Sincerely,

-- 
David Jander
