Return-Path: <sneakums@zork.net>
Received: from zork.zork.net (zork.zork.net [64.81.246.102])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E8E792BDB5
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Nov 2004 09:41:08 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <6ubrdsjiq1.fsf@zork.zork.net> <1100989339.3795.6.camel@gaston>
From: Sean Neakums <sneakums@zork.net>
Date: Sat, 20 Nov 2004 22:41:06 +0000
In-Reply-To: <1100989339.3795.6.camel@gaston> (Benjamin Herrenschmidt's
	message of "Sun, 21 Nov 2004 09:22:19 +1100")
Message-ID: <6u7jogjg8t.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: TEST: Sleep suppport for iBook G4 & Aluminium PowerBooks (ATI
	based)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On Sat, 2004-11-20 at 21:47 +0000, Sean Neakums wrote:
>> > http://gate.crashing.org/~benh/albook-ibookg4-sleep-2.diff
>> 
>> I tried this on my 15" AlBook (one of the new 1.5GHz ones), applied to
>> Debian's 2.6.9.  It suspended and resumed fine (and quickly!), but
>> after resume I noticed that images (in Mozilla and the root window)
>> would become corrupted if obscured and made visible again, e.g. by
>> switching tabs, or by moving between a full and an empty workspace.
>
> Do you have APM emulation enabled in the kenrel config and do you
> have /dev/apm_bios ? (check in X log that it properly opens the APM
> device and gets notified of suspend and resume events).

It was built modular but not loaded, and /dev/apm_bios was present.
Having exited X, loaded the module and restarted X, I tried
suspend/resume again.  It worked well as before, but the corruption is
still present.  In XFree86.0.log, I now see a "(II) Open APM
successful" instead of "(WW) Open APM failed (/dev/apm_bios) (No such
device) ", but nothing that seems to relate to suspend/resume events.

The corruption doesn't appear immediately; it starts as a light
specking of the image and progressively getting worse with subsequent
redisplayings.
