Date: Wed, 23 Feb 2000 14:43:20 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Gabriel Ricard <g_ricard@yahoo.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Strange Issues with Lombard & PMU/PMUD
In-Reply-To: <20000222195013.10038.qmail@web1703.mail.yahoo.com>
Message-ID: <Pine.LNX.4.10.10002231347400.8833-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Ok, I've got a Lombard 400MHz running 2.2.15pre6,
> pmud-0.3pre1 on top of YDL Champion Server 1.1. I can
> put the system to sleep using Batmon (that came with
> pmud) or by closing the lid. It comes out of sleep
> just fine when I hit a key, except for resetting the
> trackpad options I had previously set, but that is a
> documented bug already.

It's a feature, not a bug. The kernel does the exact same init of the
trackpad as it did on boot. Add 'trackpad notap' to cases 1, 2 and 3 of
the pwrctl() function in /sbin/pwrctl to set the trackpad options again on
wakeup. Or figure out how to read the trackpad settings from the device
before sleep (a read of the same ADB registers as used to write the
settings to might already do) and restore them on wake. All of this can be
implemented in user space BTW.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
