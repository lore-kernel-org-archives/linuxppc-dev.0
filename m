Message-ID: <638AA0336D7ED411928700D0B7B0D75BB323E9@mail2.aiinet.com>
From: "Gessner, Matt" <mattg@aiinet.com>
To: "'Linux PPC'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Crash in serial_console_setup
Date: Wed, 9 Jan 2002 15:10:37 -0500 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Howdy, all,

I'm experiencing something rather odd.  My machine dies
on line 2956 of uart.c, which reads:

	bdp->cbd_bufaddr = __pa(mem_addr);

The assembler instruction being executed is a
	stw		r0,4(r11)

R11 contains 0xFF002800.

If I let it run, and then look at the trace w/ my BDI
and gdb, I'm in a panic from what looks like a page fault.

My IMMR is setup for 0xFF00xxxx.

Can anyone make any suggestions on what to check out?
The BDI?

I'm using the main source from bitkeeper, linuxppc_2_4.
It just got patched for a Data TLB miss error.

Thanks in advance.

Regards,

Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
