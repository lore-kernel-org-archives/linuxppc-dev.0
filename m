Date: Wed, 7 Aug 2002 11:23:02 -0500
From: Peter Bergner <bergner@borg.umn.edu>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxPPC Dev <linuxppc-dev@lists.linuxppc.org>,
	Mike Corrigan <mikejc@us.ibm.com>
Subject: FP save/restore code in ppc32/ppc64 kernels
Message-ID: <20020807162302.GA39680@congo.borg.umn.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Paul,

Can you describe (if you know/remember since a lot of this code has Cort's name
on it) how the FP save/restore code is supposed to work?  I'm wondering why we're
clearing the MSR_FE{0,1} bits along with the MSR_FP bit.  Is there a reason why
they must be cleared when we clear the MSR_FP bit?

The reason I ask is that someone was running some userland app that explicitly
set the fpscr (using asm) and he got an FP exception even though gdb showed
his MSR_FE{0,1} bits to be zero.  This got me looking at the code which seems
to be inherited old ppc32 code.  I noticed that you've updated the ppc32, so
before I update our ppc64 code, I'd like to understand more about how this is
all supposed to work.

Peter

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
