From: Joe Green <jgreen@mvista.com>
To: bhupinder sahran <bhup_sah@yahoo.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: running configuration cycle across the secondary side of a non transparent(21554) bridge
Date: Mon, 13 Aug 2001 09:28:10 -0700
Content-Type: text/plain
References: <20010812190600.27233.qmail@web3805.mail.yahoo.com>
In-Reply-To: <20010812190600.27233.qmail@web3805.mail.yahoo.com>
MIME-Version: 1.0
Message-Id: <01081309361200.30014@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


bhupinder sahran wrote:
> i am trying to run configuration cycle across the
> secondary of 21554 bridge, from my MPC8240 on which
> linux is running.
> i am not able to write anything into the downstrean
> configuration register which is at offset 0x90 from
> the primary interface.
> i have enabled the downstream configuration control &
> status register also.
> i have tried to write through CSR I/O BAR also.
> but could not write.
> can anybody tell me what could be the reason.

The first thing to check is whether the primary access lockout has been
disabled.  The chip can come up in a mode where accesses via the
primary interface are rejected (generate PCI bus retries).  This can
only be cleared from the secondary interface.  You can strap the chip
or configure the serial ROM to disable this on startup.

--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
