Return-Path: <schwab@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "SuSE Linux AG internal IMAP-Server CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 058BA67A64
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2005 22:10:35 +1000 (EST)
To: Sebastian Heutling <sheutlin@gmx.de>
References: <425266E2.7060605@gmx.de>
From: Andreas Schwab <schwab@suse.de>
Date: Tue, 05 Apr 2005 14:10:27 +0200
In-Reply-To: <425266E2.7060605@gmx.de> (Sebastian Heutling's message of
	"Tue, 05 Apr 2005 12:22:26 +0200")
Message-ID: <jeacodv2z0.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org
Subject: Re: [Fwd: Re: iBook G3 owners]
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sebastian Heutling <sheutlin@gmx.de> writes:

> Sleep/wakeup works with a modified arch/ppc/platform/pmac_sleep.S (bl 
> reloc_offset was missing which you send later). I still have a strange 
> problem with some programs started in init-Scripts. For example if I run 
> dbus on bootup and directly after that go to sleep and wake-up again my 
> ibook doesn't resume harddisks leaving the following last messages:
>
> eth0 resuming
> PHY ID: 4061e4, addr: 0
> eth0: Link is up at 100 Mbps, full duplex.
> eth0: Pause is disabled
>
> If I disable dbus (stop it) and go to sleep, wakeup - no problem. 

I have the same problem.  I'm also seeing the same hang when the KDED
Media Manager is running (independent of hal/dbus).  I believe the cause
for this is that the ide subsystem wakes up too late, and the cdrom
polling of hal or kded is resuming too early.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
