Message-ID: <3DB57883.4040109@uab.ericsson.se>
Date: Tue, 22 Oct 2002 18:10:43 +0200
From: Hans Feldt <Hans.Feldt@uab.ericsson.se>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 8260 CPM commands, need better resource ctrl?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


CPM commands are executed from different drivers, e.g. fcc_enet.c and
in different execution contexts.

Isn't there a need for a central place to handle CPM commands?

For example:

m8260_cpm_cmd(...)
	disable ints
	bounded wait until FLG is clear
	if not clear => ???
	write to CPCR
	enable ints

I have problems when testing the ATM driver and at the same time having
limited Ethernet traffic (debug printouts).  I get a "transmit timed
out" and descriptor ring dump from the eth driver. Disabling irqs in the
atm driver around CPCR handling seems to fix that problem.

Comments?

Thanks,
Hans


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
