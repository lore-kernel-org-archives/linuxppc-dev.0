From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16043.7040.957962.917725@nanango.paulus.ozlabs.org>
Date: Sun, 27 Apr 2003 09:51:28 +1000 (EST)
To: joakim.tjernlund@lumentis.se
Cc: "Linuxppc-Dev@Lists. Linuxppc. Org" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: _PAGE_HWWRITE missing in pte_mkdirty()?
In-Reply-To: <IGEFJKJNHJDCBKALBJLLKEEJFMAA.joakim.tjernlund@lumentis.se>
References: <3EA94CB4.8050509@embeddededge.com>
	<IGEFJKJNHJDCBKALBJLLKEEJFMAA.joakim.tjernlund@lumentis.se>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Joakim Tjernlund writes:

> OK, I wasn't aware that you can have dirty pages without _PAGE_RW.

Yes, think about what happens if a process has a writable dirty page
(in a private or anonymous mapping) and the process does a fork.  The
page becomes copy-on-write, so we have to make it non-writable, but it
is still dirty.

Whether the kernel actually ever calls pte_mkdirty on a non-writable
page is a different question, of course. :)

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
