Date: Fri, 9 Feb 2001 00:23:48 +0100 (MET)
From: Roman Zippel <zippel@fh-brandenburg.de>
To: David Edelsohn <dje@watson.ibm.com>
Cc: paulus@linuxcare.com.au, Dan Malek <dan@mvista.com>,
	Gabriel Paubert <paubert@iram.es>, tom_gall@vnet.ibm.com,
	linuxppc-commit@hq.fsmlabs.com,
	linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: context overflow 
In-Reply-To: <200102082114.QAA25048@mal-ach.watson.ibm.com>
Message-ID: <Pine.GSO.4.10.10102082250080.24436-100000@zeus.fh-brandenburg.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

On Thu, 8 Feb 2001, David Edelsohn wrote:

> 	I did not say that Linux VMM is the limiting part, I said that the
> design needs to work within the Linux VMM limitations.  The Linux VMM
> still uses the x86 page table design as a basis for its abstraction
> layer.  Not all processors match that configuration.

The page table abstraction is only used for user space vm management. The
important point is: it's only an abstraction as far as it concerns the
general vm code. What happens underneath is a complete different story and
the general code should provide enough hooks to allow the implementation
to do whatever it wishes. If something is missing it can certainly be
added, but always remember not to mix abstraction with implementation.

Anyway, an idea to improve current context handling: define another bit
_PAGE_HASHED for the pte. If it's set, it points to the hash table entry,
otherwise it's a normal linux pte entry. That makes pte handling a bit
more complicated, but if we can dump the current tlb/context handling, it
should be really worth it.

bye, Roman


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
