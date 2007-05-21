Return-Path: <monodhs@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 55391DDE33
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 06:08:23 +1000 (EST)
Message-ID: <4651FC48.8000002@gmx.de>
Date: Mon, 21 May 2007 22:08:40 +0200
From: =?ISO-8859-1?Q?Christian_B=F6hme?= <monodhs@gmx.de>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Interrupt routing broken on TiBook IV with 2.6.21.x ?
References: <4650E27B.3020401@gmx.de>
	<1179712614.32247.597.camel@localhost.localdomain>
In-Reply-To: <1179712614.32247.597.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

> Nope... it can't be a routing problem since interrupt -is- routed (you
> are getting it !)

Actually, these were the exact words from the ALSA developer.  For some
reason, however, the interrupt count does not increase after some (variable)
time.  It looks as if the ALSA code waits for but not receiving them.  After
a restart, an audio signal does leave the jack and the interrupt count
increases but only for about a second (sometimes more, often less).  No idea 
whether interrupts must be routed/are routable on this very machine I have at 
all ...

> Which exact tipb model is this ? (cat /proc/device-tree/model)

PowerBook3,5 of the 2002-11 release variety.

I stuck to OSS up to the 2.6.19.x kernels where everything (surprisingly)
``just worked''.  Then came the 2.6.20.x series and <root>/sound/oss/\
dmasound/dmasound_awacs.c started spitting out loads of ``tx-irq: xfer died -
patching it up...'' messages with stuttering audio output but nothing
different in their respective implementations from 2.6.19.x to 2.6.20.x.

Is there anything particular I can dive into myself to expedite finding the
cause of the problem without learning the full details of the PPC implemen-
tation ?


Cheers,
Christian
