Subject: [RFC] Machine check handling
From: Adrian Cox <adrian@humboldt.co.uk>
To: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain
Message-Id: <1092835012.10314.46.camel@localhost>
Mime-Version: 1.0
Date: Wed, 18 Aug 2004 14:16:53 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The current handling of machine check in Linux 2.6 on the PowerPC has
some problems. If the processor was in user_mode, the handler returns a
SIGBUS even if the machine check cause was a hardware fault such as an
internal cache parity error or ECC memory failure. This is quite
different to the handling of machine checks from hardware faults on
i386.

I propose restructuring the machine check handling as follows:
1) On entry to the machine handler, call a CPU specific handler to tell
us whether the cause was internal or external.
1a) If internal, log the fault and either panic or return.
2) If the cause was external, call a platform specific handler to tell
us whether the cause can be associated with a process.
2a) If yes (such as the I/O code for PowerMac), handle as current
(SIGBUS, drop to debugger, etc.).
2b) If no, log the fault and either panic or return.

In the absence of specific handlers, the code would assume that the
machine check was external to the processor and the result of process
actions. This should leave the current behaviour intact on machines
which use it for PCI probing, while on machines with genuine hardware
faults the mysterious SIGBUS arrivals will be replaced with clear log
messages.

For part 1 I'm thinking of an extra function pointer in struct cpu_spec,
and for part 2 an extra function pointer in ppc_md. I'd like to know if
anyone has any strong opinions on this before I update my old Linux 2.4
patch:
http://www.humboldt.co.uk/Downloads/PowerPC/mcheck-1.156.html

- Adrian Cox
Humboldt Solutions Ltd.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
