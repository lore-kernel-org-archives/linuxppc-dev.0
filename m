From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15946.57553.943418.884633@argo.ozlabs.ibm.com>
Date: Thu, 13 Feb 2003 11:03:29 +1100
To: Cort Dougan <cort@fsmlabs.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] vs. latest linuxppc_2_4_devel and linuxppc_2_4 for xmon
In-Reply-To: <20030212203120.GC12358@host109.fsmlabs.com>
References: <20030212203120.GC12358@host109.fsmlabs.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Cort Dougan writes:

> Allows printing of pgtables in xmon.  Mighty useful in both trees.

Nice idea. :)

The main problem I have with the patch is that it doesn't check the
pointers in the page table tree, so if the page tables are corrupted
then xmon itself will get a DSI.  Yes, if that is the case then your
system is pretty badly hosed, but it is in those sorts of situations
that you most need xmon to work.  We should also be using mread() to
read the pagetables safely.

The other problem is that it could print thousands or millions of
lines of output.  It would be nice to be able to specify an address or
a range of addresses to look up rather than printing them all.

BTW, we have other points where we need to use mread() - for example I
noticed that the top-level xmon() function calls smp_processor_id(),
which is current->processor, which will break badly if r2 is bad.

Regards,
Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
