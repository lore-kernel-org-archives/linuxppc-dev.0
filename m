Message-ID: <3C1FD7CC.246C3007@mvista.com>
Date: Tue, 18 Dec 2001 16:57:00 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: trini@mvista.com,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: PPC bootloader cache enabling
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom,

In the bootloader, we enable the L1 instruction cache and disable the L1
data cache.  If I understood the manuals correctly:

On a 750 (according to user's manual):
- The cache is unified so even though you have the L1 data cache
disabled, if you have L2 on, data will get cached there.

On a 7400/7410 (according to user's manuals):
- Last sentence in the first paragraph of section 3.7.3.1 states, "if
the L1 data cache is disabled, the L2 cache must also be disabled."

In _setup_L2CR, the L2 cache is invalidated but its then enabled at the
end.  Am I missing something or is this a bug in _setup_L2CR?  If its a
bug, maybe we should rename it to invalidate_disable_l2 or something
like that?

Mark


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
