Message-ID: <3980DEAF.ACFB0C43@embeddededge.com>
Date: Thu, 27 Jul 2000 21:15:27 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Altivec on 2.4.xx?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Anyone out there using Altivec with a 2.4.0 kernel?  Maybe this
is the wrong list to ask....suggestions welcome.

There is a bug in the Instruction fault handler that interprets the
Altivec enabled flag in the MSR as a write attempt to a protected
instruction page.  It is because we commonly use the DSISR and SRR1,
and call it 'error_code' in do_page_fault.  The 0x02000000 is the
Altivec enabled flag in SRR1.

This should also break 2.2.xx (unless Altivec enabled is managed
differently and I don't know that).

Right now, I am just removing this as part of the exception handler,
so this function never finds this bit set for instruction faults.
Anyone else?


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
