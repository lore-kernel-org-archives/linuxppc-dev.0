Message-ID: <3FC4D4B5.2030901@elitedvb.net>
Date: Wed, 26 Nov 2003 17:28:37 +0100
From: Felix Domke <tmbinc@elitedvb.net>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: 405 Critical Interrupts
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

i need to have a low-latency interrupt on a 405-based chip with linux 2.4.

Did anybody yet worked on this?

I thought about routing the CriticalInterrupt pretty much the same way
as the HardwareInterrupt, but with disabling MSR_CE. MSR_CE would be
enabled then even in (normal) interrupts, we probably have to add a
__crit_cli and __save_and_crit_cli as someone already suggested.

Does CRIT_EXCEPTION work? Is do_IRQ reentrant? Should i use the same
interrupt processing as a normal hardware interrupt, with the exception
that only "critical"-flagged interrupts are processed?

Any suggestions?

The background: the IBM-STB045xx's capture port, which we use for
IR-decoding, doesn't have any buffering, so when a time-consuming
interrupt is processed (PIO network, maybe PIO ide), we miss IR cycles.

Felix


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
