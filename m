From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15304.11248.720092.645241@cargo.ozlabs.ibm.com>
Date: Sat, 13 Oct 2001 21:56:32 +1000 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: interesting line in process.c
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm intrigued by this line, line 276 in arch/ppc/kernel/process.c in
linuxppc_2_4_devel:

#if defined(CONFIG_4xx) && defined(DCRN_PLB0_BEAR) && defined(DCRN_PLB0_BEAR)

When could we have DCRN_PLB0_BEAR defined but DCRN_PLB0_BEAR not? :)
Could it ever be defined if CONFIG_4xx was not defined?

Which brings up another question that I have been meaning to ask: what
is the rationale for adding the dbcr0/1 fields to the ptrace struct
for 4xx?

Since struct ptrace is part of the kernel/user ABI, I prefer not to
change it unless it is absolutely necessary.  Could the dbcr0/1 fields
go in the thread_struct instead?  Where and how are they used?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
