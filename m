Return-Path: <arekm@pld-linux.org>
Received: from outgoing.smtp.agnat.pl (outgoing.smtp.agnat.pl [193.239.44.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 885D9687DE
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Nov 2005 03:52:46 +1100 (EST)
From: Arkadiusz Miskiewicz <arekm@pld-linux.org>
To: linuxppc-dev@ozlabs.org
Date: Thu, 24 Nov 2005 17:52:24 +0100
References: <1132715288.26560.262.camel@gaston>
In-Reply-To: <1132715288.26560.262.camel@gaston>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Message-Id: <200511241752.25310.arekm@pld-linux.org>
Subject: Re: [PATCH] Fix USB suspend/resume crasher
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 23 November 2005 04:08, Benjamin Herrenschmidt wrote:
> This is my latest patch against current linus -git, it closes the IRQ
> race and makes various other OHCI & EHCI code path safer vs.
> suspend/resume. I've been able to (finally !) successfully suspend and
> resume various Mac models, with or without USB mouse plugged, or
> plugging while asleep, or unplugging while asleep etc... all without a
> crash. There are still some races here or there in the USB code, but at
> least the main cause of crash is now fixes by this patch (access to a
> controller that has been suspended, due to either shared interrupts or
> other code path).

btw. what should happen if there are drivers which do not support=20
suspend/resume?

I'm using zd1211 wifi usb driver (which isn't state of art) from=20
http://zd1211.ath.cx/repos/trunk rev 39 and while trying to suspend on my=20
ibook g4 dec 2004 I'm getting this:
http://www.t17.ds.pwr.wroc.pl/~misiek/rozne/failed-sleep.jpg

After that the only thing I can do is turn the thing off and turn it back o=
n -=20
it just hangs. It would be nice if it just refuse to suspend or got things=
=20
back into sane state.

I'm using 2.6.15rc2git3 + both patches posted in this thread.

ps.
My usual suspend is:

/sbin/rmmod therm_adt746x
/sbin/rmmod zd1211
/sbin/rmmod usbmouse
/sbin/rmmod usbhid
/sbin/rmmod zd1211
/sbin/rmmod ehci-hcd
/sbin/rmmod ohci-hcd
/usr/sbin/snooze

(I guess that rmmod zd1211 should be enough now).

=2D-=20
Arkadiusz Mi=B6kiewicz                    PLD/Linux Team
http://www.t17.ds.pwr.wroc.pl/~misiek/  http://ftp.pld-linux.org/
